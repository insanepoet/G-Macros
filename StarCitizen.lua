function OnEvent(event, arg)
    --OutputLogMessage("Event: "..event.." Arg: "..arg.."\n")
    
    -- Declare Variables
    local xOrig,yOrig,xTarget,yTarget,trashY
    
    -- Run This one to determine midScreen then uncomment the variable below and set it with the value from the log
    --if IsMouseButtonPressed(5) then
    -- You must set this depending on your screen size
    -- aka  YourResolution / 2
      --midScreen,trashY = GetMousePosition()
      --OutputLogMessage("EdgeScreen set to %d\n",midScreen)
    --end
    
    midScreen = 32759
    
    -- Loop While button is down
    if IsMouseButtonPressed(4) then
    
    -- Get Origin Coordinates
      xOrig, yOrig = GetMousePosition()
      --OutputLogMessage("Originating x at %d, %d\n", xOrig, yOrig)
    
    -- Set Target Coorinate for X
      if (xOrig > midScreen) then
        xTarget = midScreen - ((xOrig - 10) - midScreen)
      else
        xTarget = midScreen + (midScreen - (xOrig + 10))
      end
      --OutputLogMessage("Target x is %d\n", xTarget)
    
      repeat
        yTarget = yOrig + math.random(0,20)
        Sleep(math.random(150,200))
        MoveMouseTo(xOrig,yOrig)
        --Sleep(math.random(50,100))
        --OutputLogMessage("Mouse Moved to: %d,%d\n",xOrig,yOrig)
        PressMouseButton(1)
        --OutputLogMessage("Mouse Down\n")
        MoveMouseTo(xTarget,yTarget)
        --Sleep(math.random(50,100))
        --OutputLogMessage("Mouse Moved to: %d,%d\n",xTarget,yTarget)
        ReleaseMouseButton(1)
        Sleep(math.random(150,200))
        --OutputLogMessage("Mouse Up\n")
        MoveMouseTo(xOrig,yOrig)
        --OutputLogMessage("Mouse Moved to: %d,%d\n",xOrig,yOrig)
     until not IsMouseButtonPressed(4)
     --OutputLogMessage("We're done here")
    end
    
    if IsMouseButtonPressed(5) then
    end  
end
