Locations: x, y.

Thread 0:
store(y,1,wg0,SC,REL,A,G,DV);
r0 := load(x,wg0,SC,ACQ,A,G,DV);

Thread 1:
r0 := load(x,wg1,SC,ACQ,A,G);
r1 := load(y,wg1,SC,ACQ,A,G,DV);

Thread 2:
store(x,1,wg1,SC,REL,A,G,DV);

Final: 1:r0==1 && 1:r1==0 && 0:r0==0 && x==1 && y==1

Locations: x, y.

Thread 0:
store(y,1,wg4);
fence(,membar_gl);
r0 := load(x,wg1);

Thread 1:
r1 := load(x,wg3);
fence(,membar_cta);
r0 := load(y,wg2);

Thread 2:
store(x,1,wg0);

Final: 0:r0==0 && 1:r0==0 && 1:r1==1 && x==1 && y==1
