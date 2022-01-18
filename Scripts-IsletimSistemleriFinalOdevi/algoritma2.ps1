<#                             --------------------------------------------------------------------------------- 2. ALGORİTMA ----------------------------------------------------------------------- #>




<#
  - Oncelikle Get-WMIObject methodu ile bilgisayarımızın çekirdek sayısını bulup "CpuCores" adli degiskene atadik.

  - Daha sonra Get-Counter methodu ile programlarımızın kullandigi CPU yüzdelik dilimini çekip "data1" adlı degiskene atadik.

    !!!!!!! Onemli : Gunlerdir kafa yordugumuz ve uzun arastirmalarimiz sonucu guzel bir kaynak bulup sorunu cozdugumuz Get-Counter methodu sizin bilgisayariniz Ingilizce dilinde oldugu icin calismayabilir.Powershell asagida kullandigimiz soz dizimlerini 
    bilgisayarimizin  diline gore otomatik olarak ceviriyormus.Yani  Get-Counter methodunda bulunan "\İşlem(*)\% İşlemci Zamanı" soz dizimini siz "\Process(*)\% Processor Time" olarak degistirmeniz gerekiyor.Buldugumuz kaynagi asagiya ekledik.

  - Kaynak :  https://powershellmagazine.com/2013/07/19/querying-performance-counters-from-powershell/

  - Get-Counter methodu;sizin bizden istediginiz zaman , Process id ve program yolunu bize vermedigi icin biz bu bilgileri Get-Process methodu ile alip "data2" adli degiskene atadik ve daha sonrasinda bu iki methodun tek ortak noktasi olan "Program isimlerini" if blogu icerisinde kesistirerek
    ilgili programimizin butun bilgilerini cekmeyi basardik.

  - En sonunda da bilgilerimizi , D klasoru altinda "algoritma2Log" adli txt dosyamiza yazdirdik. 

#>
$CpuCores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors

$data1=(Get-Counter "\İşlem(*)\% İşlemci Zamanı").CounterSamples | Select InstanceName, @{Name="CPU";Expression={[Decimal]::Round(($_.CookedValue / $CpuCores), 2)}} | sort *CPU -Descending  | WHERE CPU -GT 10 | SELECT *

$data2=Get-Process | Sort-Object CPU -Descending | Select-Object  Id,NAME,Path, CPU, StartTime 


foreach($k in $data1)
{
foreach($j in $data2)
{
if($k.InstanceName -eq $j.NAME){
( '  ID :'+($j.ID) + ' Name :'+($k.InstanceName) +  '  Path :' +($j.Path) +'   CPU Using(%) :' +($k.CPU) +'   Start Time :' +($j.StartTime)  )|  Format-Table |Out-File "D:\algoritma2Log.txt" -Append 

}
}
}