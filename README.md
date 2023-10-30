# UE123 - AWS Terraform

Wochenprojekt: 
Diese Woche wollen wir eine kleine Serverless Architektur bauen, die die neu gelernten Services  miteinander verbindet. 
Denkt euch etwas aus, dass die Services SQS, SNS, Lambda und DynamoDB miteinander verbindet. 

Mögliche Vorschläge: 
Eine Datei wird in einen S3 Bucket gelegt und SNS reagiert, informiert SQS, die es weiterleitet an eine Lambdafunktion, welche dann den Namen der Datei mit Uhrzeit in eine DynamoDB schreibt.



