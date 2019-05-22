USE IEgypt_95;
GO

--****************		"As a registered/unregistered user, I should be able to ..." EXECUTIONS		********************--
GO

--1]
DECLARE 
@typename VARCHAR(255)='Logo',
@categoryname VARCHAR(255)
EXEC Original_Content_Search @typename, @categoryname
GO

--2]
DECLARE 
@fullname VARCHAR(255) = 'Contributor_1_fn Contributor_1_mn Contributor_1_ln'
EXEC Contributor_Search @fullname
GO

--3]
GO
--To Register as a Viewer
DECLARE
@usertype TINYINT=1,
@email VARCHAR(255)='viewer_4_email', @password VARCHAR(255)='123', 
@firstname VARCHAR(255)='viewer_4_fn',@middlename VARCHAR(255)='viewer_4_mn', @lastname VARCHAR(255)='viewer_4_ln', @birth_date DATETIME='1-1-1990', 
@working_place_name VARCHAR(255)='viewer_4_workingplace', @working_place_type VARCHAR(255)='viewer_4_workingplacetype',@workring_place_description VARCHAR(500),
@specilization VARCHAR(255), @portofolio_link VARCHAR(500), @years_experience TINYINT, 
@hire_date DATETIME,@working_hours INT, @payment_rate DECIMAL(8,2), 
@user_id INT
EXEC Register_User @usertype, @email, @password, @firstname,@middlename, @lastname, @birth_date, @working_place_name, @working_place_type,@workring_place_description, @specilization, @portofolio_link, @years_experience, @hire_date,@working_hours, @payment_rate,@user_id OUTPUT
GO
--To Register as a Contributor
DECLARE
@usertype TINYINT=2,
@email VARCHAR(255)='Contributor_6_email', @password VARCHAR(255)='123', 
@firstname VARCHAR(255)='Contributor_6_fn',@middlename VARCHAR(255)='Contributor_6_mn', @lastname VARCHAR(255)='Contributor_6_ln', @birth_date DATETIME='1-1-1990', 
@working_place_name VARCHAR(255), @working_place_type VARCHAR(255),@workring_place_description VARCHAR(500),
@specilization VARCHAR(255)='Specialization', @portofolio_link VARCHAR(500)='tumblr.com/6', @years_experience TINYINT=55, 
@hire_date DATETIME,@working_hours INT, @payment_rate DECIMAL(8,2), 
@user_id INT
EXEC Register_User @usertype, @email, @password, @firstname,@middlename, @lastname, @birth_date, @working_place_name, @working_place_type,@workring_place_description, @specilization, @portofolio_link, @years_experience, @hire_date,@working_hours, @payment_rate,@user_id OUTPUT
GO
--To Register as an Authorized Reviewer
DECLARE
@usertype TINYINT=3,
@email VARCHAR(255)='AR_3_email', @password VARCHAR(255)='123', 
@firstname VARCHAR(255)='AR_3_fn',@middlename VARCHAR(255)='AR_3_mn', @lastname VARCHAR(255)='AR_3_ln', @birth_date DATETIME='1-1-1990', 
@working_place_name VARCHAR(255), @working_place_type VARCHAR(255),@workring_place_description VARCHAR(500),
@specilization VARCHAR(255), @portofolio_link VARCHAR(500), @years_experience TINYINT, 
@hire_date DATETIME,@working_hours INT=50, @payment_rate DECIMAL(8,2)=1000, 
@user_id INT
EXEC Register_User @usertype, @email, @password, @firstname,@middlename, @lastname, @birth_date, @working_place_name, @working_place_type,@workring_place_description, @specilization, @portofolio_link, @years_experience, @hire_date,@working_hours, @payment_rate,@user_id OUTPUT
GO
--To Register as a Content Manager
DECLARE
@usertype TINYINT=4,
@email VARCHAR(255)='CM_4_email', @password VARCHAR(255)='123', 
@firstname VARCHAR(255)='CM_4_fn',@middlename VARCHAR(255)='CM_4_mn', @lastname VARCHAR(255)='CM_4_ln', @birth_date DATETIME='1-1-1990', 
@working_place_name VARCHAR(255), @working_place_type VARCHAR(255),@workring_place_description VARCHAR(500),
@specilization VARCHAR(255), @portofolio_link VARCHAR(500), @years_experience TINYINT, 
@hire_date DATE='1-1-2018',@working_hours INT=50, @payment_rate DECIMAL(8,2)=2000, 
@user_id INT
EXEC Register_User @usertype, @email, @password, @firstname,@middlename, @lastname, @birth_date, @working_place_name, @working_place_type,@workring_place_description, @specilization, @portofolio_link, @years_experience, @hire_date,@working_hours, @payment_rate,@user_id OUTPUT
GO

--4]
DECLARE 
@typename VARCHAR(255)='Image',
@content_manager_id INT=11
EXEC Check_Type @typename, @content_manager_id
GO

--5]
EXEC Order_Contributor
GO

--6]
DECLARE
@contributor_id INT
EXEC Show_Original_Content @contributor_id
GO

--****************		"As a registered user, I should be able to ..." EXECUTIONS		********************--
GO

--1]
DECLARE
@email VARCHAR(255)='viewer_1_email',
@password VARCHAR(255)='123',
@user_id INT
EXEC User_login @email, @password, @user_id OUTPUT
GO

--2]
DECLARE
@user_id INT=1,
@email VARCHAR(255) , @password VARCHAR(255) , @firstname VARCHAR(255) , @middlename VARCHAR(255) ,@lastname VARCHAR(255) , @birth_date DATETIME , 
@working_place_name VARCHAR(255) , @working_place_type VARCHAR(255) , @workring_place_description VARCHAR(500) ,
@specilization VARCHAR(255) ,@portofolio_link VARCHAR(500) , @years_experience INT , 
@hire_date DATETIME , @working_hours INT , @payment_rate DECIMAL(8,2)
EXEC Show_Profile @user_id, @email OUTPUT, @password OUTPUT, @firstname OUTPUT, @middlename OUTPUT,@lastname OUTPUT, @birth_date OUTPUT, @working_place_name OUTPUT, @working_place_type OUTPUT, @workring_place_description OUTPUT, @specilization OUTPUT,@portofolio_link OUTPUT, @years_experience OUTPUT, @hire_date OUTPUT, @working_hours OUTPUT, @payment_rate OUTPUT
GO

--3]
DECLARE
@user_id INT=1,
@email VARCHAR(255) , @password VARCHAR(255)='1111' , @firstname VARCHAR(255) , @middlename VARCHAR(255) ,@lastname VARCHAR(255) , @birth_date DATETIME , 
@working_place_name VARCHAR(255) , @working_place_type VARCHAR(255) , @workring_place_description VARCHAR(500) ,
@specilization VARCHAR(255) ,@portofolio_link VARCHAR(500) , @years_experience INT , 
@hire_date DATETIME , @working_hours INT , @payment_rate DECIMAL(8,2)
EXEC Edit_Profile @user_id, @email , @password , @firstname , @middlename ,@lastname , @birth_date , @working_place_name , @working_place_type , @workring_place_description , @specilization ,@portofolio_link , @years_experience , @hire_date , @working_hours , @payment_rate
GO

--4]
DECLARE
@user_id INT=2
EXEC Deactivate_Profile @user_id
GO

--5]
DECLARE
@event_id INT=1
EXEC Show_Event @event_id
GO

--6]
DECLARE
@user_id INT=11
EXEC Show_Notification @user_id
GO

--7]
DECLARE
@viewer_id INT=1,
@content_id INT
EXEC Show_New_Content @viewer_id, @content_id
GO

--****************		"As a Viewer (registered user), I should be able to ..." EXECUTIONS		********************--
GO

--1]
DECLARE
@city VARCHAR(255)='Giza',
@event_date_time DATETIME='1/1/2019 12:00:00 AM',
@description VARCHAR(500),
@entartainer VARCHAR(255),
@viewer_id INT=1,
@location VARCHAR(255)='Some Location',
@event_id INT
EXEC Viewer_Create_Event @city, @event_date_time, @description, @entartainer, @viewer_id,@location, @event_id OUTPUT
GO

--2]
DECLARE
@event_id INT=3,
@link VARCHAR(500)='some event pic link'
EXEC Viewer_Upload_Event_Photo @event_id, @link
GO

DECLARE
@event_id INT=3,
@link VARCHAR(500)='some event video link'
EXEC Viewer_Upload_Event_Video @event_id, @link
GO

--3]
DECLARE 
@event_id INT = 3
EXEC Viewer_Create_Ad_From_Event @event_id
GO

--4]
DECLARE
@viewer_id INT=1,
@original_content_id INT=1
EXEC Apply_Existing_Request @viewer_id, @original_content_id
GO

--5]
DECLARE
@information VARCHAR(500)='info',
@contributor_id INT=6,
@viewer_id INT=1
EXEC Apply_New_Request @information, @contributor_id, @viewer_id
GO

--6]
DECLARE
@request_id INT=12
EXEC Delete_New_Request @request_id
GO

--7]
DECLARE
@orignal_content_id INT=1,
@rating_value INT=5,
@viewer_id INT=1
EXEC Rating_Original_Content @orignal_content_id, @rating_value, @viewer_id
GO

--8]
DECLARE 
@comment_text VARCHAR(500)='testtt',
@viewer_id INT=1,
@original_content_id INT =2,
@written_time DATETIME='1/1/2018 12:00:00 AM'
EXEC Write_Comment @comment_text, @viewer_id, @original_content_id, @written_time
GO

--9]
DECLARE
@comment_text VARCHAR(500)='updated comment text',
@viewer_id INT = 1,
@original_content_id INT =1,
@last_written_time DATETIME = '1/1/2018 12:00:00 AM',
@updated_written_time DATETIME ='2/1/2018 12:00:00 AM'
EXEC Edit_Comment @comment_text, @viewer_id, @original_content_id, @last_written_time, @updated_written_time
GO

--10]
DECLARE
@viewer_id INT =1,
@original_content_id INT =1,
@written_time DATETIME ='2/1/2018 12:00:00 AM'
EXEC Delete_Comment @viewer_id, @original_content_id,@written_time
GO

--11]
DECLARE
@viewer_id INT=1,
@location VARCHAR(255)='GUC',
@description VARCHAR(500)='desc'
EXEC Create_Ads @viewer_id, @description, @location
GO

--12]
DECLARE
@ad_id INT=4,
@description VARCHAR(500)='new desc',
@location VARCHAR(255)='AUC'
EXEC Edit_Ad @ad_id,@description, @location
GO

--13]
DECLARE
@ad_id INT=4
EXEC Delete_Ads @ad_id
GO

--14]
DECLARE
@msg_text VARCHAR(500)='fdbnfnsdgn',
@viewer_id INT=1,
@contributor_id INT=4,
@sender_type BIT=0,
@sent_at DATETIME=CURRENT_TIMESTAMP
EXEC Send_Message @msg_text, @viewer_id, @contributor_id, @sender_type, @sent_at
GO

--15]
DECLARE
@contributor_id INT =4
EXEC Show_Message @contributor_id
GO

--16]
EXEC Highest_Rating_Original_content
GO

--17]
DECLARE
@request_id INT =11,
@contributor_id INT=4
EXEC Assign_New_Request @request_id, @contributor_id
GO

--****************			“As a contributor, I should be able to ...” EXECUTIONS			********************--
GO

--1]
DECLARE
@request_id INT,
@contributor_id INT=4
EXEC Receive_New_Requests @request_id, @contributor_id
GO

--2]
DECLARE
@contributor_id INT =6,
@accept_status BIT=0,
@request_id INT=9
EXEC Respond_New_Request @contributor_id, @accept_status, @request_id
GO

--3]
DECLARE
@type_id VARCHAR(255)='Logo',
@subcategory_name VARCHAR(255)='High School',
@category_id VARCHAR(255)='Educational',
@contributor_id INT=4,
@link VARCHAR(500)='some link4'
EXEC Upload_Original_Content @type_id,@subcategory_name, @category_id, @contributor_id, @link
GO

--4]
DECLARE
@new_request_id INT=1,
@contributor_id INT=4,
@subcategory_name VARCHAR(255)='High School',
@category_id VARCHAR(255)='Educational',
@link VARCHAR(500)='some link5'
EXEC Upload_New_Content @new_request_id, @contributor_id, @subcategory_name, @category_id, @link
GO

--5]
DECLARE
@content_id INT=4
EXEC Delete_Content @content_id
GO

--6]
DECLARE
@contributor_id INT=4,
@can_receive BIT
EXEC Receive_New_Request @contributor_id, @can_receive OUTPUT
GO

--****************			“As a staff member, I should be able to ...” EXECUTIONS			********************--
GO

--1]
DECLARE
@reviewer_id INT=10,
@original_content INT=1,
@status BIT=1
EXEC reviewer_filter_content @reviewer_id, @original_content, @status
GO

--2]
DECLARE
@content_manager_id INT=12,
@original_content INT=1,
@status BIT = 1
EXEC content_manager_filter_content @content_manager_id, @original_content, @status
GO

--3]
DECLARE
@category_name VARCHAR(255)= 'Political'
EXEC Staff_Create_Category @category_name
GO

--4]
DECLARE
@category_name VARCHAR(255)='Political',
@subcategory_name VARCHAR(255)='Internal'
EXEC Staff_Create_Subcategory @category_name, @subcategory_name
GO

--5]
DECLARE
@type_name VARCHAR(255)='Paint'
EXEC Staff_Create_Type @type_name
GO

--6]
EXEC Most_Requested_Content
GO

--7]
EXEC Workingplace_Category_Relation
GO

--8]
/* ALREADY IMPLEMENTED
DECLARE
@viewer_id INT,
@original_content_id INT,
@comment_time DATETIME
EXEC Delete_Comment @viewer_id, @original_content_id, @comment_time
GO
*/
GO

--9]
DECLARE
@content_id INT=1
EXEC Delete_Original_Content @content_id
GO

--10]
DECLARE
@content_id INT=5
EXEC Delete_New_Content @content_id
GO

--11]
DECLARE
@contributor_id INT=4,
@new_request_id INT= 9
EXEC Assign_Contributor_Request @contributor_id, @new_request_id
GO

--12]
EXEC Show_Possible_Contributors
GO
