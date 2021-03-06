﻿function Close-NetworkStream {
    Param (
        [Parameter(Position = 0)]
        [String]$Mode,
    
        [Parameter(Position = 1)]
        [Object]$Stream
    )    
    switch ($Mode) {
        'Smb' { 
            try { $Stream.Pipe.Dispose() }
            catch { Write-Verbose "Failed to dispose Smb stream. $($_.Exception.Message)." }
            continue 
        }
        'Tcp' { 
            try { 
                if ($PSVersionTable.CLRVersion.Major -lt 4) { $Stream.Socket.Close() ; $Stream.TcpStream.Close() }
                else { $Stream.Socket.Dispose() ; $Stream.TcpStream.Dispose() }
            }
            catch { Write-Verbose "Failed to dispose Tcp socket. $($_.Exception.Message)." }
            continue 
        }
        'Udp' { 
            try { 
                if ($PSVersionTable.CLRVersion.Major -lt 4) { $Stream.Socket.Close() ; $Stream.UdpClient.Close() }
                else { $Stream.Socket.Dispose() ; $Stream.UdpClient.Dispose() }
            }
            catch { Write-Verbose "Failed to dispose Udp socket. $($_.Exception.Message)." }
        }
    }
}