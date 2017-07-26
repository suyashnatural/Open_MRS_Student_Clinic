

# User Authentication

select * from user_role;

# Procedure for User Authentication - Valid Case

DROP PROCEDURE IF EXISTS user_auth;
DELIMITER |
CREATE PROCEDURE user_auth
(IN name CHAR(32), IN pass CHAR(64), OUT role CHAR(36))
BEGIN
SELECT user_role.user, user_role.password, user_role.role INTO @name, @pass, @role FROM user_role WHERE user_role.user = name;
 IF (SELECT COUNT(user_role.user) FROM user_role WHERE user_role.user = name AND user_role.password = pass)!=1 THEN
SET @message_text = CONCAT ('Login Incorrect for user \'',@name, '\'');
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
ELSE
SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'successfully authenticated';
SELECT @role as role INTO role;
END IF;
END;|
DELIMITER ;

SET @name='suyash';
SET @pass='suyash';
CALL `student_clinic_db_final`.`user_auth`(@name, @pass, @role);
SELECT @role;


# Procedure for User Authentication - InValid Case

SET @name='boshu';
SET @pass='boshu';
CALL `student_clinic_db_final`.`user_auth`(@name, @pass, @role);
SELECT @role;


# User Authentication Implementation 

select * from privilege;

# Role based access control - Prescription created by the doctor

DROP PROCEDURE IF EXISTS create_prescription;
DELIMITER $$
CREATE PROCEDURE `create_prescription`
(IN username varchar(255), IN pass varchar(255),IN  presc_id int, IN med_name varchar(255), IN med_quantity int)
BEGIN
CALL user_auth(username, pass, @role);
IF(@role like 'doctor')
THEN 
IF ((select Insert_priv from privilege where Role like 'doctor') like 'Y')
THEN
insert into prescription values(presc_id, med_name, med_quantity);
ELSE
SET @message_text = CONCAT(username, ' donot have insert privilege');
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
END IF;
ELSE
SET @message_text = CONCAT(username, ' with role ', @role, ' is not authorized to create the prescription');
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
END IF;
END$$
DELIMITER ;


SET @username = 'abhishek';
SET @pass = 'abhishek';
SET @presc_id = 90;
SET @med_name = 'Calpol';
SET @med_quantity = 2;
CALL `student_clinic_db_final`.`create_prescription`(@username, @pass, @presc_id, @med_name, @med_quantity);

select * from prescription;

 
 # Role other than doctor cannot create the prescription
 
SET @username = 'harika';
SET @pass = 'harika';
SET @presc_id = 95;
SET @med_name = 'Calpol';
SET @med_quantity = 2;
CALL `student_clinic_db_final`.`create_prescription`(@username, @pass, @presc_id, @med_name, @med_quantity);


# Prescription deleted by the doctor

DROP PROCEDURE IF EXISTS delete_prescription;
DELIMITER $$
CREATE PROCEDURE `delete_prescription`
(IN username varchar(255), IN pass varchar(255),IN  presc_id int)
BEGIN
CALL user_auth(username, pass, @role);
IF(@role like 'doctor')
THEN 
IF ((select Delete_priv from privilege where Role like 'doctor') like 'Y')
THEN
delete from prescription where prescription_id=presc_id;
ELSE
SET @message_text = CONCAT(username, ' donot have delete privilege');
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
END IF;
ELSE
SET @message_text = CONCAT(username, ' with role ', @role, ' is not authorized to delete the prescription');
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message_text;
END IF;
END$$
DELIMITER ;


#CALL
SET @username = 'abhishek';
SET @pass = 'abhishek';
SET @presc_id = 95;
CALL `student_clinic_db_final`.`delete_prescription`(@username, @pass, @presc_id);

select * from prescription;


# Role other than doctor cannot delete the prescription

SET @username = 'harika';
SET @pass = 'harika';
SET @presc_id = 95;
CALL `student_clinic_db_final`.`delete_prescription`(@username, @pass, @presc_id);
