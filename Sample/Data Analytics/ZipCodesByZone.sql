--3 digit State to State zip codes listed for contract interpretation

Select Cast(ZipCodeCodeMax as VARCHAR) as 'ZipCodeCodeMax', Cast(ZipCodeCodeMin as VARCHAR) as 'ZipCodeCodeMin', StateCode
From (
    SELECT  Min(Left(ZipCodeCode,3)) AS ZipCodeCodeMin, Max(Left(ZipCodeCode,3)) AS ZipCodeCodeMax, StateCode
    FROM            someZipCodeTable
    Group By StateCode) x
Order by StateCode