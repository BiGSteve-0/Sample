--%%%%%%%%%%%%%%%%% Recording Errors with Extended Events %%%%%%%%%%%%%%%%%%%%%%%%%

CREATE EVENT SESSION [Errors_Reported]
ON DATABASE
    ADD EVENT sqlserver.error_reported
    (ACTION
     (
         mdmtargetpkg.mdmget_TimeStampUTC,
         sqlserver.client_app_name,
         sqlserver.client_hostname,
         sqlserver.context_info,
         sqlserver.database_name,
         sqlserver.sql_text
     )
     WHERE (                                                -- set the severity when you for the errors
               ([package0].[greater_than_int64]([severity], (10))) -- anything below 10 is considered minor
               AND ([sqlserver].[not_equal_i_sql_unicode_string]([sqlserver].[sql_text], N'''Select @@SPID'''))
           )
    )
    ADD TARGET package0.event_file
    (SET filename = N'some blob storage directory', max_file_size = (256)) -- KB of course
WITH
(
    STARTUP_STATE = ON
)
GO


-- Throw a database error
-- below 102 is just a warning
Raiserror('MyError', 11,1);
Go

-- Querying Extented Events
SELECT
     obj1.name as [XEvent-name],
     col2.name as [XEvent-column],
     obj1.description as [Descr-name],
     col2.description as [Descr-column]
  FROM
               sys.dm_xe_objects        as obj1
      JOIN sys.dm_xe_object_columns as col2 on col2.object_name = obj1.name
      Where obj1.description like '%null%'
  ORDER BY
    obj1.name,
    col2.name;
Go

