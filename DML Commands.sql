SQL DML OUTPUT 
========================================================

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1.1  INSERT INTO Customer

SQL> INSERT INTO Customer
  2  (customer_id, customer_name, mobile_no, customer_email, customer_address, registration_date)
  3  VALUES
  4  (501, 'Suresh Kumar', '8765432100', 'suresh.kumar@email.com', '45 Anna Salai', SYSDATE);

1 row created.

SQL> select * from customer;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT
---------
        501 Suresh Kumar         8765432100      suresh.kumar@email.com
45 Anna Salai
13-FEB-26


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1.2  INSERT INTO Supplier


SQL> INSERT INTO Supplier
  2  (supplier_id, supplier_name, contact_person, supplier_phone, supplier_email, supplier_address, gst_number)
  3  VALUES
  4  (301, 'MedPlus Distributors', 'Venkat Reddy', '9876543213', 'venkat@medplus.com', 'Industrial Area, Hyderabad', '33AABCU9603R1Z5');

1 row created.

SQL> select * from supplier;

SUPPLIER_ID SUPPLIER_NAME        CONTACT_PERSON       SUPPLIER_PHONE
----------- -------------------- -------------------- ---------------
SUPPLIER_EMAIL
--------------------------------------------------
SUPPLIER_ADDRESS
--------------------------------------------------------------------------------
GST_NUMBER
--------------------
        301 MedPlus Distributors Venkat Reddy         9876543213
venkat@medplus.com
Industrial Area, Hyderabad
33AABCU9603R1Z5


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1.3  INSERT INTO Medicine (ID: 1001)


SQL> INSERT INTO Medicine
  2  (medicine_id, category_id, medicine_name, Medicine_brand, unitsize, mrp, GST, Selling_Price)
  3  VALUES
  4  (1001, 2, 'Paracetamol 500mg', 'Dolo-650', 100, 20, 12345678, 25.00);

1 row created.

SQL> select * from medicine;

MEDICINE_ID CATEGORY_ID MEDICINE_NAME
----------- ----------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE
---------- -------------
       1001           2 Paracetamol 500mg
Dolo-650                                                  100         20
  12345678            25


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1.4  INSERT INTO Medicine (ID: 1002)


SQL> INSERT INTO Medicine
  2  (medicine_id, category_id, medicine_name, Medicine_brand, unitsize, mrp, selling_price)
  3  VALUES
  4  (1002, 1, 'Amoxicillin 500mg', 'Himax', '750', '20', 45.00);

1 row created.

SQL> select * from Medicine;

MEDICINE_ID CATEGORY_ID MEDICINE_NAME
----------- ----------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE
---------- -------------
       1002           1 Amoxicillin 500mg
Himax                                                     750         20
                      45


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1.5  INSERT INTO Customer (ID: 502)


SQL> INSERT INTO Customer
  2  (customer_id, customer_name, Mobile_no, customer_email, customer_address, registration_date)
  3  VALUES
  4  (502, 'Priya Sharma', '8765432101',
  5   R(REPLACE('PriyaSharma',' ','')) || '@customer.com',
  6   'Velachery Main Road', SYSDATE);

1 row created.

SQL> select * from customer;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT
---------
        502 Priya Sharma         8765432101      priyasharma@customer.com
Velachery Main Road
25-FEB-26


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1.6  INSERT ALL INTO Category


SQL> INSERT ALL
  2    INTO Category (category_id, category_name, description, tax_rate, active_status, created_date)
  3    VALUES (1, 'Antibiotics', 'Antibacterial medications', 12, 'ACTIVE', SYSDATE)
  4    INTO Category (category_id, category_name, description, tax_rate, active_status, created_date)
  5    VALUES (2, 'Painkillers', 'Analgesics and pain relief', 5, 'ACTIVE', SYSDATE)
  6    INTO Category (category_id, category_name, description, tax_rate, active_status, created_date)
  7    VALUES (3, 'Antacids', 'Stomach acidity relief', 5, 'ACTIVE', SYSDATE);
 
3 rows created.

SQL> select * from category;

CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
DESCRIPTION
--------------------------------------------------------------------------------
  TAX_RATE ACTIVE_STATUS        CREATED_D UPDATED_D
---------- -------------------- --------- ---------
          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26

          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26

CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
DESCRIPTION
--------------------------------------------------------------------------------
  TAX_RATE ACTIVE_STATUS        CREATED_D UPDATED_D
---------- -------------------- --------- ---------

          3 Antacids
Stomach acidity relief
         5 ACTIVE               25-FEB-26


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1.7  INSERT INTO Discount


SQL> INSERT INTO Discount
  2  (discount_id, discount_name, discount_type, discount_value, start_date, end_date, active_status)
  3  VALUES
  4  (5001, 'New Year Sale', 'PERCENTAGE', 15.00,
  5   TRUNC(SYSDATE, 'MM'),
  6   LAST_DAY(ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1)), 'ACTIVE');

1 row created.

SQL> select * from Discount;

DISCOUNT_ID
-----------
DISCOUNT_NAME
--------------------------------------------------------------------------------
DISCOUNT_TYPE        DISCOUNT_VALUE START_DAT END_DATE  ACTIVE_STATUS
-------------------- -------------- --------- --------- --------------------
       5001
New Year Sale
PERCENTAGE                       15 01-FEB-26 31-MAR-26 ACTIVE

INSERT with all columns (without mentioning column names)

SQL> INSERT INTO Category
  2  VALUES (7, 'Herbal', 'Natural medicines',8,'ACTIVE',SYSDATE,NULL);
1 row created.
CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
DESCRIPTION
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  TAX_RATE ACTIVE_STATUS        CREATED_D UPDATED_D
---------- -------------------- --------- ---------
          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26

          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26

          3 Antacids
Stomach acidity relief
         5 ACTIVE               25-FEB-26
         7 Herbal
Natural medicines
         8 ACTIVE               26-FEB-26

INSERT rows from another table using SELECT
SQL> INSERT INTO Category_Backup
  2  SELECT * FROM Category;

11 rows created.

SQL> SELECT * FROM Category_Backup;

CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
DESCRIPTION
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  TAX_RATE ACTIVE_STATUS        CREATED_D UPDATED_D
---------- -------------------- --------- ---------
          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26

          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26

          3 Antacids
Stomach acidity relief
         5 ACTIVE               25-FEB-26

          4 Tablets
Oral Medicines
        12 ACTIVE               25-FEB-26 25-FEB-26

          5 Syrup
Liquid Medicines
         5 ACTIVE               25-FEB-26 25-FEB-26

          6 Injection
Injectable Medicines
        18 ACTIVE               25-FEB-26 25-FEB-26

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1.8  INSERT INTO Batch

SQL> INSERT INTO Batch
  2  (batch_id, medicine_id, batch_no, manufacture_date, expiry_date, quantity_received, quantity_available, cost_price)
  3  VALUES
  4  (4001, 1001, 'PARA001', TO_DATE('2025-10-01','YYYY-MM-DD'),
  5   ADD_MONTHS(TO_DATE('2025-10-01','YYYY-MM-DD'), 24), 1000, 950, 18.50);

1 row created.

SQL> select * from batch;

  BATCH_ID MEDICINE_ID BATCH_NO
---------- ----------- --------------------------------------------------
MANUFACTU EXPIRY_DA QUANTITY_RECEIVED QUANTITY_AVAILABLE COST_PRICE
--------- --------- ----------------- ------------------ ----------
      4001        1001 PARA001
01-OCT-25 01-OCT-27              1000                950         19


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1.9  INSERT INTO Supplier (Prompt / & Variables)


SQL> INSERT INTO SUPPLIER (supplier_id, supplier_name, contact_person, Supplier_phone, Supplier_address)
  2      VALUES (&supplier_id, '&supplier_name', '&contact_person', '&Supplier_phone', '&Supplier_address');
Enter value for supplier_id: 108
Enter value for supplier_name: Karthi
Enter value for contact_person: wes
Enter value for supplier_phone: 980989066
Enter value for supplier_address: Vellore
old   2:     VALUES (&supplier_id, '&supplier_name', '&contact_person', '&Supplier_phone', '&Supplier_address')
new   2:     VALUES (108, 'Karthi', 'wes', '980989066', 'Vellore')

1 row created.


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 1.10  INSERT ERRORS (Constraint Violations)

SQL> alter table supplier add constraint c8 foreign key(customer_email) references supplier(customer_id);
alter table supplier add constraint c8 foreign key(customer_email) references supplier(customer_id);
                                      *
ERROR at line 1:
ORA-02298: cannot validate (C##HR.C1) - parent keys not found

SQL> INSERT INTO Medicine(Medicine_id, Medicine_name, Medicie_Brand, unit_size, Mrp)
  2      VALUES (9, 'cred', 'Test', 10.00, 5);
INSERT INTO Medicine(Medicine_id, Medicine_name, Medicie_Brad, unit_size, Mrp)
*
ERROR at line 1:
ORA-02290: check constraint (System.SYS_C008243) violated

SQL> insert into Medicine values(1,'erf','Cfsin',34,4);
insert into Medicine values(1,'erf','Cfsin',34,4);
*
ERROR at line 1:
ORA-00001: unique constraint (system.SYS_C008245) violated

SQL> INSERT INTO Suppiler VALUES(11, 'Ganesh', 876543219, ganesh@com, Virudhunagar', '3467598494');
INSERT INTO Suppiler VALUES(11, 'Ganesh', 876543219, ganesh@com, Virudhunagar', '3467598494');
*
ERROR at line 1:
ORA-02291: integrity constraint (system.SYS_C008256) violated - parent key
not found



━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 2.1  UPDATE Medicine - selling_price (Prescription Required)


SQL> UPDATE Medicine
  2  SET selling_price = selling_price * 5.05
  3  WHERE prescription_required = 'Y';

1 row updated.

SQL> select * from medicine;

MEDICINE_ID CATEGORY_ID MEDICINE_NAME
----------- ----------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE PRESCRIPTION_RE
---------- ------------- ---------------
       1002           1 Amoxicillin 500mg
Himax                                                     750         20
                      45

       1003           2 vicks 500mg
vicks                                                     500          7
                      25 Y


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 2.2  UPDATE Batch - quantity_available (Expiring within 3 months)


SQL> UPDATE Batch
  2  SET quantity_available = quantity_available * 0.9
  3  WHERE expiry_date <= ADD_MONTHS(SYSDATE, 3);

1 row updated.

SQL> select * from Batch;

  BATCH_ID MEDICINE_ID BATCH_NO
---------- ----------- --------------------------------------------------
MANUFACTU EXPIRY_DA QUANTITY_RECEIVED QUANTITY_AVAILABLE COST_PRICE
--------- --------- ----------------- ------------------ ----------
      4001        1001 PARA001
01-OCT-25 01-OCT-27              1000                950         19

         2             Ibuprofen
          25-MAY-26                                  180

         5             URGENT-B101
          27-MAR-26                                  100


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 2.3  UPDATE Customer - INITCAP Names


SQL> UPDATE Customer
  2  SET CUSTOMER_NAME = INITCAP(CUSTOMER_NAME);

1 row updated.

SQL> select * from customer;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT
---------
        502 Priya Sharma         8765432101      priyasharma@customer.com
Velachery Main Road
25-FEB-26


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 2.4  UPDATE Batch - cost_price from Medicine (Subquery)


SQL> UPDATE Batch b
  2  SET cost_price = (
  3    SELECT m.selling_price * 0.75
  4    FROM Medicine m
  5    WHERE m.medicine_id = b.medicine_id
  6  );

2 rows updated.

SQL> select * from batch;

  BATCH_ID MEDICINE_ID BATCH_NO
---------- ----------- --------------------------------------------------
MANUFACTU EXPIRY_DA QUANTITY_RECEIVED QUANTITY_AVAILABLE COST_PRICE
--------- --------- ----------------- ------------------ ----------
      4001        1001 PARA001
01-OCT-25 01-OCT-27              1000                950

         2             Ibuprofen
          25-MAY-26                                  180

         5             URGENT-B101
          27-MAR-26                                  100

         1         101
          25-JUN-26                                   50


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 2.5  UPDATE Batch - batch_no Prefix 'URGENT-' (Expiring within 60 days)


SQL> UPDATE Batch
  2  SET batch_no = 'URGENT-' || batch_no
  3  WHERE (expiry_date - SYSDATE) <= 60;

1 row updated.

SQL> select * from batch;

  BATCH_ID MEDICINE_ID BATCH_NO
---------- ----------- --------------------------------------------------
MANUFACTU EXPIRY_DA QUANTITY_RECEIVED QUANTITY_AVAILABLE COST_PRICE
--------- --------- ----------------- ------------------ ----------
      4001        1001 PARA001
01-OCT-25 01-OCT-27              1000                950

         2             Ibuprofen
          25-MAY-26                                  180

         5             URGENT-B101
          27-MAR-26                                  100

         1         101
          25-JUN-26                                   50


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 2.6  UPDATE Discount - end_date Extended by 15 Days


SQL> UPDATE Discount
  2  SET end_date = end_date + 15
  3  WHERE active_status = 'ACTIVE'
  4    AND end_date >= SYSDATE;

1 row updated.

SQL> select * from discount;

DISCOUNT_ID
-----------
DISCOUNT_NAME
--------------------------------------------------------------------------------
DISCOUNT_TYPE        DISCOUNT_VALUE START_DAT END_DATE  ACTIVE_STATUS
-------------------- -------------- --------- --------- --------------------
       5001
New Year Sale
PERCENTAGE                       15 01-FEB-26 15-APR-26 ACTIVE


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 2.7  UPDATE Medicine - Names to UPPER


SQL> UPDATE Medicine
  2  SET Medicine_Name = UPPER(Medicine_name);

2 rows updated.

SQL> select * from Medicine;

MEDICINE_ID CATEGORY_ID MEDICINE_NAME
----------- ----------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE PRESCRIPTION_RE
---------- ------------- ---------------
       1002           1 AMOXICILLIN 500MG
Himax                                                     750         20
                      45

       1003           2 VICKS 500MG
vicks                                                     500          7
                      25 Y


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 2.8  UPDATE Medicine - Names to lower


SQL> UPDATE Medicine
  2  SET Medicine_Name = lower(Medicine_name);

2 rows updated.

SQL> select * from Medicine;

MEDICINE_ID CATEGORY_ID MEDICINE_NAME
----------- ----------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE PRESCRIPTION_RE
---------- ------------- ---------------
       1002           1 amoxicillin 500mg
Himax                                                     750         20
                      45

       1003           2 vicks 500mg
vicks                                                     500          7
                      25 Y


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 2.9  UPDATE Medicine - selling_price Rounded to Nearest 5


SQL> UPDATE Medicine
  2  SET selling_price = ROUND(selling_price / 5) * 5;

2 rows updated.

SQL> select * from medicine;

MEDICINE_ID CATEGORY_ID MEDICINE_NAME
----------- ----------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE PRESCRIPTION_RE
---------- ------------- ---------------
       1002           1 amoxicillin 500mg
Himax                                                     750         20
                      45

       1003           2 vicks 500mg
vicks                                                     500          7
                      25 Y

UPDATE ALL rows (no WHERE)

SQL> UPDATE Customer
  2  SET customer_address = 'Chennai';

4 rows updated.

SQL> select * from customer;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL                 CUSTOMER_ADDRESS                            REGISTRAT
----------- -------------------- --------------- ------------------------------ ---------------------------------------------------------------------------------------------------- ---------
        502 Priya Sharma         8765432101      priyasharma@customer.com       Chennai                                     25-FEB-26
        501 Suresh Kumar         8765432100      suresh.kumar@email.com         Chennai                                     25-FEB-26
         50 ARUN                 9000000001      arun1@gmail.com                Chennai                                     25-FEB-26
         60 KARTHIK              9011111111      karthik@gmail.com              Chennai                                     25-FEB-26

UPDATE MULTIPLE COLUMNS at once
SQL> UPDATE Category
  2  SET tax_rate = 8,
  3      active_status = 'INACTIVE'
  4  WHERE category_id = 2;

1 row updated.

SQL> select * from category;

CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
DESCRIPTION
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  TAX_RATE ACTIVE_STATUS        CREATED_D UPDATED_D
---------- -------------------- --------- ---------
          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26

          2 Painkillers
Analgesics and pain relief
         8 INACTIVE             25-FEB-26

          3 Antacids
Stomach acidity relief
         5 ACTIVE               25-FEB-26

          4 Tablets
Oral Medicines
        12 ACTIVE               25-FEB-26 25-FEB-26

          5 Syrup
Liquid Medicines
         5 ACTIVE               25-FEB-26 25-FEB-26

          6 Injection
Injectable Medicines
        18 ACTIVE               25-FEB-26 25-FEB-26

         50 Pain
Pain Relief
         5 ACTIVE               25-FEB-26 25-FEB-26

         51 Cold
Cold Relief
         5 ACTIVE               25-FEB-26 25-FEB-26

         52 Fever
Fever Relief
         5 ACTIVE               25-FEB-26 25-FEB-26

UPDATE using MONTHS_BETWEEN to compute a derived attribute (AGE)
SQL> UPDATE Customer
  2  SET age = FLOOR(MONTHS_BETWEEN(SYSDATE, registration_date) / 12);

4 rows updated.

SQL> select * from customer;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL                 CUSTOMER_ADDRESS                            REGISTRAT
---
       AGE
---
        502 Priya Sharma         8765432101      priyasharma@customer.com       Chennai                                     25-FEB-26
         0

        501 Suresh Kumar         8765432100      suresh.kumar@email.com         Chennai                                     25-FEB-26
         0

         50 ARUN                 9000000001      arun1@gmail.com                Chennai                                     25-FEB-26
         0

         60 KARTHIK              9011111111      karthik@gmail.com              Chennai                                     25-FEB-26
         0


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 3.1  DELETE FROM Customer - NULL Email


SQL> DELETE FROM Customer
  2  WHERE customer_email IS NULL;

1 row deleted.

SQL> select * from Customer;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT
---------
        502 Priya Sharma         8765432101      priyasharma@customer.com
Velachery Main Road
25-FEB-26

          2 Divya                9123456780      divya@gmail.com
Madurai
25-FEB-26

DELETE ALL ROWS (no condition)

SQL> DELETE FROM Medicine;

47 rows deleted.

SQL> roll back;
Rollback�━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 3.2  DELETE FROM Supplier - Address LIKE '%Vellore%' + ROLLBACK
SQL>  DELETE FROM SUPPLIER WHERE Supplier_address LIKE '%Vellore%';

1 row deleted.

SQL> rollback;

Rollback complete.
[24bcsl03@mepcolinux sql]$cat ex3b.txt
M Batch - Zero/Negative Quantity


SQL> DELETE FROM Batch
  2  WHERE quantity_available <= 0;

1 row deleted.

  BATCH_ID MEDICINE_ID BATCH_NO
---------- ----------- --------------------------------------------------
MANUFACTU EXPIRY_DA QUANTITY_RECEIVED QUANTITY_AVAILABLE COST_PRICE
--------- --------- ----------------- ------------------ ----------
      4001        1001 PARA001
01-OCT-25 01-OCT-27              1000                950

         2             Ibuprofen
          25-MAY-26                                  180

         5             URGENT-B101
          27-MAR-26                                  100

         1         101  errt
          25-JUN-26                                   50


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 3.4  DELETE FROM Customer - Registered Over 5 Years Ago


SQL> DELETE FROM Customer
  2  WHERE registration_date < ADD_MONTHS(SYSDATE, -60);

1 row deleted.

SQL> select * from customer;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT
---------
        502 Priya Sharma         8765432101      priyasharma@customer.com
Velachery Main Road
25-FEB-26

          2 Divya                9123456780      divya@gmail.com
Madurai
25-FEB-26

DELETE with = condition
SQL> DELETE FROM Medicine
  2  WHERE medicine_id = 101;

1 row deleted.

DELETE with >condition

sqL> DELETE FROM Medicine
  2  WHERE cat_id = 1
  3    AND selling_price > 100;

1 row deleted.

SQL> select * from medicine;

MEDICINE_ID     CAT_ID MEDICINE_NAME        MEDICINE_BRAND                                       UNITSIZE        MRP       GST SELLING_PRICE PRESCRIPTION_RE
----------- ---------- -------------------- -------------------------------------------------- ---------- ---------- ---------- ------------- ---------------
       1002          1 amoxicillin 500mg    Himax                                                     750         20      45
       1003          2 vicks 500mg          vicks                                                     500          7      25 Y
        103          1 Dolo                 ABC Pharma                                                 10         60        12     66 NO
       5001         50 Pain1                BrandA                                                     10         40         5     45 NO
       6001         50 PainA                BrandA                                                     10         40         5     45 NO

DELETE with OR condition
SQL> DELETE FROM Customer
  2  WHERE customer_address = 'Madurai'
  3     OR customer_address = 'Salem';

4 rows deleted.

SQL> select * from customer;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL                 CUSTOMER_ADDRESS                            REGISTRAT
----------- -------------------- --------------- ------------------------------ ---------------------------------------------------------------------------------------------------- ---------
        502 Priya Sharma         8765432101      priyasharma@customer.com       Velachery Main Road                         25-FEB-26
        501 Suresh Kumar         8765432100      suresh.kumar@email.com         45 Anna Salai                               25-FEB-26
          1 Ravi                 9876543210      ravi@gmail.com                 Chennai                                     25-FEB-26
          3 Mani                 9876543212      mani@gmail.com                 Trichy                                      25-FEB-26
         50 ARUN                 9000000001      arun1@gmail.com                Chennai                                     25-FEB-26
         60 KARTHIK              9011111111      karthik@gmail.com              Chennai                                     25-FEB-26

6 rows selected.

Multiple LIKE pattern deletions

SQL> DELETE FROM Customer
  2  WHERE customer_name LIKE '%i';

2 rows deleted.

SQL> select * from customer;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL                 CUSTOMER_ADDRESS                            REGISTRAT
----------- -------------------- --------------- ------------------------------ ---------------------------------------------------------------------------------------------------- ---------
        502 Priya Sharma         8765432101      priyasharma@customer.com       Velachery Main Road                         25-FEB-26
        501 Suresh Kumar         8765432100      suresh.kumar@email.com         45 Anna Salai                               25-FEB-26
         50 ARUN                 9000000001      arun1@gmail.com                Chennai                                     25-FEB-26
         60 KARTHIK              9011111111      karthik@gmail.com              Chennai                                     25-FEB-26
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 4.1  BETWEEN / NOT BETWEEN


SQL> SELECT medicine_name, Medicine_brand, selling_price
  2  FROM Medicine
  3  WHERE selling_price BETWEEN 30 AND 50;

MEDICINE_NAME        MEDICINE_BRAND
-------------------- --------------------------------------------------
SELLING_PRICE
-------------
amoxicillin 500mg    Himax
           45


SQL> SELECT medicine_name, Medicine_brand, unitsize, selling_price, mrp
  2  from medicine
  3  WHERE MRP NOT BETWEEN 10 AND 20;

MEDICINE_NAME        MEDICINE_BRAND
-------------------- --------------------------------------------------
  UNITSIZE SELLING_PRICE        MRP
---------- ------------- ----------
vicks 500mg          vicks
       500            25          7


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 4.2  LIKE / NOT LIKE


SQL> SELECT * from customer where customer_Address Like '%Velachery%';

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT
---------
        502 Priya Sharma         8765432101      priyasharma@customer.com
Velachery Main Road
25-FEB-26

SQL> SELECT * from customer where customer_Address NOT Like '%Velachery%';

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT
---------
        501 Suresh Kumar         8765432100      suresh.kumar@email.com
45 Anna Salai
25-FEB-26

        503 Arikaran             876543200       Ari@email.com
Madurai
25-FEB-26


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 4.3  IN / NOT IN


SQL> SELECT category_id, category_name
  2  FROM Category
  3  WHERE tax_rate IN (5,12);

CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
          1 Antibiotics
          2 Painkillers
          3 Antacids

SQL> SELECT category_id, category_name
  2  FROM Category
  3  WHERE tax_rate NOT IN (5,12);

CATEGORY_ID   CATEGORY_NAME
------------  --------------
        4  Vitamins
        5  Syrups

TCL / Other — Missing:
SQL> TRUNCATE TABLE med1;

Table truncated.
SQL> select * from med1;

no rows selected

MERGE statement
SQL> MERGE INTO Supplier s
  2  USING Supplier_New sn
  3  ON (s.supplier_id = sn.supplier_id)
  4  WHEN MATCHED THEN
  5      UPDATE SET
  6          s.supplier_phone = sn.supplier_phone,
  7          s.supplier_address = sn.supplier_address
  8  WHEN NOT MATCHED THEN
  9      INSERT (supplier_id, supplier_name, supplier_phone, supplier_address)
 10      VALUES (sn.supplier_id, sn.supplier_name, sn.supplier_phone, sn.supplier_address);

1 row merged.

SQL> ALTER TABLE Customer
  2  ADD age NUMBER;

Table altered.

SELECT specific columns (no WHERE)
SELECT category_id, category_name
FROM Category;
CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
          1 Antibiotics
          2 Painkillers
          3 Antacids
          4 Tablets
          5 Syrup
          6 Injection
         50 Pain
         51 Cold
         52 Fever
        200 General
          7 Herbal

Column ALIAS without AS

SQL> SELECT medicine_name NAME,
  2         selling_price PRICE
  3  FROM Medicine;

NAME                      PRICE
-------------------- ----------
amoxicillin 500mg            45
vicks 500mg                  25
Dolo                         66
Pain1                        45
PainA                        45
PainB                        47
PainC                        49
ColdA                        35
ColdB                        37
Med1                         45
Med2                         45
Med3                         45
Med1                         55
Med27                        55

Column concatenation ||

SQL> SELECT customer_name || ' - ' || customer_address AS full_details
  2  FROM Customer;

FULL_DETAILS
---------------------------------------------------------------------------------------------------------------------------
Priya Sharma - Chennai
Suresh Kumar - Chennai
ARUN - Chennai
KARTHIK - Chennai

Arithmetic
Increase Selling Price by 10
SQL> SELECT medicine_name,
  2         selling_price + 10 INCREASED_PRICE
  3  FROM Medicine;

MEDICINE_NAME        INCREASED_PRICE
-------------------- ---------------
amoxicillin 500mg                 55
vicks 500mg                       35
Dolo                              76
Pain1                             55
PainA                             55
PainB                             57
PainC                             59
ColdA                             45
ColdB                             47
Med1                              55
Med2                              55
Med3                              55

Reduce MRP by 5
sQL> SELECT medicine_name,
  2         mrp - 5 REDUCED_MRP
  3  FROM Medicine;

MEDICINE_NAME        REDUCED_MRP
-------------------- -----------
amoxicillin 500mg             15
vicks 500mg                    2
Dolo                          55
Pain1                         35
PainA                         35
PainB                         37
PainC                         39
ColdA                         25
ColdB                         27
Med1                          35
Med2                          35
Med3                          35
Med1                          45
Med27                         45
Med1                          45
Med1                          45
Med2                          45

Double the GST
QL> SELECT medicine_name,
  2         gst * 2 DOUBLE_GST
  3  FROM Medicine;

MEDICINE_NAME        DOUBLE_GST
-------------------- ----------
amoxicillin 500mg
vicks 500mg
Dolo                         24
Pain1                        10
PainA                        10
PainB                        10
PainC                        10

Half of Selling Price

SQL> SELECT medicine_name,
  2         selling_price / 2 HALF_PRICE
  3  FROM Medicine;

MEDICINE_NAME        HALF_PRICE
-------------------- ----------
amoxicillin 500mg          22.5
vicks 500mg                12.5
Dolo                         33
Pain1                      22.5
PainA                      22.5
PainB                      23.5
PainC                      24.5
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 4.4  WHERE Conditions


SQL> SELECT category_id, category_name, tax_rate
  2  FROM Category
  3  WHERE tax_rate > 8;

CATEGORY_ID CATEGORY_NAME                                        TAX_RATE
----------- -------------------------------------------------- ----------
          1 Antibiotics                                                12

SQL> SELECT medicine_name, Medicine_brand
  2  FROM Medicine
  3  WHERE prescription_required = 'Y';

MEDICINE_NAME        MEDICINE_BRAND
-------------------- --------------------------------------------------
vicks 500mg          vicks

SQL> SELECT customer_id, customer_name, Mobile_no
  2  FROM Customer
  3  WHERE UPPER(customer_Address) LIKE '%CHENNAI%';

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO
----------- -------------------- ---------------
         10 Ravi                 9876543210

SQL> SELECT customer_id, customer_name, Mobile_no
  2  FROM Customer
  3  WHERE UPPER(customer_Address) NOT LIKE '%CHENNAI%';

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO
----------- -------------------- ---------------
        502 Priya Sharma         8765432101
          2 Divya                9123456780
         11 Meena                9123456780

SQL> SELECT discount_name, discount_value,
  2         TO_CHAR(start_date, 'DD-MON-YY') || ' to ' ||
  3         TO_CHAR(end_date, 'DD-MON-YY') AS period
  4  FROM Discount
  5  WHERE active_status = 'ACTIVE';

DISCOUNT_NAME
--------------------------------------------------------------------------------
DISCOUNT_VALUE PERIOD
-------------- ----------------------------------------
New Year Sale
            15 01-FEB-26 to 15-APR-26

AND Equivalent to BETWEEN
SQL> SELECT medicine_name, selling_price
  2  FROM Medicine
  3  WHERE selling_price >= 60
  4    AND selling_price <= 150;

MEDICINE_NAME        SELLING_PRICE
-------------------- -------------
Dolo                            66


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 4.5  AGGREGATE FUNCTIONS


MEDIAN()
SQL> SELECT MEDIAN(selling_price) MEDIAN_PRICE
  2  FROM Medicine;

MEDIAN_PRICE
------------
          55

SQL> SELECT MEDIAN(cost_price) MEDIAN_COST
  2  FROM Batch;

MEDIAN_COST
-----------
       42.5

VARIANCE()
SQL> SELECT VARIANCE(selling_price) PRICE_VARIANCE
  2  FROM Medicine;

PRICE_VARIANCE
--------------
    46.9010101

Quantity Variation
SQL> SELECT VARIANCE(quantity_available) STOCK_VARIANCE
  2  FROM Batch;

STOCK_VARIANCE
--------------
        136870
SQL> SELECT COUNT(*) AS total_customers
  2  FROM Customer;

TOTAL_CUSTOMERS
---------------
              4
STDDEV()
SQL> SELECT STDDEV(selling_price) PRICE_STDDEV
  2  FROM Medicine;

PRICE_STDDEV
------------
  6.84843121

SQL> SELECT STDDEV(cost_price) COST_STDDEV
  2  FROM Batch;

COST_STDDEV
-----------
 3.53553391

COUNT() with NULL Values

SQL> SELECT COUNT(customer_email)
  2  FROM Customer;

COUNT(CUSTOMER_EMAIL)
---------------------
                    4

SQL> SELECT COUNT(*)
  2  FROM Customer;

  COUNT(*)
----------
         4
SQL> SELECT AVG(selling_price) AS avg_price
  2  FROM Medicine;

 AVG_PRICE
----------
        35

SQL> SELECT category_id, AVG(selling_price) AS avg_price
  2  FROM Medicine
  3  GROUP BY category_id;

CATEGORY_ID  AVG_PRICE
----------- ----------
          1         45
          2         25

SQL> SELECT medicine_id, SUM(quantity_received) AS total_received
  2  FROM Batch
  3  GROUP BY medicine_id;

MEDICINE_ID TOTAL_RECEIVED
----------- --------------
       1001           1000

        101

SQL> commit;

Commit complete.

SQL> SELECT Batch_id, SUM(quantity_available) AS total_avail
  2  FROM Batch
  3  GROUP BY batch_id;

  BATCH_ID TOTAL_AVAIL
---------- -----------
      4001         950
         2         180
         5         100
         1          50


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 4.6  GROUP BY / HAVING


SQL> SELECT customer_Address, COUNT(*) AS cust_count
  2  FROM Customer
  3  GROUP BY customer_Address;

CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
CUST_COUNT
----------
Velachery Main Road
         1

Madurai
         2

Chennai
         1

SQL> SELECT customer_Address, COUNT(*) AS cust_count
  2  FROM Customer
  3  GROUP BY customer_Address
  4  HAVING COUNT(*) > 1;

CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
CUST_COUNT
----------
Madurai
         2

SQL> SELECT TO_CHAR(registration_date,'YYYY-MM') AS reg_month,
  2         COUNT(*) AS reg_count
  3  FROM Customer
  4  GROUP BY TO_CHAR(registration_date,'YYYY-MM');

REG_MON  REG_COUNT
------- ----------
2026-02          2
2024-06          1
2020-04          1

SQL> SELECT active_status, COUNT(*) AS disc_count
  2  FROM Discount
  3  GROUP BY active_status;

ACTIVE_STATUS        DISC_COUNT
-------------------- ----------
ACTIVE                        1

 group by Multiple attribute
SQL> SELECT cat_id,
  2         gst,
  3         COUNT(*) TOTAL_MEDICINES
  4  FROM Medicine
  5  GROUP BY cat_id, gst;

    CAT_ID        GST TOTAL_MEDICINES
---------- ---------- ---------------
         1                          1
         2                          1
         1         12               1
        50          5               7
        51          5               2
       200          5              33

6 rows selected.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 4.7  DATE FUNCTIONS

CURRENT_DATE
SELECT customer_name,
       CURRENT_DATE
FROM Customer;

CUSTOMER_NAME        CURRENT_D
-------------------- ---------
Priya Sharma         26-FEB-26
Suresh Kumar         26-FEB-26
ARUN                 26-FEB-26
KARTHIK              26-FEB-26

CURRENT_TIMESTAMP

SQL> SELECT customer_name,
  2         CURRENT_TIMESTAMP
  3  FROM Customer;

CUSTOMER_NAME        CURRENT_TIMESTAMP
-------------------- ---------------------------------------------------------------------------
Priya Sharma         26-FEB-26 08.00.36.515000 AM +05:30
Suresh Kumar         26-FEB-26 08.00.36.515000 AM +05:30
ARUN                 26-FEB-26 08.00.36.515000 AM +05:30
KARTHIK              26-FEB-26 08.00.36.515000 AM +05:30

Date + / − Number (Add/Subtract Days)

SQL> SELECT batch_id,
  2         manufacture_date,
  3         manufacture_date + 5 NEW_DATE
  4  FROM Batch;

  BATCH_ID MANUFACTU NEW_DATE
---------- --------- ---------
      4001 01-OCT-25 06-OCT-25
         2
         5
         1 17-NOV-25 22-NOV-25
         3 06-JAN-26 11-JAN-26

SQL> SELECT batch_id,
  2         expiry_date - 5 UPDATED_DATE
  3  FROM Batch;

  BATCH_ID UPDATED_D
---------- ---------
      4001 26-SEP-27
         2 20-MAY-26
         5 22-MAR-26
         1 08-SEP-26
         3 17-DEC-26

Date Arithmetic ERROR Demo
SQL> SELECT manufacture_date * 5
  2  FROM Batch;
SELECT manufacture_date * 5
       *
ERROR at line 1:
ORA-00932: inconsistent datatypes: expected NUMBER got DATE

Date − Date (Days Difference)
SQL> SELECT customer_name,
  2         SYSDATE - registration_date DAYS_REGISTERED
  3  FROM Customer;

CUSTOMER_NAME        DAYS_REGISTERED
-------------------- ---------------
Priya Sharma              1.04329861
Suresh Kumar              .840347222
ARUN                      .542627315
KARTHIK                   .511134259

NEXT_DAY()
SQL> SELECT batch_id,
  2         NEXT_DAY(manufacture_date,'MONDAY') NEXT_SUPPLY_DAY
  3  FROM Batch;

  BATCH_ID NEXT_SUPP
---------- ---------
      4001 06-OCT-25
         2
         5
         1 24-NOV-25
         3 12-JAN-26

LAST_DAY()
SQL> SELECT batch_id,
  2         LAST_DAY(manufacture_date) MONTH_END
  3  FROM Batch;

  BATCH_ID MONTH_END
---------- ---------
      4001 31-OCT-25
         2
         5
         1 30-NOV-25
         3 31-JAN-26

TRUNC(Date)
SQL> SELECT customer_name,
  2         TRUNC(registration_date,'MM') MONTH_START
  3  FROM Customer;

CUSTOMER_NAME        MONTH_STA
-------------------- ---------
Priya Sharma         01-FEB-26
Suresh Kumar         01-FEB-26
ARUN                 01-FEB-26
KARTHIK              01-FEB-26


