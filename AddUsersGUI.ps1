#Creates Base Window
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework

$Screen = New-Object System.Windows.Forms.Form
$Screen.Text = "Active Directory"
$Screen.Size = New-Object System.Drawing.Size(650,400)
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
	$fullName = $FirstName.Text + " " + $LastName.Text
	$emailAddr = $FirstName.Text[0] + "." + $LastName.Text + "@magicTestDomain.test"
	$defaultPassword = ConvertTo-SecureString -String "P@55c0de1" -AsPlainText -Force
	
	New-ADUser -Name $fullName -GivenName $FirstName.Text -Surname $LastName.Text -EmailAddress $emailAddr -Title $selectTitle.Text -AccountPassword $defaultPassword 
	if ($?) {
		$popupComplete = [System.Windows.MessageBox]::Show('User has been created','Completed')
		$FirstName.Clear()
		$MiddleName.Clear()
		$LastName.Clear()
		$selectTitle.SelectedIndex = -1
	} else {
		$popupFailed = [System.Windows.MessageBox]::Show('User failed to be created','Failed','Ok','Error')
	}
}

#Titles 
$Column = New-Object System.Windows.Forms.Label
$Column.Text = "First Name"
$Column.Location = New-Object System.Drawing.Point(10,10)
$Column.Size = New-Object System.Drawing.Size(80,20)
$Screen.Controls.Add($Column)

#Middle Initial (Optional) Title
$ColumnM = New-Object System.Windows.Forms.Label
$ColumnM.Text = "Middle Initial"
$ColumnM.Location = New-Object System.Drawing.Point(120,10)
$ColumnM.Size = New-Object System.Drawing.Size(80,20)
$Screen.Controls.Add($ColumnM)

#Last Name Title
$columnL = New-Object System.Windows.Forms.Label
$columnL.Text = "Last Name"
$columnL.Location = New-Object System.Drawing.Point(200,10)
$columnL.Size = New-Object System.Drawing.Size(80,20)
$Screen.Controls.Add($columnL)

#Job Title
$jobTitle = New-Object System.Windows.Forms.Label
$jobTitle.Text = "Title"
$jobTitle.Location = New-Object System.Drawing.Point(340,10)
$jobTitle.Size = New-Object System.Drawing.Size(80,20)
$Screen.Controls.Add($jobTitle)

#-----------------------------------------------------------
#End of title labels
#-----------------------------------------------------------

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
$LastName = New-Object System.Windows.Forms.TextBox
$LastName.Location = New-Object System.Drawing.Point(200,30)
$LastName.Size = New-Object System.Drawing.Size(100,30)
$Screen.Controls.Add($LastName)

#Select Title ComboBox
$selectTitle = New-Object System.Windows.Forms.ComboBox
$selectTitle.Location = New-Object System.Drawing.Point(340,30)
$selectTitle.Size = New-Object System.Drawing.Size(100,30)

#Hastable that contains that Titles for the Users
$titleList = @{Accountant = "$Accountant";Developer = "$Developer"}
$selectTitle.items.addRange($titleList.keys)
$selectTitle.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

$Screen.Controls.Add($selectTitle)

#---------------------------------------------------------------------------



#Creates a Primary button that will allow you to create new rows
$addRowButton = New-Object System.Windows.Forms.Button
$addRowButton.Location = New-Object System.Drawing.Point(550,10)
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
