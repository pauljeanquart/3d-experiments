Hello friends!

EggBot, EggDuino, Spherebot, ... there are really many to buy or to build yourself. Everyone has their own ideas of how a part should look.
My idea is now ...

Basically, they're just 3D printed parts, a bit of electronics, software, and a few other parts. Balls or eggs up to a diameter of 80mm fit in. For this purpose, the mount on the motor side is adjustable and in two different lengths. The counter bearing is designed as a threaded spindle. The pen holder also includes three different ones, just for different pen diameters.

What do you need:

3D printer with a print area of ​​min. 195x120mm
the printed parts
1x Arduino UNO
1x CNC Shield for the Arduino
6x jumpers for the CNC shield
2x stepper motors Nema 17
2x stepper motor driver A4988
1x electrolytic capacitor 100uF
1x servo SG90
1x power supply for the CNC Shield (12Volt)
1x ball bearing 608-2Z
2x O-ring 2.65x16
1x compression spring approx. Ø9x45mm
M3 screws in different lengths
M3 square nuts
Cables, plugs, ... other small parts
Software:

Arduino IDE
https://www.arduino.cc/en/Main/Software
EggDuino
https://github.com/plex3r/EggDuino
Inkscape
https://inkscape.org/de/
EggBot PlugIn
https://github.com/evil-mad/EggBot/releases/
You have to print some of the 3D printed parts with support.
I printed the larger parts with 30% infill, the smaller parts with 60%.
You then have to rework the parts a little so that everything fits together exactly.

The jumpers come on the CNC shield to set the microsteps (see photos).
How you have to connect the servo can also be seen in one of the photos.
The electrolytic capacitor between GND / RST on the CNC Shield is also important.
! Caution !: the negative pole of the capacitor must be connected at "GND".
(but only plug in after installing the EggDuino firmware!).

After the software installation you have to adjust the file "ebb_serial.py".
"C: \ Program Files \ Inkscape \ share \ extensions \ ebb_serial.py" (see photos)

How you generally deal with the EggBot can be seen in many videos on the net, so I save myself from writing detailed instructions.

Here is a short video ...
https://www.youtube.com/watch?v=g3lcvoDMEzc

If you are satisfied with my work you can support me for further projects.
https://www.paypal.me/herbertb1

THANKS

Have fun with it!

Print settings
Printer:
Homemade CoreXY

Rafts:
Yes

Supports:
Yes

Resolution:
0.2mm

Infill:
30-60%