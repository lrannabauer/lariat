require("strict")
require("fileOps")
require("declare")
require("string_split")
local Dbg = require("Dbg")

reverseMapT = false

function readRMap(reverseMapD)

   local dbg = Dbg:dbg()
   dbg.start("readRMap(",reverseMapD,")")
   -- open reverseMap file and read it in.

   local mapT = {}

   --declare("reverseMapT",{})
   for dir in reverseMapD:split(":") do

      local reverseMapFn = pathJoin(reverseMapD,"reverseMapT.lua")
      local rmF          = io.open(reverseMapFn,"r")
      if (not rmF) then
         reverseMapFn = pathJoin(reverseMapD,"reverseMapT.old.lua")
         rmF          = io.open(reverseMapFn,"r")
      end
      
      if (rmF) then
         local whole  = rmF:read("*all")
         rmF:close()
         local func, msg = loadstring(whole)
         if (func) then
            func()
         else
            dbg.print("Problem with reverse map: ",msg,"\n")
         end
      end

      local rmapT = _G.reverseMapT
      for k, v in pairs(rmapT) do
         mapT[k] = v
      end
   end

   dbg.fini()
   return mapT 

end
