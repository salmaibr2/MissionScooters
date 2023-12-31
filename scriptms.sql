
CREATE TABLE [dbo].[Customers](
	[Customer_ID] [int] NOT NULL,
	[Customer_FirstName] [varchar](50) NOT NULL,
	[Customer_LastName] [varchar](50) NOT NULL,
	[Customer_Email] [varchar](100) NOT NULL,
	[Customer_Phone] [varchar](15) NULL,
	[Address_ID] [int] NOT NULL,
	[Customer_Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomerInfo]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerInfo] AS
SELECT Customer_FirstName + ' ' + Customer_LastName AS Customer_Name, 
       Customer_Email, 
       Customer_ID
FROM Customers;
GO
/****** Object:  Table [dbo].[Vendor]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendor](
	[Vendor_ID] [int] IDENTITY(1,1) NOT NULL,
	[Vendor_CompanyName] [nvarchar](255) NOT NULL,
	[Vendor_Address] [nvarchar](255) NOT NULL,
	[Vendor_ContactName] [nvarchar](255) NOT NULL,
	[Vendor_ContactPhone] [nvarchar](255) NOT NULL,
	[Vendor_ContactEmail] [nvarchar](255) NOT NULL,
	[Vendor_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Vendor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendor_Purchase_Order]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendor_Purchase_Order](
	[VPO_ID] [int] IDENTITY(1,1) NOT NULL,
	[Vendor_ID] [int] NOT NULL,
	[Product_ID] [numeric](10, 0) NOT NULL,
	[VPO_ProductQuantity] [int] NOT NULL,
	[VPO_ProductPrice] [int] NOT NULL,
	[VPO_ProductTotal] [int] NOT NULL,
	[VPO_TotalAmount] [int] NOT NULL,
	[VPO_PaymentMethod] [int] NOT NULL,
	[VPO_PaymentStatus] [int] NOT NULL,
	[VPO_ProductReceived] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VPO_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Product_ID] [numeric](10, 0) NOT NULL,
	[Product_Name] [varchar](50) NULL,
	[Product_Status] [int] NULL,
	[Product_Price] [int] NULL,
	[Description] [varchar](500) NULL,
	[Product_Quantity] [int] NULL,
	[Reorder_Level] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Product_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vendor_and_Purchases]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE VIEW [dbo].[Vendor_and_Purchases] AS
  SELECT A.Vendor_CompanyName, C.Product_ID, C.Product_Name, B.VPO_ProductQuantity, (C.Product_Price - B.VPO_ProductPrice) as ProfitPerUnit, (C.Product_Price - B.VPO_ProductPrice) * B.VPO_ProductQuantity as TotalProfit
  FROM [cis55_49].[dbo].[Vendor] A
  INNER JOIN [cis55_49].[dbo].[Vendor_Purchase_Order] B ON A.Vendor_ID = B.Vendor_ID
  INNER JOIN [cis55_49].[dbo].[Products] C ON B.Product_ID = C.Product_ID;
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[User_ID] [int] NOT NULL,
	[Customer_ID] [int] NULL,
	[User_Password] [nvarchar](30) NULL,
	[User_Email] [nvarchar](30) NULL,
	[User_Status] [bit] NULL,
	[User_Phone_Number] [nchar](10) NULL,
	[User_Creation_Date] [date] NULL,
	[User_Last_Login] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment_Method]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Method](
	[payment_method_ID] [int] NOT NULL,
	[Method_Name] [nvarchar](50) NULL,
	[description] [nvarchar](100) NULL,
	[payment_method_status] [nvarchar](20) NULL,
	[User_ID] [int] NOT NULL,
	[card_number] [varchar](16) NULL,
	[exp_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_method_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Customers_Payment_Cards]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Customers_Payment_Cards] as
Select Customers.Customer_FirstName, Customers.Customer_LastName, Payment_Method.Method_Name, Payment_Method.card_number, Payment_Method.exp_date
from Payment_Method 
Join [User] on Payment_Method.User_ID= [User].User_ID
join [Customers] on [User].Customer_ID= Customers.Customer_ID
GO
/****** Object:  Table [dbo].[Address]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[AddressID] [int] NOT NULL,
	[Street] [varchar](200) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](5) NULL,
	[Address_Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomersAddresses]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CustomersAddresses] AS
SELECT [Customer_ID] ,[Customer_FirstName],[Customer_LastName],
	   [Address].Street, [Address].City, [Address].State, [Address].Zip
FROM [cis55_49].[dbo].[Customers]
JOIN [cis55_49].[dbo].[Address] ON Address.AddressID = Customers.Address_ID;
GO
/****** Object:  Table [dbo].[Shipping]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipping](
	[Shipping_ID] [int] NOT NULL,
	[Shipping_Status] [varchar](200) NULL,
	[Shipping_Method] [varchar](200) NULL,
	[Shipping_Price] [float] NULL,
	[Shipping_Distance] [float] NULL,
	[Shipping_Address_ID] [int] NULL,
	[Order_ID] [varchar](50) NULL,
	[Order_Date] [date] NULL,
	[Carrier] [varchar](200) NULL,
	[Estimated_Delivery_Date] [date] NULL,
	[Package_Weight] [float] NULL,
	[Tracking_Number] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Shipping_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Shipping_status_item]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Shipping_status_item] AS
SELECT Shipping_Status FROM Shipping;
GO
/****** Object:  Table [dbo].[Customer_Order]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Order](
	[order_id] [varchar](50) NOT NULL,
	[order_date] [date] NOT NULL,
	[order_name] [varchar](50) NOT NULL,
	[order_address] [varchar](75) NOT NULL,
	[order_billing_address] [varchar](75) NOT NULL,
	[Customer_ID] [int] NOT NULL,
	[order_status] [int] NULL,
	[order_total_amount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[payment_ID] [int] NOT NULL,
	[order_ID] [varchar](50) NULL,
	[payment_amount] [int] NULL,
	[payment_method_ID] [int] NULL,
	[payment_date] [date] NULL,
	[payment_status] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomerOrdersPerMonth]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerOrdersPerMonth] AS
SELECT COUNT(*) AS OrdersPerMonth
FROM cis55_49.dbo.Customer_Order AS C
INNER JOIN cis55_49.dbo.Payment AS P
ON C.order_id=P.order_ID;
GO
/****** Object:  Table [dbo].[OrderLineItem]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLineItem](
	[order_line_item_id] [varchar](100) NOT NULL,
	[order_line_item_status] [varchar](25) NOT NULL,
	[order_id] [varchar](50) NOT NULL,
	[order_line_amount] [int] NOT NULL,
	[product_id] [numeric](10, 0) NOT NULL,
	[order_line_quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_line_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[STATE_Profits]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[STATE_Profits] AS
SELECT Address.State,
 SUM( ([Products].Product_Price - [VPO_ProductPrice]) * [OrderLineItem].order_line_quantity) as TotalProfits

  FROM [dbo].[Vendor_Purchase_Order]
  JOIN [dbo].[Products] ON [Vendor_Purchase_Order].Product_ID = Products.Product_ID
  JOIN [dbo].[OrderLineItem] ON [ORDERLINEiTEM].product_id = [Vendor_Purchase_Order].Product_ID
  JOIN Customer_Order ON Customer_Order.order_id = OrderLineItem.order_id
  JOIN Customers ON Customers.Customer_ID = Customer_Order.Customer_ID
  JOIN Address ON Address.AddressID = CUSTOMERS.Address_ID
  group by State;
GO
/****** Object:  Table [dbo].[Asset]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asset](
	[Asset_ID] [int] NOT NULL,
	[Order_ID] [varchar](50) NOT NULL,
	[Product_ID] [numeric](10, 0) NOT NULL,
	[Asset_Status] [bit] NULL,
	[Serial_Number] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Asset_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer_Service_Agent]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Service_Agent](
	[Customer_Service_ID] [int] NOT NULL,
	[User_ID] [int] NULL,
	[CSA_name] [varchar](255) NOT NULL,
	[Customer_Service_Status] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Customer_Service_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 10/24/2023 4:48:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[Inventory_ID] [int] NOT NULL,
	[Inventory_Status] [bit] NULL,
	[Product_ID] [numeric](10, 0) NULL,
	[Serial_Number] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Inventory_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Address] ([AddressID], [Street], [City], [State], [Zip], [Address_Status]) VALUES (1, N'123 Main St', N'Los Angeles', N'CA', N'90001', 1)
INSERT [dbo].[Address] ([AddressID], [Street], [City], [State], [Zip], [Address_Status]) VALUES (2, N'456 Elm St', N'New York', N'NY', N'10001', 0)
INSERT [dbo].[Address] ([AddressID], [Street], [City], [State], [Zip], [Address_Status]) VALUES (3, N'789 Oak St', N'Chicago', N'IL', N'60007', 1)
INSERT [dbo].[Address] ([AddressID], [Street], [City], [State], [Zip], [Address_Status]) VALUES (4, N'101 Maple St', N'San Francisco', N'CA', N'94016', 0)
INSERT [dbo].[Address] ([AddressID], [Street], [City], [State], [Zip], [Address_Status]) VALUES (5, N'716 Coco St', N'Seattle', N'WA', N'12098', 0)
GO
INSERT [dbo].[Asset] ([Asset_ID], [Order_ID], [Product_ID], [Asset_Status], [Serial_Number]) VALUES (4010039, N'EXM11050', CAST(3 AS Numeric(10, 0)), 1, 230530003)
INSERT [dbo].[Asset] ([Asset_ID], [Order_ID], [Product_ID], [Asset_Status], [Serial_Number]) VALUES (4064621, N'EXM11052', CAST(4 AS Numeric(10, 0)), 1, 230810005)
INSERT [dbo].[Asset] ([Asset_ID], [Order_ID], [Product_ID], [Asset_Status], [Serial_Number]) VALUES (4110039, N'EXM11051', CAST(2 AS Numeric(10, 0)), 1, 230120002)
INSERT [dbo].[Asset] ([Asset_ID], [Order_ID], [Product_ID], [Asset_Status], [Serial_Number]) VALUES (4390876, N'EXM11053', CAST(5 AS Numeric(10, 0)), 1, 230920010)
INSERT [dbo].[Asset] ([Asset_ID], [Order_ID], [Product_ID], [Asset_Status], [Serial_Number]) VALUES (4810039, N'EXM11054', CAST(5 AS Numeric(10, 0)), 1, 230920019)
GO
INSERT [dbo].[Customer_Order] ([order_id], [order_date], [order_name], [order_address], [order_billing_address], [Customer_ID], [order_status], [order_total_amount]) VALUES (N'EXM11050', CAST(N'2023-08-23' AS Date), N'John Doe', N'123 Main St', N'123 Main St', 1, 1, 999)
INSERT [dbo].[Customer_Order] ([order_id], [order_date], [order_name], [order_address], [order_billing_address], [Customer_ID], [order_status], [order_total_amount]) VALUES (N'EXM11051', CAST(N'2023-08-24' AS Date), N'Jane Smith', N'456 Elm St', N'234 Cedar Ave', 2, 0, 4998)
INSERT [dbo].[Customer_Order] ([order_id], [order_date], [order_name], [order_address], [order_billing_address], [Customer_ID], [order_status], [order_total_amount]) VALUES (N'EXM11052', CAST(N'2023-08-25' AS Date), N'Bob Johnson', N'789 Oak St', N'789 Oak St', 3, 1, 899)
INSERT [dbo].[Customer_Order] ([order_id], [order_date], [order_name], [order_address], [order_billing_address], [Customer_ID], [order_status], [order_total_amount]) VALUES (N'EXM11053', CAST(N'2023-08-25' AS Date), N'Alice Will', N'101 Maple St', N'101 Maple St', 4, 1, 4797)
INSERT [dbo].[Customer_Order] ([order_id], [order_date], [order_name], [order_address], [order_billing_address], [Customer_ID], [order_status], [order_total_amount]) VALUES (N'EXM11054', CAST(N'2023-08-26' AS Date), N'Ella Washington', N'716 Coco St', N'716 Coco St', 5, 1, 6396)
GO
INSERT [dbo].[Customer_Service_Agent] ([Customer_Service_ID], [User_ID], [CSA_name], [Customer_Service_Status]) VALUES (101, 6, N'Tim Luu', N'Active')
INSERT [dbo].[Customer_Service_Agent] ([Customer_Service_ID], [User_ID], [CSA_name], [Customer_Service_Status]) VALUES (102, 7, N'John Doe', N'Inactive')
INSERT [dbo].[Customer_Service_Agent] ([Customer_Service_ID], [User_ID], [CSA_name], [Customer_Service_Status]) VALUES (103, 8, N'David Johnson', N'On Leave')
INSERT [dbo].[Customer_Service_Agent] ([Customer_Service_ID], [User_ID], [CSA_name], [Customer_Service_Status]) VALUES (104, 9, N'Ethan Robles', N'Active')
INSERT [dbo].[Customer_Service_Agent] ([Customer_Service_ID], [User_ID], [CSA_name], [Customer_Service_Status]) VALUES (105, 10, N'Anthony Delgado', N'Active')
GO
INSERT [dbo].[Customers] ([Customer_ID], [Customer_FirstName], [Customer_LastName], [Customer_Email], [Customer_Phone], [Address_ID], [Customer_Status]) VALUES (1, N'John', N'Doe', N'jdoe@gmail.com', N'5551231234', 1, 1)
INSERT [dbo].[Customers] ([Customer_ID], [Customer_FirstName], [Customer_LastName], [Customer_Email], [Customer_Phone], [Address_ID], [Customer_Status]) VALUES (2, N'Jane', N'Smith', N'jsmith@yahoo.com', N'5559871234', 2, 0)
INSERT [dbo].[Customers] ([Customer_ID], [Customer_FirstName], [Customer_LastName], [Customer_Email], [Customer_Phone], [Address_ID], [Customer_Status]) VALUES (3, N'Bob', N'Johnson', N'bobj@outlook.com', N'5556784328', 3, 1)
INSERT [dbo].[Customers] ([Customer_ID], [Customer_FirstName], [Customer_LastName], [Customer_Email], [Customer_Phone], [Address_ID], [Customer_Status]) VALUES (4, N'Alice', N'Will', N'WillA@gmail.com', N'5559871230', 4, 1)
INSERT [dbo].[Customers] ([Customer_ID], [Customer_FirstName], [Customer_LastName], [Customer_Email], [Customer_Phone], [Address_ID], [Customer_Status]) VALUES (5, N'Ella', N'Washington', N'ellawash@yahoo.com', N'5557892345', 5, 1)
GO
INSERT [dbo].[Inventory] ([Inventory_ID], [Inventory_Status], [Product_ID], [Serial_Number]) VALUES (10030, 1, CAST(5 AS Numeric(10, 0)), 230920010)
INSERT [dbo].[Inventory] ([Inventory_ID], [Inventory_Status], [Product_ID], [Serial_Number]) VALUES (10037, 1, CAST(2 AS Numeric(10, 0)), 230120002)
INSERT [dbo].[Inventory] ([Inventory_ID], [Inventory_Status], [Product_ID], [Serial_Number]) VALUES (10039, 1, CAST(1 AS Numeric(10, 0)), 230120001)
INSERT [dbo].[Inventory] ([Inventory_ID], [Inventory_Status], [Product_ID], [Serial_Number]) VALUES (64321, 1, CAST(3 AS Numeric(10, 0)), 230530003)
INSERT [dbo].[Inventory] ([Inventory_ID], [Inventory_Status], [Product_ID], [Serial_Number]) VALUES (68739, 1, CAST(5 AS Numeric(10, 0)), 230920019)
INSERT [dbo].[Inventory] ([Inventory_ID], [Inventory_Status], [Product_ID], [Serial_Number]) VALUES (90876, 1, CAST(4 AS Numeric(10, 0)), 230810005)
GO
INSERT [dbo].[OrderLineItem] ([order_line_item_id], [order_line_item_status], [order_id], [order_line_amount], [product_id], [order_line_quantity]) VALUES (N'360', N'1', N'EXM11050', 1, CAST(3 AS Numeric(10, 0)), 1)
INSERT [dbo].[OrderLineItem] ([order_line_item_id], [order_line_item_status], [order_id], [order_line_amount], [product_id], [order_line_quantity]) VALUES (N'361', N'0', N'EXM11051', 1, CAST(2 AS Numeric(10, 0)), 2)
INSERT [dbo].[OrderLineItem] ([order_line_item_id], [order_line_item_status], [order_id], [order_line_amount], [product_id], [order_line_quantity]) VALUES (N'362', N'1', N'EXM11052', 1, CAST(4 AS Numeric(10, 0)), 1)
INSERT [dbo].[OrderLineItem] ([order_line_item_id], [order_line_item_status], [order_id], [order_line_amount], [product_id], [order_line_quantity]) VALUES (N'363', N'1', N'EXM11053', 1, CAST(5 AS Numeric(10, 0)), 3)
INSERT [dbo].[OrderLineItem] ([order_line_item_id], [order_line_item_status], [order_id], [order_line_amount], [product_id], [order_line_quantity]) VALUES (N'364', N'1', N'EXM11054', 1, CAST(1 AS Numeric(10, 0)), 4)
GO
INSERT [dbo].[Payment] ([payment_ID], [order_ID], [payment_amount], [payment_method_ID], [payment_date], [payment_status]) VALUES (10291, N'EXM11053', 4797, 158256, CAST(N'2023-08-25' AS Date), N'complete')
INSERT [dbo].[Payment] ([payment_ID], [order_ID], [payment_amount], [payment_method_ID], [payment_date], [payment_status]) VALUES (19281, N'EXM11051', 4998, 108367, CAST(N'2023-08-25' AS Date), N'inprogress')
INSERT [dbo].[Payment] ([payment_ID], [order_ID], [payment_amount], [payment_method_ID], [payment_date], [payment_status]) VALUES (38219, N'EXM11052', 899, 163821, CAST(N'2023-08-25' AS Date), N'complete')
INSERT [dbo].[Payment] ([payment_ID], [order_ID], [payment_amount], [payment_method_ID], [payment_date], [payment_status]) VALUES (46823, N'EXM11054', 6396, 182786, CAST(N'2023-08-28' AS Date), N'inprogress')
INSERT [dbo].[Payment] ([payment_ID], [order_ID], [payment_amount], [payment_method_ID], [payment_date], [payment_status]) VALUES (62562, N'EXM11050', 999, 192762, CAST(N'2023-08-24' AS Date), N'complete')
GO
INSERT [dbo].[Payment_Method] ([payment_method_ID], [Method_Name], [description], [payment_method_status], [User_ID], [card_number], [exp_date]) VALUES (102827, N'credit card', N'capital one card', N'deactivated', 2, N'1109928428999283', CAST(N'2023-02-01' AS Date))
INSERT [dbo].[Payment_Method] ([payment_method_ID], [Method_Name], [description], [payment_method_status], [User_ID], [card_number], [exp_date]) VALUES (108367, N'debit card', N'wells fargo card', N'active', 2, N'2719934929843849', CAST(N'2027-09-01' AS Date))
INSERT [dbo].[Payment_Method] ([payment_method_ID], [Method_Name], [description], [payment_method_status], [User_ID], [card_number], [exp_date]) VALUES (158256, N'debit card', N'capital one card', N'active', 4, N'4653738228639246', CAST(N'2028-08-01' AS Date))
INSERT [dbo].[Payment_Method] ([payment_method_ID], [Method_Name], [description], [payment_method_status], [User_ID], [card_number], [exp_date]) VALUES (163821, N'credit card', N'wells fargo card', N'active', 3, N'1028923892891029', CAST(N'2026-11-01' AS Date))
INSERT [dbo].[Payment_Method] ([payment_method_ID], [Method_Name], [description], [payment_method_status], [User_ID], [card_number], [exp_date]) VALUES (182786, N'debit card', N'capital one card', N'active', 5, N'5482975410289284', CAST(N'2025-07-01' AS Date))
INSERT [dbo].[Payment_Method] ([payment_method_ID], [Method_Name], [description], [payment_method_status], [User_ID], [card_number], [exp_date]) VALUES (192623, N'credit card', N'bank of america card', N'deactivated', 4, N'2038654812975647', CAST(N'2024-12-01' AS Date))
INSERT [dbo].[Payment_Method] ([payment_method_ID], [Method_Name], [description], [payment_method_status], [User_ID], [card_number], [exp_date]) VALUES (192762, N'credit card', N'chase card', N'active', 1, N'5485293739482384', CAST(N'2026-06-01' AS Date))
GO
INSERT [dbo].[Products] ([Product_ID], [Product_Name], [Product_Status], [Product_Price], [Description], [Product_Quantity], [Reorder_Level]) VALUES (CAST(1 AS Numeric(10, 0)), N'Sporty Scooter', 1, 1499, N'Fast, sleek, and aerodynamic sport scooter', 20, 10)
INSERT [dbo].[Products] ([Product_ID], [Product_Name], [Product_Status], [Product_Price], [Description], [Product_Quantity], [Reorder_Level]) VALUES (CAST(2 AS Numeric(10, 0)), N'Electric Scooter', 1, 2000, N'Eco-friendly electric-powered scooter', 25, 12)
INSERT [dbo].[Products] ([Product_ID], [Product_Name], [Product_Status], [Product_Price], [Description], [Product_Quantity], [Reorder_Level]) VALUES (CAST(3 AS Numeric(10, 0)), N'Classic Scooter', 1, 999, N'A timeless design for urban commuting', 10, 8)
INSERT [dbo].[Products] ([Product_ID], [Product_Name], [Product_Status], [Product_Price], [Description], [Product_Quantity], [Reorder_Level]) VALUES (CAST(4 AS Numeric(10, 0)), N'Three-Wheeled Scooter', 1, 899, N'Wider deck providing stability and balance', 10, 5)
INSERT [dbo].[Products] ([Product_ID], [Product_Name], [Product_Status], [Product_Price], [Description], [Product_Quantity], [Reorder_Level]) VALUES (CAST(5 AS Numeric(10, 0)), N'Off-Road Scooter', 1, 1599, N'Very durable and built for adventurous off-road trails', 20, 10)
GO
INSERT [dbo].[Shipping] ([Shipping_ID], [Shipping_Status], [Shipping_Method], [Shipping_Price], [Shipping_Distance], [Shipping_Address_ID], [Order_ID], [Order_Date], [Carrier], [Estimated_Delivery_Date], [Package_Weight], [Tracking_Number]) VALUES (12345, N'1', N'ground', 1, 100, 123, N'EXM11050', CAST(N'2023-08-23' AS Date), N'UPS', CAST(N'2023-08-26' AS Date), 1.23, 1234)
INSERT [dbo].[Shipping] ([Shipping_ID], [Shipping_Status], [Shipping_Method], [Shipping_Price], [Shipping_Distance], [Shipping_Address_ID], [Order_ID], [Order_Date], [Carrier], [Estimated_Delivery_Date], [Package_Weight], [Tracking_Number]) VALUES (12354, N'1', N'ground', 1.5, 150, 213, N'EXM11052', CAST(N'2023-08-25' AS Date), N'FedEx', CAST(N'2023-08-28' AS Date), 1.34, 2134)
INSERT [dbo].[Shipping] ([Shipping_ID], [Shipping_Status], [Shipping_Method], [Shipping_Price], [Shipping_Distance], [Shipping_Address_ID], [Order_ID], [Order_Date], [Carrier], [Estimated_Delivery_Date], [Package_Weight], [Tracking_Number]) VALUES (13245, N'0', N'ground', 1.25, 125, 132, N'EXM11051', CAST(N'2023-08-24' AS Date), N'UPS', CAST(N'2023-08-27' AS Date), 1.32, 1243)
INSERT [dbo].[Shipping] ([Shipping_ID], [Shipping_Status], [Shipping_Method], [Shipping_Price], [Shipping_Distance], [Shipping_Address_ID], [Order_ID], [Order_Date], [Carrier], [Estimated_Delivery_Date], [Package_Weight], [Tracking_Number]) VALUES (13254, N'1', N'ground', 1.75, 175, 231, N'EXM11053', CAST(N'2023-08-25' AS Date), N'DHL', CAST(N'2023-08-28' AS Date), 1.43, 2143)
INSERT [dbo].[Shipping] ([Shipping_ID], [Shipping_Status], [Shipping_Method], [Shipping_Price], [Shipping_Distance], [Shipping_Address_ID], [Order_ID], [Order_Date], [Carrier], [Estimated_Delivery_Date], [Package_Weight], [Tracking_Number]) VALUES (13425, N'1', N'ground', 2, 200, 321, N'EXM11054', CAST(N'2023-08-26' AS Date), N'USPS', CAST(N'2023-08-29' AS Date), 1.24, 1423)
GO
INSERT [dbo].[User] ([User_ID], [Customer_ID], [User_Password], [User_Email], [User_Status], [User_Phone_Number], [User_Creation_Date], [User_Last_Login]) VALUES (1, 1, N'SecretPineapple$42', N'jdoe@gmail.com', 1, N'5551231234', CAST(N'2023-07-09' AS Date), CAST(N'2023-10-02' AS Date))
INSERT [dbo].[User] ([User_ID], [Customer_ID], [User_Password], [User_Email], [User_Status], [User_Phone_Number], [User_Creation_Date], [User_Last_Login]) VALUES (2, 2, N'SecureMonkey@2023', N'jsmith@yahoo.com', 0, N'5559871234', CAST(N'2023-07-14' AS Date), CAST(N'2023-10-01' AS Date))
INSERT [dbo].[User] ([User_ID], [Customer_ID], [User_Password], [User_Email], [User_Status], [User_Phone_Number], [User_Creation_Date], [User_Last_Login]) VALUES (3, 3, N'BlueElephant&23', N'bobj@outlook.com', 1, N'5556784328', CAST(N'2023-07-02' AS Date), CAST(N'2023-09-14' AS Date))
INSERT [dbo].[User] ([User_ID], [Customer_ID], [User_Password], [User_Email], [User_Status], [User_Phone_Number], [User_Creation_Date], [User_Last_Login]) VALUES (4, 4, N'Fast!6', N'WillA@gmail.com', 1, N'5559871230', CAST(N'2023-08-15' AS Date), CAST(N'2023-09-27' AS Date))
INSERT [dbo].[User] ([User_ID], [Customer_ID], [User_Password], [User_Email], [User_Status], [User_Phone_Number], [User_Creation_Date], [User_Last_Login]) VALUES (5, 5, N'Cozy*5', N'ellawash@yahoo.com', 1, N'5557892345', CAST(N'2023-08-12' AS Date), CAST(N'2023-08-30' AS Date))
INSERT [dbo].[User] ([User_ID], [Customer_ID], [User_Password], [User_Email], [User_Status], [User_Phone_Number], [User_Creation_Date], [User_Last_Login]) VALUES (6, NULL, N'fuZy376', N'Tim.Luu@scoorters.com', 1, NULL, NULL, NULL)
INSERT [dbo].[User] ([User_ID], [Customer_ID], [User_Password], [User_Email], [User_Status], [User_Phone_Number], [User_Creation_Date], [User_Last_Login]) VALUES (7, NULL, N'In10802', N'John.Doe@scoorters.com', 0, NULL, NULL, NULL)
INSERT [dbo].[User] ([User_ID], [Customer_ID], [User_Password], [User_Email], [User_Status], [User_Phone_Number], [User_Creation_Date], [User_Last_Login]) VALUES (8, NULL, N'ajagd729', N'David.Johnson@scoorters.com', 1, NULL, NULL, NULL)
INSERT [dbo].[User] ([User_ID], [Customer_ID], [User_Password], [User_Email], [User_Status], [User_Phone_Number], [User_Creation_Date], [User_Last_Login]) VALUES (9, NULL, N'misR287', N'Ethan.Robles@scoorters.com', 1, NULL, NULL, NULL)
INSERT [dbo].[User] ([User_ID], [Customer_ID], [User_Password], [User_Email], [User_Status], [User_Phone_Number], [User_Creation_Date], [User_Last_Login]) VALUES (10, NULL, N'nuggets!@8', N'Anthony.Delgado@scoorters.com', 1, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Vendor] ON 

INSERT [dbo].[Vendor] ([Vendor_ID], [Vendor_CompanyName], [Vendor_Address], [Vendor_ContactName], [Vendor_ContactPhone], [Vendor_ContactEmail], [Vendor_Status]) VALUES (1, N'SalzScooters', N'8284 Rowland Motorway Suite 543, Hermistonborough, NE', N'Andy Warhol', N'1232958205', N'a.warhol@salzscooters.com', 1)
INSERT [dbo].[Vendor] ([Vendor_ID], [Vendor_CompanyName], [Vendor_Address], [Vendor_ContactName], [Vendor_ContactPhone], [Vendor_ContactEmail], [Vendor_Status]) VALUES (2, N'ScootsZoomies', N'15156 Ondricka Pass Suite 354, Schummbury, MS', N'Jane Austin', N'3828505730', N'austin.jane@scootszoomies.com', 1)
INSERT [dbo].[Vendor] ([Vendor_ID], [Vendor_CompanyName], [Vendor_Address], [Vendor_ContactName], [Vendor_ContactPhone], [Vendor_ContactEmail], [Vendor_Status]) VALUES (3, N'GnarlyWheels', N'71537 Krajcik Cliffs Apt. 916, Port Deborahview, CO', N'JK Rowling', N'3085732209', N'Jrowling@gnarlywheels.com', 1)
INSERT [dbo].[Vendor] ([Vendor_ID], [Vendor_CompanyName], [Vendor_Address], [Vendor_ContactName], [Vendor_ContactPhone], [Vendor_ContactEmail], [Vendor_Status]) VALUES (4, N'WatchOut', N'5016 Berenice Roads, East Adamstad, KS', N'Taylor Swift', N'5559271234', N'tswizzles@watchout.com', 1)
INSERT [dbo].[Vendor] ([Vendor_ID], [Vendor_CompanyName], [Vendor_Address], [Vendor_ContactName], [Vendor_ContactPhone], [Vendor_ContactEmail], [Vendor_Status]) VALUES (5, N'ModernTransportation', N'8186 Graham Isle, South Myaview, ID', N'Nicole Kidman', N'8884658333', N'NicoleK@moderntransportation.com', 0)
SET IDENTITY_INSERT [dbo].[Vendor] OFF
GO
SET IDENTITY_INSERT [dbo].[Vendor_Purchase_Order] ON 

INSERT [dbo].[Vendor_Purchase_Order] ([VPO_ID], [Vendor_ID], [Product_ID], [VPO_ProductQuantity], [VPO_ProductPrice], [VPO_ProductTotal], [VPO_TotalAmount], [VPO_PaymentMethod], [VPO_PaymentStatus], [VPO_ProductReceived]) VALUES (1, 1, CAST(1 AS Numeric(10, 0)), 100, 1200, 120000, 129000, 12345, 1, 1)
INSERT [dbo].[Vendor_Purchase_Order] ([VPO_ID], [Vendor_ID], [Product_ID], [VPO_ProductQuantity], [VPO_ProductPrice], [VPO_ProductTotal], [VPO_TotalAmount], [VPO_PaymentMethod], [VPO_PaymentStatus], [VPO_ProductReceived]) VALUES (2, 2, CAST(2 AS Numeric(10, 0)), 100, 1500, 150000, 161250, 67891, 1, 1)
INSERT [dbo].[Vendor_Purchase_Order] ([VPO_ID], [Vendor_ID], [Product_ID], [VPO_ProductQuantity], [VPO_ProductPrice], [VPO_ProductTotal], [VPO_TotalAmount], [VPO_PaymentMethod], [VPO_PaymentStatus], [VPO_ProductReceived]) VALUES (3, 2, CAST(3 AS Numeric(10, 0)), 100, 500, 50000, 53750, 67891, 1, 1)
INSERT [dbo].[Vendor_Purchase_Order] ([VPO_ID], [Vendor_ID], [Product_ID], [VPO_ProductQuantity], [VPO_ProductPrice], [VPO_ProductTotal], [VPO_TotalAmount], [VPO_PaymentMethod], [VPO_PaymentStatus], [VPO_ProductReceived]) VALUES (4, 3, CAST(4 AS Numeric(10, 0)), 100, 450, 45000, 48375, 45678, 1, 1)
INSERT [dbo].[Vendor_Purchase_Order] ([VPO_ID], [Vendor_ID], [Product_ID], [VPO_ProductQuantity], [VPO_ProductPrice], [VPO_ProductTotal], [VPO_TotalAmount], [VPO_PaymentMethod], [VPO_PaymentStatus], [VPO_ProductReceived]) VALUES (5, 4, CAST(5 AS Numeric(10, 0)), 100, 1300, 130000, 139750, 54834, 0, 1)
SET IDENTITY_INSERT [dbo].[Vendor_Purchase_Order] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__8A8E974744F58DF7]    Script Date: 10/24/2023 4:48:03 PM ******/
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[Customer_Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Asset]  WITH CHECK ADD FOREIGN KEY([Order_ID])
REFERENCES [dbo].[Customer_Order] ([order_id])
GO
ALTER TABLE [dbo].[Asset]  WITH CHECK ADD FOREIGN KEY([Product_ID])
REFERENCES [dbo].[Products] ([Product_ID])
GO
ALTER TABLE [dbo].[Customer_Order]  WITH CHECK ADD FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customers] ([Customer_ID])
GO
ALTER TABLE [dbo].[Customer_Service_Agent]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Service_Agent_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([User_ID])
GO
ALTER TABLE [dbo].[Customer_Service_Agent] CHECK CONSTRAINT [FK_Customer_Service_Agent_User]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD FOREIGN KEY([Address_ID])
REFERENCES [dbo].[Address] ([AddressID])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([Product_ID])
REFERENCES [dbo].[Products] ([Product_ID])
GO
ALTER TABLE [dbo].[OrderLineItem]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Customer_Order] ([order_id])
GO
ALTER TABLE [dbo].[OrderLineItem]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([Product_ID])
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD FOREIGN KEY([payment_method_ID])
REFERENCES [dbo].[Payment_Method] ([payment_method_ID])
GO
ALTER TABLE [dbo].[Payment_Method]  WITH CHECK ADD FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([User_ID])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customers] ([Customer_ID])
GO
ALTER TABLE [dbo].[Vendor_Purchase_Order]  WITH CHECK ADD FOREIGN KEY([Product_ID])
REFERENCES [dbo].[Products] ([Product_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Vendor_Purchase_Order]  WITH CHECK ADD FOREIGN KEY([Vendor_ID])
REFERENCES [dbo].[Vendor] ([Vendor_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Customer_Service_Agent]  WITH CHECK ADD CHECK  (([Customer_Service_Status]='On Leave' OR [Customer_Service_Status]='Inactive' OR [Customer_Service_Status]='Active'))
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD CHECK  (([Product_ID]>=(0)))
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD CHECK  (([Product_Price]>(0)))
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD CHECK  (([Product_Quantity]>=(0)))
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD CHECK  (([Reorder_Level]>=(0)))
GO
/****** Object:  StoredProcedure [dbo].[SelectProduct]    Script Date: 10/24/2023 4:48:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectProduct] @product varchar(50)
AS
SELECT * FROM cis55_49.dbo.Products WHERE Products.Product_Name = @product
GO
USE [master]
GO
ALTER DATABASE [cis55_49] SET  READ_WRITE 
GO
