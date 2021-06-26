USE ShoppingStrom;

--Query 1

GO
CREATE FUNCTION PriceRangeProduct(@MinPrice int, @MaxPrice int)
RETURNS Table AS
RETURN(
		SELECT * FROM Product WHERE Price BETWEEN @MinPrice AND @MaxPrice
);
GO

GO
CREATE FUNCTION PriceRangeWithPType(@MinPrice int, @MaxPrice int, @product_Type varchar(30))
RETURNS Table AS
RETURN(
		SELECT * FROM Product WHERE (Price BETWEEN @MinPrice AND @MaxPrice) AND Type = @product_Type
);
GO

SELECT * FROM PriceRangeProduct(2000, 10000);
SELECT * FROM PriceRangeWithPType(2000, 10000,'FootWear');
SELECT * FROM PriceRangeWithPType(2000, 10000,'Clothes');

--Query 2

SELECT Cart_ID, SUM(Product.Price) AS TotalPrice 
FROM Cart_Product INNER Join Product ON Cart_Product.Product_ID = Product.Product_ID
Group by Cart_ID;

GO
CREATE FUNCTION CartProductsPriceTotal(@CartID varchar(5))
RETURNS int AS
BEGIN
RETURN(
		SELECT SUM(Product.Price) AS TotalPrice 
		FROM Cart_Product INNER Join Product ON Cart_Product.Product_ID = Product.Product_ID
		WHERE Cart_ID = @CartID
		Group by Cart_ID
);
END
GO

SELECT dbo.CartProductsPriceTotal ('CI001') AS Total_Price;

--Query 3

SELECT Reviews.Product_ID, AVG(Reviews.Rate) AS Rating 
FROM Reviews INNER Join Product ON Reviews.Product_ID = Product.Product_ID
Group by Reviews.Product_ID;

GO
CREATE FUNCTION ChackReviews(@ProductID varchar(5))
RETURNS FLOAT AS
BEGIN
RETURN(
		SELECT AVG(Reviews.Rate) AS Rating 
		FROM Reviews INNER Join Product ON Reviews.Product_ID = Product.Product_ID
		WHERE Product.Product_ID = @ProductID
		Group by Reviews.Product_ID
);
END
GO

SELECT dbo.ChackReviews('PR012') AS Rating;

--Query 4
SELECT * FROM Product WHERE Category_ID = 'CA010';
SELECT * FROM Product WHERE AddBy = 'AD002';
