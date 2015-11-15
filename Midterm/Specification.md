<h1>Bike Light Specification Document</h1>

<h3>Inputs and Outputs</h3>
The bike light has one input and one output. The input of this design is a button press from the single button of the light.
The output of this system is in the form of light from a single LED which has two states - on and off.

<h3>System Operational Modes</h3>
This system has four modes: `off`, `on`, `blinking`, `dim`. `off` is where the LED is unpowered, `on` is where the LED is powered, `blinking` is where the LED toggles between `on` and `off`, and `dim` is where the LED is `on` at approximately 50% brightness.

Below is a graphical illustration of the four states from the perspective of the human eye.
![Graphical Representation of States](https://github.com/jenwei/CompArchFA15/blob/master/Midterm/img/graphical.png)

Looking at a generic bike light, the blinking rate was approximately 35 blinks/10 seconds or 3.5 Hz, which rounds up to approx. 4.0 Hz (2^2 Hz), the frequency this bike controller clone will be using.

As mentioned in the midterm handout, digital circuits like this one often implement analog behaviors such as dimming using Pulse Width Modulation, where the LED is turned off and on rapidly, faster than the eye can see. Thus, the perceived brightness depends on the total amount of time the LED spends on - the "duty cycle". Since `dim` is supposed to be `on` at approximately 50% brightness. However, the midterm handout also mentions that the human vision flicker limitation is 128 Hz, meaning that despite the lower frequency, the human eye will not notice the flickering, and will perceive it as a dimness in the LED instead.

<h3>Finite State Machine</h3>
<p>The FSM diagram below depicts the four states of the bike light. The state moves onto the next state when the button is pressed. Otherwise, the state stays the same.</p>
![FSM of Bike Light](https://github.com/jenwei/CompArchFA15/blob/master/Midterm/img/light_fsm_v2.png)
