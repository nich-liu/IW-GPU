Locations: x, y.

Thread 0:
r0 := load(y,wg0,ACQ,A,G,DV);
if (r0==2) { store(x,1,wg0,REL,A,G,DV) };

Thread 1:
store(y,2,wg1,A,G,DV);

Thread 2:
r0 := load(x,wg0,ACQ,A,G);
store(y,1,wg0,A,G,DV);

Final: 0:r0==2 && 2:r0==1 && x==1 && y==2

Locations: y, x.

Thread 0:
r0 := load(y,wg4);
if (r0==2) { fence(,membar_gl); store(x,1,wg0) };

Thread 1:
store(y,2,wg3);

Thread 2:
r0 := load(x,wg1);
fence(,membar_cta);
store(y,1,wg2);

Final: 2:r0==1 && 0:r0==2 && y==2 && x==1
