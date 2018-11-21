#Creates Base Window
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Screen = New-Object System.Windows.Forms.Form
$Screen.Text = "Active Directory"
$Screen.Size = New-Object System.Drawing.Size(550,400)
$Global:counter = 30

#Creates the new rows
$createNewRow = {
	$counter = $counter + 30
	$newRow = New-Object System.Windows.Forms.TextBox
	$newRow.Location = New-Object System.Drawing.Point(10,$counter)
	$newRow.Size = New-Object System.Drawing.Size(100,$counter)
	$Screen.Controls.Add($newRow)
}

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

#Creates a Primary button that will allow you to create new rows
$addRowButton = New-Object System.Windows.Forms.Button
$addRowButton.Location = New-Object System.Drawing.Point(120,10)
$addRowButton.Size = New-Object System.Drawing.Size(70,20)
$addRowButton.Text = "Make Row"
$addRowButton.add_Click($createNewRow)
$Screen.Controls.Add($addRowButton)

#Displays the Final Window with everything on it
$Screen.ShowDialog()
