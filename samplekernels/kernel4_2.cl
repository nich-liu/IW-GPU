#include "testing_common.h"

__kernel void litmus_test(
  __global atomic_uint *ga /* global, atomic locations */,
  __global int *gn /* global, non-atomic locations */,
  __global int *out /* output */,
  __global int *shuffled_ids /* ids */,
  volatile __global int *scratchpad,
  int scratch_location, // increment by 2
  int x_y_distance, // incremented by 2
  int dwarp_size)
{
  int lid = get_local_id(0);
  int wgid = get_group_id(0);

if (TESTING_WARP || TEST_THREAD(0,0) || TEST_THREAD(1,2) ) {
  if (TEST_THREAD(0,0)) {
    // Work-item 0 in workgroup 0:
    test_barrier(2, &(ga[3]));
    int tmp0 = atomic_load_explicit(&ga[1], memory_order_acquire, memory_scope_work_group);
    if (tmp0 == 1)
      gn[0] = 1;
    out[0] = tmp0;
    }
 else if (TEST_THREAD(1,2)) {
    // Work-item 1 in workgroup 2:
    test_barrier(2, &(ga[3]));
    out[1] = gn[0];
    if (tmp1 == 1)
      atomic_store_explicit(&ga[1], 1, memory_order_release, memory_scope_work_group);
    }
}
else {
    // Stress
    for (int i = 0; i < STRESS_ITERATIONS; i++)
    {
      switch (STRESS_PATTERN)
      {
      default:
        scratchpad[scratch_location] = i;
        int tmp = scratchpad[scratch_location];
        if (tmp < 0)
          break;
      }
    }
  }
}

//Postcondition
__kernel void check_outputs(__global atomic_uint *ga, __global int *out, __global int *result) {
    if (get_global_id(0) == 0) {
      if (out[0] == 1 && out[1] == 1 && gn[0] == 1 && ga[1] == 1) {
        *result=1;
      }
      else {
        *result=0;
      }
    }
}
