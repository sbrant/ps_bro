foreach($line in Get-Content ~/wip/bro/http.log) {
    # capture fields
    if($line -match '^\#fields.*') {
        $mod_line = $line.TrimStart("#fields  ").TrimStart()
        $split_line = $mod_line.Split("`t")
    # discard comments    
    } elseif ($line -match '^\#+') {
        Continue
    # write data fields to clean file
    } else {
        Write-Output $line | Out-File -Append -FilePath "~/wip/bro/http.clean.csv"
    }
}
Import-Csv ~/wip/bro/http.clean.csv -Header $split_line -Delimiter `t | ConvertTo-Json -Compress | Out-File -FilePath "~/wip/bro/dns.json"

