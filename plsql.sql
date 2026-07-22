[24bcsl03@mepcolinux sql]$cat plsql.prn
SQL> set serveroutput on;
1. Simple PLSQL block
SQL> declare
  2        v_mname medicine.medicine_name%type;
  3        v_price medicine.selling_price%type;
  4      begin
  5        select medicine_name, selling_price
  6        into v_mname, v_price
  7        from medicine
  8        where medicine_id = 201;
  9       dbms_output.put_line('Medicine: ' || v_mname);
 10       dbms_output.put_line('Price: ' || v_price);
 11     end;
 12     /
Medicine: Paracetamol
Price: 110
PL/SQL procedure successfully completed.

2.if-else
SQL> DECLARE
  2    v_status category.active_status%TYPE;
  3  BEGIN
  4    SELECT active_status
  5    INTO v_status
  6    FROM category
  7    WHERE category_id = 1;
  8
  9    IF v_status = 'ACTIVE' THEN
 10      DBMS_OUTPUT.PUT_LINE('Category Active');
 11    ELSE
 12      DBMS_OUTPUT.PUT_LINE('Category Inactive');
 13    END IF;
 14  END;
 15  /
Category Active
PL/SQL procedure successfully completed.

SQL> DECLARE
  2    v_status category.active_status%TYPE;
  3  BEGIN
  4    SELECT active_status
  5    INTO v_status
  6    FROM category
  7    WHERE category_id = 4;
  8
  9    IF v_status = 'ACTIVE' THEN
 10      DBMS_OUTPUT.PUT_LINE('Category Active');
 11    ELSE
 12      DBMS_OUTPUT.PUT_LINE('Category Inactive');
 13    END IF;
 14  END;
 15  /
Category Inactive
PL/SQL procedure successfully completed.

SQL> DECLARE
  2    v_price medicine.selling_price%TYPE;
  3  BEGIN
  4    SELECT selling_price
  5    INTO v_price
  6    FROM medicine
  7    WHERE medicine_id = 101;
  8
  9    IF v_price > 200 THEN
 10      IF v_price > 500 THEN
 11        DBMS_OUTPUT.PUT_LINE('High Price Medicine');
 12      ELSE
 13        DBMS_OUTPUT.PUT_LINE('Normal Price Medicine');
 14      END IF;
 15    ELSE
 16      DBMS_OUTPUT.PUT_LINE('Low Price Medicine');
 17    END IF;
 18  END;
 19  /
Low Price Medicine
PL/SQL procedure successfully completed.

3.nested if
SQL> DECLARE
  2    v_price medicine.selling_price%TYPE;
  3  BEGIN
  4    SELECT selling_price
  5    INTO v_price
  6    FROM medicine
  7    WHERE medicine_id = 204;
  8
  9    IF v_price > 200 THEN
 10      IF v_price > 500 THEN
 11        DBMS_OUTPUT.PUT_LINE('High Price Medicine');
 12      ELSE
 13        DBMS_OUTPUT.PUT_LINE('Normal Price Medicine');
 14      END IF;
 15    ELSE
 16      DBMS_OUTPUT.PUT_LINE('Low Price Medicine');
 17    END IF;
 18  END;
 19  /
High Price Medicine
PL/SQL procedure successfully completed.

4. Basic for loop to print 1 to 5
SQL> DECLARE
  2    v_num NUMBER := 1;
  3  BEGIN
  4    LOOP
  5      DBMS_OUTPUT.PUT_LINE(v_num);
  6      v_num := v_num + 1;
  7      EXIT WHEN v_num > 4;
  8    END LOOP;
  9  END;
 10  /
1
2
3
4
PL/SQL procedure successfully completed.

5. while loop to print medicine names.
SQL> DECLARE
  2    v_id NUMBER := 201;
  3    v_name medicine.medicine_name%TYPE;
  4  BEGIN
  5    WHILE v_id <= 205 LOOP
  6      SELECT medicine_name
  7      INTO v_name
  8      FROM medicine
  9      WHERE medicine_id = v_id;
 10
 11      DBMS_OUTPUT.PUT_LINE('Medicine: ' || v_name);
 12      v_id := v_id + 1;
 13    END LOOP;
 14  END;
 15  /
Medicine: Paracetamol
Medicine: Ibuprofen
Medicine: Cough Syrup
PL/SQL procedure successfully completed.

6. For loop to print Medicine id.
SQL> BEGIN
  2    FOR i IN 101..105 LOOP
  3      DBMS_OUTPUT.PUT_LINE('Medicine ID: ' || i);
  4    END LOOP;
  5  END;
  6  /
Medicine ID: 101
Medicine ID: 102
Medicine ID: 103
PL/SQL procedure successfully completed.

7.explicit cursor to display medicine name and sellingprice
SQL> DECLARE
  2    CURSOR med_cur IS
  3    SELECT medicine_name, selling_price FROM medicine;
  4
  5    v_name medicine.medicine_name%TYPE;
  6    v_price medicine.selling_price%TYPE;
  7  BEGIN
  8    OPEN med_cur;
  9
 10    LOOP
 11      FETCH med_cur INTO v_name, v_price;
 12      EXIT WHEN med_cur%NOTFOUND;
 13
 14      DBMS_OUTPUT.PUT_LINE(v_name || ' ' || v_price);
 15    END LOOP;
 16
 17    CLOSE med_cur;
 18  END;
 19  /
Paracetamol 110
Ibuprofen 165
Cough Syrup 135
Insulin 650
PL/SQL procedure successfully completed.

8. Cursor in for loop to display batch details.
SQL> DECLARE
  2    CURSOR b_cur IS
  3    SELECT batch_id, cost_price FROM batch;
  4  BEGIN
  5    FOR rec IN b_cur LOOP
  6      DBMS_OUTPUT.PUT_LINE('Batch: ' || rec.batch_id || ' Cost Price: ' || rec.cost_price);
  7    END LOOP;
  8  END;
  9  /
Batch: 301 Cost Price: 90
Batch: 302 Cost Price: 95
Batch: 303 Cost Price: 140
Batch: 304 Cost Price: 550
PL/SQL procedure successfully completed.

9. Cursor to display category status
SQL> DECLARE
  2    CURSOR c_cur IS
  3      SELECT category_id, active_status FROM category;
  4  BEGIN
  5    FOR rec IN c_cur LOOP
  6      IF rec.active_status = 'ACTIVE' THEN
  7        DBMS_OUTPUT.PUT_LINE('Category ' || rec.category_id || ' active');
  8      ELSE
  9        DBMS_OUTPUT.PUT_LINE('Category ' || rec.category_id || ' inactive');
 10      END IF;
 11    END LOOP;
 12  END;
 13  /
Category 1 active
Category 2 active
Category 3 active
Category 4 inactive
PL/SQL procedure successfully completed.

10. Aggregate function to calculate total, high price, and low price cost
SQL> DECLARE
  2    v_total NUMBER;
  3    v_high  NUMBER;
  4    v_low   NUMBER;
  5  BEGIN
  6    SELECT SUM(selling_price) INTO v_total FROM medicine;
  7
  8    SELECT SUM(selling_price)
  9    INTO v_high
 10    FROM medicine
 11    WHERE selling_price >= 100;
 12
 13    SELECT SUM(selling_price)
 14    INTO v_low
 15    FROM medicine
 16    WHERE selling_price < 100;
 17
 18    DBMS_OUTPUT.PUT_LINE('Total Medicine Price: ' || v_total);
 19    DBMS_OUTPUT.PUT_LINE('High Price Amount: ' || v_high);
 20    DBMS_OUTPUT.PUT_LINE('Low Price Amount: ' || v_low);
 21  END;
 22  /
Total Medicine Price: 1600
High Price Amount: 1510
Low Price Amount: 90
PL/SQL procedure successfully completed.

11.(Joins – Medicine and Batch)
SQL> DECLARE
  2    CURSOR c1 IS
  3      SELECT m.medicine_name, b.cost_price
  4      FROM medicine m
  5      JOIN batch b
  6      ON m.medicine_id = b.medicine_id;
  7  BEGIN
  8    FOR rec IN c1 LOOP
  9      DBMS_OUTPUT.PUT_LINE(rec.medicine_name ||
 10                           ' cost:' || rec.cost_price);
 11    END LOOP;
 12  END;
 13  /
Paracetamol cost:90
Paracetamol cost:95
Ibuprofen cost:140
Insulin cost:550
PL/SQL procedure successfully completed.

12. subquery ( medicine who made highest purchase)
SQL> DECLARE
  2    v_name medicine.medicine_name%TYPE;
  3    amt NUMBER;
  4  BEGIN
  5    SELECT MAX(cost_price) INTO amt FROM batch;
  6
  7    SELECT medicine_name
  8    INTO v_name
  9    FROM medicine
 10    WHERE medicine_id =
 11    (SELECT medicine_id FROM batch
 12     WHERE cost_price =
 13     (SELECT MAX(cost_price) FROM batch));
 14
 15    DBMS_OUTPUT.PUT_LINE('Highest cost price: ' || amt);
 16    DBMS_OUTPUT.PUT_LINE('Medicine with highest cost: ' || v_name);
 17  END;
 18  /
Highest cost price: 550
Medicine with highest cost: Insulin
PL/SQL procedure successfully completed.

13.add new row in customer table.
SQL> DECLARE
  2    v_id customer.customer_id%TYPE := 200;
  3    v_name customer.customer_name%TYPE := 'Rahul';
  4    v_mobile customer.mobile_no%TYPE := '9876543210';
  5    v_date customer.registration_date%TYPE := SYSDATE;
  6  BEGIN
  7    INSERT INTO customer(customer_id, customer_name, mobile_no, registration_date)
  8    VALUES(v_id, v_name, v_mobile, v_date);
  9
 10    DBMS_OUTPUT.PUT_LINE('Customer inserted');
 11    COMMIT;
 12  END;
 13  /
Customer inserted
PL/SQL procedure successfully completed.

SQL> select * from customer where customer_id=200;
CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT        AGE
--------- ----------
        200 Rahul                9876543210

17-MAR-26

14.add rows in batch table
SQL> DECLARE
  2    v_id batch.batch_id%TYPE := 900;
  3    v_mid batch.medicine_id%TYPE := 204;
  4    v_qty batch.quantity_received%TYPE := 100;
  5    v_avl batch.quantity_available%TYPE := 100;
  6    v_cost batch.cost_price%TYPE := 5000;
  7  BEGIN
  8    INSERT INTO batch(batch_id, medicine_id, batch_no, manufacture_date,
  9                      expiry_date, quantity_received, quantity_available, cost_price)
 10    VALUES(v_id, v_mid, 'B900', SYSDATE, SYSDATE+365,
 11           v_qty, v_avl, v_cost);
 12
 13    DBMS_OUTPUT.PUT_LINE('Batch inserted');
 14    COMMIT;
 15  END;
 16  /
Batch inserted

PL/SQL procedure successfully completed.
SQL> select * from batch where batch_id=900;
  BATCH_ID MEDICINE_ID BATCH_NO
---------- ----------- --------------------------------------------------
MANUFACTU EXPIRY_DA QUANTITY_RECEIVED QUANTITY_AVAILABLE COST_PRICE
--------- --------- ----------------- ------------------ ----------
       900         204 B900
17-MAR-26 17-MAR-27               100                100       5000

15. update customer address
SQL> SELECT customer_address FROM customer WHERE customer_id = 3;
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
Tuticorin

SQL> DECLARE
  2    v_id customer.customer_id%TYPE := 3;
  3    v_addr customer.customer_address%TYPE := 'Chennai';
  4  BEGIN
  5    UPDATE customer
  6    SET customer_address = v_addr
  7    WHERE customer_id = v_id;
  8
  9    DBMS_OUTPUT.PUT_LINE('Address updated');
 10    COMMIT;
 11  END;
 12  /
Address updated
PL/SQL procedure successfully completed.

SQL> SELECT customer_address FROM customer WHERE customer_id = 3;
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
Chennai

16. delete customer
SQL> DECLARE
  2    v_id customer.customer_id%TYPE := 200;
  3  BEGIN
  4    DELETE FROM customer
  5    WHERE customer_id = v_id;
  6
  7    DBMS_OUTPUT.PUT_LINE('Customer deleted');
  8    COMMIT;
  9  END;
 10  /
Customer deleted
PL/SQL procedure successfully completed.

SQL> SELECT * FROM customer WHERE customer_id = 200;
no rows selected

17.Insert using if condition
SQL> DECLARE
  2    v_price medicine.selling_price%TYPE := 200;
  3  BEGIN
  4    IF v_price > 300 THEN
  5      INSERT INTO medicine(medicine_id, medicine_name, selling_price)
  6      VALUES(300, 'NewTablet', v_price);
  7
  8      DBMS_OUTPUT.PUT_LINE('Medicine inserted');
  9    ELSE
 10      DBMS_OUTPUT.PUT_LINE('Price too low');
 11    END IF;
 12
 13    COMMIT;
 14  END;
 15  /
Price too low
PL/SQL procedure successfully completed.

SQL> DECLARE
  2    v_age customer.age%TYPE := 25;
  3  BEGIN
  4    IF v_age > 18 THEN
  5      INSERT INTO customer(customer_id, customer_name, mobile_no, registration_date, age)
  6      VALUES(300, 'Raja', '9876543210', SYSDATE, v_age);
  7
  8      DBMS_OUTPUT.PUT_LINE('Customer inserted');
  9    ELSE
 10      DBMS_OUTPUT.PUT_LINE('Age too low');
 11    END IF;
 12
 13    COMMIT;
 14  END;
 15  /
Customer inserted
PL/SQL procedure successfully completed.

SQL> SELECT * FROM customer WHERE customer_id = 300;
CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT        AGE
--------- ----------
        300 Raja                 9876543210

17-MAR-26         25

18.Update Medicine Prices using Cursor
SQL> DECLARE
  2    CURSOR c1 IS
  3      SELECT medicine_id, selling_price FROM medicine;
  4  BEGIN
  5    FOR rec IN c1 LOOP
  6      UPDATE medicine
  7      SET selling_price = rec.selling_price + 10
  8      WHERE medicine_id = rec.medicine_id;
  9    END LOOP;
 10
 11    DBMS_OUTPUT.PUT_LINE('Medicine prices updated');
 12    COMMIT;
 13  END;
 14  /
Medicine prices updated
PL/SQL procedure successfully completed.

SQL> select selling_price from medicine;
SELLING_PRICE
-------------
          120
          175
          145
          660
          100
          460

8 rows selected.

19. delete inactive status
SQL> SELECT * FROM category WHERE active_status = 'INACTIVE';
CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
DESCRIPTION
--------------------------------------------------------------------------------
  TAX_RATE ACTIVE_STATUS        CREATED_D UPDATED_D
---------- -------------------- --------- ---------
          4 medicine
Medicine in tablet form
        25 INACTIVE             17-MAR-26


SQL> DECLARE
  2  BEGIN
  3    DELETE FROM category
  4    WHERE active_status = 'INACTIVE';
  5
  6    DBMS_OUTPUT.PUT_LINE('Inactive categories deleted');
  7    COMMIT;
  8  END;
  9  /
Inactive categories deleted
PL/SQL procedure successfully completed.

SQL> SELECT * FROM category WHERE active_status = 'INACTIVE';
no rows selected

20.Record to Store Medicine Details
SQL> DECLARE
  2    TYPE med_rec IS RECORD(
  3      v_name medicine.medicine_name%TYPE,
  4      v_price medicine.selling_price%TYPE
  5    );
  6
  7    rec med_rec;
  8  BEGIN
  9    SELECT medicine_name, selling_price
 10    INTO rec
 11    FROM medicine
 12    WHERE medicine_id = 204;
 13
 14    DBMS_OUTPUT.PUT_LINE(rec.v_name || ' ' || rec.v_price);
 15  END;
 16  /
Insulin 660
PL/SQL procedure successfully completed.

21.Exceptions
SQL> DECLARE
  2    v_price medicine.selling_price%TYPE;
  3  BEGIN
  4    SELECT selling_price
  5    INTO v_price
  6    FROM medicine
  7    WHERE medicine_id = 9999;
  8
  9    DBMS_OUTPUT.PUT_LINE(v_price);
 10
 11  EXCEPTION
 12    WHEN NO_DATA_FOUND THEN
 13      DBMS_OUTPUT.PUT_LINE('No medicine found');
 14
 15    WHEN TOO_MANY_ROWS THEN
 16      DBMS_OUTPUT.PUT_LINE('Multiple rows found');
 17  END;
 18  /
No medicine found
PL/SQL procedure successfully completed.

SQL> DECLARE
  2    v_price medicine.selling_price%TYPE;
  3  BEGIN
  4    SELECT selling_price
  5    INTO v_price
  6    FROM medicine
  7    WHERE cat_id = 1;
  8
  9    DBMS_OUTPUT.PUT_LINE(v_price);
 10
 11  EXCEPTION
 12    WHEN NO_DATA_FOUND THEN
 13      DBMS_OUTPUT.PUT_LINE('No medicine found');
 14
 15    WHEN TOO_MANY_ROWS THEN
 16      DBMS_OUTPUT.PUT_LINE('Multiple rows found');
 17  END;
 18  /
Multiple rows found
PL/SQL procedure successfully completed.

SQL> DECLARE
  2    v_price medicine.selling_price%TYPE;
  3  BEGIN
  4    SELECT selling_price
  5    INTO v_price
  6    FROM medicine
  7    WHERE medicine_id = 204;
  8
  9    DBMS_OUTPUT.PUT_LINE(v_price);
 10
 11  EXCEPTION
 12    WHEN NO_DATA_FOUND THEN
 13      DBMS_OUTPUT.PUT_LINE('No medicine found');
 14    WHEN TOO_MANY_ROWS THEN
 15      DBMS_OUTPUT.PUT_LINE('Multiple rows found');
 16  END;
 17  /
660
PL/SQL procedure successfully completed.

SQL> DECLARE
  2    e_low_price EXCEPTION;
  3    v_price medicine.selling_price%TYPE;
  4  BEGIN
  5    SELECT selling_price
  6    INTO v_price
  7    FROM medicine
  8    WHERE medicine_id = &id;
  9
 10    IF v_price < 100 THEN
 11      RAISE e_low_price;
 12    END IF;
 13
 14  EXCEPTION
 15    WHEN e_low_price THEN
 16      DBMS_OUTPUT.PUT_LINE('Medicine price too low!');
 17    WHEN NO_DATA_FOUND THEN
 18      DBMS_OUTPUT.PUT_LINE('No such medicine id');
 19  END;
 20  /
Enter value for id: 204
old   8:   WHERE medicine_id = &id;
new   8:   WHERE medicine_id = 204;
selling_price too low!
PL/SQL procedure successfully completed.
