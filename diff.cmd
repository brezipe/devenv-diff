<# : chooser.bat
:: launches a File... Open sort of file chooser and outputs choice(s) to the console
:: https://stackoverflow.com/a/15885133/1683264

@echo off
setlocal

for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    echo You chose %%~I
)
goto :EOF

: end Batch portion / begin PowerShell hybrid chimera #>

Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd
: $f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
$f.Filter = "All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $false
[void]$f.ShowDialog()
: if ($f.Multiselect) { $f.FileNames } else { notepad $f.FileName }

$f2 = new-object Windows.Forms.OpenFileDialog
$f2.InitialDirectory = pwd
$f2.Filter = "All Files (*.*)|*.*"
$f2.ShowHelp = $true
$f2.Multiselect = $false
[void]$f2.ShowDialog()

$devenv = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe"
$arg1 = "/diff"

& $devenv $arg1 $f.FileName $f2.FileName
