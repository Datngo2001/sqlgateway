  CREATE TABLE murach.User (
    UserID SERIAL,
    Email VARCHAR(50),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    
    PRIMARY KEY(UserID) 
  );

  INSERT INTO murach.User 
    (Email, FirstName, LastName)
  VALUES 
    ('jsmith@gmail.com', 'John', 'Smith'),
    ('andi@murach.com', 'Andrea', 'Steelman'), 
    ('joelmurach@yahoo.com', 'Joel', 'Murach');

  CREATE TABLE murach.Download (
    DownloadID SERIAL,
    UserID INT NOT NULL,
    DownloadDate timestamp NOT NULL,
    DownloadFilename VARCHAR(30) NOT NULL,
    ProductCode VARCHAR(10) NOT NULL,

    PRIMARY KEY (DownloadID), 
    FOREIGN KEY (UserID) REFERENCES murach.User (UserID)
  );

  INSERT INTO murach.Download 
    (UserID, DownloadDate, DownloadFilename, ProductCode)
  VALUES 
    (1, '2014-02-01', 'jr01_so_long.mp3', 'jr01'), 
    (1, NOW(), 'jr01_filter.mp3', 'jr01'),
    (2, NOW(), 'jr01_filter.mp3', 'jr01'),
    (3, NOW(), 'jr01_so_long.mp3', 'jr01');
    
    
  CREATE TABLE murach.UserPass (
    Username varchar(15) NOT NULL PRIMARY KEY,
    Password varchar(15) NOT NULL
  );
    
  INSERT INTO murach.UserPass VALUES ('andrea', 'sesame'),
                              ('joel', 'sesame'),
                              ('anne', 'sesame');
                            
  CREATE TABLE murach.UserRole (   
    Username VARCHAR(15) NOT NULL,
    Rolename VARCHAR(15) NOT NULL,

    PRIMARY KEY (Username, Rolename)
  );
    
  INSERT INTO murach.UserRole VALUES ('andrea', 'service'),
                              ('andrea', 'programmer'),
                              ('joel', 'programmer');


  -- Tạo User
  CREATE USER murach_user PASSWORD 'sesame';

  GRANT USAGE ON SCHEMA murach TO murach_user
  GRANT SELECT, INSERT, UPDATE, DELETE
  ON murach.user, murach.userpass, murach.userrole, murach.download TO murach_user;