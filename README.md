# ClipDistanceControl

[Readme auch verfügbar in Deutsch.](https://github.com/Timmiej93/clipDistanceControl/blob/master/README_DE.md)

This is a script for the game Farming Simulator 17. The purpose of this script is to control the 'clip distance' (also known as view distance or draw distance) of an object or vehicle that is inside the associated trigger. With how the GIANTS engine currently handles rendering objects, it also renders them if they are not visible to the player (e.g. a broken sight-line or blocked by a vehicle shed). Reducing the clip distance on them when they are in this shed can greatly increase the performance of the game. While and after I have been working on the script, it has been thoroughly tested by [Northside Farming Group](https://www.fs-uk.com/forum/index.php?topic=182644.0) for months, meaning that this script should be MP compatible. Creating this script was the idea of SneakyBeaky, and is based upon the FS15 version, of which the author is unknown to me. If you know who the original author is, please let me know.
This script has to be implemented on a map. 

## How to implement

If you want to implement this script on your map, please be sure to read the [Copyright](#Copyright) section of this README. There are just a few simple rules that ensure that the origin of the script can always be found.

**Adding the trigger shape**
- Add a shape to your map. I'd suggest simply clicking '**Create > Primitives > Cube**' in the Giants editor menu.
- In the Attributes window, change the **Scale X / Y / Z** values so the trigger is the desired size and tick the '**Rigid Body**' checkbox.
- Go to the '**Rigid Body**' tab, and tick the '**Collision**' and '**Trigger**' boxes, and put '56031c2' in the 'Collision Mask' textbox. Click the button behind that textbox to verify the following numbers have a checkmark behind them: 1, 6, 7, 8, 12, 13, 21, 22, 24 and 26.
- Go to the '**Shape**' tab, and tick the '**Non Renderable**' checkbox.

## Add the script and proper settings
- With the trigger selected, open the '**User Attributes**' window.
- Add a new attribute called '**onCreate**', with type '**Script Callback**', and set it to '**modOnCreate.clipDistanceControl**'
- Add another new attribute called '**innerClipDistance**', with type '**Integer**'. Set this to the clip distance in meters you'd like to use for that trigger. Remember, if the distance between you (the player) and the object in the trigger is greater than the entered distance, it will not be visible. If this attribute is not set, the clip distance will be set to 300, which reduces the effect greatly.

## ModDesc
Don't forget to add the following section to your modDesc, anywhere between the modDesc nodes.
```
<extraSourceFiles>
  <sourceFile filename="scripts/clipDistanceControl.lua"/>
</extraSourceFiles>
```
For the above, the script has to be in a folder called 'scripts', which is at the root of your map. If you already have the 'extraSourceFiles' node in your modDesc, only add the 'sourceFile' node.

## Notes
Simply repeat this process for each trigger. All given names are **case sensitive**. Don't forget to hit enter after changing values in GE,  save regularly, etc.. The 'Attributes' and 'User Attributes' window can be opened by clicking '*Window > Attribute*s' and '*Window > User Attributes*' in the GE menu.

If people are having issues with implementing this script, I can add screenshots to clarify some statements, just let me know.

You need to download the lua file provided to be able to implement it in the map. I hope this goes without saying.

Those who have viewed the Oakfield WIP thread may have seen that a similar script will be implemented on that map. These scripts are independent of each other, and while similar, are not the same. This means that this tutorial will not work for that script. If you are unsure which script you are using, either open it and check if there is a comment with my name on the first couple of lines, or simply download this script to replace the one you have.

## Copyright
Copyright (c) Timmiej93, 2018. All rights reserved.

Disclaimer: By using the code available on this website, you agree to the fact that you are using this code solely at your own risk. The code is provided without any form of warranty, and I (Timmiej93) hereby disclaim all forms of warranty.

This file **`can`** be used in any map without specific permission. A map that includes this script can also be distributed **`without any restrictions`**. Crediting me is **`not required`**, but it would be nice. The script can however **`not`** be claimed to be your own work. 
The comment block at the start of the file (line 1 through 44) can **`not`** be removed however (there's also no need to remove it), to ensure that anyone with questions can find the original author, and can complain to me, instead of you, the map maker.

I (Timmiej93) wrote this script, and I hold the copyright on this mod. That simply means that the code is mine. It also means that you can't just use this code for your own projects. Any contributions becomes my property as soon as it's committed, otherwise I would not be able to publish these changes. If your computer crashes or is damaged in any other way due to this mod, you can tell me, and I'll try to fix it for you. I will not take any responsibility for any damage.
