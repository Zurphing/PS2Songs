function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Test")
	Now = 0x0714DB8 - 0x56454E
	Sys3 = 0x2A59DB0 - 0x56450E
	else
		ConsolePrint("Installation Failed.")
	end
end

local Writes = 0
function _OnFrame()
Place = ReadShort(Now)
IsMenuOpen = ReadByte(0x6877DA)
MenuFlag2 = ReadByte(0x6877DA+0x4)
if ReadShort(0x1ACF3C) == 512 and Place ~= 0xFFFF and IsMenuOpen == 0x3 and MenuFlag2 == 0x00 and ReadShort(Sys3+0xB04C) < 0x320 then --L3 pressed, write vanilla values
	local Field, Fight
	for i = 0xB04C, 0x1084C, 0x40 do
		for j = 0, 1 do
			local Offset = Sys3 + i + 4*j
			Field = ReadShort(Offset)
			Fight = ReadShort(Offset+2)
			--WriteShort(Offset, FieldStored) --Writes vanilla values
			WriteShort(Offset+2, Fight+0x320)
			WriteShort(Offset, Field+0x320)
		end
	end
end

if ReadShort(0x1ACF3C) == 256 and Place ~= 0xFFFF and IsMenuOpen == 0x3 and MenuFlag2 == 0x00 and ReadShort(Sys3+0xB04C) >= 0x320 then --L3 pressed, write vanilla values
	local Field, Fight
	for i = 0xB04C, 0x1084C, 0x40 do
		for j = 0, 1 do
			local Offset = Sys3 + i + 4*j
			Field = ReadShort(Offset)
			Fight = ReadShort(Offset+2)
			--WriteShort(Offset, FieldStored) --Writes vanilla values
			WriteShort(Offset+2, Fight-0x320)
			WriteShort(Offset, Field-0x320)
		end
	end
end

end