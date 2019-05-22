CREATE DATABASE IEgypt_95;
GO
USE IEgypt_95;
GO

/*
DROP Table Announcement;
DROP Table Ads_Photos_Link;
DROP Table Ads_Video_Link;
DROP Table Advertisement;
DROP Table Event_Videos_link;
DROP Table Event_Photos_link;
DROP Table [Event];
DROP Table Rate;
DROP Table Comment;
DROP Table New_Content;
DROP Table New_Request;
DROP Table Existing_Request;
DROP Table Original_Content;
DROP Table Content;
DROP Table Notification_Object;
DROP Table Sub_Category;
DROP Table Category;
DROP Table [Message];
DROP Table Reviewer;
DROP Table Content_manager;
DROP Table Content_type;
DROP Table Staff;
DROP Table Contributor;
DROP Table Viewer;
DROP Table Notified_Person;
DROP Table [User];
*/
GO
--
CREATE Table [User]
(
ID INT PRIMARY KEY IDENTITY,
email VARCHAR(255) UNIQUE NOT NULL,
first_name VARCHAR(255) NOT NULL,
middle_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
birth_date DATETIME NOT NULL,
age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date)),
[password] VARCHAR(255) NOT NULL,
last_login DATETIME DEFAULT CURRENT_TIMESTAMP,
[status] BIT DEFAULT 1 -- 1 means activated 0 means deactivated
);

CREATE Table Notified_Person
(
ID INT IDENTITY PRIMARY KEY,
);

CREATE Table Viewer
(
ID INT PRIMARY KEY,
working_place VARCHAR(255) NOT NULL,
working_place_type VARCHAR(255) NOT NULL,
working_place_description VARCHAR(500),
FOREIGN KEY (ID) REFERENCES [User](ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE Table Contributor 
(
ID INT PRIMARY KEY,
years_of_experience TINYINT,
portfolio_link VARCHAR(500) UNIQUE,
specialization VARCHAR(255),
notified_id INT,
FOREIGN KEY (notified_id) REFERENCES Notified_Person(ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (ID) REFERENCES [User](ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE Table Staff 
( 
ID INT PRIMARY KEY,
hire_date DATETIME DEFAULT CURRENT_TIMESTAMP,
working_hours INT NOT NULL,
payment_rate DECIMAL(8,2) NOT NULL,
total_salary AS payment_rate*working_hours,
notified_id INT,
FOREIGN KEY (ID) REFERENCES [User](ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (notified_id) REFERENCES Notified_Person(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE Table Content_type
(
[type] VARCHAR(255) PRIMARY KEY
);

CREATE Table Content_manager
(
ID INT PRIMARY KEY,
[type] VARCHAR(255),
FOREIGN KEY (ID) REFERENCES Staff(ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ([type]) REFERENCES Content_type([type]) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE Table Reviewer
(
ID INT PRIMARY KEY,
FOREIGN KEY (ID) REFERENCES Staff(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE Table [Message]
(
sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
contributer_id INT,
viewer_id INT,
sender_type BIT,
read_at DATETIME,
[text] VARCHAR(500) NOT NULL,
read_status BIT DEFAULT 0,	--0 means not yet read
CONSTRAINT PK_Message PRIMARY KEY (sent_at,contributer_id,viewer_id,sender_type),
FOREIGN KEY (contributer_id) REFERENCES Contributor(ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (viewer_id) REFERENCES Viewer(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);-----------------------------------------------------------------------------------------

CREATE Table Category
(
[type] VARCHAR(255) PRIMARY KEY,
[description] VARCHAR(500),
);

CREATE Table Sub_Category 
(
category_type VARCHAR(255),
[name] VARCHAR(255),
CONSTRAINT PK_Sub_Category PRIMARY KEY(category_type,[name]),
FOREIGN KEY (category_type) REFERENCES Category([type]) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE Table Notification_Object
(
ID INT PRIMARY KEY IDENTITY
);

CREATE Table Content
(
ID INT PRIMARY KEY IDENTITY,
link VARCHAR(500) NOT NULL,
uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
contributer_id INT NOT NULL,
category_type VARCHAR(255),
subcategory_name VARCHAR(255), 
[type] VARCHAR(255),
FOREIGN KEY(contributer_id) REFERENCES Contributor(ID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FK_Content FOREIGN KEY (category_type,subcategory_name) REFERENCES Sub_Category(category_type,[name]) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY ([type]) REFERENCES Content_type([type]) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE Table Original_Content
(
ID INT PRIMARY KEY,
content_manager_id INT,
reviewer_id INT,
review_status BIT,
filter_status BIT,
rating DECIMAL(2,1) DEFAULT 0,	--Assuming rating is between 0 & 5 
FOREIGN KEY(ID) REFERENCES Content(ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(reviewer_id) REFERENCES Reviewer(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(content_manager_id) REFERENCES Content_manager(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);-----------------------------------------------------------------------------------------------------

CREATE Table Existing_Request
(
id INT PRIMARY KEY IDENTITY,
original_content_id INT NOT NULL,
viewer_id INT NOT NULL,
FOREIGN KEY (original_content_id) REFERENCES Original_Content(ID) ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY (viewer_id) REFERENCES  Viewer(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);--------------------------------------------------------------------------------------

CREATE Table New_Request
(
id INT PRIMARY KEY IDENTITY,
accept_status BIT,
accepted_at DATETIME,
information VARCHAR(500),
specified BIT NOT NULL,
viewer_id INT NOT NULL,
notif_obj_id INT NOT NULL,
contributer_id INT,
FOREIGN KEY(viewer_id) REFERENCES Viewer(ID)  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(notif_obj_id) REFERENCES Notification_Object(ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(contributer_id) REFERENCES Contributor(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);---------------------------------------------------------------------------------

CREATE Table New_Content
(
ID INT PRIMARY KEY ,
new_request_id INT NOT NULL,
FOREIGN KEY(ID) REFERENCES Content(ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(new_request_id) REFERENCES New_Request(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);-------------------------------------------------------------------------------------------

CREATE Table Comment
(
Viewer_id INT,
original_content_id INT,
[date] DATETIME DEFAULT CURRENT_TIMESTAMP,
[text] VARCHAR(500) NOT NULL,
CONSTRAINT PK_Comment PRIMARY KEY (Viewer_id,original_content_id,[date]),
FOREIGN KEY(Viewer_id) REFERENCES Viewer(ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(original_content_id) REFERENCES Original_Content(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);------------------------------------------------------------------------------------------------

CREATE Table Rate 
(
viewer_id INT,
original_content_id INT,
[date] DATETIME DEFAULT CURRENT_TIMESTAMP,
rate INT NOT NULL,
CONSTRAINT PK_Rate PRIMARY KEY (viewer_id,original_content_id),
FOREIGN KEY (viewer_id) REFERENCES Viewer(ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (original_content_id) REFERENCES Original_Content(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);-----------------------------------------------------------------------------------------

CREATE Table [Event] 
( 
id INT IDENTITY PRIMARY KEY, 
[description] VARCHAR(500), 
[location] VARCHAR(255) NOT NULL,
city VARCHAR(255) NOT NULL,
[time] DATETIME NOT NULL,
entertainer VARCHAR(255),
notification_object_id INT NOT NULL,
viewer_id INT NOT NULL,
FOREIGN KEY (notification_object_id) REFERENCES Notification_Object(ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (viewer_id) REFERENCES Viewer(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE Table Event_Photos_link
(
event_id INT,
link VARCHAR(500),
CONSTRAINT PK_Event_Photos_link PRIMARY KEY (event_id,link),
FOREIGN KEY (event_id) REFERENCES [Event](id) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE Table Event_Videos_link
(
event_id INT,
link VARCHAR(500),
CONSTRAINT PK_Event_Videos_link PRIMARY KEY (event_id,link),
FOREIGN KEY (event_id) REFERENCES [Event](id) ON DELETE CASCADE ON UPDATE CASCADE,
);

CREATE Table Advertisement
(
id INT PRIMARY KEY IDENTITY,
[description] VARCHAR(500),
[location] VARCHAR(255),
event_id INT,
viewer_id INT,
FOREIGN KEY(event_id) REFERENCES [Event](id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(viewer_id) REFERENCES Viewer(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);----------------------------------------------------------------------

CREATE Table Ads_Video_Link
(
advertisement_id INT,
link VARCHAR(500),
CONSTRAINT PK_Ads_Video_Link PRIMARY KEY(advertisement_id,link),
FOREIGN KEY(advertisement_id) REFERENCES Advertisement(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE Table Ads_Photos_Link
(
advertisement_id INT,
link VARCHAR(500),
CONSTRAINT PK_Ads_Photos_Link PRIMARY KEY(advertisement_id,link),
FOREIGN KEY(advertisement_id) REFERENCES Advertisement(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE Table Announcement 
(
ID INT IDENTITY PRIMARY KEY,
seen_at DATETIME,
sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
notified_person_id INT NOT NULL,
notification_object_id INT NOT NULL,
FOREIGN KEY (notified_person_id) REFERENCES Notified_Person ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (notification_object_id) REFERENCES Notification_Object ON DELETE CASCADE ON UPDATE CASCADE
);