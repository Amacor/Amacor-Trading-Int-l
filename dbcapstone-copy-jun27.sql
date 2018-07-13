-- MySQL dump 10.13  Distrib 5.7.12, for Win32 (AMD64)
--
-- Host: 127.0.0.1    Database: dbcapstonecopy
-- ------------------------------------------------------
-- Server version	5.7.19-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbladdon`
--

DROP TABLE IF EXISTS `tbladdon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbladdon` (
  `intDesignAddonID` int(11) NOT NULL,
  `boolReflector` tinyint(1) NOT NULL,
  `boolPrint` tinyint(1) NOT NULL,
  `boolEmbro` tinyint(1) NOT NULL,
  `intRefSize` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`intDesignAddonID`),
  UNIQUE KEY `intAddonID_UNIQUE` (`intDesignAddonID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbladdon`
--


--
-- Table structure for table `tblclientacct`
--

DROP TABLE IF EXISTS `tblclientacct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblclientacct` (
  `intClientAcctID` int(11) NOT NULL AUTO_INCREMENT,
  `intPendingOrder` int(11) DEFAULT NULL,
  `fltPayables` float NOT NULL,
  `intReturnItems` int(11) DEFAULT NULL,
  `floatBalance` float NOT NULL,
  `txtRemarks` longtext,
  `boolClientStatus` tinyint(1) NOT NULL,
  `intClientType` int(1) NOT NULL,
  PRIMARY KEY (`intClientAcctID`),
  UNIQUE KEY `intClientAcctID_UNIQUE` (`intClientAcctID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblclientacct`
--


--
-- Table structure for table `tblcompayables`
--

DROP TABLE IF EXISTS `tblcompayables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblcompayables` (
  `intComPayablesID` int(11) NOT NULL AUTO_INCREMENT,
  `fltAmount` float NOT NULL,
  `datDueDate` date NOT NULL,
  PRIMARY KEY (`intComPayablesID`),
  UNIQUE KEY `intComPayablesID_UNIQUE` (`intComPayablesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcompayables`
--


--
-- Table structure for table `tbldeliverorder`
--

DROP TABLE IF EXISTS `tbldeliverorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbldeliverorder` (
  `intDeliverID` int(11) NOT NULL AUTO_INCREMENT,
  `intDeliverProductID` int(11) NOT NULL,
  `datDate` date NOT NULL,
  `intQuantity` int(11) NOT NULL,
  `fltUnitPrice` float NOT NULL,
  `fltTotalAmount` float NOT NULL,
  `txtRemarks` longtext NOT NULL,
  `intDeliverUserID` int(11) DEFAULT NULL,
  PRIMARY KEY (`intDeliverID`),
  UNIQUE KEY `intDeliverID_UNIQUE` (`intDeliverID`),
  KEY `intDeliverProductID_idx` (`intDeliverProductID`),
  KEY `intUserID_idx` (`intDeliverUserID`),
  CONSTRAINT `intDeliverProductID` FOREIGN KEY (`intDeliverProductID`) REFERENCES `tblproductinv` (`intProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `intDeliverUserID` FOREIGN KEY (`intDeliverUserID`) REFERENCES `tbluser` (`intUserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldeliverorder`
--


--
-- Table structure for table `tblinventory`
--

DROP TABLE IF EXISTS `tblinventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblinventory` (
  `intInventoryID` int(11) NOT NULL AUTO_INCREMENT,
  `intMaterialID` int(11) NOT NULL,
  `intProductID` int(11) NOT NULL,
  `intQuantity` int(11) NOT NULL,
  `txtRemarks` longtext,
  PRIMARY KEY (`intInventoryID`),
  UNIQUE KEY `intInitialInvID_UNIQUE` (`intInventoryID`),
  KEY `intMaterialID` (`intMaterialID`),
  KEY `inyProductID_idx` (`intProductID`),
  CONSTRAINT `intMaterialID` FOREIGN KEY (`intMaterialID`) REFERENCES `tblmaterialsdtl` (`intMaterialID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `inyProductID` FOREIGN KEY (`intProductID`) REFERENCES `tblproductinv` (`intProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblinventory`
--


--
-- Table structure for table `tbljoborder`
--

DROP TABLE IF EXISTS `tbljoborder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbljoborder` (
  `intJOID` int(11) NOT NULL AUTO_INCREMENT,
  `datOrderDate` date NOT NULL,
  `datDeadline` date NOT NULL,
  `intOrderDetails` int(11) NOT NULL,
  `fltPartialPayment` float NOT NULL,
  `fltTotalAmount` float NOT NULL,
  `intJOSubconID` int(11) NOT NULL,
  PRIMARY KEY (`intJOID`),
  UNIQUE KEY `intJOID_UNIQUE` (`intJOID`),
  KEY `intJOSubconID_idx` (`intJOSubconID`),
  CONSTRAINT `intJOSubconID` FOREIGN KEY (`intJOSubconID`) REFERENCES `tblsubcontractor` (`intSubconID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbljoborder`
--


--
-- Table structure for table `tblmatdesc`
--

DROP TABLE IF EXISTS `tblmatdesc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmatdesc` (
  `intMatDescID` int(11) NOT NULL AUTO_INCREMENT,
  `strtype` varchar(45) NOT NULL,
  `strColor` varchar(45) NOT NULL,
  `fltUnit` float NOT NULL,
  PRIMARY KEY (`intMatDescID`),
  UNIQUE KEY `intMatDescID_UNIQUE` (`intMatDescID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmatdesc`
--


--
-- Table structure for table `tblmaterialsdtl`
--

DROP TABLE IF EXISTS `tblmaterialsdtl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmaterialsdtl` (
  `intMaterialID` int(11) NOT NULL AUTO_INCREMENT,
  `strMaterialName` varchar(45) NOT NULL,
  `txtMaterialDesc` longtext NOT NULL,
  `fltUnitQuantity` float NOT NULL,
  `txtRemarks` varchar(45) DEFAULT NULL,
  `intMaterialDescID` int(11) DEFAULT NULL,
  PRIMARY KEY (`intMaterialID`),
  UNIQUE KEY `intIMDID_UNIQUE` (`intMaterialID`),
  KEY `intMaterialDescID_idx` (`intMaterialDescID`),
  CONSTRAINT `intMaterialDescID` FOREIGN KEY (`intMaterialDescID`) REFERENCES `tblmatdesc` (`intMatDescID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmaterialsdtl`
--


--
-- Table structure for table `tblmaterialssourcing`
--

DROP TABLE IF EXISTS `tblmaterialssourcing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblmaterialssourcing` (
  `intMatSrcID` int(11) NOT NULL AUTO_INCREMENT,
  `intMatDescriptionID` int(11) NOT NULL,
  `fltUnitPrice` float NOT NULL,
  `fltPartialPayment` float NOT NULL,
  `fltTotalAmount` float NOT NULL,
  PRIMARY KEY (`intMatSrcID`),
  UNIQUE KEY `intMatSrcID_UNIQUE` (`intMatSrcID`),
  KEY `intMatDescriptionID_idx` (`intMatDescriptionID`),
  CONSTRAINT `intMatDescriptionID` FOREIGN KEY (`intMatDescriptionID`) REFERENCES `tblmatdesc` (`intMatDescID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmaterialssourcing`
--


--
-- Table structure for table `tblnewdesign`
--

DROP TABLE IF EXISTS `tblnewdesign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblnewdesign` (
  `intNDID` int(11) NOT NULL,
  `strColor` varchar(20) NOT NULL,
  `intSize` int(1) NOT NULL,
  `strCloth` varchar(45) NOT NULL,
  `strGarment` varchar(45) NOT NULL,
  `boolAddon` tinyint(4) NOT NULL,
  `intAddonID` int(11) NOT NULL,
  PRIMARY KEY (`intNDID`),
  UNIQUE KEY `intNDID_UNIQUE` (`intNDID`),
  KEY `intDesignAddonID_idx` (`intAddonID`),
  CONSTRAINT `intDesignAddonID` FOREIGN KEY (`intAddonID`) REFERENCES `tbladdon` (`intDesignAddonID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblnewdesign`
--


--
-- Table structure for table `tblorderdetails`
--

DROP TABLE IF EXISTS `tblorderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblorderdetails` (
  `intOrderDetailsID` int(11) NOT NULL AUTO_INCREMENT,
  `strType` varchar(45) NOT NULL,
  `strSize` varchar(45) NOT NULL,
  `boolEmbro` tinyint(1) NOT NULL,
  `boolPrint` tinyint(1) NOT NULL,
  `boolCustomized` tinyint(1) NOT NULL,
  `intQuantity` int(11) NOT NULL,
  `fltUnitPrice` float NOT NULL,
  PRIMARY KEY (`intOrderDetailsID`),
  UNIQUE KEY `intOrderDetailsID_UNIQUE` (`intOrderDetailsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblorderdetails`
--


--
-- Table structure for table `tblpodesc`
--

DROP TABLE IF EXISTS `tblpodesc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpodesc` (
  `intPODescID` int(11) NOT NULL,
  `strType` varchar(45) NOT NULL,
  `strColor` varchar(45) NOT NULL,
  `fltUnitPrice` float NOT NULL,
  `intUnitQTY` int(11) NOT NULL,
  `boolAddOn` tinyint(1) NOT NULL,
  `strGarment` varchar(45) NOT NULL,
  `strSize` varchar(2) NOT NULL,
  PRIMARY KEY (`intPODescID`),
  UNIQUE KEY `intPODescID_UNIQUE` (`intPODescID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpodesc`
--


--
-- Table structure for table `tblpriceagreement`
--

DROP TABLE IF EXISTS `tblpriceagreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpriceagreement` (
  `intPAID` int(11) NOT NULL,
  `intSubconID` int(11) NOT NULL,
  `fltUnitPrice` float NOT NULL,
  PRIMARY KEY (`intPAID`),
  KEY `intSubconID_idx` (`intSubconID`),
  CONSTRAINT `intSubconID` FOREIGN KEY (`intSubconID`) REFERENCES `tblsubcontractor` (`intSubconID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpriceagreement`
--


--
-- Table structure for table `tblproductinv`
--

DROP TABLE IF EXISTS `tblproductinv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblproductinv` (
  `intProductID` int(11) NOT NULL AUTO_INCREMENT,
  `strColor` varchar(45) NOT NULL,
  `strSize` varchar(12) NOT NULL,
  `boolEmbro` tinyint(1) NOT NULL,
  `boolPrint` tinyint(1) NOT NULL,
  `boolCustomized` tinyint(1) NOT NULL,
  `intQuantity` int(11) NOT NULL,
  `fltUnitPrice` float NOT NULL,
  `txtRemarks` longtext,
  PRIMARY KEY (`intProductID`),
  UNIQUE KEY `intProductID_UNIQUE` (`intProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproductinv`
--


--
-- Table structure for table `tblpurchaseorder`
--

DROP TABLE IF EXISTS `tblpurchaseorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblpurchaseorder` (
  `intPOID` int(11) NOT NULL,
  `intSupplierID` int(11) NOT NULL,
  `datPODate` date NOT NULL,
  `intPOAmount` int(11) NOT NULL,
  `intPODesc` int(11) NOT NULL,
  PRIMARY KEY (`intPOID`),
  UNIQUE KEY `intPOID_UNIQUE` (`intPOID`),
  KEY `intPODesc_idx` (`intPODesc`),
  KEY `intSupplierID_idx` (`intSupplierID`),
  CONSTRAINT `intPODesc` FOREIGN KEY (`intPODesc`) REFERENCES `tblpodesc` (`intPODescID`) ON UPDATE CASCADE,
  CONSTRAINT `intSupplierID` FOREIGN KEY (`intSupplierID`) REFERENCES `tblsupplier` (`intSupplierID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpurchaseorder`
--


--
-- Table structure for table `tblreceivedpayment`
--

DROP TABLE IF EXISTS `tblreceivedpayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblreceivedpayment` (
  `intReceivedID` int(11) NOT NULL AUTO_INCREMENT,
  `intAmount` int(11) NOT NULL,
  `datDate` date NOT NULL,
  `intSalesOrderID` int(11) NOT NULL,
  `fltPartialPayment` float NOT NULL,
  `fltFullPayment` float NOT NULL,
  `txtRemarks` longtext NOT NULL,
  `intReceiveUserID` int(11) DEFAULT NULL,
  PRIMARY KEY (`intReceivedID`),
  UNIQUE KEY `intReceivedID_UNIQUE` (`intReceivedID`),
  KEY `intSalesOrderID_idx` (`intSalesOrderID`),
  KEY `intReceiveUserID_idx` (`intReceiveUserID`),
  CONSTRAINT `intReceiveUserID` FOREIGN KEY (`intReceiveUserID`) REFERENCES `tbluser` (`intUserID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `intSalesOrderID` FOREIGN KEY (`intSalesOrderID`) REFERENCES `tblsalesorder` (`intsalesorderID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreceivedpayment`
--


--
-- Table structure for table `tblreceivedprod`
--

DROP TABLE IF EXISTS `tblreceivedprod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblreceivedprod` (
  `intReceiveID` int(11) NOT NULL AUTO_INCREMENT,
  `intRProductID` int(11) NOT NULL,
  `datdate` date NOT NULL,
  `intQuantity` int(11) NOT NULL,
  `txtRemarks` longtext NOT NULL,
  PRIMARY KEY (`intReceiveID`),
  UNIQUE KEY `intReceiveID_UNIQUE` (`intReceiveID`),
  KEY `intProductID_idx` (`intRProductID`),
  CONSTRAINT `intRProductID` FOREIGN KEY (`intRProductID`) REFERENCES `tblproductinv` (`intProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreceivedprod`
--


--
-- Table structure for table `tblreportexpense`
--

DROP TABLE IF EXISTS `tblreportexpense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblreportexpense` (
  `intReportExpenseID` int(11) NOT NULL AUTO_INCREMENT,
  `intReceiverID` int(11) NOT NULL,
  `fltAmount` float NOT NULL,
  `datDate` date NOT NULL,
  `intMatSrcID` int(11) NOT NULL,
  `inSubconDuesId` int(11) NOT NULL,
  `txtRemarks` longtext,
  PRIMARY KEY (`intReportExpenseID`),
  UNIQUE KEY `intReportExpenseID_UNIQUE` (`intReportExpenseID`),
  KEY `intReceiverID_idx` (`intReceiverID`),
  KEY `intMatSrcID_idx` (`intMatSrcID`),
  CONSTRAINT `intMatSrcID` FOREIGN KEY (`intMatSrcID`) REFERENCES `tblmaterialssourcing` (`intMatSrcID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `intReceiverID` FOREIGN KEY (`intReceiverID`) REFERENCES `tblsupplier` (`intSupplierID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreportexpense`
--


--
-- Table structure for table `tblreturneditems`
--

DROP TABLE IF EXISTS `tblreturneditems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblreturneditems` (
  `intReturneditemID` int(11) NOT NULL AUTO_INCREMENT,
  `intReturnedProductID` int(11) NOT NULL,
  `intQuantity` int(11) NOT NULL,
  `txtCondition` longtext NOT NULL,
  `txtRemarks` longtext,
  PRIMARY KEY (`intReturneditemID`),
  UNIQUE KEY `intReturneditemID_UNIQUE` (`intReturneditemID`),
  KEY `intReturnedProductID_idx` (`intReturnedProductID`),
  CONSTRAINT `intReturnedProductID` FOREIGN KEY (`intReturnedProductID`) REFERENCES `tblproductinv` (`intProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreturneditems`
--


--
-- Table structure for table `tblsalesorder`
--

DROP TABLE IF EXISTS `tblsalesorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsalesorder` (
  `intsalesorderID` int(11) NOT NULL AUTO_INCREMENT,
  `datOrderDate` date NOT NULL,
  `datDeadline` date NOT NULL,
  `txtOrderDetails` longtext NOT NULL,
  `intSalesQuoteID` int(11) DEFAULT NULL,
  `fltPartialPayment` float NOT NULL,
  `fltTotalAmount` float NOT NULL,
  `intOrderDetailsID` int(11) DEFAULT NULL,
  `intUserID` int(11) DEFAULT NULL,
  `txtRemarks` longtext,
  `boolSOType` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`intsalesorderID`),
  UNIQUE KEY `intsalesorderID_UNIQUE` (`intsalesorderID`),
  KEY `intSalesQuoteID_idx` (`intSalesQuoteID`),
  KEY `intOrderDetailsID_idx` (`intOrderDetailsID`),
  KEY `intUserID_idx` (`intUserID`),
  CONSTRAINT `intOrderDetailsID` FOREIGN KEY (`intOrderDetailsID`) REFERENCES `tblorderdetails` (`intOrderDetailsID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `intSalesQuoteID` FOREIGN KEY (`intSalesQuoteID`) REFERENCES `tblsalesquote` (`intSQID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `intUserID` FOREIGN KEY (`intUserID`) REFERENCES `tbluser` (`intUserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsalesorder`
--


--
-- Table structure for table `tblsalesquote`
--

DROP TABLE IF EXISTS `tblsalesquote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsalesquote` (
  `intSQID` int(11) NOT NULL,
  `intProductID` int(11) DEFAULT NULL,
  `fltUnitPrice` float NOT NULL,
  `strType` varchar(45) NOT NULL,
  `strSize` varchar(45) NOT NULL,
  `boolEmbro` tinyint(1) NOT NULL,
  `boolCustomized` tinyint(1) NOT NULL,
  `intQuantity` int(11) NOT NULL,
  PRIMARY KEY (`intSQID`),
  UNIQUE KEY `intSQID_UNIQUE` (`intSQID`),
  KEY `intProductID_idx` (`intProductID`),
  CONSTRAINT `intProductID` FOREIGN KEY (`intProductID`) REFERENCES `tblproductinv` (`intProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsalesquote`
--


--
-- Table structure for table `tblstocks`
--

DROP TABLE IF EXISTS `tblstocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblstocks` (
  `intStockID` int(11) NOT NULL,
  `boolStockType` tinyint(1) NOT NULL,
  `strStockName` varchar(20) NOT NULL,
  `boolStockUpdate` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`intStockID`),
  UNIQUE KEY `intStockID_UNIQUE` (`intStockID`),
  CONSTRAINT `intNDStockID` FOREIGN KEY (`intStockID`) REFERENCES `tblnewdesign` (`intNDID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `intPOStockID` FOREIGN KEY (`intStockID`) REFERENCES `tblsupplier` (`intSupplierID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblstocks`
--


--
-- Table structure for table `tblsubconacct`
--

DROP TABLE IF EXISTS `tblsubconacct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsubconacct` (
  `intSubconAcctID` int(11) NOT NULL AUTO_INCREMENT,
  `intPendingJobOrder` int(11) NOT NULL,
  `fltPayables` float NOT NULL,
  `intReturnItems` int(11) NOT NULL,
  `txtRemarks` longtext,
  PRIMARY KEY (`intSubconAcctID`),
  UNIQUE KEY `intSubconAcctID_UNIQUE` (`intSubconAcctID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsubconacct`
--


--
-- Table structure for table `tblsubcondues`
--

DROP TABLE IF EXISTS `tblsubcondues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsubcondues` (
  `intSubconDueID` int(11) NOT NULL AUTO_INCREMENT,
  ` intDueProductID` int(11) NOT NULL,
  `intQuantity` int(11) NOT NULL,
  `fltUnitPrice` float NOT NULL,
  `fltPartialPayment` float NOT NULL,
  `fltTotalAmount` float NOT NULL,
  PRIMARY KEY (`intSubconDueID`),
  UNIQUE KEY `intSubconDueID_UNIQUE` (`intSubconDueID`),
  KEY ` intDueProductID_idx` (` intDueProductID`),
  CONSTRAINT ` intDueProductID` FOREIGN KEY (` intDueProductID`) REFERENCES `tblproductinv` (`intProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsubcondues`
--


--
-- Table structure for table `tblsubcontractor`
--

DROP TABLE IF EXISTS `tblsubcontractor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsubcontractor` (
  `intSubconID` int(11) NOT NULL AUTO_INCREMENT,
  `strSubconName` varchar(45) NOT NULL,
  `strSubconAddress` varchar(150) NOT NULL,
  `intSubconContact` int(11) NOT NULL,
  `intSubconAcct` int(11) NOT NULL,
  `boolSubconStatus` tinyint(1) NOT NULL,
  PRIMARY KEY (`intSubconID`),
  UNIQUE KEY `intSubconID_UNIQUE` (`intSubconID`),
  KEY `intSubconAcct_idx` (`intSubconAcct`),
  CONSTRAINT `intSubconAcct` FOREIGN KEY (`intSubconAcct`) REFERENCES `tblsubconacct` (`intSubconAcctID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsubcontractor`
--


--
-- Table structure for table `tblsupplier`
--

DROP TABLE IF EXISTS `tblsupplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblsupplier` (
  `intSupplierID` int(11) NOT NULL AUTO_INCREMENT,
  `strSupplierName` varchar(45) NOT NULL,
  `strSupplierAddress` varchar(150) NOT NULL,
  `intSupplierContact` int(11) NOT NULL,
  `intComPayables` int(11) NOT NULL,
  PRIMARY KEY (`intSupplierID`),
  UNIQUE KEY `intSupplierID_UNIQUE` (`intSupplierID`),
  KEY `intComPayables_idx` (`intComPayables`),
  CONSTRAINT `intComPayables` FOREIGN KEY (`intComPayables`) REFERENCES `tblcompayables` (`intComPayablesID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsupplier`
--


--
-- Table structure for table `tbltransaction`
--

DROP TABLE IF EXISTS `tbltransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbltransaction` (
  `intTransactionID` int(11) NOT NULL AUTO_INCREMENT,
  `intTransProductID` int(11) NOT NULL,
  `intTransUserID` int(11) NOT NULL,
  `strTransStatus` tinyint(1) NOT NULL,
  PRIMARY KEY (`intTransactionID`),
  UNIQUE KEY `intTransactionID_UNIQUE` (`intTransactionID`),
  KEY `intTransProductID_idx` (`intTransProductID`),
  KEY `intTransUserID_idx` (`intTransUserID`),
  CONSTRAINT `intTransProductID` FOREIGN KEY (`intTransProductID`) REFERENCES `tblproductinv` (`intProductID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `intTransUserID` FOREIGN KEY (`intTransUserID`) REFERENCES `tbluser` (`intUserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltransaction`
--


--
-- Table structure for table `tbluser`
--

DROP TABLE IF EXISTS `tbluser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbluser` (
  `intUserID` int(11) NOT NULL AUTO_INCREMENT,
  `strUserName` varchar(45) NOT NULL,
  `strAddress` varchar(150) NOT NULL,
  `intContact` int(12) NOT NULL,
  `strEmail` varchar(45) NOT NULL,
  `strPassword` varchar(50) NOT NULL,
  `intUserType` int(1) NOT NULL,
  `boolStatus` tinyint(1) NOT NULL,
  PRIMARY KEY (`intUserID`),
  UNIQUE KEY `intUserID_UNIQUE` (`intUserID`),
  CONSTRAINT `intUserClientAcctID` FOREIGN KEY (`intUserID`) REFERENCES `tblclientacct` (`intClientAcctID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `intUserSubconID` FOREIGN KEY (`intUserID`) REFERENCES `tblsubcontractor` (`intSubconID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbluser`
--


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
