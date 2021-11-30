nothing: nothing.o
	ld nothing.o -o nothing

nothing.o: nothing.s
	as nothing.s -g  -o nothing.o
