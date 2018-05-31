draw: main.o  touch.o framebuffer.o  
	cc -o $@ $^ 

buttontest: buttonExample.o  touch.o framebuffer.o  
	cc -o $@ $^ -l wiringPi

