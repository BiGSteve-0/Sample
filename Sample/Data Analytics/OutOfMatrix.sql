Begin Transaction OutOfMatrix

Declare @ETLCartesian VARCHAR(50)
Declare @Sql NVARCHAR(Max)
Declare @Sql2 NVARCHAR(Max)

Set @ETLCartesian = 'dbo.BASFCartesian'

-- Create a new table called '[TableName]' in schema '[dbo]' and Drop the table if it already exists
IF OBJECT_ID(@ETLCartesian, 'U') IS NOT NULL
 Set @SQL = 'DROP Table @ETLCartesian'
GO

-- Create the table in the specified schema
Set SQL2 = 'CREATE TABLE @ETLCartesian(
        OriginZone varchar(30) NOT NULL,
        OriginZone1 varchar(30) NOT NULL,
        DestinationZone varchar(30) NOT NULL,
        Rates FLOAT(10) not NULL
    );'
GO
        Insert Into @ETLCartesian(OriginZone, OriginZone1, DestinationZone, Rates)
         Select OriginZone, column2 'OriginZone1', Column1 'DestinationZone', Rates
         From (
            SELECT *
            From dbo.BASFMatrix
            UNPIVOT (Rates For OriginZone IN
                (USAL, USAZ1, USAZ11, USAZ2, USAZ22, USAR, USCA1, USCA2, USCO1, USCO11, USCO2, USCO22, USCT, USDE, USFL1, USFL2, USGA, USGA2, USID, USIL, USIN, USIA, USKS, USKY, USLA, USME, USMDDC, USMDDC1, USMA, USMI1, USMI2, USMN, USMS, USMO, USMT, USNE, USNV1, USNV11, USNV111, USNV2, USNV22, USNV222, USNH, USNJ1, USNJ2, USNM1, USNM2, USNM22, USNY1, USNY2, USNY3, USNC1, USNC11, USNC111, USNC2, USNC22, USND, USOH, USOK, USOR, USPA1, USPA2, USRI, USSC, USSD, USTN, USTX1, USTX2, USTX22, USTX3, USUT1, USUT2, USVT, USVA1, USVA11, USWA, USWV, USWI, USWY)
            )  as unpvt
        ) p;

        Select * 
        From @ETLCartesian
        Pivot( Count(OriginZone)
            For DestinationZone   --column that contains the values that will become column headers
            in (USAL, USAZ1, USAZ11, USAZ2, USAZ22, USAR, USCA1, USCA2, USCO1, USCO11, USCO2, USCO22, USCT, USDE, USFL1, USFL2, USGA, USGA2, USID, USIL, USIN, USIA, USKS, USKY, USLA, USME, USMDDC, USMDDC1, USMA, USMI1, USMI2, USMN, USMS, USMO, USMT, USNE, USNV1, USNV11, USNV111, USNV2, USNV22, USNV222, USNH, USNJ1, USNJ2, USNM1, USNM2, USNM22, USNY1, USNY2, USNY3, USNC1, USNC11, USNC111, USNC2, USNC22, USND, USOH, USOK, USOR, USPA1, USPA2, USRI, USSC, USSD, USTN, USTX1, USTX2, USTX22, USTX3, USUT1, USUT2, USVT, USVA1, USVA11, USWA, USWV, USWI, USWY)
        ) as pvt;

COMMIT        


