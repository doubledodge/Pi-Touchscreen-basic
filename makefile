draw: main.o  touch.o framebuffer.o  
	cc -o $@ $^ 

buttontest: buttonExample.o  touch.o framebuffer.o  
	cc -o $@ $^ -l wiringPi

LKSdemo: LKS_CUSTOM.c 
	cc $^  -o $@  -I/usr/include/freetype2

clean:
	rm *.o
