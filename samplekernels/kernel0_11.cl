Locations: x, y, z.

Thread 0:
store(x,1,wg0,NAL);
fence(,wg1,A);
r0 := load(z,wg2,A);
if (r0==1) { store(y,1,wg3,A) };

Thread 1:
r0 := load(y,wg4,ACQ,A);
if (r0==1) { r1 := load(x,wg5,NAL) };
if (r1==1) { store(z,1,wg6,A) };

Final: 0:r0==1 && 1:r0==1 && 1:r1==1 && x==1 && y==1 && z==1

Locations: x, y, z.

Thread 0:
store(x,1,wg0,NAL);
fence(,wg1,REL,A);
r0 := load(z,wg2,A);
if (r0==1) { store(y,1,wg3,A) };

Thread 1:
r0 := load(y,wg4,ACQ,A);
if (r0==1) { r1 := load(x,wg5,NAL) };
if (r1==1) { store(z,1,wg6,A) };

Final: 0:r0==1 && 1:r0==1 && 1:r1==1 && x==1 && y==1 && z==1
