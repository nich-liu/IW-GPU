Locations: x, y, z.

Thread 0:
store(y,1,wg0,NAL);

Thread 1:
r0 := load(z,wg1,A);
if (r0==1) { r1 := load(y,wg2,NAL) };
if (r1==1) { store(x,1,wg3,A) };

Thread 2:
r0 := load(x,wg4,A);
if (r0==1) { store(z,1,wg5,A) };

Final: 1:r0==1 && 1:r1==1 && 2:r0==1 && x==1 && y==1 && z==1

Locations: x, y, z.

Thread 0:
r0 := load(z,wg1,A);
store(y,1,wg0,NAL);
if (r0==1) { r1 := load(y,wg2,NAL) };
if (r1==1) { store(x,1,wg3,A) };

Thread 1:
r0 := load(x,wg4,A);
if (r0==1) { store(z,1,wg5,A) };

Final: 1:r0==1 && 1:r1==1 && 2:r0==1 && x==1 && y==1 && z==1
