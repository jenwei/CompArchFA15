<h1>Bike Light Specification Document</h1>

<h3>Inputs and Outputs</h3>
The bike light has one input and one output. The input of this design is a button press from the single button of the light.
The output of this system is in the form of light from a single LED which has two states - on and off.

<h3>System Operational Modes</h3>
This system has four modes: `off`, `on`, `blinking`, `dim`. `off` is where the LED is unpowered, `on` is where the LED is powered, `blinking` is where the LED toggles between `on` and `off` at a certain frequency, and `dim` is where the LED toggles between `on` and `off` quickly.

The `on` state has a frequency of 32,768 Hz.

Looking at a generic bike light, the blinking rate was approximately 35 blinks/10 seconds or 3.5 Hz which is the frequency this bike controller clone will be using.

Since `dim` is supposed to be `on` at approximately 50% brightness, the frequency of that should be approximately half the frequency of the `on` state or 16,384 Hz.

<h3>Finite State Machine</h3>
![FSM of Bike Light](https://github.com/jenwei/CompArchFA15/blob/master/Midterm/img/light_fsm_v2.png)
As shown in the FSM diagram, the four modes are represented and transition from one mode to the next when the button is pressed, otherwise, the mode stays the same.
