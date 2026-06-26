$employees = Import-Csv "$PSScriptRoot/../employees.csv"

foreach ($employee in $employees) {

    $upn = "$($employee.firstname).$($employee.lastname)@yourdomain.com".ToLower()
    $displayName = "$($employee.firstname) $($employee.lastname)"

    Write-Host "Processing: $displayName - Status: $($employee.status)"

    if ($employee.status -eq "active") {

        Write-Host "JOINER DETECTED: Creating user $upn"

        $passwordProfile = @{
            Password = "TempP@ssword123!"
            ForceChangePasswordNextSignIn = $true
        }

        New-MgUser `
            -DisplayName $displayName `
            -UserPrincipalName $upn `
            -MailNickname "$($employee.firstname)$($employee.lastname)" `
            -AccountEnabled `
            -PasswordProfile $passwordProfile `
            -Department $employee.department `
            -JobTitle $employee.jobTitle `
            -UsageLocation "US"

    }
    elseif ($employee.status -eq "inactive") {

        Write-Host "LEAVER DETECTED: Disabling user $upn"

        $user = Get-MgUser -Filter "userPrincipalName eq '$upn'"

        if ($user) {
            Update-MgUser -UserId $user.Id -AccountEnabled:$false
            Revoke-MgUserSignInSession -UserId $user.Id
            Write-Host "Disabled and revoked sessions for $upn"
        }
        else {
            Write-Host "User not found: $upn"
        }

    }
    elseif ($employee.status -eq "moved") {

        Write-Host "MOVER DETECTED: Updating user $upn"

        $user = Get-MgUser -Filter "userPrincipalName eq '$upn'"

        if ($user) {
            Update-MgUser `
                -UserId $user.Id `
                -Department $employee.department `
                -JobTitle $employee.jobTitle

            Write-Host "Updated department/job title for $upn"
        }
        else {
            Write-Host "User not found: $upn"
        }
    }
}