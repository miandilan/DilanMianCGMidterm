# DilanMianCGMidterm
My midterm exam practical section project.

Link to the gravel and stone textures website:
https://3dtextures.me/

Explanation of the tasks:

So since my student ID starts with 1 and ends with 3, my tasks for the even number section. I added the background for the game which is the
green plane. Then I added blue circular objects to represent the bodies of water on the map. Then I added the circles to create a rocket ship
that will spiral around the lightsource in the middle of the background plane. I created the rocketship script to make the transform rotate
around the light source with the lightsource being the target. For more details please check the Spinner Script in the folder Spinner Scripts in 
the object. Then I added the reflection probe to the ship with a cubemap to a sphere and then added a reflection script added to it. The script just calls the 
render probe and the render texture and runs in the update method the renderprobe method with the render texture as an argument. The sphere with 
the reflection probe attached is used for the windshield and has a reflection material with a render texture and reflection shader class attached (please read it for details). This is what allowed accurate reflectivity for the windshield to be realistic. I used these methods since they were the easiest ones I knew from the previous lab 2. Finally I had updated my ToonRamp script attached to the ship and background to try and implement a bump map texture in it. This was meant to create a realistic texture with the toonramp appearance. I tried doing this by adding some variables in the properties, struct, and surf method to unpack the normals and otuput onto the bump shader uv coordinates (see code for details it's the ToonRamp shader class).It unfortunately didn't work and only displayed the Toon Ramp shader but not the actual bump map. 



