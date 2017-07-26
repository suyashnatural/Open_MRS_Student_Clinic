

# VIEWS

# 1...Find out the students with pending bills.

create or replace view bill_pending_view as 
select student.student_id, student.student_name, student_bill.bill_no, bill.amount, bill.amount_paid, payment.pay_trans_num, bill.due_date, payment.pay_status
from bill
join bill_payment using (bill_no)
join payment using (pay_trans_num)
join student_bill using (bill_no)
join student using (student_id)
where (bill.amount_paid<bill.amount);

select * from bill_pending_view;

# Implementationo of above views - Calulate the amount pending and due date for all the student using the view

select bv.student_id, bv.student_name, bv.bill_no, (bv.amount-bv.amount_paid) as amount_remaining, bv.due_date
from bill_pending_view bv
join payment p using(pay_trans_num);


# 2...Find out total number of medicines prescribed to a student ‘Suyash Nande’

create or replace view Medicine_For_Student as
select s.student_id,s.student_name,v.visit_id,d.doc_name, p.medicine_name AS Prescribed_Medicine
from student s 
join visit_history using(student_id)
join visit v using (visit_id)
join doctor d using(doctor_id)
join prescription p using(prescription_id)
where s.student_name = 'Suyash Nande';

select * from medicine_for_student;

# Implementation -- Calculate the total number of medicines prescribed for that student.

select student_id, student_name, count(*) as Total_Num_Medicines from Medicine_For_Student;




# 3... Find out maximum visit for any department.

create or replace view dept_with_max_visit as
select a.dpt_id, a.dpt_name, count(a.dpt_name) as max_visit
from affiliated_with a 
join visit v using(doctor_id)
group by a.dpt_id, a.dpt_name
HAVING max(v.doctor_id);

select * from dept_with_max_visit;

# Implementation -- Find out dept with maximum visit count

select  dpt_id, dpt_name, max(max_visit) from dept_with_max_visit;

SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';
SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION';