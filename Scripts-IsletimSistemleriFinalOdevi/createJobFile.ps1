Set-ExecutionPolicy RemoteSigned

<# Odevi iki farkli algoritma ile yaptigimiz icin her bir algoritma icin ayri ayri schedule job ve powershell Script dosyalari olusturduk. #>

<# 

 Eger size gonderdigimiz "Scripts-IsletimSistemleriFinalOdevi" adli klasor masaustunde degilse bu klasoru masaustune almayi ve asagidaki -Argument kisminde Scriptimizin yolunda bulunan "Umut" yazisini kendi user name'nize gore degistirmenizi
 rica ederiz.  
 
 #>

<# 1. algoritma için job #>

<# Her gün saat sabah 10:00'da yolunu belirttiğimiz powershell script'ini çalıştıran "algoritmaTask1 adında bir schedule job oluşturuyoruz. #>

$action = New-ScheduledTaskAction -Execute 'Powershell.exe'  -Argument 'C:\Users\Umut\Desktop\Scripts-IsletimSistemleriFinalOdevi\algoritma1.ps1'

$trigger =  New-ScheduledTaskTrigger -Daily -At 10am

Register-ScheduledTask -Action $action  -Trigger $trigger -TaskName "algoritmaTask1" 






<# 2. algoritma için job #>

<# Her gün saat sabah 10:00'da yolunu belirttiğimiz powershell script'ini çalıştıran "algoritmaTask2 adında bir schedule job oluşturuyoruz. #>

$action = New-ScheduledTaskAction -Execute 'Powershell.exe'  -Argument 'C:\Users\Umut\Desktop\Scripts-IsletimSistemleriFinalOdevi\algoritma2.ps1'

$trigger =  New-ScheduledTaskTrigger -Daily -At 10am

Register-ScheduledTask -Action $action  -Trigger $trigger -TaskName "algoritmaTask2" 


