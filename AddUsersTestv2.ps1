#Creates Base Window
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework

$Screen = New-Object System.Windows.Forms.Form
$Screen.Text = "Active Directory"
$Screen.Size = New-Object System.Drawing.Size(440,290)
#$Screen.MaximizeBox = $False
#$Screen.MinimizeBox = $False
$Global:counter = 30

$createUser = {
	if ($firstName.Text -eq '' -And $lastName.Text -eq '' -And $selectTitle.Text -eq '') {
		#Write-Host "Fields are empty"
	} elseif ($firstName.Text -ne '' -And $lastName.Text -eq '' -And $selectTitle.Text -eq '') {
		Write-host "Error First Row: Missing Last Name and Title"
	} elseif ($firstName.Text -eq '' -And $lastName.Text -ne '' -And $selectTitle.Text -eq '') {
		Write-host "Error First Row: Missing First Name and Title"
	} elseif ($firstName.Text -ne '' -And $lastName.Text -ne '' -And $selectTitle.Text -eq '') {
		Write-Host "Error First Row: Empty Title"
	} elseif ($firstName.Text -eq '' -And $lastName.Text -eq '' -And $selectTitle.Text -ne '') {
		Write-Host "Error First Row: Missing First and Last Name"
	} elseif ($firstName.Text -eq '' -And $lastName.Text -eq '' -And $selectTitle.Text -ne '') {
		Write-Host "Error First Row: Missing First and Last Name"
	} elseif ($firstName.Text -eq '' -And $lastName.Text -ne '' -And $selectTitle.Text -ne '') {
		Write-Host "Error First Row: Missing First Name"
	} elseif ($firstName.Text -ne '' -And $lastName.Text -eq '' -And $selectTitle.Text -ne '') {
		Write-Host "Error First Row: Missing Last Name"
	}else {
		$fullName = $firstName.Text + " " + $lastName.Text
		$emailAddr = $firstName.Text[0] + "." + $lastName.Text + "@magicTestDomain.test"
		$defaultPassword = $passwordTextBox.Text | ConvertTo-SecureString -AsPlainText -Force
		New-ADUser -Name $fullName -GivenName $firstName.Text -Surname $lastName.Text -EmailAddress $emailAddr -Title $selectTitle.Text -AccountPassword $defaultPassword
		if ($?) {
			if ($selectTitle.Text -eq 'Accountant') {
                $addAccountant = @("Account-Grp","Chicago"); ForEach ($grp in $addAccountant) {Add-ADPrincipalGroupMembership $fullName -MemberOf $Grp }
            }
			$popupComplete = [System.Windows.MessageBox]::Show('User has been created','Completed')
		} else {
			$popupFailed = [System.Windows.MessageBox]::Show('User failed to be created','Failed','Ok','Error')
		}
	}
	
	if ($firstName2.Text -eq '' -And $lastName2.Text -eq '' -And $selectTitle2.Text -eq '') {
		#Write-Host "Fields are empty"
	} elseif ($firstName2.Text -ne '' -And $lastName2.Text -eq '' -And $selectTitle2.Text -eq '') {
		Write-host "Error Second Row: Missing Last Name"
	} elseif ($firstName2.Text -eq '' -And $lastName2.Text -ne '' -And $selectTitle2.Text -eq '') {
		Write-host "Error Second Row: Missing First Name"
	} elseif ($firstName2.Text -ne '' -And $lastName2.Text -ne '' -And $selectTitle2.Text -eq '') {
		Write-Host "Error Second Row: Missing Title"
	} elseif ($firstName2.Text -eq '' -And $lastName2.Text -eq '' -And $selectTitle2.Text -ne '') {
		Write-Host "Error Second Row: Missing First and Last Name"
	} elseif ($firstName2.Text -eq '' -And $lastName2.Text -ne '' -And $selectTitle2.Text -ne '') {
		Write-Host "Error Second Row: Missing First Name"
	} elseif ($firstName2.Text -ne '' -And $lastName2.Text -eq '' -And $selectTitle2.Text -ne '') {
		Write-Host "Error Second Row: Missing Last Name"
	}else {
		Write-Host "Good to Go"
	}
}
#-----------------------
$colL = 10
$col1 = 40
$col2 = 160
$col3 = 280
#-----------------------
#Labels
#-----------------------

$row1 = New-Object System.Windows.Forms.Label
$row1.Text = 1
$row1.Location = New-Object System.Drawing.Point(10,$counter)
$row1.Size = New-Object System.Drawing.Size(20,30)
$Screen.Controls.Add($row1)
	
$row2 = New-Object System.Windows.Forms.Label
$row2.Text = 2
$row2.Location = New-Object System.Drawing.Point(10,($counter*2))
$row2.Size = New-Object System.Drawing.Size(20,30)
$Screen.Controls.Add($row2)

#Titles 
$labelFirst = New-Object System.Windows.Forms.Label
$labelFirst.Text = "First Name"
$labelFirst.Location = New-Object System.Drawing.Point($col1,10)
$labelFirst.Size = New-Object System.Drawing.Size(80,20)
$Screen.Controls.Add($labelFirst)

#Last Name Title
$labelLast = New-Object System.Windows.Forms.Label
$labelLast.Text = "Last Name"
$labelLast.Location = New-Object System.Drawing.Point($col2,10)
$labelLast.Size = New-Object System.Drawing.Size(80,20)
$Screen.Controls.Add($labelLast)

#Job Title
$jobTitle = New-Object System.Windows.Forms.Label
$jobTitle.Text = "Title"
$jobTitle.Location = New-Object System.Drawing.Point($col3,10)
$jobTitle.Size = New-Object System.Drawing.Size(80,20)
$Screen.Controls.Add($jobTitle)

#-----------------------------------------------------------
#End of title labels
#-----------------------------------------------------------

#First Name Box
$firstName = New-Object System.Windows.Forms.TextBox
$firstName.Location = New-Object System.Drawing.Point($col1,30)
$firstName.Size = New-Object System.Drawing.Size(100,30)
$Screen.Controls.Add($firstName)

$firstName2 = New-Object System.Windows.Forms.TextBox
$firstName2.Location = New-Object System.Drawing.Point($col1,60)
$firstName2.Size = New-Object System.Drawing.Size(100,30)
$Screen.Controls.Add($firstName2)

#Last Name Box
$lastName = New-Object System.Windows.Forms.TextBox
$lastName.Location = New-Object System.Drawing.Point($col2,30)
$lastName.Size = New-Object System.Drawing.Size(100,30)
$Screen.Controls.Add($lastName)

$lastName2 = New-Object System.Windows.Forms.TextBox
$lastName2.Location = New-Object System.Drawing.Point($col2,60)
$lastName2.Size = New-Object System.Drawing.Size(100,30)
$Screen.Controls.Add($lastName2)

#Select Title ComboBox
$selectTitle = New-Object System.Windows.Forms.ComboBox
$selectTitle.Location = New-Object System.Drawing.Point($col3,30)
$selectTitle.Size = New-Object System.Drawing.Size(100,30)

$selectTitle2 = New-Object System.Windows.Forms.ComboBox
$selectTitle2.Location = New-Object System.Drawing.Point($col3,60)
$selectTitle2.Size = New-Object System.Drawing.Size(100,30)

$titleList2 = @{'' = ""; Accountant = "$Accountant"; Developer = "$Developer"}
$selectTitle2.items.addRange($titleList2.keys)
$selectTitle2.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$Screen.Controls.Add($selectTitle2)

#Hastable that contains that Titles for the Users
$titleList = @{'' = ""; Accountant = "$Accountant"; Developer = "$Developer"}
$selectTitle.items.addRange($titleList.keys)
$selectTitle.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList

$Screen.Controls.Add($selectTitle)

#---------------------------------------------------------------------------
$labelPass = New-Object System.Windows.Forms.Label
$labelPass.Text = "Enter Default Password for New Users"
$labelPass.Location = New-Object System.Drawing.Point(30,150)
$labelPass.Size = New-Object System.Drawing.Size(250,20)
$Screen.Controls.Add($labelPass)

$passwordTextBox = New-Object System.Windows.Forms.MaskedTextBox
$passwordTextBox.Location = New-Object System.Drawing.Point(30,170)
$passwordTextBox.Size = New-Object System.Drawing.Size(80,60)
$passwordTextBox.PasswordChar = "*"
$Screen.Controls.Add($passwordTextBox)

#Create Users Button
$addUserButton = New-Object System.Windows.Forms.Button
$addUserButton.Location = New-Object System.Drawing.Point(180,200)
$addUserButton.Size = New-Object System.Drawing.Size(100,20)
$addUserButton.Text = "Create Users"
$addUserButton.add_Click($createUser)
$Screen.Controls.Add($addUserButton) 

#Displays the Final Window with everything on it
$Screen.ShowDialog()
