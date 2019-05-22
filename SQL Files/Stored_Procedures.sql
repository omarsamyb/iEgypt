USE IEgypt_95;
GO

/*
DROP PROCEDURE Original_Content_Search;
DROP PROCEDURE Contributor_Search;
DROP PROCEDURE Register_User;
DROP PROCEDURE Check_Type;
DROP PROCEDURE Order_Contributor;
DROP PROCEDURE Show_Original_Content;
----------------------------------------
DROP PROCEDURE User_login;
DROP PROCEDURE Show_Profile;
DROP PROCEDURE Edit_Profile;
DROP PROCEDURE Deactivate_Profile;
DROP PROCEDURE Show_Event;
DROP PROCEDURE Show_Notification;
DROP PROCEDURE Show_New_Content;
----------------------------------------
DROP PROCEDURE Viewer_Create_Event;
DROP PROCEDURE Viewer_Upload_Event_Photo;
DROP PROCEDURE Viewer_Upload_Event_Video;
DROP PROCEDURE Viewer_Create_Ad_From_Event;
DROP PROCEDURE Apply_Existing_Request;
DROP PROCEDURE Apply_New_Request;
DROP PROCEDURE Delete_New_Request;
DROP PROCEDURE Rating_Original_Content;
DROP PROCEDURE Write_Comment;
DROP PROCEDURE Edit_Comment;
DROP PROCEDURE Delete_Comment;
DROP PROCEDURE Create_Ads;
DROP PROCEDURE Edit_Ad;
DROP PROCEDURE Delete_Ads;
DROP PROCEDURE Send_Message;
DROP PROCEDURE Show_Message;
DROP PROCEDURE Highest_Rating_Original_content;
DROP PROCEDURE Assign_New_Request;
-------------------------------------------
DROP PROCEDURE Receive_New_Requests;
DROP PROCEDURE Respond_New_Request;
DROP PROCEDURE Upload_Original_Content;
DROP PROCEDURE Upload_New_Content;
DROP PROCEDURE Delete_Content;
DROP PROCEDURE Receive_New_Request;
-------------------------------------------
DROP PROCEDURE reviewer_filter_content;
DROP PROCEDURE content_manager_filter_content;
DROP PROCEDURE Staff_Create_Category;
DROP PROCEDURE Staff_Create_Subcategory;
DROP PROCEDURE Staff_Create_Type;
DROP PROCEDURE Most_Requested_Content;
DROP PROCEDURE Workingplace_Category_Relation;
DROP PROCEDURE Delete_Original_Content;
DROP PROCEDURE Delete_New_Content;
DROP PROCEDURE Assign_Contributor_Request;
DROP PROCEDURE Show_Possible_Contributors;

DROP FUNCTION checkContributorAvailablity;
DROP PROCEDURE checkName;
GO
*/

--****************		"As a registered/unregistered user, I should be able to ..."		********************--
GO

CREATE FUNCTION checkContributorAvailablity (@contributor_id INT)
RETURNS BIT
BEGIN
	DECLARE @returnedValue BIT
	DECLARE @noUploaded INT
	SELECT @noUploaded=(
							SELECT COUNT(*)
							FROM New_Request 
							INNER JOIN New_Content
							ON New_Content.new_request_id=New_Request.id
							WHERE New_Request.contributer_id=@contributor_id)

DECLARE @noRequests INT
SELECT @noRequests=(SELECT COUNT(*) FROM New_Request WHERE New_Request.contributer_id=@contributor_id AND New_Request.accept_status=1)
IF @noRequests-@noUploaded <3
SET @returnedValue=1
ELSE
SET @returnedValue=0
RETURN @returnedValue
END
GO

CREATE PROCEDURE checkName
@name VARCHAR(255),
@out BIT OUTPUT
AS
	IF @name NOT LIKE '% % %'
		SELECT @out=0
	ELSE
		SELECT @out=1
GO

--1]
CREATE PROCEDURE Original_Content_Search 
@typename VARCHAR(255), 
@categoryname VARCHAR(255)
AS
IF @typename IS NOT NULL AND @categoryname IS NOT NULL
SELECT Original_Content.ID,Original_Content.content_manager_id,Original_Content.reviewer_id,Original_Content.review_status,Original_Content.filter_status,Original_Content.rating,Content.link,Content.uploaded_at,Content.contributer_id,Content.category_type,Content.subcategory_name,Content.[type]
FROM Original_Content
LEFT JOIN Content
ON Original_Content.ID=Content.ID
WHERE (category_type=@categoryname AND [type]=@typename) AND (Original_Content.filter_status=1 AND Original_Content.review_status=1)
ELSE
SELECT Original_Content.ID,Original_Content.content_manager_id,Original_Content.reviewer_id,Original_Content.review_status,Original_Content.filter_status,Original_Content.rating,Content.link,Content.uploaded_at,Content.contributer_id,Content.category_type,Content.subcategory_name,Content.[type]
FROM Original_Content
LEFT JOIN Content
ON Original_Content.ID=Content.ID
WHERE (category_type=@categoryname OR [type]=@typename) AND (Original_Content.filter_status=1 AND Original_Content.review_status=1)
GO

--2]
CREATE PROCEDURE Contributor_Search
@fullname VARCHAR(255)
AS
--METHOD 1 TO SPLIT STRINGS
--SELECT *
--INTO fullnametable
--FROM STRING_SPLIT(@fullname, ' ')
--SELECT @fn=(SELECT TOP 1 * FROM fullnametable)
--DELETE FROM fullnametable WHERE fullnametable.value=@fn
--SELECT @mn=(SELECT TOP 1 * FROM fullnametable)
--DELETE FROM fullnametable WHERE fullnametable.value=@mn
--SELECT @ln=(SELECT TOP 1 * FROM fullnametable)
--DROP TABLE fullnametable

--METHOD 2 to split String
/*DECLARE @fn VARCHAR(255)
DECLARE @mn VARCHAR(255)
DECLARE @ln VARCHAR(255)
SELECT @fn= LEFT(@fullname,CHARINDEX(' ',@fullname)-1)
SELECT @fullname=STUFF(@fullname,1,CHARINDEX(' ',@fullname),'')
SELECT @mn= LEFT(@fullname,CHARINDEX(' ',@fullname)-1)
SELECT @fullname=STUFF(@fullname,1,CHARINDEX(' ',@fullname),'')
SELECT @ln= @fullname
SELECT [User].ID, [User].email, [User].first_name, [User].middle_name, [User].last_name, [User].birth_date, [User].age,[User].last_login,[User].[status], Contributor.portfolio_link, Contributor.specialization, Contributor.years_of_experience,Contributor.notified_id
FROM Contributor
LEFT JOIN [User]
ON [User].ID=Contributor.ID
WHERE [User].first_name= @fn AND [User].middle_name=@mn AND [User].last_name=@ln
*/
--METHOD 3 USING LIKE
SELECT [User].ID, [User].email, [User].first_name, [User].middle_name, [User].last_name, [User].birth_date, [User].age,[User].last_login,[User].[status], Contributor.portfolio_link, Contributor.specialization, Contributor.years_of_experience,Contributor.notified_id
FROM Contributor
LEFT JOIN [User]
ON [User].ID=Contributor.ID
WHERE [User].first_name +' '+[User].middle_name+' '+[User].last_name LIKE @fullname
GO

--3]
CREATE PROCEDURE Register_User 
@usertype TINYINT,
@email VARCHAR(255), @password VARCHAR(255), 
@firstname VARCHAR(255),@middlename VARCHAR(255), @lastname VARCHAR(255), @birth_date DATETIME, 
@working_place_name VARCHAR(255), @working_place_type VARCHAR(255),@workring_place_description VARCHAR(500),
@specilization VARCHAR(255), @portofolio_link VARCHAR(500), @years_experience TINYINT, 
@hire_date DATETIME,@working_hours INT, @payment_rate DECIMAL(8,2), 
@user_id INT OUTPUT
AS
IF (@email IS NULL OR @password IS NULL OR @firstname IS NULL OR @middlename IS NULL OR @lastname IS NULL OR @birth_date IS NULL OR ((@working_place_name IS NULL OR @working_place_type IS NULL) AND @usertype=1) OR @usertype IS NULL)
OR (EXISTS(SELECT email FROM [User] WHERE @email=[User].email))
PRINT 'Some of the Required Fields are missing or your entered EMAIL is used'
ELSE
IF @usertype =1
BEGIN
	INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
	VALUES (@email,@firstname,@middlename,@lastname,@birth_date,@password)
	SET @user_id= IDENT_CURRENT('[User]')
	INSERT INTO Viewer (ID,working_place,working_place_type,working_place_description)
	VALUES (@user_id,@working_place_name,@working_place_type,@workring_place_description)
END
ELSE
IF @usertype=2
BEGIN
	INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
	VALUES (@email,@firstname,@middlename,@lastname,@birth_date,@password)
	SET @user_id= IDENT_CURRENT('[User]')
	INSERT INTO Notified_Person DEFAULT VALUES
	INSERT INTO Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id)
	VALUES (@user_id,@years_experience,@portofolio_link,@specilization,IDENT_CURRENT('Notified_Person'))
END
ELSE
IF @usertype=3
BEGIN
	INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
	VALUES (@email,@firstname,@middlename,@lastname,@birth_date,@password)
	SET @user_id= IDENT_CURRENT('[User]')
	INSERT INTO Notified_Person DEFAULT VALUES
	IF @hire_date IS NOT NULL
	BEGIN
		INSERT INTO Staff (ID,hire_date,working_hours,payment_rate,notified_id)
		VALUES (@user_id,@hire_date,@working_hours,@payment_rate,IDENT_CURRENT('Notified_Person'))
	END
	ELSE
	BEGIN
		INSERT INTO Staff (ID,working_hours,payment_rate,notified_id)
		VALUES (@user_id,@working_hours,@payment_rate,IDENT_CURRENT('Notified_Person'))
	END
	INSERT INTO Reviewer (ID)
	VALUES(@user_id)
END
ELSE
BEGIN
	INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
	VALUES (@email,@firstname,@middlename,@lastname,@birth_date,@password)
	SET @user_id= IDENT_CURRENT('[User]')
	INSERT INTO Notified_Person DEFAULT VALUES
	IF @hire_date IS NOT NULL
	BEGIN
		INSERT INTO Staff (ID,hire_date,working_hours,payment_rate,notified_id)
		VALUES (@user_id,@hire_date,@working_hours,@payment_rate,IDENT_CURRENT('Notified_Person'))
	END
	ELSE
	BEGIN
		INSERT INTO Staff (ID,working_hours,payment_rate,notified_id)
		VALUES (@user_id,@working_hours,@payment_rate,IDENT_CURRENT('Notified_Person'))
	END
	INSERT INTO Content_manager(ID)
	VALUES(@user_id)
END
GO

--4]
CREATE PROCEDURE Check_Type
@typename VARCHAR(255),
@content_manager_id INT
AS
IF EXISTS (SELECT [type] FROM Content_type WHERE Content_type.[type]=@typename)
BEGIN
	UPDATE Content_manager
	SET [type]=@typename
	WHERE Content_manager.ID=@content_manager_id
END
ELSE
BEGIN
	INSERT INTO Content_type ([type])
	VALUES (@typename)
	UPDATE Content_manager
	SET [type]=@typename
	WHERE Content_manager.ID=@content_manager_id
END
GO

--5]
CREATE PROCEDURE Order_Contributor
AS
SELECT [User].ID, [User].email, [User].first_name, [User].middle_name, [User].last_name, [User].birth_date, [User].age,[User].last_login,[User].[status], Contributor.portfolio_link, Contributor.specialization, Contributor.years_of_experience,Contributor.notified_id
FROM Contributor
LEFT JOIN [User]
ON [User].ID=Contributor.ID
ORDER BY years_of_experience DESC
GO

--6]
CREATE PROCEDURE Show_Original_Content
@contributor_id INT
AS
IF @contributor_id IS NULL
BEGIN
	SELECT Original_Content.ID,Original_Content.content_manager_id,Original_Content.reviewer_id,Original_Content.review_status,Original_Content.filter_status, Original_Content.rating, Content.link, Content.uploaded_at,Content.contributer_id, Content.category_type, Content.subcategory_name,Content.[type],[User].email, [User].first_name, [User].middle_name, [User].last_name, [User].birth_date, [User].age,[User].last_login,[User].[status], Contributor.portfolio_link, Contributor.specialization, Contributor.years_of_experience,Contributor.notified_id
	FROM Original_Content
	LEFT JOIN Content
	ON Original_Content.ID=Content.ID
	LEFT JOIN Contributor
	ON Content.contributer_id=Contributor.ID
	LEFT JOIN [User]
	ON [User].ID=Contributor.ID
	WHERE Original_Content.filter_status=1 AND Original_Content.review_status=1
END
ELSE
BEGIN
	SELECT Original_Content.ID,Original_Content.content_manager_id,Original_Content.reviewer_id,Original_Content.review_status,Original_Content.filter_status, Original_Content.rating, Content.link, Content.uploaded_at,Content.contributer_id, Content.category_type, Content.subcategory_name,Content.[type],[User].email, [User].first_name, [User].middle_name, [User].last_name, [User].birth_date, [User].age,[User].last_login,[User].[status], Contributor.portfolio_link, Contributor.specialization, Contributor.years_of_experience,Contributor.notified_id
	FROM Original_Content
	LEFT JOIN Content
	ON Original_Content.ID=Content.ID
	LEFT JOIN Contributor
	ON Content.contributer_id=Contributor.ID
	LEFT JOIN [User]
	ON [User].ID=Contributor.ID
	WHERE Original_Content.filter_status=1 AND Original_Content.review_status=1 AND Contributor.ID=@contributor_id
END
GO


--****************				"As a registered user, I should be able to ..."				********************--
GO

--1]
CREATE PROCEDURE User_login 
@email VARCHAR(255),
@password VARCHAR(255), 
@user_id INT OUTPUT
AS
DECLARE @last_login DATETIME
DECLARE @id INT
DECLARE @status BIT
DECLARE @diff INT
IF (NOT EXISTS (SELECT * FROM [User] WHERE [User].email=@email AND [User].[password]=@password))
BEGIN
	PRINT 'Wrong E-Mail or Password'
	SET @user_id=-1
END
ELSE
BEGIN
	SELECT @id = (SELECT [User].ID FROM [User] WHERE email=@email)
	SELECT @last_login = (SELECT [User].last_login FROM [User] WHERE email=@email)
	SELECT @status =(SELECT [User].status FROM [User] WHERE email=@email)
	SELECT @diff = DATEDIFF(DAY,@last_login,CURRENT_TIMESTAMP)
	IF @status =0 AND @diff >14
	BEGIN
		PRINT 'You Can not login because Your deactivated account has been inactive for over 2 weeks'
		SET @user_id=-1
	END
	ELSE
	BEGIN
		SET @user_id=@id
		UPDATE [User]
		SET [status]=1,last_login=CURRENT_TIMESTAMP
		WHERE [User].ID=@id
	END
END
GO

--2]
CREATE PROCEDURE Show_Profile
@user_id INT,
@email VARCHAR(255) OUTPUT, @password VARCHAR(255) OUTPUT, @firstname VARCHAR(255) OUTPUT, @middlename VARCHAR(255) OUTPUT,@lastname VARCHAR(255) OUTPUT, @birth_date DATETIME OUTPUT, 
@working_place_name VARCHAR(255) OUTPUT, @working_place_type VARCHAR(255) OUTPUT, @workring_place_description VARCHAR(500) OUTPUT,
@specilization VARCHAR(255) OUTPUT,@portofolio_link VARCHAR(500) OUTPUT, @years_experience INT OUTPUT, 
@hire_date DATETIME OUTPUT, @working_hours INT OUTPUT, @payment_rate DECIMAL(8,2) OUTPUT
AS
IF NOT EXISTS (SELECT [User].ID FROM [User] WHERE [User].ID=@user_id)
	PRINT 'User Does not Exist'
ELSE
BEGIN
	SET @email=(SELECT [User].email FROM [User] WHERE [User].ID = @user_id)
	SET @password=(SELECT [User].[password] FROM [User] WHERE [User].ID = @user_id)
	SET @firstname=(SELECT [User].first_name FROM [User] WHERE [User].ID = @user_id)
	SET @middlename=(SELECT [User].middle_name FROM [User] WHERE [User].ID = @user_id)
	SET @lastname=(SELECT [User].last_name FROM [User] WHERE [User].ID = @user_id)
	SET @birth_date=(SELECT [User].birth_date FROM [User] WHERE [User].ID = @user_id)
	SET @working_place_name=(SELECT Viewer.working_place FROM Viewer WHERE Viewer.ID = @user_id)
	SET @working_place_type=(SELECT Viewer.working_place_type FROM Viewer WHERE Viewer.ID = @user_id)
	SET @workring_place_description=(SELECT Viewer.working_place_description FROM Viewer WHERE Viewer.ID = @user_id)
	SET @specilization=(SELECT Contributor.specialization FROM Contributor WHERE Contributor.ID = @user_id)
	SET @portofolio_link=(SELECT Contributor.portfolio_link FROM Contributor WHERE Contributor.ID = @user_id)
	SET @years_experience=(SELECT Contributor.years_of_experience FROM Contributor WHERE Contributor.ID = @user_id)
	SET @hire_date=(SELECT Staff.hire_date FROM Staff WHERE Staff.ID = @user_id)
	SET @working_hours=(SELECT Staff.working_hours FROM Staff WHERE Staff.ID = @user_id)
	SET @payment_rate=(SELECT Staff.payment_rate FROM Staff WHERE Staff.ID = @user_id)
END
GO

--3]
CREATE PROCEDURE Edit_Profile 
@user_id INT,
@email VARCHAR(255) , @password VARCHAR(255) , @firstname VARCHAR(255) , @middlename VARCHAR(255) ,@lastname VARCHAR(255) , @birth_date DATETIME , 
@working_place_name VARCHAR(255) , @working_place_type VARCHAR(255) , @workring_place_description VARCHAR(500) ,
@specilization VARCHAR(255) ,@portofolio_link VARCHAR(500) , @years_experience INT , 
@hire_date DATETIME , @working_hours INT , @payment_rate DECIMAL(8,2)
AS
IF @email IS NOT NULL
UPDATE [User]
SET email=@email
WHERE @user_id=[User].ID

IF @password IS NOT NULL
UPDATE [User]
SET [User].[password]=@password
WHERE @user_id=[User].ID

IF @firstname IS NOT NULL
UPDATE [User]
SET first_name=@firstname
WHERE @user_id=[User].ID

IF @middlename IS NOT NULL
UPDATE [User]
SET middle_name=@middlename
WHERE @user_id=[User].ID

IF @lastname IS NOT NULL
UPDATE [User]
SET last_name=@lastname
WHERE @user_id=[User].ID

IF @birth_date IS NOT NULL
UPDATE [User]
SET birth_date=@birth_date
WHERE @user_id=[User].ID

IF @working_place_name IS NOT NULL
UPDATE Viewer
SET working_place=@working_place_name
WHERE @user_id=Viewer.ID

IF @working_place_type IS NOT NULL
UPDATE Viewer
SET working_place_type=@working_place_type
WHERE @user_id=Viewer.ID

IF @workring_place_description IS NOT NULL
UPDATE Viewer
SET working_place_description=@workring_place_description
WHERE @user_id=Viewer.ID

IF @specilization IS NOT NULL
UPDATE Contributor
SET specialization=@specilization
WHERE @user_id=Contributor.ID

IF @portofolio_link IS NOT NULL
UPDATE Contributor
SET portfolio_link=@portofolio_link
WHERE @user_id=Contributor.ID

IF @years_experience IS NOT NULL
UPDATE Contributor
SET years_of_experience=@years_experience
WHERE @user_id=Contributor.ID

IF @hire_date IS NOT NULL
UPDATE Staff
SET hire_date=@hire_date
WHERE @user_id=Staff.ID

IF @working_hours IS NOT NULL
UPDATE Staff
SET working_hours=@working_hours
WHERE @user_id=Staff.ID

IF @payment_rate IS NOT NULL
UPDATE Staff
SET payment_rate=@payment_rate
WHERE @user_id=Staff.ID
GO

--4]
CREATE PROCEDURE Deactivate_Profile 
@user_id INT
AS
UPDATE [User]
SET [status]=0
WHERE [User].ID=@user_id
GO

--5]
CREATE PROCEDURE Show_Event
@event_id INT
AS
IF EXISTS (SELECT * FROM [Event] WHERE [Event].id=@event_id)
BEGIN
	SELECT [Event].id,[Event].city , [Event].[description], [Event].entertainer,[Event].[location],[Event].notification_object_id,[Event].[time],[Event].viewer_id,Event_Photos_link.link AS 'Photos Link',Event_Videos_link.link AS 'Videos Link',[User].first_name,[User].middle_name,[USER].last_name
	FROM [Event]
	LEFT JOIN Event_Photos_link
	ON [Event].id=Event_Photos_link.event_id
	LEFT JOIN Event_Videos_link
	ON [Event].id=Event_Videos_link.event_id
	INNER JOIN [User]
	ON [Event].viewer_id=[User].ID
	WHERE [Event].id=@event_id
END
ELSE
BEGIN
	SELECT [Event].id,[Event].city , [Event].[description], [Event].entertainer,[Event].[location],[Event].notification_object_id,[Event].[time],[Event].viewer_id,Event_Photos_link.link AS 'Photos Link',Event_Videos_link.link AS 'Videos Link',[User].first_name,[User].middle_name,[USER].last_name
	FROM [Event]
	LEFT JOIN Event_Photos_link
	ON [Event].id=Event_Photos_link.event_id
	LEFT JOIN Event_Videos_link
	ON [Event].id=Event_Videos_link.event_id
	INNER JOIN [User]
	ON [Event].viewer_id=[User].ID
	WHERE [Event].[time] > CURRENT_TIMESTAMP
END
GO

--6]
CREATE PROCEDURE Show_Notification 
@user_id INT
AS
IF EXISTS (SELECT * FROM Contributor WHERE Contributor.ID=@user_id)
BEGIN
	UPDATE Announcement
	SET seen_at=CURRENT_TIMESTAMP
	WHERE Announcement.notified_person_id=(SELECT DISTINCT Announcement.notified_person_id FROM Announcement LEFT JOIN Contributor ON Contributor.notified_id=Announcement.notified_person_id WHERE Contributor.ID=@user_id) AND Announcement.seen_at IS NULL

	SELECT Announcement.ID,Announcement.seen_at,Announcement.sent_at,Announcement.notified_person_id,Announcement.notification_object_id,Contributor.ID AS 'Contributor ID',[Event].id,[Event].city , [Event].[description], [Event].entertainer,[Event].[location],[Event].[time],[Event].viewer_id,New_Request.id AS 'New Request ID',New_Request.accept_status,New_Request.accepted_at,New_Request.information,New_Request.specified,New_Request.viewer_id,New_Request.contributer_id
	FROM Announcement
	LEFT JOIN Contributor
	ON Contributor.notified_id=Announcement.notified_person_id
	LEFT JOIN [Event]
	ON [Event].notification_object_id=Announcement.notification_object_id
	LEFT JOIN New_Request
	ON New_Request.notif_obj_id=Announcement.notification_object_id
	WHERE Contributor.ID=@user_id
END
ELSE
BEGIN
	UPDATE Announcement
	SET seen_at=CURRENT_TIMESTAMP
	WHERE Announcement.notified_person_id=(SELECT DISTINCT Announcement.notified_person_id FROM Announcement LEFT JOIN Staff ON Staff.notified_id=Announcement.notified_person_id WHERE Staff.ID=@user_id) AND Announcement.seen_at IS NULL

	SELECT Announcement.ID,Announcement.seen_at,Announcement.sent_at,Announcement.notified_person_id,Announcement.notification_object_id,[Event].id,[Event].city , [Event].[description], [Event].entertainer,[Event].[location],[Event].[time],[Event].viewer_id
	FROM Announcement
	LEFT JOIN Staff
	ON Staff.notified_id=Announcement.notified_person_id
	LEFT JOIN [Event]
	ON [Event].notification_object_id=Announcement.notification_object_id
	WHERE Staff.ID=@user_id
END
GO

--7]
CREATE PROCEDURE Show_New_Content
@viewer_id INT,
@content_id INT
AS
IF @content_id IS NULL
BEGIN
	SELECT New_Content.ID, New_Content.new_request_id, Content.contributer_id , Content.link ,Content.category_type, Content.subcategory_name , Content.[type],Content.uploaded_at,[User].first_name,[User].middle_name,[User].last_name
	FROM New_Content
	LEFT JOIN  Content
	ON New_Content.ID=Content.ID
	LEFT JOIN New_Request
	ON New_Content.new_request_id=New_Request.id
	LEFT JOIN [User]
	ON Content.contributer_id=[User].ID
	WHERE New_Request.viewer_id=@viewer_id
END
ELSE
BEGIN
	SELECT New_Content.ID, New_Content.new_request_id, Content.contributer_id , Content.link ,Content.category_type, Content.subcategory_name , Content.[type],Content.uploaded_at,[User].first_name,[User].middle_name,[User].last_name
	FROM New_Content
	LEFT JOIN  Content
	ON New_Content.ID=Content.ID
	LEFT JOIN New_Request
	ON New_Content.new_request_id=New_Request.id
	LEFT JOIN [User]
	ON Content.contributer_id=[User].ID
	WHERE New_Request.viewer_id=@viewer_id AND New_Content.ID=@content_id
END
GO


--****************			As a Viewer (registered user), I should be able to ..."			********************--
GO

--1]
CREATE PROCEDURE Viewer_Create_Event
@city VARCHAR(255),
@event_date_time DATETIME,
@description VARCHAR(500),
@entartainer VARCHAR(255),
@viewer_id INT,
@location VARCHAR(255),
@event_id INT OUTPUT
AS
IF @event_date_time IS NULL OR @location IS NULL OR @city IS NULL
BEGIN
	PRINT 'Some of the required fields are missing'
	SET @event_id=-1
END
ELSE
BEGIN
	INSERT INTO Notification_Object DEFAULT VALUES
	INSERT INTO [Event] ([description],[location],city,[time],entertainer,notification_object_id,viewer_id)
	VALUES (@description,@location,@city,@event_date_time,@entartainer,IDENT_CURRENT('Notification_Object'),@viewer_id)
	INSERT INTO Announcement (sent_at,notified_person_id,notification_object_id)
	SELECT CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
	FROM Notified_Person
	SET @event_id=IDENT_CURRENT('[Event]')
END
GO

--2]
CREATE PROCEDURE Viewer_Upload_Event_Photo
@event_id INT,
@link VARCHAR(500)
AS
INSERT INTO Event_Photos_link(event_id,link)
VALUES (@event_id,@link)
GO
CREATE PROCEDURE Viewer_Upload_Event_Video 
@event_id INT,
@link VARCHAR(500)
AS
INSERT INTO Event_Videos_link(event_id,link)
VALUES (@event_id,@link)
GO

--3]
CREATE PROCEDURE Viewer_Create_Ad_From_Event 
@event_id INT
AS
DECLARE @description VARCHAR(500)
DECLARE @location VARCHAR(255)
DECLARE @viewer_id INT
SELECT @description=(SELECT [Event].[description] FROM [Event] WHERE [Event].id=@event_id)
SELECT @location=(SELECT [Event].[location] FROM [Event] WHERE [Event].id=@event_id)
SELECT @viewer_id=(SELECT [Event].viewer_id FROM [Event] WHERE [Event].id=@event_id)
INSERT INTO Advertisement([description],[location],event_id,viewer_id)
VALUES (@description,@location,@event_id,@viewer_id)
GO

--4]
CREATE PROCEDURE Apply_Existing_Request
@viewer_id INT,
@original_content_id INT
AS
IF (SELECT Original_Content.rating FROM Original_Content WHERE Original_Content.ID=@original_content_id) >=4
BEGIN
	INSERT INTO Existing_Request(original_content_id,viewer_id)
	VALUES (@original_content_id,@viewer_id)
END
ELSE
PRINT 'Sorry this original content can not be bought because it has a rating less than 4'
GO

--5]
CREATE PROCEDURE Apply_New_Request 
@information VARCHAR(500),
@contributor_id INT,
@viewer_id INT
AS
IF @contributor_id IS NULL
BEGIN
	INSERT INTO Notification_Object DEFAULT VALUES
	INSERT INTO New_Request (information,specified,viewer_id,notif_obj_id)
	VALUES (@information,0,@viewer_id,IDENT_CURRENT('Notification_Object'))
	INSERT INTO Announcement (sent_at,notified_person_id,notification_object_id)
	SELECT CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
	FROM Notified_Person
	INNER JOIN Contributor
	ON Contributor.notified_id=Notified_Person.ID
	WHERE dbo.checkContributorAvailablity (Contributor.ID)=1
END
ELSE
IF @contributor_id IS NOT NULL AND dbo.checkContributorAvailablity (@contributor_id)=1
BEGIN
	INSERT INTO Notification_Object DEFAULT VALUES
	INSERT INTO New_Request (information,specified,viewer_id,notif_obj_id,contributer_id)
	VALUES (@information,1,@viewer_id,IDENT_CURRENT('Notification_Object'),@contributor_id)
	INSERT INTO Announcement (sent_at,notified_person_id,notification_object_id)
	SELECT CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
	FROM Notified_Person
	INNER JOIN Contributor
	ON Contributor.notified_id=Notified_Person.ID
	WHERE Contributor.ID=@contributor_id
END
ELSE
PRINT 'This Contributor already has 3 pending requests'
GO

--6]
CREATE PROCEDURE Delete_New_Request 
@request_id INT
AS
IF (SELECT New_Request.accept_status FROM New_Request WHERE New_Request.id=@request_id)=1
PRINT 'Sorry you can not delete the request now as a contributer already accepted it and is currently working on it'
ELSE
BEGIN
	DELETE FROM New_Request
	WHERE New_Request.id=@request_id
END
GO

--7]
CREATE PROCEDURE Rating_Original_Content  
@orignal_content_id INT,
@rating_value INT,
@viewer_id INT
AS
IF @rating_value >5 OR @rating_value <0
PRINT 'Invalid Rating, Please give a rating between 0 and 5'
ELSE
IF EXISTS (SELECT * FROM Rate WHERE @viewer_id=rate.viewer_id AND @orignal_content_id=rate.original_content_id)
PRINT 'You already rated this item'
ELSE
BEGIN
	INSERT INTO Rate (viewer_id,original_content_id,[date],rate)
	VALUES (@viewer_id,@orignal_content_id,CURRENT_TIMESTAMP,@rating_value)
	DECLARE @sum_ratings INT
	DECLARE @total_ratings INT
	SELECT @sum_ratings=(SELECT SUM(Rate.rate) FROM Rate WHERE @orignal_content_id=Rate.original_content_id)
	SELECT @total_ratings=(SELECT COUNT(*) FROM Rate WHERE @orignal_content_id=Rate.original_content_id)
	UPDATE Original_Content
	SET rating=@sum_ratings/@total_ratings
	WHERE @orignal_content_id=Original_Content.ID
END
GO

--8]
CREATE PROCEDURE Write_Comment
@comment_text VARCHAR(500),
@viewer_id INT,
@original_content_id INT,
@written_time DATETIME
AS
INSERT INTO Comment (Viewer_id,original_content_id,[date],[text])
VALUES (@viewer_id,@original_content_id,@written_time,@comment_text)
GO

--9]
CREATE PROCEDURE Edit_Comment 
@comment_text VARCHAR(500),
@viewer_id INT,
@original_content_id INT,
@last_written_time DATETIME,
@updated_written_time DATETIME
AS
UPDATE Comment
SET [text]=@comment_text , [date]=@updated_written_time
WHERE [date]=@last_written_time AND Viewer_id=@viewer_id AND original_content_id=@original_content_id
GO

--10]
CREATE PROCEDURE Delete_Comment 
@viewer_id INT,
@original_content_id INT,
@written_time DATETIME
AS
DELETE FROM Comment WHERE Viewer_id=@viewer_id AND original_content_id=@original_content_id AND [date]=@written_time
GO

--11]
CREATE PROCEDURE Create_Ads 
@viewer_id INT,
@description VARCHAR(500),
@location VARCHAR (255)
AS
INSERT INTO Advertisement (viewer_id,[description],[location])
VALUES (@viewer_id,@description,@location)
GO

--12]
CREATE PROCEDURE Edit_Ad
@ad_id INT,
@description VARCHAR(500),
@location VARCHAR(255)
AS
IF @description IS NOT NULL
BEGIN
	UPDATE Advertisement
	SET [description]=@description
	WHERE Advertisement.id=@ad_id
END
IF @location IS NOT NULL
BEGIN
	UPDATE Advertisement
	SET [location]=@location
	WHERE Advertisement.id=@ad_id
END
GO

--13]
CREATE PROCEDURE Delete_Ads 
@ad_id INT
AS
DELETE Advertisement
WHERE Advertisement.id=@ad_id
GO

--14]
CREATE PROCEDURE Send_Message 
@msg_text VARCHAR(500),
@viewer_id INT,
@contributor_id INT,
@sender_type BIT,
@sent_at DATETIME
AS
INSERT INTO [Message] (sent_at,contributer_id,viewer_id,sender_type,[text])
VALUES (@sent_at,@contributor_id,@viewer_id,@sender_type,@msg_text)
GO

--15]
CREATE PROCEDURE Show_Message 
@contributor_id INT
AS
UPDATE [Message]
SET read_at=CURRENT_TIMESTAMP,read_status=1
WHERE contributer_id=@contributor_id

SELECT *
FROM [Message]
WHERE [Message].contributer_id=@contributor_id
GO

--16]
CREATE PROCEDURE Highest_Rating_Original_content
AS
DECLARE @max DECIMAL(2,1) = (SELECT MAX(Original_Content.rating) FROM Original_Content)
SELECT Original_Content.ID,Original_Content.content_manager_id,Original_Content.reviewer_id,Original_Content.filter_status,Original_Content.review_status,Original_Content.rating,Content.link,Content.uploaded_at,Content.contributer_id,Content.category_type,Content.subcategory_name,Content.[type]
FROM Original_Content
LEFT JOIN Content
ON Original_Content.ID=Content.ID
WHERE Original_Content.rating=@max
GO

--17]
CREATE PROCEDURE Assign_New_Request 
@request_id INT,
@contributor_id INT
AS
IF (SELECT New_Request.accept_status FROM New_Request WHERE New_Request.id=@request_id) IS NULL
BEGIN
	DECLARE @objid INT=(SELECT New_Request.notif_obj_id FROM New_Request WHERE New_Request.id=@request_id)
	IF @contributor_id IS NULL
	BEGIN
		DELETE FROM Announcement
		WHERE Announcement.notification_object_id=@objid

		INSERT INTO Announcement (sent_at,notified_person_id,notification_object_id)
		SELECT CURRENT_TIMESTAMP, Notified_Person.ID, @objid
		FROM Notified_Person
		INNER JOIN Contributor
		ON Contributor.notified_id=Notified_Person.ID
		WHERE dbo.checkContributorAvailablity (Contributor.ID)=1

		UPDATE New_Request
		SET contributer_id=@contributor_id,specified=0
		WHERE New_Request.id=@request_id
	END
	ELSE
	IF @contributor_id IS NOT NULL AND (dbo.checkContributorAvailablity (@contributor_id)=1)
	BEGIN
		DELETE FROM Announcement
		WHERE Announcement.notification_object_id=@objid

		INSERT INTO Announcement (sent_at,notified_person_id,notification_object_id)
		SELECT CURRENT_TIMESTAMP, Notified_Person.ID, @objid
		FROM Notified_Person
		INNER JOIN Contributor
		ON Contributor.notified_id=Notified_Person.ID
		WHERE Contributor.ID=@contributor_id

		UPDATE New_Request
		SET contributer_id=@contributor_id,specified=1
		WHERE New_Request.id=@request_id
	END
	ELSE
		PRINT 'This Contributor already has 3 pending requests'
END
ELSE
PRINT 'This Request has already been accepted/rejected by a contributor'
GO

--****************			“As a contributor, I should be able to ...”			********************--
GO

--1]
CREATE PROCEDURE Receive_New_Requests 
@request_id INT,
@contributor_id INT
AS
IF @request_id IS NULL
BEGIN
	SELECT *
	FROM New_Request
	WHERE New_Request.specified=0 OR New_Request.contributer_id=@contributor_id
END
ELSE
BEGIN
	SELECT *
	FROM New_Request
	WHERE New_Request.id=@request_id AND New_Request.contributer_id=@contributor_id
END
GO

--2]
CREATE PROCEDURE Respond_New_Request
@contributor_id INT,
@accept_status BIT,
@request_id INT
AS
IF (SELECT New_Request.accept_status FROM New_Request WHERE New_Request.id=@request_id) =1
PRINT 'This Request has already been accepted/rejected by some other contributer'
ELSE
IF (SELECT New_Request.specified FROM New_Request WHERE New_Request.id=@request_id)=1 OR ((SELECT New_Request.specified FROM New_Request WHERE New_Request.id=@request_id)=0 AND @accept_status=1)
BEGIN
	UPDATE New_Request
	SET accept_status=@accept_status, contributer_id=@contributor_id
	WHERE New_Request.id=@request_id
END
ELSE
BEGIN	--This is done when a contributer rejects a new request that is sent to all contributers , rejecting it just removes the request from his notifications
	DECLARE @notifedperson INT
	DECLARE @objid INT
	SET @notifedperson = (SELECT Contributor.notified_id FROM Contributor WHERE Contributor.ID=@contributor_id)
	SET @objid=(SELECT New_Request.notif_obj_id FROM New_Request WHERE New_Request.id=@request_id)
	DELETE FROM Announcement
	WHERE Announcement.notified_person_id=@notifedperson AND Announcement.notification_object_id=@objid
END
GO

--3]
CREATE PROCEDURE Upload_Original_Content 
@type_id VARCHAR(255),
@subcategory_name VARCHAR(255), 
@category_id VARCHAR(255),
@contributor_id INT,
@link VARCHAR(500)
AS
INSERT INTO Content (link,uploaded_at,contributer_id,category_type,subcategory_name,[type])
VALUES (@link,CURRENT_TIMESTAMP,@contributor_id,@category_id,@subcategory_name,@type_id)
INSERT INTO Original_Content (ID)
VALUES (IDENT_CURRENT('Content'))
GO

--4]
CREATE PROCEDURE Upload_New_Content
@new_request_id INT,
@contributor_id INT,
@subcategory_name VARCHAR(255),
@category_id VARCHAR(255),
@link VARCHAR(500)
AS
INSERT INTO Content (link,uploaded_at,contributer_id,category_type,subcategory_name)
VALUES (@link,CURRENT_TIMESTAMP,@contributor_id,@category_id,@subcategory_name)
INSERT INTO New_Content (ID,new_request_id)
VALUES (IDENT_CURRENT('Content'),@new_request_id)
GO

--5]
CREATE PROCEDURE Delete_Content 
@content_id INT
AS
IF ((SELECT Original_Content.review_status FROM Original_Content WHERE Original_Content.ID=@content_id) IS NOT NULL AND (SELECT Original_Content.filter_status FROM Original_Content WHERE Original_Content.ID=@content_id) IS NULL)
PRINT 'This Content is already being filtered'
ELSE
BEGIN
	DELETE FROM Rate
	WHERE Rate.original_content_id=@content_id

	DELETE FROM Comment
	WHERE Comment.original_content_id=@content_id

	DELETE FROM Existing_Request
	WHERE Existing_Request.original_content_id=@content_id

	DELETE FROM Original_Content
	WHERE Original_Content.ID=@content_id

	DELETE FROM New_Content
	WHERE New_Content.ID=@content_id

	DELETE FROM Content
	WHERE Content.ID=@content_id
END
GO

--6]
CREATE PROCEDURE Receive_New_Request 
@contributor_id INT,
@can_receive BIT OUTPUT
AS
DECLARE @countuploaded INT
SELECT @countuploaded=(
				SELECT COUNT(*)
				FROM New_Request 
				INNER JOIN New_Content
				ON New_Content.new_request_id=New_Request.id
				WHERE New_Request.contributer_id=@contributor_id)

DECLARE @countrequests INT
SELECT @countrequests=(SELECT COUNT(*) FROM New_Request WHERE New_Request.contributer_id=@contributor_id AND New_Request.accept_status=1)
IF @countrequests-@countuploaded <3
SET @can_receive=1
ELSE
SET @can_receive=0
GO

--****************			“As a staff member, I should be able to ...” EXECUTIONS			********************--
GO

--1]
CREATE PROCEDURE reviewer_filter_content
@reviewer_id INT,
@original_content INT,
@status BIT
AS
UPDATE Original_Content
SET review_status=@status, reviewer_id=@reviewer_id
WHERE Original_Content.ID=@original_content
GO

--2]
CREATE PROCEDURE content_manager_filter_content 
@content_manager_id INT,
@original_content INT,
@status BIT
AS
IF ((SELECT Content.[type] FROM Content WHERE Content.ID=@original_content) = (SELECT Content_manager.[type] FROM Content_manager WHERE Content_manager.ID=@content_manager_id)) AND (SELECT Original_Content.review_status FROM Original_Content WHERE Original_Content.ID=@original_content)=1
UPDATE Original_Content
SET filter_status=@status , content_manager_id=@content_manager_id
WHERE Original_Content.ID=@original_content
GO

--3]
CREATE PROCEDURE Staff_Create_Category 
@category_name VARCHAR(255)
AS
IF NOT EXISTS (SELECT * FROM Category WHERE Category.[type] = @category_name)
BEGIN
	INSERT INTO Category ([type])
	VALUES (@category_name)
END
GO

--4]
CREATE PROCEDURE Staff_Create_Subcategory
@category_name VARCHAR(255),
@subcategory_name VARCHAR(255)
AS
IF NOT EXISTS (SELECT * FROM Category WHERE Category.[type] = @category_name)
BEGIN
	INSERT INTO Category ([type])
	VALUES (@category_name)
END
IF NOT EXISTS (SELECT * FROM Sub_Category WHERE Sub_Category.[name] = @subcategory_name AND Sub_Category.category_type=@category_name)
BEGIN
	INSERT INTO Sub_Category (category_type,[name])
	VALUES (@category_name,@subcategory_name)
END
GO

--5]
CREATE PROCEDURE Staff_Create_Type 
@type_name VARCHAR(255)
AS
IF NOT EXISTS (SELECT * FROM Content_type WHERE Content_type.[type]=@type_name)
BEGIN
	INSERT INTO Content_type([type])
	VALUES (@type_name)
END
GO

--6]
CREATE PROCEDURE Most_Requested_Content
AS
SELECT Original_Content.ID, COUNT(Existing_Request.id) AS 'Number of Requests'
FROM Original_Content
LEFT JOIN Existing_Request
ON Existing_Request.original_content_id=Original_Content.ID
GROUP BY Original_Content.ID
ORDER BY COUNT(Existing_Request.id) DESC
GO

--7]
CREATE PROCEDURE Workingplace_Category_Relation
AS
SELECT Content.ID AS 'content', New_Request.id AS 'newreqid', New_Request.viewer_id AS 'viewer', Content.category_type AS 'cat'
INTO newreq
FROM New_Content
LEFT JOIN New_Request
ON New_Request.id=New_Content.new_request_id
LEFT JOIN Content
ON Content.ID=New_Content.ID

SELECT Content.ID AS 'content', Existing_Request.id AS 'eid', Existing_Request.viewer_id AS 'viewer', Content.category_type AS 'cat'
INTO ereq
FROM Existing_Request
LEFT JOIN Content
ON Content.ID=Existing_Request.original_content_id

SELECT Viewer.working_place_type AS 'type',Category.[type] AS 'cat', Viewer.ID AS 'viewer'
INTO cat
FROM Category
CROSS JOIN Viewer

SELECT *
INTO both
FROM newreq
UNION
SELECT *
FROM ereq

SELECT cat.[type], cat.cat, COUNT(both.cat)
FROM cat
LEFT JOIN both
ON both.cat=cat.cat AND both.viewer=cat.viewer
GROUP BY cat.cat, cat.[type]

DROP TABLE ereq;
DROP TABLE newreq;
DROP TABLE cat;
DROP TABLE both;
GO

--8]
/* ALREADY IMPLEMENTED
CREATE PROCEDURE Delete_Comment
@viewer_id INT,
@original_content_id INT,
@comment_time DATETIME
AS
DELETE FROM Comment
WHERE Comment.Viewer_id=@viewer_id AND Comment.original_content_id=@original_content_id AND Comment.[date]=@comment_time
GO
*/
GO

--9]
CREATE PROCEDURE Delete_Original_Content 
@content_id INT
AS
DELETE FROM Rate
WHERE Rate.original_content_id=@content_id

DELETE FROM Comment
WHERE Comment.original_content_id=@content_id

DELETE FROM Existing_Request
WHERE Existing_Request.original_content_id=@content_id

DELETE FROM Original_Content
WHERE Original_Content.ID=@content_id

DELETE FROM Content
WHERE Content.ID=@content_id
GO

--10]
CREATE PROCEDURE Delete_New_Content 
@content_id INT
AS
DELETE FROM New_Content
WHERE New_Content.ID=@content_id 

DELETE FROM Content
WHERE Content.ID=@content_id
GO

--11]
CREATE PROCEDURE Assign_Contributor_Request 
@contributor_id INT,
@new_request_id INT
AS
IF (dbo.checkContributorAvailablity (@contributor_id)=1)
	UPDATE New_Request
	SET contributer_id=@contributor_id
	WHERE New_Request.id=@new_request_id
ELSE
	PRINT 'This Contributor already has 3 pending requests'
GO

--12]
CREATE PROCEDURE Show_Possible_Contributors
AS
SELECT Contributor.ID AS 'Contributor ID', COUNT(New_Content.ID) AS 'Total Handled Requests throughout History'
FROM Contributor
LEFT JOIN New_Request
ON New_Request.contributer_id=Contributor.ID
LEFT JOIN New_Content
ON New_Content.new_request_id=New_Request.id
LEFT JOIN Content
ON Content.ID=New_Content.ID
GROUP BY Contributor.ID
HAVING COUNT(New_Request.ID)-COUNT(New_Content.ID) <3
ORDER BY ISNULL(AVG(DATEDIFF(DAY,accepted_at,uploaded_at)),999999), COUNT(New_Content.ID) DESC
GO
