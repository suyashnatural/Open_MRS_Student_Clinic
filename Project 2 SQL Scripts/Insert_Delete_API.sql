
					
                    
                    #-------- INSERT Procedures ---------#


# --------- To insert new student data

DELIMITER $$
CREATE PROCEDURE `NewStudent_INSERT`(IN Student_ID varchar(12),
IN Student_Name varchar(90),
IN Student_DOB date,
IN Student_Contact varchar(30),
IN Student_Address varchar(90))
BEGIN
INSERT INTO student values(Student_ID,Student_Name,Student_DOB,Student_Contact,Student_Address);
END$$
DELIMITER ;

SET @Student_ID='90';
SET @Student_Name='Bhavya';
SET @Student_DOB='1992-07-12';
SET @Student_Contact='9803650355';
SET @Student_Address='UTD,NC';
CALL `student_clinic_db_final`.`NewStudent_INSERT`(@Student_ID,@Student_Name,@Student_DOB,@Student_Contact,@Student_Address);

select * from student;


# -------------- To insert new insurance company

DELIMITER $$
CREATE PROCEDURE `InsuranceCompany_insert`(IN COMPANY_ID varchar(12),
IN  COMPANY_NAME varchar(45),
IN COMPANY_CONTACT varchar(30),
IN COMPANY_ADDRESS varchar(90)
)
BEGIN
INSERT INTO insurance(insurance_id,insurance_company,contact,address) values(COMPANY_ID,COMPANY_NAME,COMPANY_CONTACT,COMPANY_ADDRESS);
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`InsuranceCompany_insert`('199','ISO','7645423457','ABCD');

select * from insurance;

# --------------To insert the visit information

DELIMITER $$
CREATE PROCEDURE `VISIT_insert`
(IN VISIT_ID varchar(11),
IN VISIT_DATE date,
IN VISIT_TIME time,
IN VISIT_COMPLAINT varchar(90),
IN DIAGNOSIS_ID varchar(11),
IN DOC_ID varchar(12),
IN PRESCR_ID varchar(11)
)
BEGIN
INSERT INTO visit(visit_id,visit_date,time,complaint,diagnosis_id,doctor_id,prescription_id)
 values(VISIT_ID,VISIT_DATE,VISIT_TIME,VISIT_COMPLAINT,DIAGNOSIS_ID,DOC_ID,PRESCR_ID);
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`VISIT_insert`('6','2017-05-03','01:00:00','Throat infection','14','101','12');



# ------------- To enter new diagnosis record

DELIMITER $$
CREATE PROCEDURE `New_diagnosis`
(IN DIAGNOSIS_ID varchar(12),IN  DIAGNOSIS_CATEGORY varchar(45))
BEGIN
INSERT INTO diagnosis(diagnosis_id,category) values(DIAGNOSIS_ID,DIAGNOSIS_CATEGORY);
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`New_diagnosis`('16','Throatinfection');



# ---------------To create new bills

DELIMITER $$
CREATE PROCEDURE `Newbill_insert`(IN BILL_ID varchar(11),
IN  BILL_AMOUNT decimal(9,6),
IN CREATE_DATE date,
IN BILL_DUE date
)
BEGIN
INSERT INTO bill(bill_no,amount,bill_date,due_date) 
values(BILL_ID,BILL_AMOUNT,CREATE_DATE,BILL_DUE);
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Newbill_insert`('1','	555','2017-04-03','2017-05-03');
CALL `student_clinic_db_final`.`Newbill_insert`('2','	550','2017-04-03','2017-05-04');
CALL `student_clinic_db_final`.`Newbill_insert`('3','	111','2017-03-03','2017-04-05');
CALL `student_clinic_db_final`.`Newbill_insert`('4','	220','2017-05-03','2017-06-03');



# -------------To create prescription

DELIMITER $$
CREATE PROCEDURE `Prescription_insert`(IN PRESCRIP_ID varchar(11),
IN  MED_QTY int(11)
)
BEGIN
INSERT INTO prescription(prescription_id,medicine_quantity) values(PRESCRIP_ID,MED_QTY);
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Prescription_insert`('14','50');
CALL `student_clinic_db_final`.`Prescription_insert`('15','75');
CALL `student_clinic_db_final`.`Prescription_insert`('16','95');


# ------------- Insert into prescription medicine 

DELIMITER $$
CREATE PROCEDURE `Prescription_med_insert`(IN PRESCRIP_ID varchar(11),
IN  MED_INVTRY_ID varchar(11))
BEGIN
INSERT INTO prescription_medicine(prescription_id,med_inventory_id) values(PRESCRIP_ID,MED_INVTRY_ID);
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Prescription_med_insert`('45','897');
CALL `student_clinic_db_final`.`Prescription_med_insert`('55','900');
CALL `student_clinic_db_final`.`Prescription_med_insert`('34','789');


# ------------- To insert into payment table 

DELIMITER $$
CREATE PROCEDURE `Payment_insert`(IN  TRANSCTION_NUM varchar(11),
IN  METHOD varchar(90),
IN  PAYSTATUS varchar(45),
IN  PAYDATE date
)
BEGIN
INSERT INTO Payment(pay_trans_num,pay_method,pay_status,pay_date) 
values(TRANSCTION_NUM,METHOD,PAYSTATUS,PAYDATE);
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Payment_insert`('107','SELF','PAID','2017-11-09');
CALL `student_clinic_db_final`.`Payment_insert`('108','INSURANCE','PAID','2017-01-12');
CALL `student_clinic_db_final`.`Payment_insert`('109','SELF','PENDING','2017-05-17');
CALL `student_clinic_db_final`.`Payment_insert`('110','INSURANCE','PENDING','2017-08-01');


 # ------------------ Student insurance insert 

DELIMITER $$
CREATE PROCEDURE `Studentinsurance_insert`(IN  STUD_ID varchar(7), IN  INSURNC_ID varchar(90))
BEGIN
INSERT INTO student_insurance(student_id,insurance_id) 
values(STUD_ID,INSURNC_ID);
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Studentinsurance_insert`('10','2');
CALL `student_clinic_db_final`.`Studentinsurance_insert`('55','2');




# ---------- To insert bill payment

DELIMITER $$
CREATE PROCEDURE `BillPayment_insert`(IN BILL_ID varchar(11),
IN  TRANS_NUM varchar(11))
BEGIN
INSERT INTO bill_payment(bill_no,pay_trans_num) 
values(BILL_ID,TRANS_NUM);
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`BillPayment_insert`('1','106');
CALL `student_clinic_db_final`.`BillPayment_insert`('2','107');
CALL `student_clinic_db_final`.`BillPayment_insert`('3','108');
CALL `student_clinic_db_final`.`BillPayment_insert`('4','109');




								# -------------- Update Procedures -------------#

#-------- Given student id and bill amount to be updated

DELIMITER $$
CREATE PROCEDURE `Update_BillAmount`(IN STUD_ID varchar(12),
IN  AMOUNT_UPDATE decimal(9,6)
)
BEGIN
UPDATE bill set amount=AMOUNT_UPDATE where bill_no
in(SELECT bill_no from student_bill where student_id=STUD_ID);
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Update_BillAmount`('4','123.500000');

select * from student_bill;
select * from student;
select * from bill;

SET SQL_SAFE_UPDATES = 0;

 #-------- Given student id and update the payment status

DELIMITER $$
CREATE PROCEDURE `Update_PaymentStatus`(IN STUD_ID varchar(12),
IN  STATUS_UPDATE varchar(45)
)
BEGIN
UPDATE payment set pay_status=STATUS_UPDATE where pay_trans_num
in(SELECT pay_trans_num from bill_payment where bill_no 
in(SELECT bill_no from student_bill where student_id=STUD_ID));
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Update_PaymentStatus`('1','Paid');




#--------  Updating insurance company id for a given student_id

DELIMITER $$
CREATE PROCEDURE `Update_InsuranceCompany`(IN STUD_ID varchar(12),
IN  Company_UPDATE varchar(7))
BEGIN
UPDATE student_insurance set insurance_id=Company_UPDATE
where student_id=STUD_ID;
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Update_InsuranceCompany`('1','50');



					# ---------------------Delete Procedure -------------------#
                    
                    

 #--------  To delete student record

DELIMITER $$
CREATE PROCEDURE `Del_Student`
(IN DEL_STUDENT_ID varchar(12))
BEGIN
delete from student where student_id= DEL_STUDENT_ID;
END$$
DELIMITER ;

select * from student;

CALL `student_clinic_db_final`.`Del_Student`('56');



#--------      To delete diagnosis record

DELIMITER $$
CREATE PROCEDURE `DEL_diagnosis_data`
(IN Del_DIAGNOSIS_ID varchar(12))
BEGIN
DELETE FROM diagnosis WHERE diagnosis_id = Del_DIAGNOSIS_ID;
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`DEL_diagnosis_data`(‘903’);


#--------    To delete doctor data

SELECT * FROM student_clinic_db_final.doctor;
DELIMITER $$
CREATE PROCEDURE `Delete_Doctor`
(IN Del_Doc varchar(12))
BEGIN
DELETE FROM doctor WHERE doctor_id = Del_Doc;
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Delete_Doctor`(‘202’);




#--------   To delete insurance company data

DELIMITER $$
CREATE PROCEDURE `Del_InsuranceCompany`
(IN DEL_COMPANY_ID varchar(12))
BEGIN
DELETE FROM insurance where insurance_id = DEL_COMPANY_ID;
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Del_InsuranceCompany`(‘5’);


#--------   To delete medicine record

DELIMITER $$
CREATE PROCEDURE `Delete_medicine`(IN Del_Med varchar(12))
BEGIN
DELETE FROM medicine WHERE med_inventory_id = Del_Med;
END$$
DELIMITER ;

CALL `student_clinic_db_final`.`Delete_medicine`(‘321’);








