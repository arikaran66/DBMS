SQL> CREATE TABLE Customer (
  2      customer_id INT PRIMARY KEY,                     -- PK at start
  3      customer_name VARCHAR(20) NOT NULL,
  4      customer_phone VARCHAR(15) ,
  5      customer_email VARCHAR(50),
  6      customer_address VARCHAR(100) ,
  7      registration_date DATE NOT NULL
  8  );

Table created.

SQL> desc Customer
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 CUSTOMER_ID                               NOT NULL NUMBER(38)
 CUSTOMER_NAME                             NOT NULL VARCHAR2(20)
 CUSTOMER_PHONE                                     VARCHAR2(15)
 CUSTOMER_EMAIL                                     VARCHAR2(50)
 CUSTOMER_ADDRESS                                   VARCHAR2(100)
 REGISTRATION_DATE                         NOT NULL DATE

SQL> ALTER TABLE Customer
  2  ADD CONSTRAINT chk_customer_phone_len
  3      CHECK (CHAR_LENGTH(customer_phone) = 10);
    CHECK (CHAR_LENGTH(customer_phone) = 10)
           *
ERROR at line 3:
ORA-00904: "CHAR_LENGTH": invalid identifier


SQL> ALTER TABLE Customer
  2  ADD CONSTRAINT chk_customer_phone_len
  3      CHECK (CHAR_LENGTH(customer_phone) = 10);
    CHECK (CHAR_LENGTH(customer_phone) = 10)
           *
ERROR at line 3:
ORA-00904: "CHAR_LENGTH": invalid identifier


SQL> CREATE TABLE Supplier (
  2      supplier_id INT PRIMARY KEY,                     -- PK at start
  3      supplier_name VARCHAR(20) ,
  4      contact_person VARCHAR(20) ,
  5      supplier_phone VARCHAR(15) ,
  6      supplier_email VARCHAR(50),
  7      supplier_address VARCHAR(200) ,
  8      gst_number VARCHAR(20)
  9  );

Table created.

SQL> desc Supplier
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SUPPLIER_ID                               NOT NULL NUMBER(38)
 SUPPLIER_NAME                                      VARCHAR2(20)
 CONTACT_PERSON                                     VARCHAR2(20)
 SUPPLIER_PHONE                                     VARCHAR2(15)
 SUPPLIER_EMAIL                                     VARCHAR2(50)
 SUPPLIER_ADDRESS                                   VARCHAR2(200)
 GST_NUMBER                                         VARCHAR2(20)

SQL> ALTER TABLE Supplier
  2  ADD CONSTRAINT chk_supplier_phone_len
  3      CHECK (LENGTH(supplier_phone) = 10);

Table altered.

SQL> CREATE TABLE Medicine (
  2      medicine_id INT,
  3      category_id INT ,
  4      medicine_name VARCHAR(20),
  5      brand VARCHAR(50) ,
  6      unitsize INT ,
  7      mrp INT,
  8      gst INT,
  9      selling_price INT,
 10      CONSTRAINT pk_medicine PRIMARY KEY (medicine_id)
 11  );

Table created.

SQL> desc Medicine
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 MEDICINE_ID                               NOT NULL NUMBER(38)
 CATEGORY_ID                                        NUMBER(38)
 MEDICINE_NAME                                      VARCHAR2(20)
 BRAND                                              VARCHAR2(50)
 UNITSIZE                                           NUMBER(38)
 MRP                                                NUMBER(38)
 GST                                                NUMBER(38)
 SELLING_PRICE                                      NUMBER(38)

SQL> ALTER TABLE Medicine
  2  ADD CONSTRAINT chk_medicine_price_pos
  3      CHECK (selling_price > 0);

Table altered.

SQL> desc Medicine
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 MEDICINE_ID                               NOT NULL NUMBER(38)
 CATEGORY_ID                                        NUMBER(38)
 MEDICINE_NAME                                      VARCHAR2(20)
 BRAND                                              VARCHAR2(50)
 UNITSIZE                                           NUMBER(38)
 MRP                                                NUMBER(38)
 GST                                                NUMBER(38)
 SELLING_PRICE                                      NUMBER(38)



SQL> alter table customer drop primary key;

Table altered.

SQL> desc customer
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 CUSTOMER_ID                                        NUMBER(38)
 CUSTOMER_NAME                             NOT NULL VARCHAR2(20)
 MOBILE_NO                                          VARCHAR2(15)
 CUSTOMER_EMAIL                                     VARCHAR2(50)
 CUSTOMER_ADDRESS                                   VARCHAR2(100)
 REGISTRATION_DATE                         NOT NULL DATE

SQL> alter table customer add constraint c1 primary key(customer_id);

Table altered.

SQL> desc customer
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 CUSTOMER_ID                               NOT NULL NUMBER(38)
 CUSTOMER_NAME                             NOT NULL VARCHAR2(20)
 MOBILE_NO                                          VARCHAR2(15)
 CUSTOMER_EMAIL                                     VARCHAR2(50)
 CUSTOMER_ADDRESS                                   VARCHAR2(100)
 REGISTRATION_DATE                         NOT NULL DATE


SQL> CREATE TABLE Category (
  2      category_id INT,
  3      category_name VARCHAR(50) ,
  4      description VARCHAR(200),
  5      tax_rate INT,
  6      active_status VARCHAR(20) ,
  7      created_date DATE NOT NULL,
  8      updated_date DATE,
  9      CONSTRAINT pk_category PRIMARY KEY (category_id)      -- PK at end
 10  );

Table created.

SQL> desc Category
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 CATEGORY_ID                               NOT NULL NUMBER(38)
 CATEGORY_NAME                                      VARCHAR2(50)
 DESCRIPTION                                        VARCHAR2(200)
 TAX_RATE                                           NUMBER(38)
 ACTIVE_STATUS                                      VARCHAR2(20)
 CREATED_DATE                              NOT NULL DATE
 UPDATED_DATE                                       DATE


SQL> ALTER TABLE Category
  2  ADD CONSTRAINT uq_category_name UNIQUE (category_name);

Table altered.


SQL> alter table customer modify customer_email varchar(30);

Table altered.

SQL> ALTER TABLE Category
  2  ADD CONSTRAINT chk_medicine_price_pos
  3  ;

Table altered.
SQL> CREATE TABLE Batch (
  2      batch_id INT,
  3      medicine_id INT ,
  4      batch_no VARCHAR(50) ,
  5      manufacture_date DATE ,
  6      expiry_date DATE,
  7      quantity_received INT ,
  8      quantity_available INT ,
  9      cost_price INT
 10  );

Table created.

SQL> desc Batch
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 BATCH_ID                                           NUMBER(38)
 MEDICINE_ID                                        NUMBER(38)
 BATCH_NO                                           VARCHAR2(50)
 MANUFACTURE_DATE                                   DATE
 EXPIRY_DATE                                        DATE
 QUANTITY_RECEIVED                                  NUMBER(38)
 QUANTITY_AVAILABLE                                 NUMBER(38)
 COST_PRICE                                         NUMBER(38)

SQL> ALTER TABLE Batch
  2  ADD CONSTRAINT pk_batch PRIMARY KEY (batch_id);

Table altered.

SQL> ALTER TABLE Batch
  2  ADD CONSTRAINT chk_batch_dates
  3      CHECK (expiry_date > manufacture_date);

Table altered.

SQL> ALTER TABLE category add constraint c1 foreignkey (category_name)references Medicine(category_name);

Table altered

SQL> ALTER TABLE category drop constraint c1;

Table altered.
SQL> CREATE TABLE EmployeeHaveCustomer (
  2      employee_id INT ,
  3      customer_id INT ,
  4      assigned_date DATE NOT NULL,
  5      notes VARCHAR(200)
  6  );

Table created.

SQL> desc EmployeeHaveCustomer
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 EMPLOYEE_ID                                        NUMBER(38)
 CUSTOMER_ID                                        NUMBER(38)
 ASSIGNED_DATE                             NOT NULL DATE
 NOTES                                              VARCHAR2(200)

SQL> ALTER TABLE EmployeeHaveCustomer
  2  ADD CONSTRAINT pk_emp_have_cust
  3      PRIMARY KEY (employee_id, customer_id);

Table altered.

SQL> ALTER TABLE Customer
  2  RENAME COLUMN customer_phone TO mobile_no;

Table altered.

SQL> desc Customer
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 CUSTOMER_ID                               NOT NULL NUMBER(38)
 CUSTOMER_NAME                             NOT NULL VARCHAR2(20)
 MOBILE_NO                                          VARCHAR2(15)
 CUSTOMER_EMAIL                                     VARCHAR2(50)
 CUSTOMER_ADDRESS                                   VARCHAR2(100)
 REGISTRATION_DATE                         NOT NULL DATE

SQL> desc Medicine
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 MEDICINE_ID                               NOT NULL NUMBER(38)
 CATEGORY_ID                                        NUMBER(38)
 MEDICINE_NAME                                      VARCHAR2(20)
 BRAND                                              VARCHAR2(50)
 UNITSIZE                                           NUMBER(38)
 MRP                                                NUMBER(38)
 GST                                                NUMBER(38)
 SELLING_PRICE                                      NUMBER(38)

SQL> ALTER TABLE Medicine
  2  RENAME COLUMN BRAND TO medicine_brand;

Table altered.

SQL> desc Medicine
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 MEDICINE_ID                               NOT NULL NUMBER(38)
 CATEGORY_ID                                        NUMBER(38)
 MEDICINE_NAME                                      VARCHAR2(20)
 MEDICINE_BRAND                                     VARCHAR2(50)
 UNITSIZE                                           NUMBER(38)
 MRP                                                NUMBER(38)
 GST                                                NUMBER(38)
 SELLING_PRICE                                      NUMBER(38)

SQL> desc supplier
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SUPPLIER_ID                               NOT NULL NUMBER(38)
 SUPPLIER_NAME                                      VARCHAR2(20)
 CONTACT_PERSON                                     VARCHAR2(20)
 SUPPLIER_PHONE                                     VARCHAR2(15)
 SUPPLIER_EMAIL                                     VARCHAR2(50)
 SUPPLIER_ADDRESS                                   VARCHAR2(200)
 GST_NUMBER                                         VARCHAR2(20)

SQL> ALTER TABLE Supplier
  2  RENAME TO SupplierMaster;

Table altered.

SQL> ALTER TABLE SupplierMaster
  2  DROP COLUMN gst_number;

Table altered.

SQL> desc supplierMaster
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SUPPLIER_ID                               NOT NULL NUMBER(38)
 SUPPLIER_NAME                                      VARCHAR2(20)
 CONTACT_PERSON                                     VARCHAR2(20)
 SUPPLIER_PHONE                                     VARCHAR2(15)
 SUPPLIER_EMAIL                                     VARCHAR2(50)
 SUPPLIER_ADDRESS                                   VARCHAR2(200)

SQL> TRUNCATE TABLE Customer;
Table truncated.

SQL> desc Customer
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 CUSTOMER_ID                               NOT NULL NUMBER(38)
 CUSTOMER_NAME                             NOT NULL VARCHAR2(20)
 MOBILE_NO                                          VARCHAR2(15)
 CUSTOMER_EMAIL                                     VARCHAR2(50)
 CUSTOMER_ADDRESS                                   VARCHAR2(100)
 REGISTRATION_DATE                         NOT NULL DATE

