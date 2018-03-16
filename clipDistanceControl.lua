-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- clipDistanceControl v1.1.0.0
--
-- Purpose: The purpose of this script is to control the 'clip distance' (also known as view distance)
--	 of an object that is inside the associated trigger. With how the GIANTS engine currently handles
--	 rendering objects, it also renders them if they are not visible to the player (e.g. blocked by a 
--	 vehicle shed). Reducing the clip distance on them when they are in this shed can greatly increase
--	 the performance of the game.
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
--	 If you know or are the original author, please let me know, so I can properly credit them.
--
-- Changelog
--	For the changelog, please visit GitHub. This always has the most up to date and most complete
--  changelog available. GitHub information is at the bottom of this comment block.
--
--
-- Copyright (c) Timmiej93, 2018
-- This file can be used in any map without specific permission. It can however not be claimed to be
--	 your own work. Crediting me is not required, but it would be nice. This comment block (line 1 
--	 through 56) can NOT be removed (there is also no reason to remove it), to ensure that anyone 
--	 with questions can find the original author, and can complain to me, instead of you, the map 
--	 maker.
-- For more information or questions on copyright for this mod, please check the readme file on 
--	 GitHub. GitHub information is at the bottom of this comment block.
--
-- GitHub information
--	 GitHub > Timmiej93 > clipDistanceControl
--	 https://github.com/Timmiej93/clipDistanceControl
--
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --

clipDistanceControl = {}

local clipDistanceControl_mt = Class(clipDistanceControl)

function clipDistanceControl.onCreate(id)
    clipDistanceControl:new(id)
end
  
function clipDistanceControl:new(id, customMt)

	if (g_currentMission.CDC_savedDistances == nil) then
		g_currentMission.CDC_savedDistances = {}
	end

	local self = {}
	if (customMt ~= nil) then
		setmetatable(self, customMt)
	else
		setmetatable(self, clipDistanceControl_mt)
	end

	self.triggerId = id
	addTrigger(id, "clipDistanceControlCallback", self)
	
	self.savedCD = {}
	self.innerClipDistance = Utils.getNoNil(getUserAttribute(id, "innerClipDistance"), 100)

	return self
end

function clipDistanceControl:deleteMap()
	if (self.triggerId ~= nil) then
		removeTrigger(self.triggerId)
	end
end

function clipDistanceControl:keyEvent(unicode, sym, modifier, isDown) end
function clipDistanceControl:mouseEvent(posX, posY, isDown, isUp, button) end
function clipDistanceControl:draw() end
function clipDistanceControl:update(dt) end

function clipDistanceControl:clipDistanceControlCallback(triggerId, otherId, onEnter, onLeave, onStay, otherShapeId)

	-- Use the otherId to check if it's a vehicle or an object.
	local vehicle = g_currentMission.nodeToVehicle[otherId]
	local object = g_currentMission.nodeObjects[otherId]

	-- Grab a local copy of the table, to prevent humongeous lines.
	local gcmData = g_currentMission.CDC_savedDistances

	if (vehicle ~= nil or object ~= nil) then
	-- If the ID is indeed a vehicle or an ojbect...

		if (onEnter) then
			-- Get the vehicle's clip distance.
			local cd = getClipDistance(otherId)

			if (cd ~= nil and self.savedCD[otherId] == nil) then
				-- If the found clipdistance isn't nil, and this vehicle/object isn't in this trigger's database yet...
				if (gcmData[otherId] == nil) then
					-- If this vehicle/object isn't in the global database yet, store it there.
					gcmData[otherId] = cd
				end
				-- Store the clip distance in this trigger's database.
				self.savedCD[otherId] = cd
				-- Set the vehicle's/object's clip distance to the trigger's distance.
				setClipDistance(otherId, self.innerClipDistance)

			end
		end

		if (onLeave) then
			-- Get the stored (original) clip distance from the global database
			local cd = gcmData[otherId]

			if (cd ~= nil) then
				-- If the stored clip distance isn't nil, clear the stored data in this trigger's database and the global
				--	database, and then set the clipdistance back to the original clip distance of the vehicle / object.
				self.savedCD[otherId] = nil
				gcmData[otherId] = nil
				setClipDistance(otherId, cd)
			end
		end
	end
end

g_onCreateUtil.addOnCreateFunction("clipDistanceControl", clipDistanceControl.onCreate)
addModEventListener(clipDistanceControl)