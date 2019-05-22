USE IEgypt_95;
GO

--1]a) 3 Categories
INSERT INTO Category ([type],[description])
VALUES ('Educational','MAFESH TA3LEEM HENAA')
INSERT INTO Category ([type],[description])
VALUES ('Investment','MAFESH IVESTMENTS BARDO')
INSERT INTO Category ([type],[description])
VALUES ('Tourism','BARDO MAFESH SYAA7A ADADADADADA')
--1]b) 2 Sub-Categories
INSERT INTO Sub_Category (category_type,[name])
VALUES ('Educational','High School');
INSERT INTO Sub_Category (category_type,[name])
VALUES ('Educational','Higher Education');

INSERT INTO Sub_Category (category_type,[name])
VALUES ('Investment','Banks');
INSERT INTO Sub_Category (category_type,[name])
VALUES ('Investment','Projects');

INSERT INTO Sub_Category (category_type,[name])
VALUES ('Tourism','Hotels');
INSERT INTO Sub_Category (category_type,[name])
VALUES ('Tourism','Costal Beaches');

--------------------------------------------------------------------------------------------------
GO

--2]a) 3 Viewers
INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('viewer_1_email','viewer_1_fn','viewer_1_mn','viewer_1_ln','1-1-1990','123')
INSERT INTO Viewer (ID,working_place,working_place_type,working_place_description)
VALUES (1,'viewer_1_workingplace','viewer_1_workingplacetype','viewer_1_workingplacedescription')

INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('viewer_2_email','viewer_2_fn','viewer_2_mn','viewer_2_ln','1-1-1990','123')
INSERT INTO Viewer (ID,working_place,working_place_type,working_place_description)
VALUES (2,'viewer_2_workingplace','viewer_2_workingplacetype','viewer_2_workingplacedescription')

INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('viewer_3_email','viewer_3_fn','viewer_3_mn','viewer_3_ln','1-1-1990','123')
INSERT INTO Viewer (ID,working_place,working_place_type,working_place_description)
VALUES (3,'viewer_3_workingplace','viewer_3_workingplacetype','viewer_3_workingplacedescription')

--2]b) 5 Contributors
INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('Contributor_1_email','Contributor_1_fn','Contributor_1_mn','Contributor_1_ln','1-1-1990','123')
INSERT INTO Notified_Person DEFAULT VALUES
INSERT INTO Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id)
VALUES (4,1,'tumblr.com/1','specialization',1)

INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('Contributor_2_email','Contributor_2_fn','Contributor_2_mn','Contributor_2_ln','1-1-1990','123')
INSERT INTO Notified_Person DEFAULT VALUES
INSERT INTO Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id)
VALUES (5,2,'tumblr.com/2','specialization',2)

INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('Contributor_3_email','Contributor_3_fn','Contributor_3_mn','Contributor_3_ln','1-1-1990','123')
INSERT INTO Notified_Person DEFAULT VALUES
INSERT INTO Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id)
VALUES (6,3,'tumblr.com/3','specialization',3)

INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('Contributor_4_email','Contributor_4_fn','Contributor_4_mn','Contributor_4_ln','1-1-1990','123')
INSERT INTO Notified_Person DEFAULT VALUES
INSERT INTO Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id)
VALUES (7,4,'tumblr.com/4','specialization',4)

INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('Contributor_5_email','Contributor_5_fn','Contributor_5_mn','Contributor_5_ln','1-1-1990','123')
INSERT INTO Notified_Person DEFAULT VALUES
INSERT INTO Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id)
VALUES (8,5,'tumblr.com/5','specialization',5)

--2]c)  2 authorized reviewers
INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('AR_1_email','AR_1_fn','AR_1_mn','AR_1_ln','1-1-1990','123')
INSERT INTO Notified_Person DEFAULT VALUES
INSERT INTO Staff (ID,working_hours,payment_rate,notified_id)
VALUES (9,40,1000,6)
INSERT INTO Reviewer (ID)
VALUES(9)

INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('AR_2_email','AR_2_fn','AR_2_mn','AR_2_ln','1-1-1990','123')
INSERT INTO Notified_Person DEFAULT VALUES
INSERT INTO Staff (ID,working_hours,payment_rate,notified_id)
VALUES (10,40,1000,7)
INSERT INTO Reviewer (ID)
VALUES(10)

--2]d) 3 Content Managers
INSERT INTO Content_type ([type])
VALUES ('Logo')
INSERT INTO Content_type ([type])
VALUES ('Banner')

INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('CM_1_email','CM_1_fn','CM_1_mn','CM_1_ln','1-1-1990','123')
INSERT INTO Notified_Person DEFAULT VALUES
INSERT INTO Staff (ID,working_hours,payment_rate,notified_id)
VALUES (11,40,2000,8)
INSERT INTO Content_manager(ID,[type])
VALUES(11,'Logo')

INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('CM_2_email','CM_2_fn','CM_2_mn','CM_2_ln','1-1-1990','123')
INSERT INTO Notified_Person DEFAULT VALUES
INSERT INTO Staff (ID,working_hours,payment_rate,notified_id)
VALUES (12,40,2000,9)
INSERT INTO Content_manager(ID,[type])
VALUES(12,'Banner')

INSERT INTO [User] (email,first_name,middle_name,last_name,birth_date,[password])
VALUES ('CM_3_email','CM_3_fn','CM_3_mn','CM_3_ln','1-1-1990','123')
INSERT INTO Notified_Person DEFAULT VALUES
INSERT INTO Staff (ID,working_hours,payment_rate,notified_id)
VALUES (13,40,2000,10)
INSERT INTO Content_manager(ID,[type])
VALUES(13,'Logo')

------------------------------------------------------------------------------------------------------
GO

--4] 3 Original Content
INSERT INTO Content (link,contributer_id,category_type,subcategory_name,[type])
VALUES ('some link1',4,'Educational','High School','Logo')
INSERT INTO Original_Content (ID,content_manager_id,reviewer_id,review_status,filter_status)
VALUES (1,11,9,1,1)

INSERT INTO Content (link,contributer_id,category_type,subcategory_name,[type])
VALUES ('some link2',4,'Educational','High School','Logo')
INSERT INTO Original_Content (ID,content_manager_id,reviewer_id,review_status,filter_status)
VALUES (2,11,9,1,1)

INSERT INTO Content (link,contributer_id,category_type,subcategory_name,[type])
VALUES ('some link3',4,'Educational','High School','Logo')
INSERT INTO Original_Content (ID,content_manager_id,reviewer_id,review_status,filter_status)
VALUES (3,11,9,1,1)

-----------------------------------------------------------------------------------------------------
GO

--3]a) 2 Existing Requests
INSERT INTO Existing_Request (original_content_id,viewer_id)
VALUES (1,1)

INSERT INTO Existing_Request (original_content_id,viewer_id)
VALUES (2,1)

--3]b) 2 New Requests with same contributor and is accepted & 6] Add the new requests into notification object table
INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (accepted_at,accept_status,information,specified,viewer_id,notif_obj_id,contributer_id)
VALUES (CURRENT_TIMESTAMP,1,'info',1,1,1,4)
INSERT INTO Announcement (seen_at,sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID
WHERE Contributor.ID=4

INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (accepted_at,accept_status,information,specified,viewer_id,notif_obj_id,contributer_id)
VALUES (CURRENT_TIMESTAMP,1,'info',1,2,2,4)
INSERT INTO Announcement (seen_at,sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID
WHERE Contributor.ID=4

--3]c) 3 New Requests with a different contributor from the first 2 requests
INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (accepted_at,accept_status,information,specified,viewer_id,notif_obj_id,contributer_id)
VALUES (CURRENT_TIMESTAMP,1,'info',1,1,3,5)
INSERT INTO Announcement (seen_at,sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID
WHERE Contributor.ID=5

INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (accepted_at,accept_status,information,specified,viewer_id,notif_obj_id,contributer_id)
VALUES (CURRENT_TIMESTAMP,1,'info',1,2,4,5)
INSERT INTO Announcement (seen_at,sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID
WHERE Contributor.ID=5

INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (accepted_at,accept_status,information,specified,viewer_id,notif_obj_id,contributer_id)
VALUES (CURRENT_TIMESTAMP,1,'info',1,3,5,5)
INSERT INTO Announcement (seen_at,sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID
WHERE Contributor.ID=5

--3]d) 3 New Requests with different contributors and accepted , moreover they don't have content
INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (accepted_at,accept_status,specified,viewer_id,notif_obj_id,contributer_id)
VALUES (CURRENT_TIMESTAMP,1,1,1,6,4)
INSERT INTO Announcement (seen_at,sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID
WHERE Contributor.ID=4

INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (accepted_at,accept_status,specified,viewer_id,notif_obj_id,contributer_id)
VALUES (CURRENT_TIMESTAMP,1,1,2,7,5)
INSERT INTO Announcement (seen_at,sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP,CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID
WHERE Contributor.ID=5

INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (accepted_at,accept_status,specified,viewer_id,notif_obj_id,contributer_id)
VALUES (CURRENT_TIMESTAMP,1,1,3,8,6)
INSERT INTO Announcement (seen_at,sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID
WHERE Contributor.ID=6

--3]e) 3 New Requests with no contributors specefied and they are not accepted
INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (information,specified,viewer_id,notif_obj_id)
VALUES ('info',0,1,9)
INSERT INTO Announcement (sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID

INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (information,specified,viewer_id,notif_obj_id)
VALUES ('info',0,1,10)
INSERT INTO Announcement (sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID

INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO New_Request (information,specified,viewer_id,notif_obj_id)
VALUES ('info',0,1,11)
INSERT INTO Announcement (sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person
INNER JOIN Contributor
ON Contributor.notified_id=Notified_Person.ID

------------------------------------------------------------------------------------------------------
GO

--5] 2 Events & 6] Add the events into the notification object table
INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO [Event] ([description],[location],city,[time],entertainer,notification_object_id,viewer_id)
VALUES ('Event 1 Description','GUC','Cairo','12/12/2018 12:00:00 AM','Event 1 Entertainer',12,1)
INSERT INTO Announcement (sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person

INSERT INTO Notification_Object DEFAULT VALUES
INSERT INTO [Event] ([description],[location],city,[time],entertainer,notification_object_id,viewer_id)
VALUES ('Event 2 Description','GUC','Cairo','1/1/2018 12:00:00 AM','Event 2 Entertainer',13,1)
INSERT INTO Announcement (sent_at,notified_person_id,notification_object_id)
SELECT CURRENT_TIMESTAMP, Notified_Person.ID, IDENT_CURRENT('Notification_Object')
FROM Notified_Person

------------------------------------------------------------------------------------------------------
GO

--6] Create 2 advertisements by a viewer
INSERT INTO Advertisement ([description],[location],event_id,viewer_id)
VALUES ('some ad about some organization','New Cairo 5th District',2,1)
INSERT INTO Ads_Photos_Link(advertisement_id,link)
VALUES (1,'some photos link')

INSERT INTO Advertisement ([description],[location],event_id,viewer_id)
VALUES ('some ad about some other organization','New Cairo 5th District',2,2)