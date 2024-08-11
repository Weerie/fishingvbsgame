' Advanced interactive fishing game script with simulated animation

' Function to display a message box and return the user's choice
Function ShowMessage(message, buttons, title)
    ShowMessage = MsgBox(message, buttons, title)
End Function

' Function to simulate animation
Sub SimulateAnimation()
    Dim animationStages, i
    animationStages = Array("Casting your line...", "Waiting for a bite...", "Feeling a tug...", "Reeling in the catch!")
    For i = 0 To UBound(animationStages)
        ShowMessage animationStages(i), vbInformation, "Fishing Animation"
        WScript.Sleep 1000 ' Pause for 1 second between stages
    Next
End Sub

' Welcome message
ShowMessage "Welcome to the Ultimate Fishing Adventure! Cast your line and see what you catch!", vbOkOnly + vbInformation, "Fishing Adventure"

' Fishing game variables
Dim fishing, catchOutcome, fishType, attempts, maxAttempts, fishCount, trashCount, score
fishing = True
attempts = 0
maxAttempts = 10 ' Maximum number of fishing attempts
fishCount = 0
trashCount = 0
score = 0

' Fishing loop
While fishing And attempts < maxAttempts
    attempts = attempts + 1
    
    ' Ask the player if they want to cast their line
    Dim castLine
    castLine = ShowMessage("Attempt " & attempts & ": Do you want to cast your line and try to catch a fish?", vbYesNo + vbQuestion, "Fishing Attempt " & attempts)
    
    If castLine = vbYes Then
        ' Simulate fishing animation
        SimulateAnimation
        
        ' Random chance of catching a fish or junk
        catchOutcome = Int((13 * Rnd) + 1) ' Random number between 1 and 13

        Select Case catchOutcome
            ' Common Fish
            Case 1
                fishType = "a small Perch. (Common)"
                fishCount = fishCount + 1
                score = score + 10
            Case 2
                fishType = "a Sunfish. (Common)"
                fishCount = fishCount + 1
                score = score + 10
            
            ' Uncommon Fish
            Case 3
                fishType = "a Pike. (Uncommon)"
                fishCount = fishCount + 1
                score = score + 20
            Case 4
                fishType = "a Carp. (Uncommon)"
                fishCount = fishCount + 1
                score = score + 20
            
            ' Rare Fish
            Case 5
                fishType = "a Rainbow Trout. (Rare)"
                fishCount = fishCount + 1
                score = score + 50
            Case 6
                fishType = "a Bluegill. (Rare)"
                fishCount = fishCount + 1
                score = score + 50

            ' Legendary Fish
            Case 7
                fishType = "a Legendary Golden Fish! (Legendary)"
                fishCount = fishCount + 1
                score = score + 100
            Case 8
                fishType = "a Mythical Kraken Tentacle! (Legendary)"
                fishCount = fishCount + 1
                score = score + 100

            ' Junk Items
            Case 9
                fishType = "an old boot. Better luck next time!"
                trashCount = trashCount + 1
            Case 10
                fishType = "a rusty can. It's not your day!"
                trashCount = trashCount + 1
            Case 11
                fishType = "a tangle of seaweed. Maybe tomorrow!"
                trashCount = trashCount + 1
            Case 12
                fishType = "a sunken treasure map! (Oops, it's unreadable.)"
                trashCount = trashCount + 1
            Case 13
                fishType = "a broken fishing rod. Time for a new one!"
                trashCount = trashCount + 1
        End Select
        
        ' Show the fishing result
        ShowMessage "You caught " & fishType, vbInformation, "Catch Result"
        
        ' Show the updated score and trash count
        ShowMessage "Current Score: " & score & " points" & vbCrLf & "Total Fish Caught: " & fishCount & vbCrLf & "Total Trash Collected: " & trashCount, vbInformation, "Score and Trash Update"
    Else
        fishing = False
        ShowMessage "You've decided to stop fishing early. Hope you enjoyed the adventure!", vbInformation, "Fishing Ended"
    End If
Wend

' End of game summary
If fishing Then
    ShowMessage "You've used all your attempts. Final Score: " & score & " points" & vbCrLf & "Total Fish Caught: " & fishCount & vbCrLf & "Total Trash Collected: " & trashCount & ".", vbInformation, "Fishing Complete"
End If

' Farewell message
ShowMessage "Thanks for playing the Ultimate Fishing Adventure! Come back soon to try for a bigger haul.", vbOkOnly + vbInformation, "Goodbye"

