' Interactive fishing game script

' Function to display a message box and return the user's choice
Function ShowMessage(message, buttons, title)
    ShowMessage = MsgBox(message, buttons, title)
End Function

' Welcome message
ShowMessage "Welcome to the Great Fishing Adventure! Ready to catch some fish?", vbOkOnly + vbInformation, "Fishing Adventure"

' Fishing game variables
Dim fishing, catchOutcome, fishType, attempts, maxAttempts, fishCount
fishing = True
attempts = 0
maxAttempts = 5 ' Maximum number of fishing attempts
fishCount = 0

' Fishing loop
While fishing And attempts < maxAttempts
    attempts = attempts + 1
    
    ' Ask the player if they want to cast their line
    Dim castLine
    castLine = ShowMessage("Attempt " & attempts & ": Do you want to cast your line and try to catch a fish?", vbYesNo + vbQuestion, "Fishing Attempt " & attempts)
    
    If castLine = vbYes Then
        ' Random chance of catching a fish
        catchOutcome = Int((5 * Rnd) + 1) ' Random number between 1 and 5

        Select Case catchOutcome
            Case 1
                fishType = "a big Bass! Great catch!"
                fishCount = fishCount + 1
            Case 2
                fishType = "a slippery Trout. Nice!"
                fishCount = fishCount + 1
            Case 3
                fishType = "a rare Golden Fish! What luck!"
                fishCount = fishCount + 1
            Case 4
                fishType = "an old boot. Better luck next time!"
            Case 5
                fishType = "nothing. The fish are wise today."
        End Select
        
        ShowMessage "You caught " & fishType, vbInformation, "Catch Result"
    Else
        fishing = False
        ShowMessage "You've decided to stop fishing early. Hope you enjoyed the adventure!", vbInformation, "Fishing Ended"
    End If
Wend

' End of game summary
If fishing Then
    ShowMessage "You've used all your attempts. Total fish caught: " & fishCount & ".", vbInformation, "Fishing Complete"
End If

' Farewell message
ShowMessage "Thanks for playing the Great Fishing Adventure! Come back soon.", vbOkOnly + vbInformation, "Goodbye"
