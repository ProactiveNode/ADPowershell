#Creates Base Window
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Screen = New-Object System.Windows.Forms.Form
$Screen.Text = "Active Directory"
$Screen.Size = New-Object System.Drawing.Size(450,400)
$Global:counter = 30

#Creates the new rows
$createNewRow = {
	$Global:counter = $Global:counter + 30
	$newRow = New-Object System.Windows.Forms.TextBox
	$newRow.Location = New-Object System.Drawing.Point(10,$counter)
	$newRow.Size = New-Object System.Drawing.Size(100,$counter)
	$Screen.Controls.Add($newRow)
}

$createUser = {
	New-ADUser "$FirstName.Text $LastName.Text"
}

#Titles 
$Column = New-Object System.Windows.Forms.Label
$Column.Text = "First Name"
$Column.Location = New-Object System.Drawing.Point(10,10)
$Screen.Controls.Add($Column)

#Middle Initial (Optional) Title
$ColumnM = New-Object System.Windows.Forms.Label
$ColumnM.Text = "Middle Initial"
$ColumnM.Location = New-Object System.Drawing.Point(120,10)
$ColumnM.Size = New-Object System.Drawing.Size(80,20)
$Screen.Controls.Add($ColumnM)

#Last Name Title
$ColumnL = New-Object System.Windows.Forms.Label
$ColumnL.Text = "Last Name"
$ColumnL.Location = New-Object System.Drawing.Point(200,10)
$ColumnL.Size = New-Object System.Drawing.Size(80,20)
$Screen.Controls.Add($ColumnL)

#First Name Box
$FirstName = New-Object System.Windows.Forms.TextBox
$FirstName.Location = New-Object System.Drawing.Point(10,30)
$FirstName.Size = New-Object System.Drawing.Size(100,30)
$Screen.Controls.Add($FirstName)

#Middle Initial (Optional) Name Box
$MiddleName = New-Object System.Windows.Forms.TextBox
$MiddleName.Location = New-Object System.Drawing.Point(140,30)
$MiddleName.Size = New-Object System.Drawing.Size(30,30)
$Screen.Controls.Add($MiddleName)

#Last Name Box
$FirstName = New-Object System.Windows.Forms.TextBox
$FirstName.Location = New-Object System.Drawing.Point(200,30)
$FirstName.Size = New-Object System.Drawing.Size(100,30)
$Screen.Controls.Add($FirstName)

#Creates a Primary button that will allow you to create new rows
$addRowButton = New-Object System.Windows.Forms.Button
$addRowButton.Location = New-Object System.Drawing.Point(350,10)
$addRowButton.Size = New-Object System.Drawing.Size(70,20)
$addRowButton.Text = "Make Row"
$addRowButton.add_Click($createNewRow)
$Screen.Controls.Add($addRowButton)

#Create Users Button
$addUserButton = New-Object System.Windows.Forms.Button
$addUserButton.Location = New-Object System.Drawing.Point(300,300)
$addUserButton.Size = New-Object System.Drawing.Size(100,20)
$addUserButton.Text = "Create Users"
$addUserButton.add_Click($createUser)
$Screen.Controls.Add($addUserButton) 

#Displays the Final Window with everything on it
$Screen.ShowDialog()
