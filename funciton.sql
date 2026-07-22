[24bcsl03@mepcolinux l]$cat function.prn
Script started on Mon Apr  6 20:05:34 2026
[24bcsl03@mepcolinux ~]$cat fun.txt
INSERT ROWS INTO CUSTOMER(NO PARAMETER)

SQL> CREATE OR REPLACE PROCEDURE p1
  2  IS
  3  BEGIN
  4    INSERT INTO customer (
  5      customer_id,customer_name,mobile_no,customer_email,customer_address,registration_date,age)
  6    VALUES (101,'Wasi Sundhar','9876543210','wasi@gmail.com','Chennai',SYSDATE,25);
  7  END p1;
  8  /

Procedure created.

SQL> EXEC p1;

PL/SQL procedure successfully completed.

SQL> SELECT * FROM customer WHERE customer_id = 101;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT        AGE
--------- ----------
        101 Wasi Sundhar         9876543210      wasi@gmail.com
Chennai
30-MAR-26         25

TO DISPALY SIMPLE MESSAGE(NO PARAMETER)

SQL> CREATE OR REPLACE PROCEDURE hi
  2  IS
  3  BEGIN
  4    DBMS_OUTPUT.PUT_LINE('HI');
  5  END hi;
  6  /

Procedure created.

SQL> SET SERVEROUTPUT ON;
SQL> EXEC hi;
HI

PL/SQL procedure successfully completed.


TO INSERT ROW INTO medicine (IN PARAMETER)

SQL> CREATE OR REPLACE PROCEDURE p_medicine (
  2    m_id    IN NUMBER,
  3    m_name  IN VARCHAR2
  4  )
  5  IS
  6  BEGIN
  7    INSERT INTO medicine (medicine_id, medicine_name)
  8    VALUES (m_id, m_name);
  9  END p_medicine;
 10  /

Procedure created.

SQL> EXEC p_medicine(401, 'Paracetamol');
Medicine table was accessed. Statement complete.

PL/SQL procedure successfully completed.


SQL> SELECT * FROM medicine WHERE medicine_id = 401;

MEDICINE_ID     CAT_ID MEDICINE_NAME
----------- ---------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE PRESCRIPTION_RE SUPPLIER_ID
---------- ------------- --------------- -----------
        401            Paracetamol


  PATTERN nXn(IN PARAMETER)

SQL> CREATE OR REPLACE PROCEDURE star(n IN NUMBER)
  2  IS
  3  BEGIN
  4    FOR i IN 1..n LOOP
  5      FOR j IN 1..i LOOP
  6        DBMS_OUTPUT.PUT('* ');
  7      END LOOP;
  8      DBMS_OUTPUT.NEW_LINE;
  9    END LOOP;
 10  END star;
 11  /

Procedure created.

SQL> DECLARE
  2    n NUMBER;
  3  BEGIN
  4    n := &n;
  5    star(n);
  6  END;
  7  /
Enter value for n: 3
old   4:   n := &n;
new   4:   n := 3;
*
* *
* * *

PL/SQL procedure successfully completed.


SQL> DECLARE
  2    n NUMBER;
  3  BEGIN
  4    n := &n;
  5    star(n);
  6  END;
  7  /
Enter value for n: 4
old   4:   n := &n;
new   4:   n := 4;
*
* *
* * *
* * * *

PL/SQL procedure successfully completed.

 TO GET medicine _ID AND RETURN THEIR NAME(IN PARAMETER,OUT PARAMETER)

SQL> CREATE OR REPLACE PROCEDURE p3_medicine(id   IN NUMBER,name OUT VARCHAR2)
  2  IS
  3  BEGIN
  4    SELECT medicine_name INTO name FROM medicine WHERE medicine_id = id;
  5  END p3_medicine;
  6  /

Procedure created.

SQL> DECLARE
  2    id   NUMBER;
  3    name VARCHAR2(50);
  4  BEGIN
  5    id := &id;
  6    p3_medicine(id, name);
  7    DBMS_OUTPUT.PUT_LINE('MEDICINE NAME: ' || name);
  8  END;
  9  /
Enter value for id: 101
old   5:   id := &id;
new   5:   id := 101;
MEDICINE NAME: PARACETAMOL

PL/SQL procedure successfully completed.

Enter value for id: 203
old   5:   id := &id;
new   5:   id := 203;
MEDICINE NAME: Cough Syrup

PL/SQL procedure successfully completed.

Enter value for id: 108
old   5:   id := &id;
new   5:   id := 108;
MEDICINE NAME: VICKS

PL/SQL procedure successfully completed.

 ODD OR EVEN (IN PARAMETER ,OUT PARAMETER)

SQL> CREATE OR REPLACE PROCEDURE check_num(
  2    num IN NUMBER,
  3    ans OUT VARCHAR2
  4  )
  5  IS
  6  BEGIN
  7    IF num = 0 THEN
  8      ans := 'ZERO';
  9    ELSIF MOD(num, 2) = 0 THEN
 10      ans := 'EVEN';
 11    ELSE
 12      ans := 'ODD';
 13    END IF;
 14  END;
 15  /

Procedure created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> DECLARE
  2    num NUMBER;
  3    ans VARCHAR2(20);
  4  BEGIN
  5    num := &num;
  6    check_num(num, ans);
  7    DBMS_OUTPUT.PUT_LINE('THE NUMBER ' || num || ' IS ' || ans);
  8  END;
  9  /
Enter value for num: 20
old   5:   num := &num;
new   5:   num := 20;
THE NUMBER 20 IS EVEN

PL/SQL procedure successfully completed.

Enter value for num: 31
old   5:   num := &num;
new   5:   num := 31;
THE NUMBER 31 IS ODD

PL/SQL procedure successfully completed.

Enter value for num: 0
old   5:   num := &num;
new   5:   num := 0;
THE NUMBER 0 IS ZERO

PL/SQL procedure successfully completed.

TO GET CUSTOMER_ID  AND RETURN THEIR CITY (IN OUT PARAMETER)

SQL> CREATE OR REPLACE PROCEDURE p4_customer(
  2    id   IN OUT NUMBER,
  3    name IN OUT VARCHAR2
  4  )
  5  IS
  6  BEGIN
  7    SELECT customer_address
  8    INTO name
  9    FROM customer
 10    WHERE customer_id = id;
 11
 12  EXCEPTION
 13    WHEN NO_DATA_FOUND THEN
 14      name := 'NO DATA FOUND';
 15  END;
 16  /

Procedure created.

SQL> DECLARE
  2    id   NUMBER;
  3    name VARCHAR2(100);
  4  BEGIN
  5    id := &id;
  6
  7    p4_customer(id, name);
  8
  9    DBMS_OUTPUT.PUT_LINE('CITY: ' || name || ' | ID: ' || id);
 10  END;
 11  /
Enter value for id: 101
old   5:   id := &id;
new   5:   id := 101;
CITY: Chennai | ID: 101

PL/SQL procedure successfully completed.

Enter value for id: 1
old   5:   id := &id;
new   5:   id := 1;
CITY: Tuticorin | ID: 1

PL/SQL procedure successfully completed.

 FIBONACCI  OF NUMBER(IN OUT PARAMETER)

SQL> CREATE OR REPLACE PROCEDURE fib(n IN OUT NUMBER)
  2  IS
  3    a NUMBER := 0;
  4    b NUMBER := 1;
  5    c NUMBER;
  6  BEGIN
  7    IF n >= 1 THEN
  8      DBMS_OUTPUT.PUT_LINE(a);
  9    END IF;
 10
 11    IF n >= 2 THEN
 12      DBMS_OUTPUT.PUT_LINE(b);
 13    END IF;
 14
 15    FOR i IN 3..n LOOP
 16      c := a + b;
 17      DBMS_OUTPUT.PUT_LINE(c);
 18      a := b;
 19      b := c;
 20    END LOOP;
 21
 22    -- Return last Fibonacci number using IN OUT
 23    IF n = 1 THEN
 24      n := a;
 25    ELSIF n >= 2 THEN
 26      n := b;
 27    END IF;
 28
 29  END fib;
 30  /

Procedure created.

SQL> DECLARE
  2    num NUMBER;
  3  BEGIN
  4    num := &num;
  5
  6    DBMS_OUTPUT.PUT_LINE('FIBONACCI SERIES:');
  7    fib(num);
  8
  9    DBMS_OUTPUT.PUT_LINE('LAST VALUE: ' || num);
 10  END;
 11  /
Enter value for num: 4
old   4:   num := &num;
new   4:   num := 4;
FIBONACCI SERIES:
0
1
1
2
LAST VALUE: 2

PL/SQL procedure successfully completed.

Enter value for num: 8
old   4:   num := &num;
new   4:   num := 8;
FIBONACCI SERIES:
0
1
1
2
3
5
8
13
LAST VALUE: 13

PL/SQL procedure successfully completed.

 TO DISPLAY THE VALUES IN RECORD BY CURSOR(OUT PARAMETER)

SQL> CREATE OR REPLACE PROCEDURE p5_supplier(c_cursor OUT SYS_REFCURSOR)
  2  IS
  3  BEGIN
  4    OPEN c_cursor FOR
  5      SELECT supplier_name, supplier_phone
  6      FROM supplier;
  7  END p5_supplier;
  8  /

Procedure created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> DECLARE
  2    v_cursor SYS_REFCURSOR;
  3    name VARCHAR2(50);
  4    phone VARCHAR2(20);
  5  BEGIN
  6    p5_supplier(v_cursor);
  7
  8    LOOP
  9      FETCH v_cursor INTO name, phone;
 10      EXIT WHEN v_cursor%NOTFOUND;
 11
 12      DBMS_OUTPUT.PUT_LINE('NAME: ' || name || ' PHONE: ' || phone);
 13    END LOOP;
 14
 15    CLOSE v_cursor;
 16  END;
 17  /
NAME: ABC Pharma PHONE: 9876543210
NAME: MediCare Ltd PHONE: 9876543211
NAME: xyz SUPPLIER PHONE: 9854232265

PL/SQL procedure successfully completed.

 CREATE OR REPLACE PROCEDURE five(c_cursor OUT SYS_REFCURSOR)
SQL> CREATE OR REPLACE PROCEDURE five_medicine(c_cursor OUT SYS_REFCURSOR)
  2  IS
  3  BEGIN
  4    OPEN c_cursor FOR
  5      SELECT medicine_name
  6      FROM medicine
  7      FETCH FIRST 5 ROWS ONLY;
  8  END five_medicine;
  9  /

Procedure created.

SQL> DECLARE
  2    v_cursor SYS_REFCURSOR;
  3    name VARCHAR2(50);
  4  BEGIN
  5    five_medicine(v_cursor);
  6
  7    LOOP
  8      FETCH v_cursor INTO name;
  9      EXIT WHEN v_cursor%NOTFOUND;
 10
 11      DBMS_OUTPUT.PUT_LINE('MEDICINE: ' || name);
 12    END LOOP;
 13
 14    CLOSE v_cursor;
 15  END;
 16  /
MEDICINE: PARACETAMOL
MEDICINE: VICKS
MEDICINE: Aspirin
MEDICINE: CROCIN
MEDICINE: DOLO

PL/SQL procedure successfully completed.

 FUNCTION TO GET THE TOTAL NUMBER OF ROWS IN TABLE Medicine (NO PARAMETER)

SQL> CREATE OR REPLACE FUNCTION m_count
  2  RETURN NUMBER
  3  IS
  4    c NUMBER;
  5  BEGIN
  6    SELECT COUNT(*) INTO c FROM medicine;
  7    RETURN c;
  8
  9  EXCEPTION
 10    WHEN OTHERS THEN
 11      RETURN 0;
 12  END m_count;
 13  /

Function created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> BEGIN
  2    DBMS_OUTPUT.PUT_LINE('TOTAL MEDICINES: ' || m_count);
  3  END;
  4  /
TOTAL MEDICINES: 12

PL/SQL procedure successfully completed.

FUNCTION TO RETURN THE TOTAL NUMBER OF medicine to count medicines where price > average price(NO PARAMETER)

SQL> CREATE OR REPLACE FUNCTION m_avg_price_count
  2  RETURN NUMBER
  3  IS
  4    num NUMBER;
  5  BEGIN
  6    SELECT COUNT(*)
  7    INTO num
  8    FROM medicine
  9    WHERE selling_price > (SELECT AVG(selling_price) FROM medicine);
 10
 11    RETURN num;
 12  END m_avg_price_count;
 13  /

Function created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> BEGIN
  2    DBMS_OUTPUT.PUT_LINE('COUNT: ' || m_avg_price_count);
  3  END;
  4  /
COUNT: 2

PL/SQL procedure successfully completed.

SQL> SELECT COUNT(*) FROM medicine WHERE selling_price > (SELECT AVG(selling_price) FROM medicine);

  COUNT(*)
----------
         2

 FUNCTION TO GET CUSTOMER_ID FROM CUSTOMER AND RETURN NAME OF THAT PARTICULAR CUSTOMER(SINGLE PARAMETER)

SQL> DECLARE
  2    n NUMBER;
  3  BEGIN
  4    n := &n;
  5
  6    DBMS_OUTPUT.PUT_LINE('CUSTOMER NAME OF ' || n || ' IS ' || r_customer_name(n));
  7  END;
  8  /
Enter value for n: 101
old   4:   n := &n;
new   4:   n := 101;
CUSTOMER NAME OF 101 IS Wasi Sundhar

PL/SQL procedure successfully completed.

Enter value for n: 13
old   4:   n := &n;
new   4:   n := 13;
CUSTOMER NAME OF 13 IS NOT FOUND

PL/SQL procedure successfully completed.
Enter value for n: 1
old   4:   n := &n;
new   4:   n := 1;
CUSTOMER NAME OF 1 IS Arun

PL/SQL procedure successfully completed.

PALINDROME OR NOT (SINGLE PARAMETER)

SQL> CREATE OR REPLACE FUNCTION pal(n IN NUMBER)
  2  RETURN VARCHAR2
  3  IS
  4    num NUMBER := n;
  5    rev NUMBER := 0;
  6    rem NUMBER;
  7  BEGIN
  8    WHILE num != 0 LOOP
  9      rem := MOD(num, 10);
 10      rev := rev * 10 + rem;
 11      num := TRUNC(num / 10);
 12    END LOOP;
 13
 14    IF rev = n THEN
 15      RETURN 'PALINDROME';
 16    ELSE
 17      RETURN 'NOT PALINDROME';
 18    END IF;
 19  END pal;
 20  /

Function created.
