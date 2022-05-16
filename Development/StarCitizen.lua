---------------------------------------------------------------------------------------------
-- StarCitizen.lua
---------------------------------------------------------------------------------------------
-- Version: 0.3
-- Author: Rory Fincham
-- Based on work by: Egor Skriptunoff
-- Feature Addition Origin can be found: https://gist.github.com/Egor-Skriptunoff/be9a7e4546b47b74a9aae604f5a8c272
--
-- ------------------------------------------------------------------------------------------
--       FEATURE #1 - Inventory Mover - Mouse Button 4 (Back)
-- ------------------------------------------------------------------------------------------
--    Moves items to the opposite side of the screen when button is toggled (press to start, press to stop)
--  How to Use:
--    Place your mouse on the top left most item you wish to move from left to right or right to left and press
--    the Mouse 4 Button (Back). The script will automatically continue moving items untill Mouse 4 is pressed again.
--    Suggest the side receiving items is set to vehicle filter, and that the filters are either visible or hidden on both windows
-- ------------------------------------------------------------------------------------------
--
-- ------------------------------------------------------------------------------------------
--       FEATURE #2 - Sell at Terminal - Mouse Button 5 (Forward)
-- ------------------------------------------------------------------------------------------
--    Sells ALL items visible on a terminal one at a time using the quick sell Feature
--  How to Use:
--    Open a shop terminal and select the sell tab at the top, ensuring your source is set you should see items
--    listed below with quick sell buttons visible on each item. Press and hold Mouse Button 5 (forward) then click (lmb) a
--    quick sell button on the terminal. While continuing to hold Mouse Button 5 wait for the sale to process then click 
--    the done button to complete the sale. After the second button is clicked you may release Mouse Button 5 and the macro
--    will begin repeating the process of quickselling and completing the sale using the quicksell button location you have pressed
--    the macro is unable to scroll so if you have more than 6 items showing on the sell screen that you do not want to sell 
--    you will need to move them to another inventory before using this macro
-- ------------------------------------------------------------------------------------------
--
-- ------------------------------------------------------------------------------------------
--      USER VARIABLES
-- ------------------------------------------------------------------------------------------
--    Because everyone's latency and server speed differs the amount of time it takes your sale to process will differ.
--    This should be set in seconds, I have found 8 seconds to be a little long and 5 seconds to be a little short on occasion 
--    so I have defaulted this setting to 6 seconds, your results may vary however depending on your angle when looking at the terminal 
--    it is entirely possible to accidentally break the macro if the item sold screen takes longer that the time in this variable.
--    If it breaks you can simply restart the macro however if you find it consistently breaking you can increase the time it waits by 
--    increasing the number of seconds below.
-- ------------------------------------------------------------------------------------------
local sellProcessingTime = 6
-- ------------------------------------------------------------------------------------------
--    If you would like your mouse to change it's dpi to a specific setting change this to true and the number according to your DPI table
-- ------------------------------------------------------------------------------------------
local gameDPI = false
local gameSpecificDPI = 0
-- ------------------------------------------------------------------------------------------
-- If you would like to ensure num lock is enabled when playing this game set to true (no need to set this if you usually have num lock on)
-- ------------------------------------------------------------------------------------------
local numLoc = false
-- ------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE - THERE BE DRAGONS AHEAD
-- ------------------------------------------------------------------------------------------
local select, tostring, type, floor, min, max, sqrt, format, byte, char, rep, sub, gsub, concat = select, tostring,
    type, math.floor, math.min, math.max, math.sqrt, string.format, string.byte, string.char, string.rep, string.sub,
    string.gsub, table.concat
local MoveMouseRelative, MoveMouseTo, GetMousePosition, GetRunningTime, OutputLogMessage, OutputDebugMessage =
    MoveMouseRelative, MoveMouseTo, GetMousePosition, GetRunningTime, OutputLogMessage, OutputDebugMessage

function print(...)
    local t = {...}
    for j = 1, select("#", ...) do
        t[j] = tostring(t[j])
    end
    OutputLogMessage("%s\n", concat(t, "\t"))
end

local GetMousePositionInPixels
do
    local xy_data, xy_64K, xy_pixels, enabled = {{}, {}}, {}, {}, true

    function GetMousePositionInPixels()
        -- The function returns mouse_x_pixels, mouse_y_pixels, screen_width, screen_height, x_64K, y_64K
        -- 0 <= mouse_x_pixels < screen_width
        -- 0 <= mouse_y_pixels < screen_height
        -- it's assumed that both width and height of your screen are between 150 and 10240 pixels
        xy_64K[1], xy_64K[2] = GetMousePosition()
        if enabled then
            local jump
            local attempts_qty = 3
            for attempt = 1, attempts_qty + 1 do
                for i = 1, 2 do
                    local result
                    local size = xy_data[i][4]
                    if size then
                        local coord_64K = xy_64K[i]
                        -- How to convert between pos_64K (0...65535) and pixel (0...(size-1))
                        --    pos_64K = floor(pixel * 65535 / (size-1) + 0.5)
                        --    pixel   = floor((pos_64K + (0.5 + 2^-16)) * (size-1) / 65535)
                        local pixels = floor((coord_64K + (0.5 + 2 ^ -16)) * (size - 1) / 65535)
                        if 65535 * pixels >= (coord_64K - (0.5 + 2 ^ -16)) * (size - 1) then
                            result = pixels
                        end
                    end
                    xy_pixels[i] = result
                end
                if xy_pixels[1] and xy_pixels[2] then
                    return xy_pixels[1], xy_pixels[2], xy_data[1][4], xy_data[2][4], xy_64K[1], xy_64K[2]
                elseif attempt <= attempts_qty then
                    if jump then
                        MoveMouseTo(3 * 2 ^ 14 - xy_64K[1] / 2, 3 * 2 ^ 14 - xy_64K[2] / 2)
                        Sleep_orig(10)
                        xy_64K[1], xy_64K[2] = GetMousePosition()
                    end
                    jump = true
                    for _, data in ipairs(xy_data) do
                        data[1] = {
                            [0] = true
                        }
                        data[2] = 0
                        data[3] = 45 * 225
                        data[4] = nil
                        data[5] = 6
                        for j = 6, 229 do
                            data[j] = (2 ^ 45 - 1) * 256 + 1 + j
                        end
                        data[230] = (2 ^ 45 - 1) * 256
                    end
                    local dx = xy_64K[1] < 2 ^ 15 and 1 or -1
                    local dy = xy_64K[2] < 2 ^ 15 and 1 or -1
                    local prev_coords_processed_1, prev_coords_processed_2, prev_variants_qty, trust
                    for frame = 1, 90 * attempt do
                        for i = 1, 2 do
                            local data, coord_64K = xy_data[i], xy_64K[i]
                            local data_1 = data[1]
                            if not data_1[coord_64K] then
                                data_1[coord_64K] = true
                                data[2] = data[2] + 1
                                local min_size
                                local prev_idx = 5
                                local idx = data[prev_idx]
                                while idx > 0 do
                                    local N = data[idx]
                                    local mask = 2 ^ 53
                                    local size_from = idx * 45 + (150 - 6 * 45)
                                    for size = size_from, size_from + 44 do
                                        mask = mask / 2
                                        if N >= mask then
                                            N = N - mask
                                            if 65535 * floor((coord_64K + (0.5 + 2 ^ -16)) * (size - 1) / 65535) <
                                                (coord_64K - (0.5 + 2 ^ -16)) * (size - 1) then
                                                data[idx] = data[idx] - mask
                                                data[3] = data[3] - 1
                                            else
                                                min_size = min_size or size
                                            end
                                        end
                                    end
                                    if data[idx] < mask then
                                        data[prev_idx] = data[prev_idx] + (N - idx)
                                    else
                                        prev_idx = idx
                                    end
                                    idx = N
                                end
                                data[4] = min_size
                            end
                        end
                        local variants_qty = xy_data[1][3] + xy_data[2][3]
                        local coords_processed_1 = xy_data[1][2]
                        local coords_processed_2 = xy_data[2][2]
                        if variants_qty ~= prev_variants_qty then
                            prev_variants_qty = variants_qty
                            prev_coords_processed_1 = coords_processed_1
                            prev_coords_processed_2 = coords_processed_2
                        end
                        if min(coords_processed_1 - prev_coords_processed_1,
                            coords_processed_2 - prev_coords_processed_2) >= 20 then
                            trust = true
                            break
                        end
                        local num = sqrt(frame + 0.1) % 1 < 0.5 and 2 ^ 13 or 0
                        MoveMouseRelative(dx * max(1, floor(num / ((xy_64K[1] - 2 ^ 15) * dx + (2 ^ 15 + 2 ^ 13 / 8)))),
                            dy * max(1, floor(num / ((xy_64K[2] - 2 ^ 15) * dy + (2 ^ 15 + 2 ^ 13 / 8)))))
                        Sleep_orig(10)
                        xy_64K[1], xy_64K[2] = GetMousePosition()
                    end
                    if not trust then
                        xy_data[1][4], xy_data[2][4] = nil
                    end
                end
            end
            enabled = false
            print 'Function "GetMousePositionInPixels()" failed to determine screen resolution and has been disabled'
        end
        return 0, 0, 0, 0, xy_64K[1], xy_64K[2] -- functionality is disabled, so no pixel-related information is returned
    end

end
_G.GetMousePositionInPixels = GetMousePositionInPixels

function SetMousePositionInPixels(x, y)
    local _, _, width, height = GetMousePositionInPixels()
    if width > 0 then
        MoveMouseTo(floor(max(0, min(width - 1, x)) * (2 ^ 16 - 1) / (width - 1) + 0.5),
            floor(max(0, min(height - 1, y)) * (2 ^ 16 - 1) / (height - 1) + 0.5))
    end
end

-- ============================================== NOTHING SHOULD BE MODIFIED ABOVE THIS LINE ==============================================

----------------------------------------------------------------------
-- FUNCTIONS AND VARIABLES
----------------------------------------------------------------------
-- insert all your functions and variables here
--

local xOrig, yOrig, xTarget, yTarget, trashX, trashY, loopMove, clickCount, xSell, ySell, xComp, yComp, loopSell,
    startRunning, stopRunning, loopCount

trashX, trashY, ScreenStats = GetMousePosition()
midScreen = ScreenStats / 2
loopMove = false
loopSell = false
clickCount = 0
sellProcessingTime = sellProcessingTime * 1000

function OnEvent(event, arg, family)
    local mouse_button
    if event == "PROFILE_ACTIVATED" then
        ClearLog()
        EnablePrimaryMouseButtonEvents(true)
        -- update_internal_state(GetDate())  -- it takes about 1 second because of determining your screen resolution
        Sleep(1000)
        if gameDPI then
            SetMouseDPITableIndex(gameSpecificDPI)
        end
        if numLoc then
            if not IsKeyLockOn "NumLock" then
                PressAndReleaseKey "NumLock"
            end
        end
    elseif event == "MOUSE_BUTTON_PRESSED" or event == "MOUSE_BUTTON_RELEASED" then
        mouse_button = Logitech_order[arg] or arg -- convert 1,2,3 to "L","R","M"
    end
    -- update_internal_state(event, arg, family)    -- this invocation adds entropy to RNG (it's very fast)
    if event == "PROFILE_DEACTIVATED" then
        EnablePrimaryMouseButtonEvents(false)
        if numLoc then
            if not IsKeyLockOn "NumLock" then
                PressAndReleaseKey "NumLock"
            end
        end
    end
    ----------------------------------------------------------------------
    -- MOUSE EVENTS PROCESSING
    ----------------------------------------------------------------------
    if event == "MOUSE_BUTTON_PRESSED" and mouse_button == "L" then -- left mouse button
    end
    if event == "MOUSE_BUTTON_RELEASED" and mouse_button == "L" then -- left mouse button
    end

    if event == "MOUSE_BUTTON_PRESSED" and mouse_button == "R" then -- right mouse button
    end
    if event == "MOUSE_BUTTON_RELEASED" and mouse_button == "R" then -- right mouse button
    end

    if event == "MOUSE_BUTTON_PRESSED" and mouse_button == "M" then -- middle mouse button
    end
    if event == "MOUSE_BUTTON_RELEASED" and mouse_button == "M" then -- middle mouse button
    end

    if event == "MOUSE_BUTTON_PRESSED" and mouse_button == 4 then -- "backward" (X1) mouse button
        loopMove = not loopMove

        if loopMove then
            xOrig, yOrig = GetMousePositionInPixels()
            startRunning = GetRunningTime
            loopCount = 0
            if xOrig > midScreen then
                xTarget = midScreen - ((xOrig - midScreen) + 20)
            else
                xTarget = midScreen + ((midScreen - xOrig) + 20)
            end

            repeat
                yTarget = yOrig + math.random(0, 20)
                Sleep(math.random(135, 235))
                SetMousePositionInPixels(xOrig, yOrig)
                Sleep(5)
                PressMouseButton(1)
                Sleep(5)
                SetMousePositionInPixels(xTarget, yTarget)
                Sleep(5)
                ReleaseMouseButton(1)
                Sleep(math.random(150, 250))
                local loopedMove = loopMove
                loopedMove = IsMouseButtonPressed(4)
                loopCount = loopCount + 1
            until (not loopedMove and loopMove) or IsModifierPressd("Shft")
            stopRunning = GetRunningTime - startRunning
            print('Moved %d items in %d', loopCount, stopRunning)
        end
    end
    if event == "MOUSE_BUTTON_RELEASED" and mouse_button == 4 then -- "backward" (X1) mouse button
    end

    if event == "MOUSE_BUTTON_PRESSED" and mouse_button == 5 then -- "forward" (X2) mouse button
        loopSell = not loopSell

        if loopSell then
            repeat
                if IsMouseButtonPressed(1) and clickCount == 0 then
                    xSell, ySell = GetMousePositionInPixels()
                    clickCount = 1
                end
                if not IsMouseButtonPressed(1) and clickCount == 1 then
                    clickCount = 2
                end
                if IsMouseButtonPressed(1) and clickCount == 2 then
                    xComp, yComp = GetMousePositionInPixels()
                    clickCount = 3
                end
                Sleep(5)
            until clickCount == 3
            loopCount = 0
            startRunning = GetRunningTime
            repeat
                SetMousePositionInPixels(xSell, ySell)
                Sleep(5)
                PressAndReleaseMouseButton(1)
                Sleep(sellProcessingTime)
                SetMousePositionInPixels(xComp, yComp)
                Sleep(5)
                PressAndReleaseMouseButton(1)
                Sleep(math.random(150, 250))
                local loopedSell = loopSell
                loopedSell = IsMouseButtonPressed(5)
                loopCount = loopCount + 1
            until (not loopedSell and loopSell) or IsModifierPressd("Shft")
            clickCount = 0
            stopRunning = GetRunningTime - startRunning
            print('Sold %d items in %d', loopCount, stopRunning)
        end
    end
    if event == "MOUSE_BUTTON_RELEASED" and mouse_button == 5 then -- "forward" (X2) mouse button
    end

    if event == "MOUSE_BUTTON_PRESSED" and mouse_button == 6 then
    end
    if event == "MOUSE_BUTTON_RELEASED" and mouse_button == 6 then
    end

    if event == "MOUSE_BUTTON_PRESSED" and mouse_button == 7 then
    end
    if event == "MOUSE_BUTTON_RELEASED" and mouse_button == 7 then
    end

    if event == "MOUSE_BUTTON_PRESSED" and mouse_button == 8 then
    end
    if event == "MOUSE_BUTTON_RELEASED" and mouse_button == 8 then
    end

    ----------------------------------------------------------------------
    -- KEYBOARD AND LEFT-HANDED-CONTROLLER EVENTS PROCESSING
    ----------------------------------------------------------------------
    if event == "G_PRESSED" and arg == 1 then -- G1 key
    end
    if event == "G_RELEASED" and arg == 1 then -- G1 key
    end

    if event == "M_PRESSED" and arg == 3 then -- M3 key
    end
    if event == "M_RELEASED" and arg == 3 then -- M3 key
    end

    ----------------------------------------------------------------------
    -- EXIT EVENT PROCESSING
    ----------------------------------------------------------------------
end
