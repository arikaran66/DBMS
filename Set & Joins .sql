Script started on Thu Feb 26 14:03:14 2026
[24bcsl03@mepcolinux sql]$cat ex4.txt
ET OPERATORS & JOIN QUERIES
========================================================


-- ======================================================
-- SET OPERATORS
-- ======================================================

-- UNION: Combines results and removes duplicates
-- -------------------------------------------------------

SQL> SELECT customer_name FROM Customer
  2  UNION
  3  SELECT supplier_name FROM Supplier;

CUSTOMER_NAME
--------------------
Priya Sharma
Suresh Kumar
Arikaran
Ravi
Kumar
Mani
ABC Pharma
XYZ Pharma

8 rows selected.


-- UNION ALL: Combines results and keeps duplicates
-- -------------------------------------------------------

SQL> SELECT customer_name FROM Customer
  2  UNION ALL
  3  SELECT supplier_name FROM Supplier;

CUSTOMER_NAME
--------------------
Priya Sharma
Suresh Kumar
Arikaran
Ravi
Kumar
Mani
KUMAR
ABC Pharma
XYZ Pharma
Ravi

10 rows selected.


-- INTERSECT: Returns rows common to both queries
-- -------------------------------------------------------

SQL> SELECT customer_name FROM Customer
  2  INTERSECT
  3  SELECT supplier_name FROM Supplier;

CUSTOMER_NAME
--------------------
Ravi
ARUN


-- INTERSECT ALL: Returns common rows including duplicates
-- -------------------------------------------------------

SQL> SELECT customer_name FROM Customer
  2  INTERSECT ALL
  3  SELECT supplier_name FROM Supplier;

CUSTOMER_NAME
--------------------
Ravi
ARUN


-- MINUS: Returns rows from first query not in second query
-- -------------------------------------------------------

SQL> SELECT customer_name FROM Customer
  2  MINUS
  3  SELECT supplier_name FROM Supplier;

CUSTOMER_NAME
--------------------
Priya Sharma
Suresh Kumar
Arikaran
Kumar
Mani
KUMAR
KARTHIK

7 rows selected.

SQL> SELECT supplier_name FROM Supplier
  2  MINUS
  3  SELECT customer_name FROM Customer;

SUPPLIER_NAME
--------------------
ABC Pharma
XYZ Pharma


-- EXCEPT: Similar to MINUS (ANSI standard)
-- -------------------------------------------------------

SQL> SELECT customer_name FROM Customer
  2  EXCEPT
  3  SELECT supplier_name FROM Supplier;

CUSTOMER_NAME
--------------------
Priya Sharma
Suresh Kumar
Arikaran
Kumar
Mani
KUMAR
KARTHIK

7 rows selected.

-- ======================================================
-- JOIN QUERIES
-- ======================================================

-- BASE TABLE DATA
-- -------------------------------------------------------

SQL> select * from med;

    MED_ID MED_NAME                            PRICE
---------- ------------------------------ ----------
         1 Paracetamol                            50
         2 Ibuprofen                              60
         3 Aspirin                                40
         4 Cetirizine                             30
         5 Amoxicillin                            80
         6 Dolo                                   55
         7 Vicks                                  35
         8 Cough Syrup                            75
         9 Vitamin C                              25

9 rows selected.

SQL> Select * from med1;

    MED_ID MED_NAME                            PRICE SUPPLIER_NAME
---------- ------------------------------ ---------- ------------------------------
         1 Paracetamol                            50 ABC Pharma
         2 Ibuprofen                              60 XYZ Pharma
         3 Aspirin                                40 MedLife
         6 Dolo                                   55 ABC Pharma
         7 Vicks                                  35 HealthCare
        10 NewMed                                100 NewSupplier
        20 AnotherMed                            120 SuperMed
        30 TestMed                               200 TestPharma

8 rows selected.


-- CROSS JOIN (Cartesian Product): Every row of table1 combined with every row of table2
-- Columns get added, rows get multiplied
-- -------------------------------------------------------

SQL> SELECT *
  2  FROM Category, Medicine;

CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
DESCRIPTION
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  TAX_RATE ACTIVE_STATUS        CREATED_D UPDATED_D MEDICINE_ID CATEGORY_ID MEDICINE_NAME        MEDICINE_BRAND               UNITSIZE         MRP        GST SELLING_PRICE
---------- -------------------- --------- --------- ----------- ----------- -------------------- -------------------------------------------------- ---------- ---------- ---------- -------------
PRESCRIPTION_RE
---------------
          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                  1002           1 amoxicillin 500mg    Himax                     750          20                       45


          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                  1003           2 vicks 500mg          vicks                     500           7                       25
Y

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   101           1 Paracetamol          ABC                        10          50         12            55
NO

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   102           1 Antibiotic           XYZ                        10         120         12           135
YES

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   103           1 Dolo                 ABC Pharma                 10          60         12            66
NO

          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26                  1002           1 amoxicillin 500mg    Himax                     750          20                       45


          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26                  1003           2 vicks 500mg          vicks                     500           7                       25
Y

          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26                   101           1 Paracetamol          ABC                        10          50         12            55
NO

          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26                   102           1 Antibiotic           XYZ                        10         120         12           135
YES

          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26                   103           1 Dolo                 ABC Pharma                 10          60         12            66
NO

          3 Antacids
Stomach acidity relief
         5 ACTIVE               25-FEB-26                  1002           1 amoxicillin 500mg    Himax                     750          20                       45


          3 Antacids
Stomach acidity relief
         5 ACTIVE               25-FEB-26                  1003           2 vicks 500mg          vicks                     500           7                       25
Y

          3 Antacids
Stomach acidity relief
         5 ACTIVE               25-FEB-26                   101           1 Paracetamol          ABC                        10          50         12            55
NO

          3 Antacids
Stomach acidity relief
         5 ACTIVE               25-FEB-26                   102           1 Antibiotic           XYZ                        10         120         12           135
YES

          3 Antacids
Stomach acidity relief
         5 ACTIVE               25-FEB-26                   103           1 Dolo                 ABC Pharma                 10          60         12            66
NO

          4 Tablets
Oral Medicines
        12 ACTIVE               25-FEB-26 25-FEB-26        1002           1 amoxicillin 500mg    Himax                     750          20                       45


          4 Tablets
Oral Medicines
        12 ACTIVE               25-FEB-26 25-FEB-26        1003           2 vicks 500mg          vicks                     500           7                       25
Y

          4 Tablets
Oral Medicines
        12 ACTIVE               25-FEB-26 25-FEB-26         101           1 Paracetamol          ABC                        10          50         12            55
NO

          4 Tablets
Oral Medicines
        12 ACTIVE               25-FEB-26 25-FEB-26         102           1 Antibiotic           XYZ                        10         120         12           135
YES

          4 Tablets
Oral Medicines
        12 ACTIVE               25-FEB-26 25-FEB-26         103           1 Dolo                 ABC Pharma                 10          60         12            66
NO

          5 Syrup
Liquid Medicines
         5 ACTIVE               25-FEB-26 25-FEB-26        1002           1 amoxicillin 500mg    Himax                     750          20                       45


          5 Syrup
Liquid Medicines
         5 ACTIVE               25-FEB-26 25-FEB-26        1003           2 vicks 500mg          vicks                     500           7                       25
Y

          5 Syrup
Liquid Medicines
         5 ACTIVE               25-FEB-26 25-FEB-26         101           1 Paracetamol          ABC                        10          50         12            55
NO

          5 Syrup
Liquid Medicines
         5 ACTIVE               25-FEB-26 25-FEB-26         102           1 Antibiotic           XYZ                        10         120         12           135
YES

          5 Syrup
Liquid Medicines
         5 ACTIVE               25-FEB-26 25-FEB-26         103           1 Dolo                 ABC Pharma                 10          60         12            66
NO

          6 Injection
Injectable Medicines
        18 ACTIVE               25-FEB-26 25-FEB-26        1002           1 amoxicillin 500mg    Himax                     750          20                       45


          6 Injection
Injectable Medicines
        18 ACTIVE               25-FEB-26 25-FEB-26        1003           2 vicks 500mg          vicks                     500           7                       25
Y

          6 Injection
Injectable Medicines
        18 ACTIVE               25-FEB-26 25-FEB-26         101           1 Paracetamol          ABC                        10          50         12            55
NO

          6 Injection
Injectable Medicines
        18 ACTIVE               25-FEB-26 25-FEB-26         102           1 Antibiotic           XYZ                        10         120         12           135
YES

          6 Injection
Injectable Medicines
        18 ACTIVE               25-FEB-26 25-FEB-26         103           1 Dolo                 ABC Pharma                 10          60         12            66
NO

30 rows selected.


-- CROSS JOIN WITH CONDITION
-- -------------------------------------------------------

SQL> SELECT *
  2  FROM Category C, Medicine M
  3  WHERE C.category_id = M.category_id;

CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
DESCRIPTION
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  TAX_RATE ACTIVE_STATUS        CREATED_D UPDATED_D MEDICINE_ID CATEGORY_ID MEDICINE_NAME        MEDICINE_BRAND               UNITSIZE         MRP        GST SELLING_PRICE
---------- -------------------- --------- --------- ----------- ----------- -------------------- -------------------------------------------------- ---------- ---------- ---------- -------------
PRESCRIPTION_RE
---------------
          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                  1002           1 amoxicillin 500mg    Himax                     750          20                       45


          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26                  1003           2 vicks 500mg          vicks                     500           7                       25
Y

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   101           1 Paracetamol          ABC                        10          50         12            55
NO

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   102           1 Antibiotic           XYZ                        10         120         12           135
YES

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   103           1 Dolo                 ABC Pharma                 10          60         12            66
NO

5 rows selected.


-- CROSS JOIN with ON clause (ERROR - ON not allowed with CROSS JOIN)
-- -------------------------------------------------------

SQL> SELECT *
  2  FROM Category C
  3  CROSS JOIN Medicine M
  4  ON C.category_id = M.category_id;
ON C.category_id = M.category_id
*
ERROR at line 4:
ORA-00933: SQL command not properly ended


-- INNER JOIN: Returns only matching rows from both tables
-- -------------------------------------------------------

SQL> SELECT *
  2  FROM Category C
  3  INNER JOIN Medicine M
  4  ON C.category_id = M.category_id;

CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
DESCRIPTION
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  TAX_RATE ACTIVE_STATUS        CREATED_D UPDATED_D MEDICINE_ID CATEGORY_ID MEDICINE_NAME        MEDICINE_BRAND               UNITSIZE         MRP        GST SELLING_PRICE
---------- -------------------- --------- --------- ----------- ----------- -------------------- -------------------------------------------------- ---------- ---------- ---------- -------------
PRESCRIPTION_RE
---------------
          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                  1002           1 amoxicillin 500mg    Himax                     750          20                       45


          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26                  1003           2 vicks 500mg          vicks                     500           7                       25
Y

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   101           1 Paracetamol          ABC                        10          50         12            55
NO

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   102           1 Antibiotic           XYZ                        10         120         12           135
YES

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   103           1 Dolo                 ABC Pharma                 10          60         12            66
NO

5 rows selected.


-- NATURAL JOIN: Auto-joins on columns with the same name in both tables
-- -------------------------------------------------------

SQL> SELECT *
  2  FROM Category
  3  NATURAL JOIN Medicine;

CATEGORY_ID CATEGORY_NAME
----------- --------------------------------------------------
DESCRIPTION
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  TAX_RATE ACTIVE_STATUS        CREATED_D UPDATED_D MEDICINE_ID MEDICINE_NAME        MEDICINE_BRAND                       UNITSIZE         MRP        GST SELLING_PRICE PRESCRIPTION_RE
---------- -------------------- --------- --------- ----------- -------------------- -------------------------------------------------- ---------- ---------- ---------- ------------- ---------------
          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                  1002 amoxicillin 500mg    Himax                                     750          20                       45

          2 Painkillers
Analgesics and pain relief
         5 ACTIVE               25-FEB-26                  1003 vicks 500mg          vicks                                     500           7                       25 Y

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   101 Paracetamol          ABC                                10          50         12            55 NO

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   102 Antibiotic           XYZ                                10         120         12           135 YES

          1 Antibiotics
Antibacterial medications
        12 ACTIVE               25-FEB-26                   103 Dolo                 ABC Pharma                         10          60         12            66 NO

47 rows selected.


-- ALTER TABLE: Rename Column
-- -------------------------------------------------------

SQL> ALTER TABLE Medicine RENAME COLUMN CATEGORY_ID TO CAT_ID;

Table altered.


-- NATURAL JOIN (MED and MED1): Joins on all common columns automatically
-- -------------------------------------------------------

SQL> SELECT *
  2  FROM MED NATURAL JOIN MED1;

    MED_ID MED_NAME                            PRICE SUPPLIER_NAME
---------- ------------------------------ ---------- ------------------------------
         1 Paracetamol                            50 ABC Pharma
         2 Ibuprofen                              60 XYZ Pharma
         3 Aspirin                                40 MedLife
         6 Dolo                                   55 ABC Pharma
         7 Vicks                                  35 HealthCare


-- INNER JOIN (MED and MED1): Returns only matching rows on MED_ID
-- -------------------------------------------------------

SQL> SELECT *
  2  FROM MED M
  3  INNER JOIN MED1 M1
  4  ON M.MED_ID = M1.MED_ID;

    MED_ID MED_NAME                            PRICE     MED_ID MED_NAME                            PRICE SUPPLIER_NAME
---------- ------------------------------ ---------- ---------- ------------------------------ ---------- ------------------------------
         1 Paracetamol                            50          1 Paracetamol                            50 ABC Pharma
         2 Ibuprofen                              60          2 Ibuprofen                              60 XYZ Pharma
         3 Aspirin                                40          3 Aspirin                                40 MedLife
         6 Dolo                                   55          6 Dolo                                   55 ABC Pharma
         7 Vicks                                  35          7 Vicks                                  35 HealthCare


-- LEFT OUTER JOIN: All rows from left table (MED), matching from right (MED1), NULLs for non-matches
-- -------------------------------------------------------

SQL> SELECT *
  2  FROM MED M
  3  LEFT OUTER JOIN MED1 M1
  4  ON M.MED_ID = M1.MED_ID;

    MED_ID MED_NAME                            PRICE     MED_ID MED_NAME                            PRICE SUPPLIER_NAME
---------- ------------------------------ ---------- ---------- ------------------------------ ---------- ------------------------------
         1 Paracetamol                            50          1 Paracetamol                            50 ABC Pharma
         2 Ibuprofen                              60          2 Ibuprofen                              60 XYZ Pharma
         3 Aspirin                                40          3 Aspirin                                40 MedLife
         6 Dolo                                   55          6 Dolo                                   55 ABC Pharma
         7 Vicks                                  35          7 Vicks                                  35 HealthCare
         8 Cough Syrup                            75
         4 Cetirizine                             30
         5 Amoxicillin                            80
         9 Vitamin C                              25

9 rows selected.


-- RIGHT OUTER JOIN: All rows from right table (MED1), matching from left (MED), NULLs for non-matches
-- -------------------------------------------------------

SQL> SELECT *
  2  FROM MED M
  3  RIGHT OUTER JOIN MED1 M1
  4  ON M.MED_ID = M1.MED_ID;

    MED_ID MED_NAME                            PRICE     MED_ID MED_NAME                            PRICE SUPPLIER_NAME
---------- ------------------------------ ---------- ---------- ------------------------------ ---------- ------------------------------
         1 Paracetamol                            50          1 Paracetamol                            50 ABC Pharma
         2 Ibuprofen                              60          2 Ibuprofen                              60 XYZ Pharma
         3 Aspirin                                40          3 Aspirin                                40 MedLife
         6 Dolo                                   55          6 Dolo                                   55 ABC Pharma
         7 Vicks                                  35          7 Vicks                                  35 HealthCare
                                                             30 TestMed                               200 TestPharma
                                                             10 NewMed                                100 NewSupplier
                                                             20 AnotherMed                            120 SuperMed

8 rows selected.


-- FULL OUTER JOIN: All rows from both tables, NULLs where no match
-- -------------------------------------------------------

SQL> SELECT *
  2  FROM MED M
  3  FULL OUTER JOIN MED1 M1
  4  ON M.MED_ID = M1.MED_ID;

    MED_ID MED_NAME                            PRICE     MED_ID MED_NAME                            PRICE SUPPLIER_NAME
---------- ------------------------------ ---------- ---------- ------------------------------ ---------- ------------------------------
         1 Paracetamol                            50          1 Paracetamol                            50 ABC Pharma
         2 Ibuprofen                              60          2 Ibuprofen                              60 XYZ Pharma
         3 Aspirin                                40          3 Aspirin                                40 MedLife
         4 Cetirizine                             30
         5 Amoxicillin                            80
         6 Dolo                                   55          6 Dolo                                   55 ABC Pharma
         7 Vicks                                  35          7 Vicks                                  35 HealthCare
         8 Cough Syrup                            75
         9 Vitamin C                              25
                                                             30 TestMed                               200 TestPharma
                                                             10 NewMed                                100 NewSupplier
                                                             20 AnotherMed                            120 SuperMed

12 rows selected.


-- SELF JOIN: Joins a table with itself to find related rows within the same table
-- -------------------------------------------------------

SQL> SELECT
  2  M1.MED_NAME AS MEDICINE_NAME,
  3  M1.PRICE AS MEDICINE_PRICE,
  4  M2.MED_NAME AS SAME_SUPPLIER_MEDICINE,
  5  M2.SUPPLIER_NAME AS SUPPLIER
  6  FROM MED1 M1
  7  JOIN MED1 M2
  8  ON M1.SUPPLIER_NAME = M2.SUPPLIER_NAME
  9  AND M1.MED_ID <> M2.MED_ID;

MEDICINE_NAME                  MEDICINE_PRICE SAME_SUPPLIER_MEDICINE         SUPPLIER
------------------------------ -------------- ------------------------------ ------------------------------
Dolo                                       55 Paracetamol                    ABC Pharma
Paracetamol                                50 Dolo                           ABC Pharma



Multiple join (more than 2 tables)
-- -------------------------------------------------------

SQL> select c.category_name,m.medicine_name,s.supplier_id from category c join medicine m on c.category_id = m.cat_id join supplier s on m.supplier_id=s.supplier_id;

CATEGORY_NAME                                      MEDICINE_NAME
-------------------------------------------------- --------------------
SUPPLIER_ID
-----------
Antibiotics                                        amoxicillin 500mg
          1

Painkillers                                        vicks 500mg
          1

Pain                                               PainA
          1


CATEGORY_NAME                                      MEDICINE_NAME
-------------------------------------------------- --------------------
SUPPLIER_ID
-----------
Pain                                               PainB
          1

Pain                                               PainC
          1

Pain                                               Med1
          1


CATEGORY_NAME                                      MEDICINE_NAME
-------------------------------------------------- --------------------
SUPPLIER_ID
-----------
Pain                                               Med2
          1

Pain                                               Med3
          1

Cold                                               ColdA
          1


CATEGORY_NAME                                      MEDICINE_NAME
-------------------------------------------------- --------------------
SUPPLIER_ID
-----------
Cold                                               ColdB
          1

General                                            Med1
          1


11 rows selected.


SQL> SELECT *
  2  FROM MED M
  3  CROSS JOIN MED1 M1
  4  WHERE M.MED_ID = M1.MED_ID;

    MED_ID MED_NAME                            PRICE     MED_ID MED_NAME                            PRICE SUPPLIER_NAME
---------- ------------------------------ ---------- ---------- ------------------------------ ---------- ------------------------------
         1 Paracetamol                            50          1 Paracetamol                            50 ABC Pharma
         2 Ibuprofen                              60          2 Ibuprofen                              60 XYZ Pharma
         3 Aspirin                                40          3 Aspirin                                40 MedLife
         6 Dolo                                   55          6 Dolo                                   55 ABC Pharma
         7 Vicks                                  35          7 Vicks                                  35 HealthCare

SQL> select medicine_id,medicine_name,supplier_id from medicine join supplier using(supplier_id);

MEDICINE_ID MEDICINE_NAME        SUPPLIER_ID
----------- -------------------- -----------
       1002 amoxicillin 500mg              1
       1003 vicks 500mg                    1
       6001 PainA                          1
       6002 PainB                          1
       6003 PainC                          1
       6004 ColdA                          1
       6005 ColdB                          1
       7001 Med1                           1
       7002 Med2                           1
       7003 Med3                           1
       2001 Med1                           1
11 rows selected.


