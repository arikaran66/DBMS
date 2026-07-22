[24bcsl03@mepcolinux sql]$cat ex6.txt
     views and index

CREATE VIEW
SQL> CREATE VIEW customer_contact_view AS
  2  SELECT customer_id,
  3         customer_name,
  4         mobile_no,
  5         registration_date
  6  FROM customer;

View created.

SQL> select * from Customer_contact_view;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       REGISTRAT
---
          3 Karthik              9876543215      27-FEB-26
         10 Kl Rahul             9876543000      27-FEB-26
          1 Arun                 9876543200      23-JAN-25
          2 Bala                 9876543201      11-AUG-25

--VIEW WITH WHERE CALUSE
SQL> CREATE VIEW active_view AS
  2  SELECT discount_name, discount_value,active_status
  3  FROM discount
  4  WHERE UPPER(active_status)='ACTIVE';

View created.

SQL> select * from active_view;

DISCOUNT_NAME
--------------------------------------------------------------------------------
DISCOUNT_VALUE ACTIVE_STATUS
-------------- --------------------
Festival Offer
            10 ACTIVE

New Year Offer
            50 ACTIVE


--View with JOIN

SQL> CREATE VIEW medicine_view AS
  2  SELECT m.medicine_name,
  3         m.selling_price,
  4         s.supplier_name
  5  FROM medicine m
  6  JOIN supplier s
  7  ON m.supplier_id = s.supplier_id;

View created.

SQL> select * from medicine_view;

MEDICINE_NAME        SELLING_PRICE SUPPLIER_NAME
---
Paracetamol                    110 ABC Pharma
Ibuprofen                      165 ABC Pharma
Cough Syrup                    135 MediCare Ltd
Insulin                        650 MediCare Ltd
Vitamin Syrup                   90 ABC Pharma
Dolo                           450 ABC Pharma

6 rows selected.

View With Multiple JOIN

SQL> CREATE VIEW medicine_info AS
  2  SELECT m.medicine_name,
  3         c.category_name,
  4         s.supplier_name,
  5         m.selling_price
  6  FROM medicine m
  7  JOIN category c
  8  ON m.cat_id = c.category_id
  9  JOIN supplier s
 10  ON m.supplier_id = s.supplier_id;

View created.

SQL> select * from medicine_info;

MEDICINE_NAME        CATEGORY_NAME                                      SUPPLIER_NAME        SELLING_PRICE
---
Paracetamol          Tablet                                             ABC Pharma                     110
Ibuprofen            Tablet                                             ABC Pharma                     165
Dolo                 Tablet                                             ABC Pharma                     450
Cough Syrup          Syrup                                              MediCare Ltd                   135
Vitamin Syrup        Syrup                                              ABC Pharma                      90
Insulin              Injection                                          MediCare Ltd                   650

6 rows selected.

--View with Aggregation
SQL> CREATE VIEW medicine_quantity AS
  2  SELECT medicine_id,
  3         SUM(quantity_available) AS total_quantity
  4  FROM batch
  5  GROUP BY medicine_id;

View created.

SQL> select * from medicine_quantity
  2  ;

MEDICINE_ID TOTAL_QUANTITY
---------------------------
        201            180
        202            130
        204             40

Nested View

SQL> CREATE VIEW high_stock_medicine AS
  2  SELECT *
  3  FROM medicine_quantity
  4  WHERE total_quantity > 100;

View created.

SQL> select * from high_stock_medicine;

MEDICINE_ID TOTAL_QUANTITY
---
        201            180
        202            130

--MODIFYING VIEWS
SQL> INSERT INTO customer_contact_view
  2  VALUES (12,'Virat','9876543222',SYSDATE);

1 row created.

SQL> select * from Customer_contact_view;

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       REGISTRAT
---
          3 Karthik              9876543215      27-FEB-26
         10 Kl Rahul             9876543000      27-FEB-26
          1 Arun                 9876543200      23-JAN-25
          2 Bala                 9876543201      11-AUG-25
         12 Virat                9876543222      27-FEB-26


Simple index
SQL> CREATE INDEX idx_medicine
  2  ON medicine(medicine_name);

Index created.

Unique Index
SQL> CREATE UNIQUE INDEX idx_gst
  2  ON supplier(gst_number);

Index created.

Composite Index
SQL> CREATE INDEX idx_customer_city_age
  2  ON customer(customer_address, age);

Index created.

Bitmap Index
SQL> CREATE BITMAP INDEX idx_prescription
  2  ON medicine(prescription_required);

Index created.

Function Based Index
SQL> CREATE INDEX idx_lower_email
  2  ON customer(LOWER(customer_email));

Index created.

Drop View
SQL> DROP VIEW medicine_supplier_view;

View dropped.

SQL> select * from medicine_supplier_view;
select * from medicine_supplier_view
              *
ERROR at line 1:
ORA-00942: table or view does not exist

SQL> DROP INDEX idx_medicine;

Index dropped.

SQL> CREATE INDEX idx_medicine
  2  ON medicine(selling_price);

Index created.

SQL> SET TIMING ON;
SQL> select * from medicine;

MEDICINE_ID     CAT_ID MEDICINE_NAME
----------- ---------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE PRESCRIPTION_RE SUPPLIER_ID
---------- ------------- --------------- -----------
        201          1 Paracetamol
Cipla                                                      10        100
         5           110 NO                      101

        202          1 Ibuprofen
Sun Pharma                                                 10        150
         5           165 NO                      101

MEDICINE_ID     CAT_ID MEDICINE_NAME
----------- ---------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE PRESCRIPTION_RE SUPPLIER_ID
---------- ------------- --------------- -----------

        203          2 Cough Syrup
Zydus                                                       1        120
        12           135 YES                     102

        204          3 Insulin
Novo                                                        1        600

MEDICINE_ID     CAT_ID MEDICINE_NAME
----------- ---------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE PRESCRIPTION_RE SUPPLIER_ID
---------- ------------- --------------- -----------
        18           650 YES                     102

        205          2 Vitamin Syrup
HealthPlus                                                  1         80
        12            90 NO                      101

        206          1 Dolo

MEDICINE_ID     CAT_ID MEDICINE_NAME
----------- ---------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE PRESCRIPTION_RE SUPPLIER_ID
---------- ------------- --------------- -----------
Micro                                                      10        300
         5           450 NO                      101


6 rows selected.

Elapsed: 00:00:00.02
SQL> select mrp from medicine;

       MRP
----------
       100
       150
       120
       600
        80
       300

6 rows selected.

Elapsed: 00:00:00.00

SQL> SELECT * FROM medicine
  2  WHERE selling_price > 200;

MEDICINE_ID     CAT_ID MEDICINE_NAME
----------- ---------- --------------------
MEDICINE_BRAND                                       UNITSIZE        MRP
-------------------------------------------------- ---------- ----------
       GST SELLING_PRICE PRESCRIPTION_RE SUPPLIER_ID
---------- ------------- --------------- -----------
        204          3 Insulin
Novo                                                        1        600
        18           650 YES                     102

        206          1 Dolo
Micro                                                      10        300
         5           450 NO                      101

Elapsed: 00:00:00.01

Simple index
SQL> CREATE INDEX idx_medicine
  2  ON medicine(medicine_name);

Index created.

SQL> select medicine_name from medicine;

MEDICINE_NAME
--------------------
Paracetamol
Ibuprofen
Cough Syrup
Insulin
Vitamin Syrup
Dolo

6 rows selected.

Elapsed: 00:00:00.00

Unique Index
SQL> CREATE UNIQUE INDEX idx_gst
  2  ON supplier(gst_number);

Index created.
SQL> select gst_number from supplier;

GST_NUMBER
--------------------
GST123
GST456

Elapsed: 00:00:00.00

Composite Index
SQL> CREATE INDEX idx_customer_city_age
  2  ON customer(customer_address, age);
Index created.

SQL> select customer_address,age from customer;

CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
       AGE
----------
Tuticorin
        28

Tuticorin
        32

Tuticorin
        25
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
       AGE
----------
Tirunelveli
        35
Elapsed: 00:00:00.01

SQL> select * from customer where lower(customer_email)='arun@gmail.com';

CUSTOMER_ID CUSTOMER_NAME        MOBILE_NO       CUSTOMER_EMAIL
----------- -------------------- --------------- ------------------------------
CUSTOMER_ADDRESS
--------------------------------------------------------------------------------
REGISTRAT        AGE
--------- ----------
          1 Arun                 9876543200      arun@gmail.com
Tuticorin
23-JAN-25         25

Elapsed: 00:00:00.00
SQL> set time off;
