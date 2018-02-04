foreach($line in Get-Content ~/temp/dns.log) {
    # capture fields
    if($line -match '^\#fields.*') {
        $mod_line = $line.TrimStart("#fields  ").TrimStart()
        $split_line = $mod_line.Split("`t")
    # discard comments    
    } elseif ($line -match '^\#+') {
        Continue
    # write data fields to clean file
    } else {
        Write-Output $line | Out-File -Append -FilePath "~/temp/dns.clean.csv"
    }
}
Import-Csv ~/temp/dns.clean.csv -Header $split_line -Delimiter `t | ConvertTo-Json -Compress | Out-File -FilePath "~/temp/dns.json"

