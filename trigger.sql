Script done on Thu Mar  5 12:59:50 2026
[24bcsl03@mepcolinux sql]$cat trigger.prn
BEFORE INSERT CUSTOMER
SQL> CREATE OR REPLACE TRIGGER before_insert_customer
  2  BEFORE INSERT ON customer
  3  FOR EACH ROW
  4  BEGIN
  5     IF :NEW.customer_name IS NULL THEN
  6        RAISE_APPLICATION_ERROR(-20001, 'Customer name cannot be null');
  7     END IF;
  8  END;
  9  /

Trigger created.

SQL> INSERT INTO CUSTOMER (CUSTOMER_ID, CUSTOMER_NAME, MOBILE_NO)
  2  VALUES (1, NULL, '9876543210');
INSERT INTO CUSTOMER (CUSTOMER_ID, CUSTOMER_NAME, MOBILE_NO)
            *
ERROR at line 1:
ORA-20001: Customer name cannot be null
ORA-06512: at "SYSTEM.BEFORE_INSERT_CUSTOMER", line 3
ORA-04088: error during execution of trigger 'SYSTEM.BEFORE_INSERT_CUSTOMER'

2. AFTER INSERT  SUPPLIER

SQL> CREATE OR REPLACE TRIGGER after_insert_customer
  2  AFTER INSERT ON customer
  3  FOR EACH ROW
  4  BEGIN
  5     DBMS_OUTPUT.PUT_LINE('New customer added: ' || :NEW.customer_name);
  6  END;
  7  /

Trigger created.

SQL> INSERT INTO SUPPLIER (SUPPLIER_ID, SUPPLIER_NAME, SUPPLIER_EMAIL)
  2  VALUES (204, 'xyz SUPPLIER', 'xyz@gmail.com');
New supplier added: xyz SUPPLIER

1 row created.

3. before_delete_supplier
SQL> CREATE OR REPLACE TRIGGER before_delete_supplier
  2  BEFORE DELETE ON supplier
  3  FOR EACH ROW
  4  BEGIN
  5     RAISE_APPLICATION_ERROR(-20002, 'Cannot delete supplier');
  6  END;
  7  /

Trigger created.

SQL> DELETE FROM SUPPLIER WHERE SUPPLIER_ID = 300;
DELETE FROM SUPPLIER WHERE SUPPLIER_ID = 300
            *
ERROR at line 1:
ORA-20002: Cannot delete supplier
ORA-06512: at "SYSTEM.BEFORE_DELETE_SUPPLIER", line 2
ORA-04088: error during execution of trigger 'SYSTEM.BEFORE_DELETE_SUPPLIER'

4. after_delete_customer
SQL> CREATE OR REPLACE TRIGGER after_delete_customer
  2  AFTER DELETE ON customer
  3  FOR EACH ROW
  4  BEGIN
  5     DBMS_OUTPUT.PUT_LINE('Customer ' || :OLD.customer_name || ' has been deleted.');
  6  END;
  7  /

Trigger created.

SQL> INSERT INTO CUSTOMER
  2  (CUSTOMER_ID, CUSTOMER_NAME, MOBILE_NO, CUSTOMER_EMAIL, CUSTOMER_ADDRESS, REGISTRATION_DATE, AGE)
  3  VALUES
  4  (101, 'Arikaran', '9876543210', 'ari@gmail.com', 'Madurai', SYSDATE, 21);
New customer added: Arikaran

1 row created.

SQL> DELETE FROM CUSTOMER WHERE CUSTOMER_ID = 101;
Customer Arikaran has been deleted.

1 row deleted.

5. before_update_customer
SQL> CREATE OR REPLACE TRIGGER before_update_customer
  2  BEFORE UPDATE ON customer
  3  FOR EACH ROW
  4  BEGIN
  5      IF :NEW.age < 0 THEN
  6          RAISE_APPLICATION_ERROR(-20001, 'Age cannot be negative.');
  7      END IF;
  8  END;
  9  /

Trigger created.

SQL> UPDATE customer
  2  SET age = -5
  3  WHERE customer_id = 1;
UPDATE customer
       *
ERROR at line 1:
ORA-20001: Age cannot be negative.
ORA-06512: at "SYSTEM.BEFORE_UPDATE_CUSTOMER", line 3
ORA-04088: error during execution of trigger 'SYSTEM.BEFORE_UPDATE_CUSTOMER'

6. after_update_customer
SQL> CREATE OR REPLACE TRIGGER after_update_customer
  2  AFTER UPDATE ON customer
  3  FOR EACH ROW
  4  BEGIN
  5      DBMS_OUTPUT.PUT_LINE(
  6          'Customer ' || :OLD.customer_name ||
  7          ' updated. New Age: ' || :NEW.age
  8      );
  9  END;
 10  /

Trigger created.

SQL> UPDATE customer
  2  SET age = 25
  3  WHERE customer_id = 1;
Customer Arun updated. New Age: 25

1 row updated.

7.compound_trigger_medicine

SQL> CREATE OR REPLACE TRIGGER compound_trigger_medicine
  2  FOR INSERT OR UPDATE ON medicine
  3  COMPOUND TRIGGER
  4
  5      BEFORE EACH ROW IS
  6      BEGIN
  7          IF INSERTING THEN
  8
  9              IF :NEW.selling_price IS NULL THEN
 10                  :NEW.selling_price := :NEW.mrp;
 11              END IF;
 12          END IF;
 13      END BEFORE EACH ROW;
 14
 15      AFTER EACH ROW IS
 16      BEGIN
 17          IF UPDATING THEN
 18              DBMS_OUTPUT.PUT_LINE(
 19                  'Medicine updated: ' || :NEW.medicine_name
 20              );
 21          END IF;
 22      END AFTER EACH ROW;
 23
 24  END compound_trigger_medicine;
 25  /

Trigger created.

SQL> INSERT INTO medicine
  2  (MEDICINE_ID, MEDICINE_NAME, MRP, SELLING_PRICE)
  3  VALUES
  4  (500, 'CROCIN', 50, 45);
INSERT INTO medicine
            *
ERROR at line 1:
ORA-04098: trigger 'SYSTEM.COMPOUND_TRIGGER_MEDICINE_INVALID' is invalid and
failed re-validation

8. statement_trigger_medicine_status
SQL> CREATE OR REPLACE TRIGGER statement_trigger_medicine_status
  2  BEFORE INSERT OR UPDATE ON medicine
  3  DECLARE
  4      v_msg VARCHAR2(0) := 'UPDATED';
  5  BEGIN
  6
  7      IF UPDATING THEN
  8          FOR rec IN (
  9              SELECT medicine_id
 10              FROM medicine
 11              WHERE selling_price < 50
 12          ) LOOP
 13              UPDATE medicine
 14              SET selling_price = 50
 15              WHERE medicine_id = rec.medicine_id;
 16          END LOOP;
 17      END IF;
 18
 19  END;
 20  /

Trigger created.

SQL> INSERT INTO medicine
  2  (MEDICINE_ID, MEDICINE_NAME, MRP, SELLING_PRICE)
  3  VALUES
  4  (201, 'DOLO', 60, 45);
INSERT INTO medicine
            *
ERROR at line 1:
ORA-04098: trigger 'SYSTEM.COMPOUND_TRIGGER_MEDICINE_INVALID' is invalid and
failed re-validation

HACKERRANK QUESTION

1.before_update_timestamp_supplier
SQL> CREATE OR REPLACE TRIGGER before_update_timestamp_supplier
  2  BEFORE UPDATE ON supplier
  3  FOR EACH ROW
  4  BEGIN
  5      DBMS_OUTPUT.PUT_LINE(
  6          'Supplier ' || :NEW.supplier_name ||
  7          ' modified at ' ||
  8          TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS')
  9      );
 10  END;
 11  /

Trigger created.

SQL> UPDATE supplier SET supplier_address = 'Coimbatore' WHERE supplier_id = 102;
Supplier MediCare Ltd modified at 2026-03-26 09:11:19

1 row updated.

2. trg_update_supplier_timestamp
SQL> CREATE OR REPLACE TRIGGER trg_update_supplier_timestamp
  2  BEFORE UPDATE ON supplier
  3  FOR EACH ROW
  4  BEGIN
  5
  6      :NEW.last_modified := SYSDATE;
  7  END;
  8  /

Warning: Trigger created with compilation errors.

SQL> UPDATE supplier
  2  SET supplier_phone = '9000000000'
  3  WHERE supplier_id = 101;
UPDATE supplier
       *
ERROR at line 1:
ORA-04098: trigger 'SYSTEM.TRG_UPDATE_SUPPLIER_TIMESTAMP' is invalid and failed
re-validation

3. trg_prevent_update_business_hours_med
SQL> CREATE OR REPLACE TRIGGER trg_prevent_update_night_hours_med
  2  BEFORE UPDATE ON medicine
  3  FOR EACH ROW
  4  DECLARE
  5      v_hour NUMBER;
  6  BEGIN
  7      v_hour := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
  8
  9      IF v_hour >= 21 OR v_hour < 10 THEN
 10          RAISE_APPLICATION_ERROR(-20007, 'Cannot update during 9 PM - 10 AM');
 11      END IF;
 12  END;
 13  /

Trigger created.

SQL> UPDATE medicine SET selling_price = 70 WHERE medicine_id = 108;
UPDATE medicine
       *
ERROR at line 1:
ORA-20007: Cannot update during 9 PM - 10 AM
ORA-06512: at "SYSTEM.TRG_PREVENT_UPDATE_NIGHT_HOURS_MED", line 7
ORA-04088: error during execution of trigger
'SYSTEM.TRG_PREVENT_UPDATE_NIGHT_HOURS_MED'

4.trg_prevent_batch_delete
SQL> CREATE OR REPLACE TRIGGER trg_prevent_batch_delete
  2  BEFORE DELETE ON batch
  3  FOR EACH ROW
  4  DECLARE
  5      v_qty NUMBER;
  6  BEGIN
  7      v_qty := :OLD.quantity_available;
  8
  9      IF v_qty > 0 THEN
 10          RAISE_APPLICATION_ERROR(-20011,
 11              'Cannot delete batch. Stock available: ' || v_qty);
 12      END IF;
 13  END;
 14  /

Trigger created.

SQL> DELETE FROM batch
  2  WHERE batch_id = 301;
DELETE FROM batch
            *
ERROR at line 1:
ORA-20011: Cannot delete batch. Stock available: 500
ORA-06512: at "SYSTEM.TRG_PREVENT_BATCH_DELETE", line 7
ORA-04088: error during execution of trigger 'SYSTEM.TRG_PREVENT_BATCH_DELETE'


SQL> CREATE OR REPLACE TRIGGER trg_log_and_notify_category_invalid
  2  AFTER INSERT OR UPDATE OR DELETE ON category
  3  FOR EACH ROW
  4  DECLARE
  5      v_operation VARCHAR2(20);
  6      v_message   VARCHAR2(500);
  7      v_notification_id NUMBER;
  8  BEGIN
  9
 10      IF INSERTING THEN
 11          v_operation := 'INSERT';
 12          v_message := 'New category ' || :NEW.category_name || ' created';
 13
 14      ELSIF UPDATING THEN
 15          v_operation := 'UPDATE';
 16          v_message := 'Category ' || :NEW.category_name || ' updated';
 17
 18      ELSIF DELETING THEN
 19          v_operation := 'DELETE';
 20          v_message := 'Category ' || :OLD.category_name || ' deleted';
 21      END IF;
 22
 23
 24      v_notification_id := seq_wrong_id.NEXTVAL;
 25
 26      INSERT INTO error_notifications
 27      VALUES (v_notification_id, 'CATEGORY', v_operation, v_message, 'YES');
 28
 29  END;
 30  /

Trigger created.

SQL> INSERT INTO category (CATEGORY_ID, CATEGORY_NAME, CREATED_DATE) VALUES (30, 'TEST', SYSDATE);
INSERT INTO category
            *
ERROR at line 1:
ORA-04098: trigger 'SYSTEM.TRG_LOG_AND_NOTIFY_CATEGORY_INVALID' is invalid and
failed re-validation

SQL> INSERT INTO category (category_id, category_name, created_date) VALUES (10, 'meic', SYSDATE);

1 row created.

6. trg_check_duplicate_batch_no
SQL> CREATE OR REPLACE TRIGGER trg_check_duplicate_batch_no
  2  BEFORE INSERT OR UPDATE ON batch
  3  FOR EACH ROW
  4  DECLARE
  5      v_count NUMBER;
  6  BEGIN
  7      SELECT COUNT(*) INTO v_count
  8      FROM batch
  9      WHERE UPPER(batch_no) = UPPER(:NEW.batch_no)
 10      AND batch_id != :NEW.batch_id;
 11
 12      IF v_count > 0 THEN
 13          RAISE_APPLICATION_ERROR(-20013,
 14              'Batch number already exists. Use different batch number.');
 15      END IF;
 16  END;
 17  /

Trigger created.


SQL> INSERT INTO batch (BATCH_ID, MEDICINE_ID, BATCH_NO, QUANTITY_AVAILABLE) VALUES (301, 201, 'B001', 500);
1 row created.

SQL> INSERT INTO batch (BATCH_ID, MEDICINE_ID, BATCH_NO, QUANTITY_AVAILABLE) VALUES (10, 101, 'B001', 100);
INSERT INTO batch
            *
ERROR at line 1:
ORA-20013: Batch number already exists. Use different batch number.
ORA-06512: at "SYSTEM.TRG_CHECK_DUPLICATE_BATCH_NO", line 10
ORA-04088: error during execution of trigger
'SYSTEM.TRG_CHECK_DUPLICATE_BATCH_NO'

SQL> CREATE OR REPLACE TRIGGER trg_validate_supplier_capacity
  2  BEFORE INSERT OR UPDATE ON medicine
  3  FOR EACH ROW
  4  DECLARE
  5      v_max_capacity NUMBER := 5;
  6      v_existing_count NUMBER;
  7  BEGIN
  8
  9      SELECT COUNT(*) INTO v_existing_count
 10      FROM medicine
 11      WHERE supplier_id = :NEW.supplier_id;
 12
 13      IF v_existing_count >= v_max_capacity THEN
 14          RAISE_APPLICATION_ERROR(-20014, 'Supplier capacity exceeded!');
 15      END IF;
 16  END;
 17  /

Trigger created.

SQL> INSERT INTO medicine (MEDICINE_ID, MEDICINE_NAME, SUPPLIER_ID) VALUES (501, 'DOLO', 101);
Medicine table was accessed. Statement complete.

1 row created.

SQL> INSERT INTO medicine (MEDICINE_ID, MEDICINE_NAME, SUPPLIER_ID) VALUES (506, 'CROCIN', 101);
INSERT INTO medicine
            *
ERROR at line 1:
ORA-20014: Supplier capacity exceeded!
ORA-06512: at "SYSTEM.TRG_VALIDATE_SUPPLIER_CAPACITY", line 11
ORA-04088: error during execution of trigger
'SYSTEM.TRG_VALIDATE_SUPPLIER_CAPACITY'

7a.
1.
SQL> SELECT student_id, course_id, marks
  2  FROM enroll
  3  WHERE course_id IN (
  4      SELECT course_id
  5      FROM teaches
  6      WHERE instructor_name = 'Dr. Anand'
  7  );

STUDE COURS      MARKS
----- ----- ----------
11    C1            50
12    C1            55
13    C1            60
14    C1            65
15    C1            70

SQL> UPDATE enroll
  2  SET marks = marks * 1.40
  3  WHERE course_id = 'C1';

5 rows updated.

SQL> SELECT student_id, course_id, marks
  2  FROM enroll
  3  WHERE course_id = 'C1';

STUDE COURS      MARKS
----- ----- ----------
11    C1            70
12    C1            77
13    C1            84
14    C1            91
15    C1            98

2.

SQL> SELECT student_name
  2  FROM student
  3  WHERE student_id = (
  4      SELECT student_id
  5      FROM enroll
  6      WHERE marks = (
  7          SELECT MAX(marks)
  8          FROM enroll
  9          WHERE marks < (SELECT MAX(marks) FROM enroll)
 10      )
 11  );

STUDENT_NAME
--------------------------------------------------
Vikram

SQL> SELECT marks FROM enroll ORDER BY marks DESC;

     MARKS
----------
        98
        92
        91
        88
        84
5 rows selected.

SQL> SELECT s.student_name, e.marks FROM student s, enroll e WHERE s.student_id = e.student_id AND e.marks = 92;

STUDENT_NAME                                            MARKS
-------------------------------------------------- ----------
Vikram                                                     92

3.
SQL> SELECT DISTINCT c.course_name
  2  FROM course c, enroll e
  3  WHERE c.course_id = e.course_id
  4  AND e.marks > (SELECT AVG(marks) FROM enroll);

COURSE_NAME
--------------------------------------------------
Data Structures
Computer Networks

SQL> SELECT AVG(marks) FROM enroll;

AVG(MARKS)
----------
83.8888889

SQL> SELECT c.course_name, e.marks FROM course c, enroll e WHERE c.course_id = e.course_id AND e.marks > 88.5;

COURSE_NAME                                             MARKS
-------------------------------------------------- ----------
Data Structures                                            91
Computer Networks                                          92

4.
SQL> SELECT s.student_name, s.city
  2  FROM student s, enroll e
  3  WHERE s.student_id = e.student_id
  4  AND e.marks = (SELECT MAX(marks) FROM enroll);

STUDENT_NAME
--------------------------------------------------
CITY
--------------------------------------------------
Lokesh
Trichy

SQL> SELECT MAX(marks) FROM enroll;

MAX(MARKS)
----------
        98

SQL> SELECT s.student_name, s.city, e.marks FROM student s, enroll e WHERE s.student_id = e.student_id AND e.marks = 98;

STUDENT_NAME
--------------------------------------------------
CITY                                                    MARKS
-------------------------------------------------- ----------
Lokesh
Trichy                                                     98

5.
SQL> CREATE OR REPLACE FUNCTION max_enroll
  2  RETURN VARCHAR2
  3  IS
  4      v_course_name VARCHAR2(50);
  5  BEGIN
  6      SELECT course_name INTO v_course_name
  7      FROM course
  8      WHERE course_id = (
  9          SELECT course_id
 10          FROM enroll
 11          GROUP BY course_id
 12          ORDER BY COUNT(*) DESC
 13          FETCH FIRST 1 ROW ONLY
 14      );
 15
 16      RETURN v_course_name;
 17
 18  EXCEPTION
 19      WHEN NO_DATA_FOUND THEN
 20          RETURN 'NOT FOUND';
 21  END;
 22  /

Function created.

SQL> SELECT course_id, COUNT(*) AS total_students FROM enroll GROUP BY course_id ORDER BY total_students DESC;

COURS TOTAL_STUDENTS
----- --------------
C1                 5
C3                 2
C2                 2

SQL> SELECT course_name FROM course WHERE course_id = 'C1';

COURSE_NAME
--------------------------------------------------
Data Structures

SQL> SELECT max_enroll FROM dual;

MAX_ENROLL
--------------------------------------------------------------------------------
Data Structures


7b.
1.SQL> SELECT staff_name
  2  FROM staff
  3  WHERE UPPER(building) = 'A'
  4  AND UPPER(block) = 'C';

STAFF_NAME
--------------------------------------------------
Ravi
Kumar

SQL> SELECT staff_name, building, block FROM staff;

STAFF_NAME                                         BUILD BLOCK
-------------------------------------------------- ----- -----
Ravi                                               A     C
Kumar                                              a     c
Deepak                                             B     B


2.SQL> SELECT m.member_name, b.book_title, l.amount
  2  FROM members m, books b, borrow br, line l
  3  WHERE m.member_id = br.member_id
  4  AND b.book_id = br.book_id
  5  AND m.member_id = l.member_id
  6  AND (b.category = 'dbms' OR b.category = 'maths')
  7  AND l.amount > 500;

MEMBER_NAME                                        BOOK_TITLE                                             AMOUNT
-------------------------------------------------- -------------------------------------------------- ----------
Arun                                               DBMS Basics                                               700
Kishore                                            Advanced Maths                                            650

SQL> select category FROM books;

CATEGORY
--------------------
dbms
maths
science

SQL> SELECT member_id, amount FROM line;

MEMBE     AMOUNT
----- ----------
11           700
12           200
13           650

SQL> CREATE OR REPLACE VIEW member_book_view AS
  2  SELECT m.member_name, b.book_title
  3  FROM members m, books b, borrow br
  4  WHERE m.member_id = br.member_id
  5  AND b.book_id = br.book_id;

View created.

SQL> SELECT * FROM member_book_view;

MEMBER_NAME                                        BOOK_TITLE
-------------------------------------------------- --------------------------------------------------
Arun                                               DBMS Basics
Kishore                                            Advanced Maths

SQL> CREATE OR REPLACE PROCEDURE insert_book(
  2      p_id VARCHAR2,
  3      p_title VARCHAR2,
  4      p_author VARCHAR2,
  5      p_category VARCHAR2,
  6      p_price NUMBER
  7  )
  8  IS
  9  BEGIN
 10      INSERT INTO books
 11      VALUES (p_id, p_title, p_author, p_category, p_price);
 12  END;
 13  /

Procedure created.

SQL> EXEC insert_book('B10','Java','James','programming',600);

PL/SQL procedure successfully completed.

SQL> SELECT * FROM books WHERE book_id = 'B10';

BOOK_ BOOK_TITLE                                         AUTHOR                                             CATEGORY                  PRICE
----- -------------------------------------------------- -------------------------------------------------- -------------------- ----------
B10   Java                                               James                                              programming                 600

SQL> SET TIMING ON;
SQL> SELECT member_name FROM members ORDER BY member_name;

MEMBER_NAME
--------------------------------------------------
Arun
Bharath
Kishore

Elapsed: 00:00:00.16
SQL> CREATE INDEX idx_member_name ON members(member_name);

Index created.

Elapsed: 00:00:00.12
SQL> SELECT member_name FROM members ORDER BY member_name;

MEMBER_NAME
--------------------------------------------------
Arun
Bharath
Kishore
