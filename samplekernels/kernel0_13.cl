Locations: x, y.

Thread 0:
r0 := load(y,wg0,SC,ACQ,A);

Thread 1:
store(x,1,wg3,SC,REL,A);
store(y,1,wg1,REL,A);

Thread 2:
store(y,2,wg4,SC,REL,A);
r0 := load(x,wg2,SC,ACQ,A);

Final: 0:r0==1 && 2:r0==0 && x==1 && y==2

Locations: y, x.

Thread 0:
r0 := load(y,wg4);

Thread 1:
store(x,1,wg1);
fence(,lwsync);
store(y,1,wg3);

Thread 2:
store(y,2,wg0);
fence(,sync);
r0 := load(x,wg2);

Final: 2:r0==0 && 0:r0==1 && y==2 && x==1
