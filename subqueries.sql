SQL> select * from medicine;
MEDICINE_ID     CAT_ID MEDICINE_NAME        MEDICINE_BRAND                                       UNITSIZE        MRP       GST SELLING_PRICE PRESCRIPTION_RE SUPPLIER_ID
----------- ---------- -------------------- -------------------------------------------------- ---------- ---------- ---------- ------------- --------------- -----------
        201          1 Paracetamol          Cipla                                                      10        100         5    110 NO                      101
        202          1 Ibuprofen            Sun Pharma                                                 10        150         5    165 NO                      101
        203          2 Cough Syrup          Zydus                                                       1        120        12    135 YES                     102
        204          3 Insulin              Novo                                                        1        600        18    650 YES                     102
        205          2 Vitamin Syrup        HealthPlus                                                  1         80        12     90 NO                      101
        206          1 Dolo                 Micro                                                      10        300         5    450 NO                      101

6 rows selected.

SQL> select medicine_name, selling_price
  2  from medicine
  3  where selling_price = (select max(selling_price) from medicine);

MEDICINE_NAME        SELLING_PRICE
-------------------- -------------
Insulin                        650

SQL> SELECT medicine_name, selling_price
  2  FROM medicine
  3  WHERE selling_price >
  4        (SELECT AVG(selling_price) FROM medicine);

MEDICINE_NAME        SELLING_PRICE
-------------------- -------------
Insulin                        650
Dolo                           450

SQL> select medicine_name, medicine_id
  2  from medicine
  3  where medicine_id in (select medicine_id from batch);

MEDICINE_NAME        MEDICINE_ID
-------------------- -----------
Paracetamol                  201
Ibuprofen                    202
Insulin                      204

SQL> select medicine_name, medicine_id
  2  from medicine
  3  where medicine_id not in (select medicine_id from batch);

MEDICINE_NAME        MEDICINE_ID
-------------------- -----------
Dolo                         206
Cough Syrup                  203
Vitamin Syrup                205


SQL> select medicine_name, selling_price
  2  from medicine
  3  where selling_price > any (select selling_price from medicine where selling_price > 100);

MEDICINE_NAME        SELLING_PRICE
-------------------- -------------
Ibuprofen                      165
Cough Syrup                    135
Insulin                        650
Dolo                           450

SQL> select medicine_name, selling_price
  2  from medicine
  3  where selling_price > all (select selling_price from medicine where selling_price < 100);

MEDICINE_NAME        SELLING_PRICE
-------------------- -------------
Paracetamol                    110
Cough Syrup                    135
Ibuprofen                      165
Dolo                           450
Insulin                        650

SQL> select batch_id, cost_price
  2  from batch
  3  where cost_price < all (select cost_price from batch where cost_price > 500);

  BATCH_ID COST_PRICE
---------- ----------
       303        140
       302         95
       301         90

SQL> select batch_id, cost_price
  2  from batch
  3  where cost_price < any (select cost_price from batch where cost_price > 500);

  BATCH_ID COST_PRICE
---------- ----------
       301         90
       302         95
       303        140

SQL> select medicine_name, selling_price
  2  from medicine
  3  where selling_price = all
  4  (select selling_price from medicine
  5   where selling_price <= all
  6         (select selling_price from medicine));

MEDICINE_NAME        SELLING_PRICE
-------------------- -------------
Vitamin Syrup                   90

SQL> select medicine_name, medicine_id
  2  from medicine
  3  where medicine_id = any
  4  (select medicine_id from batch);

MEDICINE_NAME        MEDICINE_ID
-------------------- -----------
Paracetamol                  201
Ibuprofen                    202
Insulin                      204


SQL> select medicine_name, cat_id, gst
  2  from medicine m1
  3  where (cat_id, gst) in
  4  (select cat_id, gst from medicine m2
  5   where m1.medicine_id != m2.medicine_id);

MEDICINE_NAME            CAT_ID        GST
-------------------- ---------- ----------
Ibuprofen                     1          5
Dolo                          1          5
Paracetamol                   1          5
Vitamin Syrup                 2         12
Cough Syrup                   2         12

SQL> select batch_id, quantity_available
  2  from batch b1
  3  where quantity_available >
  4  (select avg(quantity_available)
  5   from batch b2
  6   where b1.medicine_id = b2.medicine_id);

  BATCH_ID QUANTITY_AVAILABLE
---------- ------------------
       302                100

SQL> select medicine_id, sum(quantity_available) as total_quantity
  2  from (select medicine_id, quantity_available from batch)
  3  group by medicine_id;

MEDICINE_ID TOTAL_QUANTITY
----------- --------------
        201            180
        202            130
        204             40

SQL> SELECT customer_name,
  2         (SELECT COUNT(*)
  3          FROM discount d
  4          WHERE UPPER(d.active_status) = 'ACTIVE')
  5         AS total_active_discounts
  6  FROM customer;

CUSTOMER_NAME        TOTAL_ACTIVE_DISCOUNTS
-------------------- ----------------------
Karthik                                   2
Arun                                      2
Bala                                      2


QL> select medicine_id, sum(quantity_available)
  2  from batch
  3  group by medicine_id
  4  having sum(quantity_available) >
  5  (select avg(quantity_available) from batch);

MEDICINE_ID SUM(QUANTITY_AVAILABLE)
----------- -----------------------
        201                     180
        202                     130

SQL> select medicine_name, medicine_id
  2  from medicine m
  3  where exists (select 1 from batch b
  4                where m.medicine_id = b.medicine_id);

MEDICINE_NAME        MEDICINE_ID
-------------------- -----------
Paracetamol                  201
Ibuprofen                    202
Insulin                      204

SQL> select medicine_name, medicine_id
  2  from medicine m
  3  where not exists (select 1 from batch b
  4                    where m.medicine_id = b.medicine_id);

MEDICINE_NAME        MEDICINE_ID
-------------------- -----------
Dolo                         206
Cough Syrup                  203
Vitamin Syrup                205

SQL> with avgprice as
  2  (select avg(selling_price) as avg_price from medicine)
  3  select medicine_name, selling_price
  4  from medicine
  5  where selling_price > (select avg_price from avgprice);

MEDICINE_NAME        SELLING_PRICE
-------------------- -------------
Insulin                        650
Dolo                           450

SQL> select medicine_name,
  2  (select category_name from category c
  3   where c.category_id = m.cat_id) as category_name
  4  from medicine m;

MEDICINE_NAME        CATEGORY_NAME
-------------------- --------------------------------------------------
Paracetamol          Tablet
Ibuprofen            Tablet
Cough Syrup          Syrup
Insulin              Injection
Vitamin Syrup        Syrup
Dolo                 Tablet

6 rows selected.

SQL> select customer_name, age
  2  from customer
  3  where age > (select avg(age) from customer);

CUSTOMER_NAME               AGE
-------------------- ----------
Bala                         35


SQL> with total_batch as (
  2      select medicine_id, sum(quantity_available) as total_qty
  3      from batch
  4      group by medicine_id),
  5  avg_batch as (
  6      select avg(quantity_available) as avg_qty
  7      from batch)
  8  select t.medicine_id, t.total_qty
  9  from total_batch t
 10  where t.total_qty > (select avg_qty from avg_batch);

MEDICINE_ID  TOTAL_QTY
----------- ----------
        201        180
        202        130



[24bcsl03@mepcolinux sql]$exit
exit
