CREATE DATABASE ShoppingStrom;
USE ShoppingStrom;

CREATE TABLE Admin(
	Admin_ID varchar(5) PRIMARY KEY,
	F_Name varchar(15) NOT NULL,
	L_Name varchar(20),
	DOB DATE CHECK (DOB < SYSDATETIME()),
	Age INT CHECK (Age > 5),
	Email varchar(30) UNIQUE NOT NULL,
	Password varchar(20) NOT NULL,
	Address varchar(225),
	Gender char(1) CHECK (Gender = 'F' OR Gender = 'M') NOT NULL, 
	Phone_No varchar(15)
);

CREATE TABLE Customer(
	Customer_ID varchar(5) PRIMARY KEY,
	F_Name varchar(15) NOT NULL,
	L_Name varchar(20),
	DOB DATE CHECK (DOB < SYSDATETIME()),
	Age INT CHECK (Age > 0),
	Email varchar(30) UNIQUE NOT NULL,
	Password varchar(20) NOT NULL,
	Address varchar(225),
	Gender char(1) CHECK (Gender = 'F' OR Gender = 'M') NOT NULL, 
	Phone_No varchar(15)
);

CREATE TABLE Categories(
	Category_ID varchar(5) PRIMARY KEY,
	Category_Name varchar(25) CHECK (Category_Name IN ('Sneakers', 'Flip-Flops', 
	'Sandals', 'Slippers', 'Loafers','joggers','Baggy Pants', 'Jeans','Palazzo', 
	'Straight Pants','Leggings', 'Dress pants','Check pants',' Oxford Button-Down',
	'Dress Shirt','Overshirt','Flannel Shirt','Office Shirt','Linen Shirt')),
	Category_Type varchar(10) CHECK (Category_Type IN ('Formal', 'InFormal', 'Casual'))
);

CREATE TABLE Product(
	Product_ID varchar(5) PRIMARY KEY,
	Title varchar(35) NOT NULL,
	Brand_Name varchar(20),
	Color varchar(15),
	Size varchar(15) NOT NULL,
	Description varchar(225),
	Price integer NOT NULL Default 0,
	For_Gender char(1) CHECK (For_Gender = 'F' OR For_Gender = 'M' OR For_Gender = 'B')
	NOT NULL Default 'B',
	Type varchar(30) NOT NULL CHECK (Type = 'FootWear' OR Type = 'Clothes'),
	Quantity integer default 1,
	AddBy varchar(5) FOREIGN KEY REFERENCES Admin(Admin_ID),
	Category_ID varchar(5) FOREIGN KEY REFERENCES Categories(Category_ID)
);


CREATE TABLE Images(
	Product_ID varchar(5) FOREIGN KEY REFERENCES Product(product_ID) NOT NUll,
	ImageSource varchar(255),
	CONSTRAINT PK_Images PRIMARY KEY (Product_ID, ImageSource)
);

CREATE TABLE Cart(
	Cart_ID varchar(5) PRIMARY KEY,
	Customer_ID varchar(5) FOREIGN KEY REFERENCES Customer(Customer_ID) NOT NULL
);

CREATE TABLE Cart_Product(
	Cart_ID varchar(5) FOREIGN KEY REFERENCES Cart(Cart_ID),
	Product_ID varchar(5) FOREIGN KEY REFERENCES Product(product_ID) NOT NUll,
	CONSTRAINT PK_Cart_Product PRIMARY KEY (Cart_ID,Product_ID)
);

CREATE TABLE Reviews(
	Review_ID varchar(5) PRIMARY KEY,
	Product_ID varchar(5) FOREIGN KEY REFERENCES Product(product_ID) NOT NUll,
	Customer_ID varchar(5) FOREIGN KEY REFERENCES Customer(Customer_ID) NOT NULL,
	Rate integer CHECK (Rate BETWEEN 1 AND 5)
);

CREATE TABLE Card_Info(
	Card_ID varchar(20) PRIMARY KEY,
	Card_Type varchar(10) CHECK (Card_Type IN ('Bank', 'EasyPaisa', 'JazzCssh')),
	Customer_ID varchar(5) FOREIGN KEY REFERENCES Customer(Customer_ID) NOT NULL
);

CREATE TABLE Orders(
	Order_ID varchar(5) PRIMARY KEY,
	Address varchar(255) NOT NULL,
	Amount integer CHECK (Amount >= 0),-- cart product sum
	Cart_ID varchar(5) FOREIGN KEY REFERENCES Cart(Cart_ID) NOT NULL,
	Card_No varchar(20) FOREIGN KEY REFERENCES Card_Info(Card_ID) NOT NULL
);

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE';