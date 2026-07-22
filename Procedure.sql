[24bcsl03@mepcolinux l]$cat procedure.prn
Script started on Mon Apr  6 20:03:57 2026
[24bcsl03@mepcolinux ~]$cat pr.txt
QL> SET SERVEROUTPUT ON;
SQL>
SQL> DECLARE
  2    n NUMBER;
  3  BEGIN
  4    n := &n;
  5
  6    DBMS_OUTPUT.PUT_LINE('THE NUMBER ' || n || ' IS ' || pal(n));
  7  END;
  8  /
Enter value for n: 156651
old   4:   n := &n;
new   4:   n := 156651;
THE NUMBER 156651 IS PALINDROME

PL/SQL procedure successfully completed.

Enter value for n: 432331
old   4:   n := &n;
new   4:   n := 432331;
THE NUMBER 432331 IS NOT PALINDROME

PL/SQL procedure successfully completed.

 FUNCTION TO COUNT THE NUMBER OF CUSTOMER IN SPECIFIED CITY AND AGE MUST BE GREATER THAN THE GIVEN AGE (MULTI PARAMETERS)

SQL> CREATE OR REPLACE FUNCTION customer_count(
  2    city IN VARCHAR2,
  3    a    IN NUMBER
  4  )
  5  RETURN NUMBER
  6  IS
  7    n NUMBER;
  8  BEGIN
  9    SELECT COUNT(*)
 10    INTO n
 11    FROM customer
 12    WHERE UPPER(customer_address) = UPPER(city)
 13      AND age > a;
 14
 15    RETURN n;
 16
 17  EXCEPTION
 18    WHEN OTHERS THEN
 19      RETURN 0;
 20  END customer_count;
 21  /

Function created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> DECLARE
  2    age_val NUMBER;
  3  BEGIN
  4    age_val := &age_val;
  5
  6    DBMS_OUTPUT.PUT_LINE(
  7      'NUMBER OF CUSTOMERS IN CHENNAI WITH AGE > ' || age_val ||
  8      ' IS ' || customer_count('Chennai', age_val)
  9    );
 10  END;
 11  /
Enter value for age_val: 20
old   4:   age_val := &age_val;
new   4:   age_val := 20;
NUMBER OF CUSTOMERS IN CHENNAI WITH AGE > 20 IS 2

PL/SQL procedure successfully completed.

SQL> CREATE OR REPLACE FUNCTION r_row_medicine(id IN NUMBER)
  2  RETURN medicine%ROWTYPE
  3  IS
  4    r medicine%ROWTYPE;
  5  BEGIN
  6    SELECT *
  7    INTO r
  8    FROM medicine
  9    WHERE medicine_id = id;
 10
 11    RETURN r;
 12
 13  EXCEPTION
 14    WHEN OTHERS THEN
 15      RETURN NULL;
 16  END r_row_medicine;
 17  /

Function created.


SQL> DECLARE
  2    n   NUMBER;
  3    ans medicine%ROWTYPE;
  4  BEGIN
  5    n := &n;
  6
  7    ans := r_row_medicine(n);
  8
  9    DBMS_OUTPUT.PUT_LINE(
 10      'NAME: ' || ans.medicine_name ||
 11      ' BRAND: ' || ans.medicine_brand ||
 12      ' PRICE: ' || ans.selling_price
 13    );
 14  END;
 15  /
Enter value for n: 101
old   5:   n := &n;
new   5:   n := 101;
NAME: PARACETAMOL BRAND:  PRICE: 60
SQL> DECLARE
  2    n   NUMBER;
  3    ans medicine%ROWTYPE;
  4  BEGIN
  5    n := &n;
  6
  7    ans := r_row_medicine(n);
  8
  9    DBMS_OUTPUT.PUT_LINE(
 10      'NAME: ' || ans.medicine_name ||
 11      ' BRAND: ' || ans.medicine_brand ||
 12      ' PRICE: ' || ans.selling_price
 13    );
 14  END;
 15  /
Enter value for n: 205
old   5:   n := &n;
new   5:   n := 205;
NAME: Vitamin Syrup BRAND: HealthPlus PRICE: 100

PL/SQL procedure successfully completed.

 TO DISPLAY THE DEATILS OF THE MEDICINES (RETURN CURSOR)

SQL> CREATE OR REPLACE FUNCTION f1_medicine
  2  RETURN SYS_REFCURSOR
  3  IS
  4    c_cursor SYS_REFCURSOR;
  5  BEGIN
  6    OPEN c_cursor FOR
  7      SELECT medicine_name, medicine_id
  8      FROM medicine;
  9
 10    RETURN c_cursor;
 11  END f1_medicine;
 12  /

Function created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> DECLARE
  2    ans SYS_REFCURSOR;
  3    v_name VARCHAR2(50);
  4    id NUMBER;
  5  BEGIN
  6    ans := f1_medicine;
  7
  8    LOOP
  9      FETCH ans INTO v_name, id;
 10      EXIT WHEN ans%NOTFOUND;
 11
 12      DBMS_OUTPUT.PUT_LINE('MEDICINE: ' || v_name || ' ID: ' || id);
 13    END LOOP;
 14
 15    CLOSE ans;
 16  END;
 17  /
MEDICINE: PARACETAMOL ID: 101
MEDICINE: VICKS ID: 108
MEDICINE: Aspirin ID: 500
MEDICINE: CROCIN ID: 110
MEDICINE: DOLO ID: 501
MEDICINE: Paracetamol ID: 401
MEDICINE: Paracetamol ID: 201
MEDICINE: Ibuprofen ID: 202
MEDICINE: Cough Syrup ID: 203
MEDICINE: Insulin ID: 204
MEDICINE: Vitamin Syrup ID: 205
MEDICINE: Dolo ID: 206

PL/SQL procedure successfully completed.

 TO FIND THE FACTORIAL OF N NUMBERS(RECURSIVE)
SQL> CREATE OR REPLACE FUNCTION fact_recur(n IN NUMBER)
  2  RETURN NUMBER
  3  IS
  4  BEGIN
  5    IF n <= 1 THEN
  6      RETURN 1;
  7    ELSE
  8      RETURN n * fact_recur(n - 1);
  9    END IF;
 10  END;
 11  /

Function created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> DECLARE
  2    n NUMBER;
  3  BEGIN
  4    n := &n;
  5
  6    DBMS_OUTPUT.PUT_LINE('FACTORIAL OF ' || n || ' IS ' || fact_recur(n));
  7  END;
  8  /
Enter value for n: 6
old   4:   n := &n;
new   4:   n := 6;
FACTORIAL OF 6 IS 720

PL/SQL procedure successfully completed.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> DECLARE
  2    n NUMBER;
  3  BEGIN
  4    n := &n;
  5
  6    DBMS_OUTPUT.PUT_LINE('FACTORIAL OF ' || n || ' IS ' || fact_recur(n));
  7  END;
  8  /
Enter value for n: 4
old   4:   n := &n;
new   4:   n := 4;
FACTORIAL OF 4 IS 24

PL/SQL procedure successfully completed.

//HACKER RANK**************

1 A) Write a PL/SQL procedure to display the CUSTOMER IDs, NAMES, MOBILE, EMAIL,CITY and REG DATE of all CUSTOMER.

SQL> CREATE OR REPLACE PROCEDURE show_customer_details
  2  IS
  3    CURSOR cust_cursor IS
  4      SELECT customer_id,
  5             customer_name,
  6             mobile_no,
  7             customer_email,
  8             customer_address,
  9             registration_date,
 10             age
 11      FROM customer;
 12
 13    v_id     customer.customer_id%TYPE;
 14    v_name   customer.customer_name%TYPE;
 15    v_mobile customer.mobile_no%TYPE;
 16    v_email  customer.customer_email%TYPE;
 17    v_addr   customer.customer_address%TYPE;
 18    v_date   customer.registration_date%TYPE;
 19    v_age    customer.age%TYPE;
 20
 21  BEGIN
 22    OPEN cust_cursor;
 23
 24    LOOP
 25      FETCH cust_cursor
 26      INTO v_id, v_name, v_mobile, v_email, v_addr, v_date, v_age;
 27
 28      EXIT WHEN cust_cursor%NOTFOUND;
 29
 30      DBMS_OUTPUT.PUT_LINE(
 31        'ID: ' || v_id ||
 32        ' NAME: ' || v_name ||
 33        ' MOBILE: ' || v_mobile ||
 34        ' EMAIL: ' || v_email ||
 35        ' CITY: ' || v_addr ||
 36        ' REG DATE: ' || v_date ||
 37        ' AGE: ' || v_age
 38      );
 39    END LOOP;
 40
 41    CLOSE cust_cursor;
 42  END;
 43  /

Procedure created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> BEGIN
  2    show_customer_details;
  3  END;
  4  /
ID: 3 NAME: Karthik MOBILE: 9876543215 EMAIL: karthik@gmail.com CITY: Chennai
REG DATE: 27-FEB-26 AGE: 28
ID: 10 NAME: Kl Rahul MOBILE: 9876543000 EMAIL: rahul@gmail.com CITY: Tuticorin
REG DATE: 27-FEB-26 AGE: 32
ID: 1 NAME: Arun MOBILE: 9876543200 EMAIL: arun@gmail.com CITY: Tuticorin REG
DATE: 23-JAN-25 AGE: 25
ID: 2 NAME: Bala MOBILE: 9876543201 EMAIL: bala@gmail.com CITY: Tirunelveli REG
DATE: 11-AUG-25 AGE: 35
ID: 101 NAME: Wasi Sundhar MOBILE: 9876543210 EMAIL: wasi@gmail.com CITY:
Chennai REG DATE: 30-MAR-26 AGE: 25
ID: 12 NAME: Virat MOBILE: 9876543222 EMAIL:  CITY:  REG DATE: 27-FEB-26 AGE:
ID: 300 NAME: Raja MOBILE: 9876543210 EMAIL:  CITY:  REG DATE: 17-MAR-26 AGE: 25

PL/SQL procedure successfully completed.

1 B)Write a PL/SQL function to display the medicine name of all medicine. Return a heading of medicine name.

SQL> CREATE OR REPLACE FUNCTION show_medicine_names
  2  RETURN VARCHAR2
  3  IS
  4  BEGIN
  5    FOR rec IN (SELECT medicine_name FROM medicine) LOOP
  6      DBMS_OUTPUT.PUT_LINE(rec.medicine_name);
  7    END LOOP;
  8
  9    RETURN 'MEDICINE NAMES';
 10  END;
 11  /

Function created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> BEGIN
  2    DBMS_OUTPUT.PUT_LINE(show_medicine_names);
  3  END;
  4  /
PARACETAMOL
VICKS
Aspirin
CROCIN
DOLO
Paracetamol
Paracetamol
Ibuprofen
Cough Syrup
Insulin
Vitamin Syrup
Dolo
MEDICINE NAMES

PL/SQL procedure successfully completed.

2 A) Write a PL/SQL procedure to display the customers who have the highest age in each city using a nested loop.
SQL> CREATE OR REPLACE PROCEDURE max_age_city
  2  IS
  3
  4    CURSOR c_city IS
  5      SELECT DISTINCT customer_address FROM customer;
  6
  7
  8    CURSOR c_cust(cname VARCHAR2) IS
  9      SELECT customer_id, customer_name, age
 10      FROM customer
 11      WHERE customer_address = cname;
 12
 13    v_city customer.customer_address%TYPE;
 14    v_id   customer.customer_id%TYPE;
 15    v_name customer.customer_name%TYPE;
 16    v_age  customer.age%TYPE;
 17
 18    max_age NUMBER;
 19  BEGIN
 20    OPEN c_city;
 21
 22    LOOP
 23      FETCH c_city INTO v_city;
 24      EXIT WHEN c_city%NOTFOUND;
 25
 26
 27      SELECT MAX(age)
 28      INTO max_age
 29      FROM customer
 30      WHERE customer_address = v_city;
 31
 32      DBMS_OUTPUT.PUT_LINE('--- CITY: ' || NVL(v_city,'N/A') || ' ---');
 33
 34      OPEN c_cust(v_city);
 35
 36      LOOP
 37        FETCH c_cust INTO v_id, v_name, v_age;
 38        EXIT WHEN c_cust%NOTFOUND;
 39
 40        IF v_age = max_age THEN
 41          DBMS_OUTPUT.PUT_LINE(
 42            'ID: ' || v_id ||
 43            ' NAME: ' || v_name ||
 44            ' AGE: ' || v_age
 45          );
 46        END IF;
 47
 48      END LOOP;
 49
 50      CLOSE c_cust;
 51    END LOOP;
 52
 53    CLOSE c_city;
 54  END;
 55  /

Procedure created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> BEGIN
  2    max_age_city;
  3  END;
  4  /
--- CITY: Chennai ---
ID: 3 NAME: Karthik AGE: 28
--- CITY: Tuticorin ---
ID: 10 NAME: Kl Rahul AGE: 32
--- CITY: Tirunelveli ---
ID: 2 NAME: Bala AGE: 35
--- CITY: chennai---

PL/SQL procedure successfully completed.


2 B) Write a PL/SQL function to display the average selling price for each category. Return category ID and average price in a row.
SQL> CREATE OR REPLACE FUNCTION avg_price_category
  2  RETURN SYS_REFCURSOR
  3  IS
  4    c_cursor SYS_REFCURSOR;
  5  BEGIN
  6    OPEN c_cursor FOR
  7      SELECT cat_id,
  8             TRUNC(AVG(selling_price)) AS avg_price
  9      FROM medicine
 10      GROUP BY cat_id;
 11
 12    RETURN c_cursor;
 13  END;
 14  /

Function created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> DECLARE
  2    c SYS_REFCURSOR;
  3    v_cat NUMBER;
  4    v_avg NUMBER;
  5  BEGIN
  6    c := avg_price_category;
  7
  8    LOOP
  9      FETCH c INTO v_cat, v_avg;
 10      EXIT WHEN c%NOTFOUND;
 11
 12      DBMS_OUTPUT.PUT_LINE(
 13        'CATEGORY: ' || v_cat ||
 14        ' AVG PRICE: ' || v_avg
 15      );
 16    END LOOP;
 17
 18    CLOSE c;
 19  END;
 20  /
CATEGORY:  AVG PRICE: 55
CATEGORY: 1 AVG PRICE: 251
CATEGORY: 2 AVG PRICE: 122
CATEGORY: 3 AVG PRICE: 660

PL/SQL procedure successfully completed.

3 A) Write a PL/SQL procedure to return the city name with the maximum number of customers.
SQL> CREATE OR REPLACE PROCEDURE max_customer_city
  2  IS
  3    v_city  customer.customer_address%TYPE;
  4    v_count NUMBER;
  5  BEGIN
  6    SELECT customer_address, COUNT(*) INTO v_city, v_count FROM customer GROUP BY customer_address ORDER BY COUNT(*) DESC FETCH FIRST 1 ROW ONLY;
  7
  8    DBMS_OUTPUT.PUT_LINE('CITY WITH MAX CUSTOMERS: ' || NVL(v_city,'N/A') ||' (COUNT: ' || v_count || ')');
  9
 10  EXCEPTION
 11    WHEN OTHERS THEN
 12      DBMS_OUTPUT.PUT_LINE('ERROR OCCURRED');
 13  END;
 14  /
Procedure created.

SQL> SET SERVEROUTPUT ON;
SQL>
SQL> BEGIN
  2    max_customer_city;
  3  END;
  4  /
CITY WITH MAX CUSTOMERS: Chennai (COUNT: 2)

PL/SQL procedure successfully completed.

3B) Write a PL/SQL function to return the medicine details whose selling price is less than the average selling price of all medicines.
SQL> CREATE OR REPLACE FUNCTION med_below_avg
  2  RETURN SYS_REFCURSOR
  3  IS
  4    v_cursor SYS_REFCURSOR;
  5  BEGIN
  6    OPEN v_cursor FOR
  7      SELECT medicine_name, selling_price, cat_id
  8      FROM medicine
  9      WHERE selling_price < (
 10        SELECT AVG(selling_price) FROM medicine
 11      );
 12
 13    RETURN v_cursor;
 14  END;
 15  /

Function created.

SQL> DECLARE
  2    v_res SYS_REFCURSOR;
  3    v_name  medicine.medicine_name%TYPE;
  4    v_price medicine.selling_price%TYPE;
  5    v_cat   medicine.cat_id%TYPE;
  6  BEGIN
  7    v_res := med_below_avg;
  8
  9    LOOP
 10      FETCH v_res INTO v_name, v_price, v_cat;
 11      EXIT WHEN v_res%NOTFOUND;
 12
 13      DBMS_OUTPUT.PUT_LINE(
 14        'NAME: ' || v_name ||
 15        ' | PRICE: ' || v_price ||
 16        ' | CATEGORY: ' || v_cat
 17      );
 18    END LOOP;
 19
 20    CLOSE v_res;
 21  END;
 22  /
NAME: CROCIN | PRICE: 45 | CATEGORY:
NAME: Aspirin | PRICE: 50 | CATEGORY:
NAME: PARACETAMOL | PRICE: 60 | CATEGORY:
NAME: VICKS | PRICE: 65 | CATEGORY:
NAME: Vitamin Syrup | PRICE: 100 | CATEGORY: 2
NAME: Paracetamol | PRICE: 120 | CATEGORY: 1
NAME: Cough Syrup | PRICE: 145 | CATEGORY: 2
NAME: Ibuprofen | PRICE: 175 | CATEGORY: 1
PL/SQL procedure successfully completed.
