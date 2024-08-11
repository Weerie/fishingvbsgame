Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Fishing Adventure"
$form.Size = New-Object System.Drawing.Size(500,400)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Create labels for displaying game information
$resultLabel = New-Object System.Windows.Forms.Label
$resultLabel.Location = New-Object System.Drawing.Point(10,10)
$resultLabel.Size = New-Object System.Drawing.Size(460,50)
$form.Controls.Add($resultLabel)

$scoreLabel = New-Object System.Windows.Forms.Label
$scoreLabel.Location = New-Object System.Drawing.Point(10,70)
$scoreLabel.Size = New-Object System.Drawing.Size(460,30)
$form.Controls.Add($scoreLabel)

$trashLabel = New-Object System.Windows.Forms.Label
$trashLabel.Location = New-Object System.Drawing.Point(10,110)
$trashLabel.Size = New-Object System.Drawing.Size(460,30)
$form.Controls.Add($trashLabel)

$attemptsLabel = New-Object System.Windows.Forms.Label
$attemptsLabel.Location = New-Object System.Drawing.Point(10,150)
$attemptsLabel.Size = New-Object System.Drawing.Size(460,30)
$form.Controls.Add($attemptsLabel)

# Create a button to start the game
$startButton = New-Object System.Windows.Forms.Button
$startButton.Text = "Start Fishing"
$startButton.Location = New-Object System.Drawing.Point(180, 200)
$startButton.Size = New-Object System.Drawing.Size(120, 50)
$startButton.Add_Click({
    $global:attempts = 0
    $global:maxAttempts = 10
    $global:fishCount = 0
    $global:trashCount = 0
    $global:score = 0
    $global:fishing = $true
    [System.Windows.Forms.MessageBox]::Show("Fishing game started! Click OK to cast your line.", "Fishing Started", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    Start-Fishing
})
$form.Controls.Add($startButton)

# Function to show message with animation
function Show-MessageAnimation {
    param (
        [string]$message,
        [int]$duration
    )
    
    $animationForm = New-Object System.Windows.Forms.Form
    $animationForm.Text = "Fishing Animation"
    $animationForm.Size = New-Object System.Drawing.Size(300,100)
    $animationForm.StartPosition = "CenterScreen"
    $animationForm.FormBorderStyle = "FixedDialog"
    $animationForm.MaximizeBox = $false
    
    $animationLabel = New-Object System.Windows.Forms.Label
    $animationLabel.Text = $message
    $animationLabel.Location = New-Object System.Drawing.Point(10,10)
    $animationLabel.Size = New-Object System.Drawing.Size(280,30)
    $animationLabel.TextAlign = "MiddleCenter"
    $animationForm.Controls.Add($animationLabel)
    
    $animationForm.Show()
    Start-Sleep -Seconds $duration
    $animationForm.Close()
}

# Function to simulate fishing action
function Simulate-Fishing {
    $messages = @(
        "Casting your line...",
        "Waiting for a bite...",
        "Feeling a tug...",
        "Reeling in the catch!"
    )
    
    foreach ($msg in $messages) {
        Show-MessageAnimation -message $msg -duration 1
    }
}

# Function to handle the fishing attempt
function Fishing-Attempt {
    $global:attempts++
    
    if ($global:attempts -le $global:maxAttempts) {
        $dialogResult = [System.Windows.Forms.MessageBox]::Show("Attempt $($global:attempts): Do you want to cast your line and try to catch a fish?", "Fishing Attempt", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
        
        if ($dialogResult -eq [System.Windows.Forms.DialogResult]::Yes) {
            Simulate-Fishing
            
            # Random chance of catching a fish or junk
            $catchOutcome = Get-Random -Minimum 1 -Maximum 15
            
            switch ($catchOutcome) {
                # Fish Categories
                1 { $fishType = "a small Perch. (Common)"; $global:fishCount++; $global:score += 10 }
                2 { $fishType = "a Sunfish. (Common)"; $global:fishCount++; $global:score += 10 }
                3 { $fishType = "a Pike. (Uncommon)"; $global:fishCount++; $global:score += 20 }
                4 { $fishType = "a Carp. (Uncommon)"; $global:fishCount++; $global:score += 20 }
                5 { $fishType = "a Rainbow Trout. (Rare)"; $global:fishCount++; $global:score += 50 }
                6 { $fishType = "a Bluegill. (Rare)"; $global:fishCount++; $global:score += 50 }
                7 { $fishType = "a Legendary Golden Fish! (Legendary)"; $global:fishCount++; $global:score += 100 }
                8 { $fishType = "a Mythical Kraken Tentacle! (Legendary)"; $global:fishCount++; $global:score += 100 }
                9 { $fishType = "an old boot. Better luck next time!"; $global:trashCount++ }
                10 { $fishType = "a rusty can. It's not your day!"; $global:trashCount++ }
                11 { $fishType = "a tangle of seaweed. Maybe tomorrow!"; $global:trashCount++ }
                12 { $fishType = "a sunken treasure map! (Oops, it's unreadable.)"; $global:trashCount++ }
                13 { $fishType = "a broken fishing rod. Time for a new one!"; $global:trashCount++ }
                14 { $fishType = "a shiny new fishing lure! (Junk, but looks nice.)"; $global:trashCount++ }
            }
            
            # Update labels
            $resultLabel.Text = "You caught $fishType"
            $scoreLabel.Text = "Current Score: $($global:score) points"
            $trashLabel.Text = "Total Trash Collected: $($global:trashCount)"
            $attemptsLabel.Text = "Total Fish Caught: $($global:fishCount)"
        } else {
            [System.Windows.Forms.MessageBox]::Show("You've decided to stop fishing early. Hope you enjoyed the adventure!", "Fishing Ended", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
            $global:fishing = $false
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("You've used all your attempts. Final Score: $($global:score) points`nTotal Fish Caught: $($global:fishCount)`nTotal Trash Collected: $($global:trashCount).", "Fishing Complete", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        $global:fishing = $false
        Show-Leaderboard
    }
}

# Function to start fishing
function Start-Fishing {
    while ($global:fishing) {
        Fishing-Attempt
    }
}

# Function to display leaderboard
function Show-Leaderboard {
    $leaderboardForm = New-Object System.Windows.Forms.Form
    $leaderboardForm.Text = "Leaderboard"
    $leaderboardForm.Size = New-Object System.Drawing.Size(300,200)
    $leaderboardForm.StartPosition = "CenterScreen"
    $leaderboardForm.FormBorderStyle = "FixedDialog"
    $leaderboardForm.MaximizeBox = $false
    
    $leaderboardLabel = New-Object System.Windows.Forms.Label
    $leaderboardLabel.Text = "Final Score: $($global:score)`nTotal Fish Caught: $($global:fishCount)`nTotal Trash Collected: $($global:trashCount)"
    $leaderboardLabel.Location = New-Object System.Drawing.Point(10,10)
    $leaderboardLabel.Size = New-Object System.Drawing.Size(260,150)
    $leaderboardLabel.TextAlign = "MiddleCenter"
    $leaderboardForm.Controls.Add($leaderboardLabel)
    
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Text = "OK"
    $okButton.Location = New-Object System.Drawing.Point(100, 160)
    $okButton.Size = New-Object System.Drawing.Size(100, 30)
    $okButton.Add_Click({
        $leaderboardForm.Close()
    })
    $leaderboardForm.Controls.Add($okButton)
    
    $leaderboardForm.ShowDialog()
}

# Run the form
$form.Add_Shown({ $form.Activate() })
[System.Windows.Forms.Application]::Run($form)
