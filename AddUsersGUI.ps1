#Creates Base Window
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$Screen = New-Object System.Windows.Forms.Form
$Screen.Text = "Active Directory"
$Screen.Size = New-Object System.Drawing.Size(550,400)

#Titles 
$Column = New-Object System.Windows.Forms.Label
$Column.Text = "First Name"
$Column.Location = New-Object System.Drawing.Point(10,10)
$Screen.Controls.Add($Column)

#First Name Box
$FirstName = New-Object System.Windows.Forms.TextBox
$FirstName.Location = New-Object System.Drawing.Point(10,30)
$FirstName.Size = New-Object System.Drawing.Size(100,30)

$Screen.Controls.Add($FirstName)


#Displays the Final Window with everything on it
$Screen.ShowDialog()
