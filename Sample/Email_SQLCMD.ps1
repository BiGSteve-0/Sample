#Emailing User Query Results

$Alerts = invoke-sqlcmd -ServerInstance dbserver -Database dbname -Query "SELECT * FROM some_table" | SELECT Severity, ServerName, Heading | ConvertTo-Html | Out-String
$Alerts = $Alerts.Replace("</head>", "<style> TD {padding-left: 2mm}</style></head>")
Send-MailMessage -To me@mycompany.com -From me@mycompany.com -BodyAsHtml $Alerts -Subject "Alerts" -SmtpServer "smtp.mycompany.com"