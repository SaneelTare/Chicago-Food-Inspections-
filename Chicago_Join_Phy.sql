/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      CHICago join.DM1
 *
 * Date Created : Thursday, October 06, 2022 16:33:18
 * Target DBMS : Microsoft SQL Server 2019
 */

/* 
 * TABLE: DimApplication 
 */

CREATE TABLE DimApplication(
    APPLICATION_ID_SK                    int             NOT NULL,
    [APPLICATION TYPE]                   nvarchar(6)     NULL,
    [APPLICATION CREATED DATE]           char(10)        NULL,
    [APPLICATION REQUIREMENTS COMPLETE]  nvarchar(10)    NULL,
    [PAYMENT DATE]                       nvarchar(10)    NULL,
    [CONDITIONAL APPROVAL]               nvarchar(1)     NULL,
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (APPLICATION_ID_SK)
)

go


IF OBJECT_ID('DimApplication') IS NOT NULL
    PRINT '<<< CREATED TABLE DimApplication >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimApplication >>>'
go

/* 
 * TABLE: DimBusiness 
 */

CREATE TABLE DimBusiness(
    BUSINESS_ID_SK            int              NOT NULL,
    Risk                      nvarchar(20)     NULL,
    Facility_Type             nvarchar(30)     NULL,
    AKA_Name                  nvarchar(10)     NULL,
    ID                        nvarchar(16)     NULL,
    [ACCOUNT NUMBER]          int              NULL,
    [SITE NUMBER]             int              NULL,
    [LEGAL NAME]              nvarchar(117)    NULL,
    [DOING BUSINESS AS NAME]  nvarchar(128)    NULL,
    [BUSINESS ACTIVITY ID]    nvarchar(81)     NULL,
    [BUSINESS ACTIVITY]       nvarchar(735)    NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (BUSINESS_ID_SK)
)

go


IF OBJECT_ID('DimBusiness') IS NOT NULL
    PRINT '<<< CREATED TABLE DimBusiness >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimBusiness >>>'
go

/* 
 * TABLE: DimInspection 
 */

CREATE TABLE DimInspection(
    InspectionID_SK    int               NOT NULL,
    Inspection_Date    nvarchar(10)      NULL,
    Results            nvarchar(20)      NULL,
    Violations         nvarchar(4000)    NULL,
    CONSTRAINT PK2_1 PRIMARY KEY NONCLUSTERED (InspectionID_SK)
)

go


IF OBJECT_ID('DimInspection') IS NOT NULL
    PRINT '<<< CREATED TABLE DimInspection >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimInspection >>>'
go

/* 
 * TABLE: DimLicense 
 */

CREATE TABLE DimLicense(
    LICENSEID_SK                     int             NOT NULL,
    [LICENSE ID]                     int             NULL,
    [LICENSE DESCRIPTION]            nvarchar(60)    NULL,
    [LICENSE CODE]                   int             NULL,
    [LICENSE NUMBER]                 int             NULL,
    [LICENSE STATUS]                 nvarchar(3)     NULL,
    [LICENSE APPROVED FOR ISSUANCE]  nvarchar(10)    NULL,
    [LICENSE STATUS CHANGE DATE]     date            NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (LICENSEID_SK)
)

go


IF OBJECT_ID('DimLicense') IS NOT NULL
    PRINT '<<< CREATED TABLE DimLicense >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimLicense >>>'
go

/* 
 * TABLE: DimLocation 
 */

CREATE TABLE DimLocation(
    Location_ID_SK    int                 NOT NULL,
    SSA               nvarchar(10)        NULL,
    ADDRESS           nvarchar(80)        NULL,
    CITY              nvarchar(30)        NULL,
    STATE             nvarchar(2)         NULL,
    ZIPCODE           nvarchar(5)         NULL,
    WARD              nvarchar(1)         NULL,
    LATITUDE          double precision    NULL,
    LONGITUDE         double precision    NULL,
    LOCATION          nvarchar(40)        NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (Location_ID_SK)
)

go


IF OBJECT_ID('DimLocation') IS NOT NULL
    PRINT '<<< CREATED TABLE DimLocation >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimLocation >>>'
go

/* 
 * TABLE: DimPolice 
 */

CREATE TABLE DimPolice(
    POLICE_ID          int            NOT NULL,
    PRECINCT           int            NULL,
    [WARD PRECINCT]    nvarchar(6)    NULL,
    [POLICE DISTRICT]  nvarchar(1)    NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (POLICE_ID)
)

go


IF OBJECT_ID('DimPolice') IS NOT NULL
    PRINT '<<< CREATED TABLE DimPolice >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimPolice >>>'
go

/* 
 * TABLE: Fact_BU 
 */

CREATE TABLE Fact_BU(
    FACT_BU                         int         NOT NULL,
    Inspection_Date                 datetime    NULL,
    [LICENSE TERM START DATE]       date        NULL,
    [LICENSE TERM EXPIRATION DATE]  date        NULL,
    [DATE ISSUED]                   date        NULL,
    Location_ID_SK                  int         NOT NULL,
    APPLICATION_ID_SK               int         NOT NULL,
    LICENSEID_SK                    int         NOT NULL,
    POLICE_ID                       int         NOT NULL,
    BUSINESS_ID_SK                  int         NOT NULL,
    InspectionID_SK                 int         NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY NONCLUSTERED (FACT_BU)
)

go


IF OBJECT_ID('Fact_BU') IS NOT NULL
    PRINT '<<< CREATED TABLE Fact_BU >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Fact_BU >>>'
go

/* 
 * TABLE: Fact_BU 
 */

ALTER TABLE Fact_BU ADD CONSTRAINT RefDimApplication2 
    FOREIGN KEY (APPLICATION_ID_SK)
    REFERENCES DimApplication(APPLICATION_ID_SK)
go

ALTER TABLE Fact_BU ADD CONSTRAINT RefDimLicense3 
    FOREIGN KEY (LICENSEID_SK)
    REFERENCES DimLicense(LICENSEID_SK)
go

ALTER TABLE Fact_BU ADD CONSTRAINT RefDimPolice4 
    FOREIGN KEY (POLICE_ID)
    REFERENCES DimPolice(POLICE_ID)
go

ALTER TABLE Fact_BU ADD CONSTRAINT RefDimBusiness5 
    FOREIGN KEY (BUSINESS_ID_SK)
    REFERENCES DimBusiness(BUSINESS_ID_SK)
go

ALTER TABLE Fact_BU ADD CONSTRAINT RefDimLocation1 
    FOREIGN KEY (Location_ID_SK)
    REFERENCES DimLocation(Location_ID_SK)
go

ALTER TABLE Fact_BU ADD CONSTRAINT RefDimInspection9 
    FOREIGN KEY (InspectionID_SK)
    REFERENCES DimInspection(InspectionID_SK)
go


