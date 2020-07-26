--[[MIT License Copyright (c) 2020 @rahkye]]


API = {}
API.VGUI = {}
API.VGUI.PaintFunctions = {}
API.RENDER = {}

--[[-------------------------------------------------------------------------
Not API functions
---------------------------------------------------------------------------]]

function API.IsValid ( element )
 return element.isApiVgui or false
end

function API.ErrorVGUI ( errorMSG )
ErrorNoHalt(errorMSG.."\n")
end

--[[-------------------------------------------------------------------------
Add style
---------------------------------------------------------------------------]]
function API.VGUI.AddPaintFunction ( name , callFunction )
 for k,v in pairs (API.VGUI.PaintFunctions) do
  if k == name then 
   table.remove(API.VGUI.PaintFunctions,tonumber(k))
  end
  end
  
  API.VGUI.PaintFunctions[name] = callFunction
end

function API.VGUI.GetPaintFunction ( name )
 if not API.VGUI.PaintFunctions[name] then 
  API.ErrorVGUI(name.." not founded in APIFunction")
  return false
 end

return API.VGUI.PaintFunctions[name]
end

--[[-------------------------------------------------------------------------
Setup style
---------------------------------------------------------------------------]]
function API.VGUI.SetPaintFunction ( name , element )

if (type(element)!="table") then 
 if (API.VGUI.GetPaintFunction(name) == false) then return end
    if (API.IsValid ( element ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
   
   element.Paint = API.VGUI.GetPaintFunction(name)
else

for k,v in pairs (element) do
 if (API.VGUI.GetPaintFunction(name) == false) then return end
    if (API.IsValid ( v ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
   
   v.Paint = API.VGUI.GetPaintFunction(name)
end

end


end

--[[-------------------------------------------------------------------------
Create VGUI element example local menu = API.VGUI.CreateElement("DFrame" , 100 , 200 , 150, 40)
---------------------------------------------------------------------------]]
function API.VGUI.CreateElement( class , x , y , parent )
 local vgui_element = vgui.Create(class)
  vgui_element:SetPos(x or 0,y or 0)
  vgui_element.VGUI_POS = Vector(x or 0,y or 0,0)
  vgui_element.isApiVgui = true
   
   if parent then 
    vgui_element:SetParent(parent)
   end

  return vgui_element 
end

--[[-------------------------------------------------------------------------
Create DFrame( x, y , w , h ) 
---------------------------------------------------------------------------]]
function API.VGUI.CreateFrame ( x , y  , title , parent )
 local vgui_element = API.VGUI.CreateElement( "DFrame" , x , y  , parent )
  vgui_element:SetTitle(title or "")
  vgui_element:MakePopup()

  return vgui_element  
end

function API.VGUI.CreatePanel ( x , y  , parent )
 local vgui_element = API.VGUI.CreateElement( "DPanel" , x , y  , parent )

  return vgui_element  
end

--[[-------------------------------------------------------------------------
Create DButton( x, y , w , h ) 
---------------------------------------------------------------------------]]
function API.VGUI.CreateButton ( x , y , text , parent )
 local vgui_element = API.VGUI.CreateElement( "DButton" , x , y  , parent )
  vgui_element:SetText(text or "")

  return vgui_element 
end

--[[-------------------------------------------------------------------------
Setup pos for elements in creating API
---------------------------------------------------------------------------]]
function API.VGUI.SetPos( element , x , y )
   if (API.IsValid ( element ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
   
   element:SetPos(x,y)
   element.VGUI_POS = Vector(x,y,0)
end

function API.VGUI.GetPos()
return element.VGUI_POS or Vector(0,0,0)
end

--[[-------------------------------------------------------------------------
Move to vgui in Center
---------------------------------------------------------------------------]]
function API.VGUI.ToCenter ( element )
   if (API.IsValid ( element ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
 API.VGUI.SetPos(element,ScrW()/2 - element:GetWide()/2,ScrH()/2 - element:GetTall()/2)
end

--[[-------------------------------------------------------------------------
Move to vgui in Left Corner
---------------------------------------------------------------------------]]
function API.VGUI.ToLeftUpCorner ( element )
   if (API.IsValid ( element ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
 API.VGUI.SetPos(element,0,0)
end

--[[-------------------------------------------------------------------------
Move to vgui in Down Corener
---------------------------------------------------------------------------]]
function API.VGUI.ToLeftDownCorner ( element )
   if (API.IsValid ( element ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
  API.VGUI.SetPos(element,0,ScrH() - element:GetTall())
end

--[[-------------------------------------------------------------------------
Move to vgui in Right Up Corner
---------------------------------------------------------------------------]]
function API.VGUI.ToRightUpCorner ( element )
   if (API.IsValid ( element ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
  API.VGUI.SetPos(element,ScrW() - element:GetWide(),0)
end

--[[-------------------------------------------------------------------------
Move to vgui in Down Up Corner
---------------------------------------------------------------------------]]
function API.VGUI.ToRightDownCorner ( element )
   if (API.IsValid ( element ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
  API.VGUI.SetPos(element,ScrW() - element:GetWide(),ScrH() - element:GetTall())
end



--[[-------------------------------------------------------------------------
DoClick
---------------------------------------------------------------------------]]
function API.VGUI.DoClick ( element , func )
 element.DoClick = func 
end

function API.VGUI.SetParamsButtonText ( element , font , color )

if (type(element)!="table") then 
   if (API.IsValid ( element ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
 element:SetFont(font)
 element:SetTextColor(color)
 else
  for k,v in pairs (element) do
  
     if (API.IsValid ( v ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
 v:SetFont(font)
 v:SetTextColor(color)
  
  end
end
 
 
end

--[[-------------------------------------------------------------------------
HideElements
---------------------------------------------------------------------------]]
function API.VGUI.ShowHideElements ( element , f )

if (type(element)!="table") then 
   if (API.IsValid ( element ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
   if f then 
  element:Hide()
  else
  element:Show()
  end
  
 else
  for k,v in pairs (element) do
  
     if (API.IsValid ( v ) == false) then 
     API.ErrorVGUI("This is not API-VGUI Element")
	 return
   end
  if f then 
  v:Hide()
  else
  v:Show()
  end
  
  end
end
 
 
end


function API.RENDER.DrawBox ( p_1 , p_2 , col )

local pp_1 = {p_1,Vector(p_2.x,p_1.y,p_1.z)}
local pp_2 = {p_1,Vector(p_1.x,p_2.y,p_1.z)}
local pp_3 = {p_1,Vector(p_1.x,p_1.y,p_2.z)}
local pp_4 = {pp_1[2],Vector(pp_1[2].x,pp_1[2].y,p_2.z)}
local pp_5 = {pp_1[2],Vector(pp_1[2].x,p_2.y,pp_1[2].z)}
local pp_6 = {pp_2[2],Vector(p_2.x,pp_2[2].y,pp_2[2].z)}
local pp_7 = {pp_2[2],Vector(pp_2[2].x,pp_2[2].y,p_2.z)}
local pp_8 = {p_2,Vector(p_2.x,p_1.y,p_2.z)}
local pp_9 = {p_2,Vector(p_2.x,pp_2[2].y,p_1.z)}
local pp_11 = {p_2,Vector(p_1.x,p_2.y,p_2.z)}
local pp_12 = {pp_3[2],Vector(p_1.x,p_2.y,p_2.z)}
local pp_13 = {pp_3[2],Vector(p_2.x,p_1.y,p_2.z)}

render.DrawLine( pp_1[1], pp_1[2], col, true )
render.DrawLine( pp_2[1], pp_2[2], col, true )
render.DrawLine( pp_3[1], pp_3[2], col, true )
render.DrawLine( pp_4[1], pp_4[2], col, true )
render.DrawLine( pp_5[1], pp_5[2], col, true )
render.DrawLine( pp_6[1], pp_6[2], col, true )
render.DrawLine( pp_7[1], pp_7[2], col, true )
render.DrawLine( pp_8[1], pp_8[2], col, true )
render.DrawLine( pp_9[1], pp_9[2], col, true )
render.DrawLine( pp_11[1], pp_11[2], col, true )
render.DrawLine( pp_12[1], pp_12[2], col, true )
render.DrawLine( pp_13[1], pp_13[2], col, true )

end


//Example
function ExampleMenu ()
	//Styles
	API.VGUI.AddPaintFunction("style_background",function(self)

	draw.RoundedBox(0,0,0,self:GetWide(),self:GetTall(),Color(115,15,15,210))
	draw.RoundedBox(0,0,0,self:GetWide(),25,Color(115,115,15,60))

	end)

	API.VGUI.AddPaintFunction("style_button",function(self)

	draw.RoundedBox(0,0,0,self:GetWide(),self:GetTall(),Color(115,15,115,210))

	end)

	local main = API.VGUI.CreateFrame(100,100,"Тестовое меню")
	main:SetSize(400,200)
	API.VGUI.SetPaintFunction("style_background",main)

	local panel_1 = API.VGUI.CreatePanel(0,30,main)
	panel_1:SetSize(main:GetWide(),main:GetTall()-60) 


	local buttton = API.VGUI.CreateButton(10,main:GetTall()-25,"НАЖМИ НА МЕНЯ",main)
	buttton:SetSize(100,20)
	API.VGUI.DoClick(buttton, function()

	panel_1:Hide()

	end)
	API.VGUI.SetPaintFunction("style_button",buttton)
end

concommand.Add("API_EXAMPLE_MENU",ExampleMenu)























