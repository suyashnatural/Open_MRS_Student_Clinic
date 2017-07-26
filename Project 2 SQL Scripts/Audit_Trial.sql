

#Trigger for before update operation for visit table

DROP TRIGGER IF EXISTS student_clinic_db_final.audit_visit_bu;
DELIMITER $$
create trigger audit_visit_bu BEFORE UPDATE on Visit
for each row
begin
insert into audit_trial_visit SELECT 'BEFORE UPDATE', NULL, NOW(),
current_user(), V.* from visit as V
where V.visit_id = old.visit_id;
end;$$
DELIMITER ;



#Trigger for after update operation for visit table
DROP TRIGGER IF EXISTS student_clinic_db_final.audit_visit_au;
DELIMITER $$
create trigger audit_visit_au AFTER UPDATE on Visit
for each row
begin
insert into audit_trial_visit SELECT 'AFTER UPDATE', NULL, NOW(), current_user(),
V.* from visit as V
where V.visit_id = new.visit_id;
end;$$
DELIMITER ;


# Trigger for insert operation for visit table
DROP TRIGGER IF EXISTS student_clinic_db_final.visit_after_insert
DELIMITER $$
create trigger visit_after_insert AFTER INSERT on Visit
for each row
Begin
insert into audit_trial_visit SELECT 'INSERT', NULL, NOW(), current_user(), V.* from
visit as V
where V.visit_id = new.visit_id;
End; $$
DELIMITER ;



# Trigger for delete operation for visit table
DROP TRIGGER IF EXISTS student_clinic_db_final.visit_before_delete
DELIMITER $$
create trigger visit_before_delete BEFORE DELETE on Visit
for each row
Begin
insert into audit_trial_visit SELECT 'DELETE', NULL, NOW(), current_user(), V.* from
visit as V
where V.visit_id = old.visit_id;
End; $$
DELIMITER ;


#    Audit Trial for visit -- Demo

select * from visit;

insert into visit values (6, '2017-05-20', '09:00', 'Sore Throat', 12, 101, 12, 701);
select * from audit_trial_visit;

update visit set complaint='Nausea' where visit_id=6;
select * from audit_trial_visit;

delete from visit where visit_id=6;
select * from visit;
select * from audit_trial_visit;


# Audit Trial for payment -- Demo

select * from payment;

insert into payment values (106, 'Self', 'Pending', '2017-04-30');
select * from audit_trial_payment;

update payment set pay_status='Paid' where pay_trans_num=106;
select * from audit_trial_payment;

delete from payment where pay_trans_num = 106;
select * from payment;
select * from audit_trial_payment;