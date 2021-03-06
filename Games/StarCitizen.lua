---------------------------------------------------------------------------------------------
-- StarCitizen.lua MINIFIED
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
local a=6
-- ------------------------------------------------------------------------------------------
--    If you would like your mouse to change it's dpi to a specific setting change this to true and the number according to your DPI table
-- ------------------------------------------------------------------------------------------
local b=false
local c=0
-- ------------------------------------------------------------------------------------------
-- If you would like to ensure num lock is enabled when playing this game set to true (no need to set this if you usually have num lock on)
-- ------------------------------------------------------------------------------------------
local d=false
-- ------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE - THERE BE DRAGONS AHEAD - to view readable code see Development Version
-- ------------------------------------------------------------------------------------------
local select,tostring,type,e,f,g,h,i,j,k,l,m,n,o=select,tostring,type,math.floor,math.min,math.max,math.sqrt,string.format,string.byte,string.char,string.rep,string.sub,string.gsub,table.concat;local MoveMouseRelative,MoveMouseTo,GetMousePosition,GetRunningTime,OutputLogMessage,OutputDebugMessage=MoveMouseRelative,MoveMouseTo,GetMousePosition,GetRunningTime,OutputLogMessage,OutputDebugMessage;function print(...)local p={...}for q=1,select("#",...)do p[q]=tostring(p[q])end;OutputLogMessage("%s\n",o(p,"\t"))end;local r;do local s,t,u,v={{},{}},{},{},true;function r()t[1],t[2]=GetMousePosition()if v then local w;local x=3;for y=1,x+1 do for z=1,2 do local A;local B=s[z][4]if B then local C=t[z]local D=e((C+0.5+2^-16)*(B-1)/65535)if 65535*D>=(C-(0.5+2^-16))*(B-1)then A=D end end;u[z]=A end;if u[1]and u[2]then return u[1],u[2],s[1][4],s[2][4],t[1],t[2]elseif y<=x then if w then MoveMouseTo(3*2^14-t[1]/2,3*2^14-t[2]/2)Sleep_orig(10)t[1],t[2]=GetMousePosition()end;w=true;for E,F in ipairs(s)do F[1]={[0]=true}F[2]=0;F[3]=45*225;F[4]=nil;F[5]=6;for q=6,229 do F[q]=(2^45-1)*256+1+q end;F[230]=(2^45-1)*256 end;local G=t[1]<2^15 and 1 or-1;local H=t[2]<2^15 and 1 or-1;local I,J,K,L;for M=1,90*y do for z=1,2 do local F,C=s[z],t[z]local N=F[1]if not N[C]then N[C]=true;F[2]=F[2]+1;local O;local P=5;local Q=F[P]while Q>0 do local R=F[Q]local S=2^53;local T=Q*45+150-6*45;for B=T,T+44 do S=S/2;if R>=S then R=R-S;if 65535*e((C+0.5+2^-16)*(B-1)/65535)<(C-(0.5+2^-16))*(B-1)then F[Q]=F[Q]-S;F[3]=F[3]-1 else O=O or B end end end;if F[Q]<S then F[P]=F[P]+R-Q else P=Q end;Q=R end;F[4]=O end end;local U=s[1][3]+s[2][3]local V=s[1][2]local W=s[2][2]if U~=K then K=U;I=V;J=W end;if f(V-I,W-J)>=20 then L=true;break end;local X=h(M+0.1)%1<0.5 and 2^13 or 0;MoveMouseRelative(G*g(1,e(X/((t[1]-2^15)*G+2^15+2^13/8))),H*g(1,e(X/((t[2]-2^15)*H+2^15+2^13/8))))Sleep_orig(10)t[1],t[2]=GetMousePosition()end;if not L then s[1][4],s[2][4]=nil end end end;v=false;print'Function "GetMousePositionInPixels()" failed to determine screen resolution and has been disabled'end;return 0,0,0,0,t[1],t[2]end end;_G.GetMousePositionInPixels=r;function SetMousePositionInPixels(Y,Z)local E,E,_,a0=r()if _>0 then MoveMouseTo(e(g(0,f(_-1,Y))*(2^16-1)/(_-1)+0.5),e(g(0,f(a0-1,Z))*(2^16-1)/(a0-1)+0.5))end end;local a1,a2,a3,a4,a5,a6,a7,a8,a9,aa,ab,ac,ad,ae,af,ag;a5,a6,ScreenStats=GetMousePosition()midScreen=ScreenStats/2;a7=false;ad=false;a8=0;a=a*1000;function OnEvent(ah,ai,aj)local ak;if ah=="PROFILE_ACTIVATED"then ClearLog()EnablePrimaryMouseButtonEvents(true)Sleep(1000)if b then SetMouseDPITableIndex(c)end;if d then if not IsKeyLockOn"NumLock"then PressAndReleaseKey"NumLock"end end elseif ah=="MOUSE_BUTTON_PRESSED"or ah=="MOUSE_BUTTON_RELEASED"then ak=Logitech_order[ai]or ai end;if ah=="PROFILE_DEACTIVATED"then EnablePrimaryMouseButtonEvents(false)if d then if not IsKeyLockOn"NumLock"then PressAndReleaseKey"NumLock"end end end;if ah=="MOUSE_BUTTON_PRESSED"and ak=="L"then end;if ah=="MOUSE_BUTTON_RELEASED"and ak=="L"then end;if ah=="MOUSE_BUTTON_PRESSED"and ak=="R"then end;if ah=="MOUSE_BUTTON_RELEASED"and ak=="R"then end;if ah=="MOUSE_BUTTON_PRESSED"and ak=="M"then end;if ah=="MOUSE_BUTTON_RELEASED"and ak=="M"then end;if ah=="MOUSE_BUTTON_PRESSED"and ak==4 then a7=not a7;if a7 then a1,a2=r()ae=GetRunningTime;ag=0;if a1>midScreen then a3=midScreen-(a1-midScreen+20)else a3=midScreen+midScreen-a1+20 end;repeat a4=a2+math.random(0,20)Sleep(math.random(135,235))SetMousePositionInPixels(a1,a2)Sleep(5)PressMouseButton(1)Sleep(5)SetMousePositionInPixels(a3,a4)Sleep(5)ReleaseMouseButton(1)Sleep(math.random(150,250))local al=a7;al=IsMouseButtonPressed(4)ag=ag+1 until not al and a7 or IsModifierPressd("Shft")af=GetRunningTime-ae;print('Attempted to Move '..tostring(ag)..' items in '..af)end end;if ah=="MOUSE_BUTTON_RELEASED"and ak==4 then end;if ah=="MOUSE_BUTTON_PRESSED"and ak==5 then ad=not ad;if ad then repeat if IsMouseButtonPressed(1)and a8==0 then a9,aa=r()a8=1 end;if not IsMouseButtonPressed(1)and a8==1 then a8=2 end;if IsMouseButtonPressed(1)and a8==2 then ab,ac=r()a8=3 end;Sleep(5)until a8==3;ag=0;ae=GetRunningTime;repeat SetMousePositionInPixels(a9,aa)Sleep(5)PressAndReleaseMouseButton(1)Sleep(a)SetMousePositionInPixels(ab,ac)Sleep(5)PressAndReleaseMouseButton(1)Sleep(math.random(150,250))local am=ad;am=IsMouseButtonPressed(5)ag=ag+1 until not am and ad or IsModifierPressd("Shft")a8=0;af=GetRunningTime-ae;print('Attempted to sell '..tostring(ag)..' items in '..af)end end;if ah=="MOUSE_BUTTON_RELEASED"and ak==5 then end;if ah=="MOUSE_BUTTON_PRESSED"and ak==6 then end;if ah=="MOUSE_BUTTON_RELEASED"and ak==6 then end;if ah=="MOUSE_BUTTON_PRESSED"and ak==7 then end;if ah=="MOUSE_BUTTON_RELEASED"and ak==7 then end;if ah=="MOUSE_BUTTON_PRESSED"and ak==8 then end;if ah=="MOUSE_BUTTON_RELEASED"and ak==8 then end;if ah=="G_PRESSED"and ai==1 then end;if ah=="G_RELEASED"and ai==1 then end;if ah=="M_PRESSED"and ai==3 then end;if ah=="M_RELEASED"and ai==3 then end end