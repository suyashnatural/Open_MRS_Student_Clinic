

# Scenario's

# 1 ---  Find department name from complaint

DROP PROCEDURE IF EXISTS dptname_forcomplaint;
DELIMITER $$
CREATE PROCEDURE `dptname_forcomplaint`(IN complaint varchar(55))
begin
select d.doc_name,d.doctor_id, a.dpt_name,a.dpt_id
from doctor d, affiliated_with a,visit v
where d.doctor_id = a.doctor_id
and v.doctor_id = a.doctor_id
and v.complaint= complaint;
END$$
DELIMITER ;

SET @Complaint='Hypertension';
CALL `student_clinic_db_final`.`dptname_forcomplaint`(@Complaint);

# 2 ---- Get the bill details and payment number of Suyash Nande

DROP PROCEDURE IF EXISTS BILL_DETAILS_SUYASH;
DELIMITER $$
CREATE PROCEDURE `BILL_DETAILS_SUYASH`(IN STU_NAME varchar(255))
BEGIN
select student.student_name, student.student_id, bill.bill_no, bill.bill_date,
payment.pay_trans_num, payment.pay_date
from bill
join bill_payment using (bill_no)
join payment using (pay_trans_num)
join student_bill using (bill_no)
join student using (student_id)
where student.student_name=STU_NAME;
END$$
DELIMITER ;

set @STU_NAME='Suyash Nande';
CALL `student_clinic_db_final`.`BILL_DETAILS_SUYASH`(@STU_NAME);

# 3 --- Find the names of the students and their address who have visited to more than one doctor.

DROP PROCEDURE IF EXISTS STU_VISIT_HISTORY;
DELIMITER $$
CREATE PROCEDURE `STU_VISIT_HISTORY`
(IN NO_OF_VISITS int)
BEGIN
select s.student_name, s.address, count(v.doctor_id)
from student s, visit v, visit_history vh, doctor d
where v.visit_id = vh.visit_id
and vh.student_id = s.student_id
and v.doctor_id = d.doctor_id
group by s.student_name,s.address
having count(v.doctor_id) > NO_OF_VISITS;
END$$
DELIMITER ;

set @NO_OF_VISITS = 1;
CALL `student_clinic_db_final`.`STU_VISIT_HISTORY`(@NO_OF_VISITS);

# 4 --- Find the name of the doctors with their contact numbers whom has been visited by only student.

DROP PROCEDURE IF EXISTS ONE_STUDENT_DOC;
DELIMITER $$
CREATE PROCEDURE `ONE_STUDENT_DOC`(IN NO_OF_VISIT int)
BEGIN
select d.doc_name, count(v.doctor_id)
from doctor d, visit v
where d.doctor_id = v.doctor_id
group by doc_name,doc_contact_no
having count(v.doctor_id)=NO_OF_VISIT;
END$$
DELIMITER ;

SET @NO_OF_VISIT=1;
CALL `student_clinic_db_final`.`ONE_STUDENT_DOC`(@NO_OF_VISIT);

# 5 --- Find names, id’s, record id and vaccine category for students who have been given
# vaccination of FLU and order by student name

DROP PROCEDURE IF EXISTS STU_WITH_VACC;
DELIMITER $$
CREATE PROCEDURE `STU_WITH_VACC`(IN VACC_NAME varchar(255))
BEGIN
select student.student_name, student.student_id, i.record_id ,i.vaccine_category
from student
join immunization_record i using(student_id)
where i.vaccine_category = VACC_NAME
order by student_name;
END$$
DELIMITER ;

SET @VACC_NAME='FLU';
CALL `student_clinic_db_final`.`STU_WITH_VACC`(@VACC_NAME);

# 6 --- Find number of visits for any student

DROP PROCEDURE IF EXISTS VISITS_OF_ANY_STUDENT;
DELIMITER $$
CREATE PROCEDURE `VISITS_OF_ANY_STUDENT`(IN STU_NAME
varchar(255))
BEGIN
select student.student_name, COUNT(visit_history.visit_id) AS NumofVisits
from student
join visit_history using(student_id)
where student_name = STU_NAME;
END$$
DELIMITER ;

SET @STU_NAME='Suyash Nande';
CALL `student_clinic_db_final`.`VISITS_OF_ANY_STUDENT`(@STU_NAME);

# 7 --- Find the student name and payment status whose payment status is pending. Order by
# name.

DROP PROCEDURE IF EXISTS Payment_Status_Of_Student;
DELIMITER $$
CREATE PROCEDURE `Payment_Status_Of_Student`(IN STATUS varchar(255))
BEGIN
select student.student_name , student.student_id, payment.pay_status
from student
join student_bill using (student_id)
join bill_payment using (bill_no)
join payment using ( pay_trans_num)
where pay_status = STATUS
order by student.student_name;
END$$
DELIMITER ;

SET @STATUS='Pending';
CALL `student_clinic_db_final`.`Payment_Status_Of_Student`(@STATUS);


# 8 --- Find how many doctors exist for any department

Drop procedure if exists `docname_fordept`;
Delimiter $$
CREATE procedure `docname_fordept`(IN department_name varchar(55))
begin
select d.doc_name, d.doctor_id, a.dpt_name
from doctor d, affiliated_with a
where d.doctor_id = a.doctor_id
and a.dpt_name like department_name;
END; $$
DELIMITER ;

set @department_name = 'General Medicine';
CALL `student_clinic_db_final`.`docname_fordept`(@department_name);
