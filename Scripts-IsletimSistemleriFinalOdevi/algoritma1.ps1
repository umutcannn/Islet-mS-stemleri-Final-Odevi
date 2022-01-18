<#                             --------------------------------------------------------------------------------- 1. ALGORİTMA ----------------------------------------------------------------------- #>


<#
 - Bize lazim olan bilgileri ayri ayri depolamak icin "ProcessName" , "CPU" ve "ID" adli 3 tane dizi olusturduk ve Select-Object methodu ile bu bilgileri tek bir seferde cekebilmek icin bu dizilerin hepsini kapsayan "properties" adinda 
   bir ana dizi olusturduk.
 
 - Daha sonra bu bilgileri Get-WmiObject methodu ile cekip "data1" adli degiskene atadik.

 - Get-WmiObject methodu,sizin bizden istediginiz zaman  ve program yolunu bize vermedigi icin biz bu bilgileri Get-Process methodu ile alip "data2" adli degiskene atadik ve daha sonrasinda bu iki methodun tek ortak noktasi olan " Process ID'leri " 
   if blogu icerisinde kesistirerek ilgili programimizin butun bilgilerini cekmeyi basardik.

   En sonunda da bilgilerimizi , D klasoru altinda "algoritma1Log" adli txt dosyamiza yazdirdik. 

#>

$properties=@(
    @{Name="ProcessName"; Expression = {$_.name}},
    @{Name="CPU"; Expression = {$_.PercentProcessorTime}},
    @{Name="ID"; Expression = {$_.IDProcess}}
)


$data1=Get-WmiObject  -class  Win32_PerfFormattedData_PerfProc_Process | WHERE PercentProcessorTime -GT 10  | Select-Object $properties 
$data2=Get-Process | Sort-Object CPU -Descending | Select-Object  Id,NAME,Path, CPU, StartTime 


foreach($k in $data1)
{
foreach($j in $data2)
{
if($k.ID -eq $j.ID){
( '  ID :'+($k.ID) + ' Name :'+($k.ProcessName) +  '  Path :' +($j.Path) +'   CPU Using(%) :' +($k.CPU) +'   Start Time :' +($j.StartTime)  )| Format-Table |Out-File "D:\algoritma1Log.txt" -Append 

}
}
}








