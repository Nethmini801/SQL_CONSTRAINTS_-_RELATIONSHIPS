create database Shop;

use Shop;


create table Customer(
CUS_ID INT(4) AUTO_INCREMENT,
F_NAME VARCHAR(30)  NOT NULL,
L_NAME VARCHAR(30) NOT NULL,
PHONE_NO VARCHAR(12) UNIQUE,
PRIMARY KEY(CUS_ID)

);

INSERT INTO customer (f_name,l_name,phone_no ) VALUES ("Kamal","Perera","0710023552");
INSERT INTO customer (f_name,l_name,phone_no ) VALUES ("Nimal","Perera","0710883552");
INSERT INTO customer (Cus_id, f_name,l_name,phone_no ) VALUES (50,"Sunil","Perera","0710800052");
INSERT INTO customer (f_name,l_name,phone_no ) VALUES ("Amal","Perera","0750883552");

/*
mysql> desc Customer;
+----------+-------------+------+-----+---------+----------------+
| Field    | Type        | Null | Key | Default | Extra          |
+----------+-------------+------+-----+---------+----------------+
| CUS_ID   | int         | NO   | PRI | NULL    | auto_increment |
| F_NAME   | varchar(30) | NO   |     | NULL    |                |
| L_NAME   | varchar(30) | NO   |     | NULL    |                |
| PHONE_NO | varchar(12) | YES  | UNI | NULL    |                |
+----------+-------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)


mysql> select * from Customer;
+--------+--------+--------+------------+
| CUS_ID | F_NAME | L_NAME | PHONE_NO   |
+--------+--------+--------+------------+
|      1 | Kamal  | Perera | 0710023552 |
|      2 | Nimal  | Perera | 0710883552 |
|     50 | Sunil  | Perera | 0710800052 |
|     51 | Amal   | Perera | 0750883552 |
+--------+--------+--------+------------+
4 rows in set (0.00 sec)

*/


-- -----------------------------------------------------------------------------------------------
create table Item(
ITEM_ID VARCHAR(5) ,
NAME VARCHAR(40) NOT NULL,
QOH INT(5) NOT NULL,
PRIMARY KEY(ITEM_ID )
);

INSERT INTO item VALUES 
('I001',"Sugar",80),
('I002',"Coconut",100),
('I003',"Oil",50);

/*
mysql> desc Item;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| ITEM_ID | varchar(5)  | NO   | PRI | NULL    |       |
| NAME    | varchar(40) | NO   |     | NULL    |       |
| QOH     | int         | NO   |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM item;

+---------+---------+-----+
| ITEM_ID | NAME    | QOH |
+---------+---------+-----+
| I001    | Sugar   |  80 |
| I002    | Coconut | 100 |
| I003    | Oil     |  50 |
+---------+---------+-----+
3 rows in set (0.00 sec)
*/

-- ------------------------------------------------------------------------------------------


create table Batch(
BATCH_ID VARCHAR(5),
UNIT_PRICE DECIMAL(9,2) NOT NULL,
QOH INT(5) NOT NULL,
ITEM_TID VARCHAR(5),
PRIMARY KEY(BATCH_ID),
FOREIGN KEY(ITEM_TID) REFERENCES Item(ITEM_ID)
);

INSERT INTO batch VALUES 
('B001',100.00,20,'I001'),
('B002',120.00,10,'I002'),
('B003',380.00,5,'I003');

-- if there is a different batch of sugar

INSERT INTO batch VALUES 
('B004',110.00,10,'I001');

/*
mysql> desc Batch;
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| BATCH_ID   | varchar(5)   | NO   | PRI | NULL    |       |
| UNIT_PRICE | decimal(9,2) | NO   |     | NULL    |       |
| QOH        | int          | NO   |     | NULL    |       |
| ITEM_TID   | varchar(5)   | YES  | MUL | NULL    |       |
+------------+--------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> select * from Batch;
+----------+------------+-----+----------+
| BATCH_ID | UNIT_PRICE | QOH | ITEM_TID |
+----------+------------+-----+----------+
| B001     |     100.00 |  20 | I001     |
| B002     |     120.00 |  10 | I002     |
| B003     |     380.00 |   5 | I003     |
| B004     |     110.00 |  10 | I001     |
+----------+------------+-----+----------+
4 rows in set (0.00 sec)
*/
-- ------------------------------------------------------------------------------------------

create table Orders(
ORDER_ID INT(4) AUTO_INCREMENT,
CREATE_DATE  DATE NOT NULL,
TOTAL_AMOUNT DECIMAL(9,2) NOT NULL,
DISCOUNT  DECIMAL(9,2),
CUSTOMER_TID INT(5), 
PRIMARY KEY(ORDER_ID),
FOREIGN KEY(CUSTOMER_TID) REFERENCES Customer(CUS_ID)
);

insert into Orders values
(001,20230318,5005.00,500.00,1),
(002,20230317,4500.00,400.00,1),
(003,20230317,4800.00,480.00,2);

/*
mysql> desc Orders;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| ORDER_ID     | int          | NO   | PRI | NULL    | auto_increment |
| CREATE_DATE  | date         | NO   |     | NULL    |                |
| TOTAL_AMOUNT | decimal(9,2) | NO   |     | NULL    |                |
| DISCOUNT     | decimal(9,2) | YES  |     | NULL    |                |
| CUSTOMER_TID | int          | YES  | MUL | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)


mysql> select * from Orders;
+----------+-------------+--------------+----------+--------------+
| ORDER_ID | CREATE_DATE | TOTAL_AMOUNT | DISCOUNT | CUSTOMER_TID |
+----------+-------------+--------------+----------+--------------+
|        1 | 2023-03-18  |      5005.00 |   500.00 |            1 |
|        2 | 2023-03-17  |      4500.00 |   400.00 |            1 |
|        3 | 2023-03-17  |      4800.00 |   480.00 |            2 |
+----------+-------------+--------------+----------+--------------+
3 rows in set (0.00 sec)

*****Above Order table contains the details of the Orders ***
*/
-- ------------------------------------------------------------------------------------------
/*
****Below Order_Details table contain the the item details according to each Order ****
*/

create table Order_Details(

OD_ID INT(4),
BATCH_TID VARCHAR(5),
QTY DECIMAL(5,2) NOT NULL,
UNIT_PRICE DECIMAL(9,2) NOT NULL,
DISCOUNT DECIMAL(9,2) NOT NULL,
PRIMARY KEY(OD_ID,BATCH_TID),
FOREIGN KEY (OD_ID) REFERENCES Orders(ORDER_ID),
FOREIGN KEY (BATCH_TID) REFERENCES Batch(BATCH_ID)
);



-- item details of order_id=1

insert into Order_Details values 
(1,'B001',2,100.00,0.00),
(1,'B002',4,80.00,0.00),
(1,'B003',3,120.00,20.00);

-- item details of order_id=2

INSERT INTO order_details VALUES 
(2,'B001',1,100.00,0.00),
(2,'B002',1,80.00,0.00);
 
/*

mysql> desc Order_Details;
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| OD_ID      | int          | NO   | PRI | NULL    |       |
| BATCH_TID  | varchar(5)   | NO   | PRI | NULL    |       |
| QTY        | decimal(5,2) | NO   |     | NULL    |       |
| UNIT_PRICE | decimal(9,2) | NO   |     | NULL    |       |
| DISCOUNT   | decimal(9,2) | NO   |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
5 rows in set (0.00 sec)


mysql> select * from Order_Details;
+-------+-----------+------+------------+----------+
| OD_ID | BATCH_TID | QTY  | UNIT_PRICE | DISCOUNT |
+-------+-----------+------+------------+----------+
|     1 | B001      | 2.00 |     100.00 |     0.00 |
|     1 | B002      | 4.00 |      80.00 |     0.00 |
|     1 | B003      | 3.00 |     120.00 |    20.00 |
|     2 | B001      | 1.00 |     100.00 |     0.00 |
|     2 | B002      | 1.00 |      80.00 |     0.00 |
+-------+-----------+------+------------+----------+
5 rows in set (0.00 sec)
*/
-- ---------------------------------------------------------------------------------Thank you------------------------------------------------------------------------------

