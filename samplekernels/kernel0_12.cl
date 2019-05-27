Locations: x, y.

Thread 0:
r1 := load(x,wg1,ACQ,A);
r0 := load(y,wg0,SC,ACQ,A);

Thread 1:
store(y,1,wg4,SC,REL,A);
r0 := load(x,wg2,SC,ACQ,A);

Thread 2:
store(x,1,wg3,SC,REL,A);

Final: 0:r0==0 && 0:r1==1 && 1:r0==0 && x==1 && y==1

Locations: y, x.

Thread 0:
r0 := load(x,wg3);
if (r0==1) { fence(,isb); r1 := load(y,wg4) };

Thread 1:
store(y,1,wg0);
fence(,dmb);
r0 := load(x,wg2);

Thread 2:
store(x,1,wg1);

Final: 1:r0==0 && 0:r0==1 && 0:r1==0 && y==1 && x==1
