param([int]$Port = 8765)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path

$Required = @(
    (Join-Path $Root "vendor\three\three.core.js"),
    (Join-Path $Root "vendor\three\three.module.js"),
    (Join-Path $Root "vendor\three\addons\controls\OrbitControls.js"),
    (Join-Path $Root "vendor\three\addons\controls\TransformControls.js")
)

foreach ($Path in $Required) {
    if (!(Test-Path $Path)) {
        Write-Host ""
        Write-Host "Offline libraries are missing."
        Write-Host "Double-click Prepare_Offline.bat once while connected to the internet."
        Write-Host ""
        Read-Host "Press Enter to close"
        exit 2
    }
}

function Get-MimeType([string]$Path) {
    switch ([IO.Path]::GetExtension($Path).ToLowerInvariant()) {
        ".html" { "text/html; charset=utf-8" }
        ".js"   { "text/javascript; charset=utf-8" }
        ".json" { "application/json; charset=utf-8" }
        ".css"  { "text/css; charset=utf-8" }
        ".png"  { "image/png" }
        ".ico"  { "image/x-icon" }
        ".svg"  { "image/svg+xml" }
        default { "application/octet-stream" }
    }
}

$Listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port)
try {
    $Listener.Start()
} catch {
    $Port = 8766
    $Listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port)
    $Listener.Start()
}

$Url = "http://127.0.0.1:$Port/MagneticCAD.html"
Write-Host ""
Write-Host "Magnetic CAD Playground - offline"
Write-Host $Url
Write-Host "Keep this window open while using the application."
Write-Host ""
Start-Process $Url

try {
    while ($true) {
        $Client = $Listener.AcceptTcpClient()
        try {
            $Stream = $Client.GetStream()
            $Reader = New-Object System.IO.StreamReader($Stream, [Text.Encoding]::ASCII, $false, 4096, $true)
            $RequestLine = $Reader.ReadLine()
            if ([string]::IsNullOrWhiteSpace($RequestLine)) { continue }

            while ($true) {
                $Line = $Reader.ReadLine()
                if ([string]::IsNullOrEmpty($Line)) { break }
            }

            $Parts = $RequestLine.Split(" ")
            $Method = $Parts[0]
            $RawPath = $Parts[1].Split("?")[0]

            if ($Method -ne "GET" -and $Method -ne "HEAD") {
                $Body = [Text.Encoding]::UTF8.GetBytes("Method not allowed")
                $Header = "HTTP/1.1 405 Method Not Allowed`r`nContent-Type: text/plain; charset=utf-8`r`nContent-Length: $($Body.Length)`r`nConnection: close`r`n`r`n"
                $HeaderBytes = [Text.Encoding]::ASCII.GetBytes($Header)
                $Stream.Write($HeaderBytes,0,$HeaderBytes.Length)
                if ($Method -ne "HEAD") { $Stream.Write($Body,0,$Body.Length) }
                continue
            }

            $Decoded = [Uri]::UnescapeDataString($RawPath.TrimStart("/"))
            if ([string]::IsNullOrWhiteSpace($Decoded)) { $Decoded = "MagneticCAD.html" }

            $Candidate = [IO.Path]::GetFullPath((Join-Path $Root $Decoded))
            $RootFull = [IO.Path]::GetFullPath($Root)

            if (!$Candidate.StartsWith($RootFull, [StringComparison]::OrdinalIgnoreCase) -or !(Test-Path $Candidate -PathType Leaf)) {
                $Body = [Text.Encoding]::UTF8.GetBytes("Not found")
                $Header = "HTTP/1.1 404 Not Found`r`nContent-Type: text/plain; charset=utf-8`r`nContent-Length: $($Body.Length)`r`nConnection: close`r`n`r`n"
                $HeaderBytes = [Text.Encoding]::ASCII.GetBytes($Header)
                $Stream.Write($HeaderBytes,0,$HeaderBytes.Length)
                if ($Method -ne "HEAD") { $Stream.Write($Body,0,$Body.Length) }
                continue
            }

            $Bytes = [IO.File]::ReadAllBytes($Candidate)
            $Mime = Get-MimeType $Candidate
            $Header = "HTTP/1.1 200 OK`r`nContent-Type: $Mime`r`nContent-Length: $($Bytes.Length)`r`nCache-Control: no-cache`r`nConnection: close`r`n`r`n"
            $HeaderBytes = [Text.Encoding]::ASCII.GetBytes($Header)
            $Stream.Write($HeaderBytes,0,$HeaderBytes.Length)
            if ($Method -ne "HEAD") { $Stream.Write($Bytes,0,$Bytes.Length) }
        } catch {
        } finally {
            $Client.Close()
        }
    }
} finally {
    $Listener.Stop()
}
