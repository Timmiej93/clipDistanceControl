-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- clipDistanceControl
--
-- Purpose: The purpose of this script is to control the 'clip distance' (also known as view distance)
--	of an object that is inside the associated trigger. With how the GIANTS engine currently handles
--	rendering objects, it also renders them if they are not visible to the player (e.g. blocked by a 
--	vehicle shed). Reducing the clip distance on them when they are in this shed can greatly increase
--	the performance of the game.
--
-- How to use:
-- - Add the trigger shape
--	 - Add a shape to your map. I'd suggest simply clicking 'Create > Primitives > Cube' in the Giants
--		editor menu.
--	 - In the Attributes window, change the Scale X / Y / Z values so the trigger is the desired size
--		and tick the 'Rigid Body' checkbox.
--	 - Go to the 'Rigid Body' tab, and tick the 'Collision' and 'Trigger' boxes, and put '56031c2' in 
--		the 'Collision Mask' textbox. Click the button behind that textbox to verify the following 
--		numbers have a checkmark behind them: 1, 6, 7, 8, 12, 13, 21, 22, 24 and 26
--	 - Go to the 'Shape' tab, and tick the 'Non Renderable' checkbox.
--
-- - Add the script and proper settings
--	 - With the trigger selected, open the 'User Attributes' window.
--	 - Add a new attribute called 'onCreate', with type 'Script Callback', and set it to 'modOnCreate.clipDistanceControl'
--	 - Add another new attribute called 'innerClipDistance', with type 'Integer'. Set this to the clip 
--		distance in meters you'd like to use for that trigger. Remember, if the distance between you (the player)
--		and	the object in the trigger is greater than the entered distance, it will not be visible.
--
-- - Simply repeat this process for each trigger. Don't forget to hit enter after changing values in GE,
--	   save regularly, etc.. The 'Attributes' and 'User Attributes' window can be opened by clicking
--	   'Window > Attributes' and 'Window > User Attributes' in the GE menu.
--
-- - Don't forget to add the 'extraSourceFiles' entry to your modDesc.
-- 
-- Authors: Timmiej93
-- Based on the FS15 script 'clipDistanceControl', of which I have been unable to find the author.
--
-- Copyright (c) Timmiej93, 2018
-- This file can be used in any map without specific permission. It can however not be claimed to be
--	your own work. Crediting me is not required, but it would be nice.
-- For more information on copyright for this mod, please check the readme file on Github
--
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --

clipDistanceControl = {}

local clipDistanceControl_mt = Class(clipDistanceControl)

function clipDistanceControl.onCreate(id)
    clipDistanceControl:new(id)
end
  
function clipDistanceControl:new(id, customMt)
	local self = {}
	if (customMt ~= nil) then
		setmetatable(self, customMt)
	else
		setmetatable(self, clipDistanceControl_mt)
	end
  
	self.triggerId = id
	addTrigger(id, "clipDistanceControlCallback", self)
	
	self.innerClipDistance = Utils.getNoNil(getUserAttribute(id, "innerClipDistance"), 300)
	self.savedCD = {}

	self.isEnabled = true
	
	return self
end

function clipDistanceControl:delete()
	removeTrigger(self.triggerId)
end

function clipDistanceControl:clipDistanceControlCallback(triggerId, otherId, onEnter, onLeave, onStay, otherShapeId)
	local vehicle = g_currentMission.nodeToVehicle[otherId]
	local object = g_currentMission.nodeObjects[otherId]

	if (vehicle ~= nil or object ~= nil) then

		if (onEnter) then
			local cd = getClipDistance(otherId)
			if (cd ~= nil and self.savedCD[otherId] == nil) then
				self.savedCD[otherId] = cd
				setClipDistance(otherId, self.innerClipDistance)
			end
		end
		if (onLeave) then
			local cd = self.savedCD[otherId]
			if (cd ~= nil) then
				self.savedCD[otherId] = nil
				setClipDistance(otherId, cd)
			end
		end
	end
end

g_onCreateUtil.addOnCreateFunction("clipDistanceControl", clipDistanceControl.onCreate)