#Este programa funciona para rastrear las direcciones ip de las conexiones establecidas con la PC.
#Esto podría permitir detectar un APT no identificado.

$conexiones = (Get-NetTCPConnection | Select RemoteAddress,State | Where-Object {$_.State -like 'Established' -and $_.RemoteAddress -notlike '127.0.0.1'} | Select RemoteAddress)

ForEach ($con in $conexiones){
    $ip = $con.RemoteAddress
    echo "[+] Informacion de IP: $ip"
    Invoke-WebRequest -Uri "http://ip-api.com/json/$ip" | Select-Object -Expand Content | ConvertFrom-Json | Select status,country,regionname,city,lat,long,isp,org,query
}