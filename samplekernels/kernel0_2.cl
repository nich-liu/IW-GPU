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

if (TESTING_WARP || TEST_THREAD(0,0) || TEST_THREAD(1,10) || TEST_THREAD(2,2) || TEST_THREAD(3,5) || TEST_THREAD(4,8) || TEST_THREAD(5,9) ) {
  if (TEST_THREAD(0,0)) {
    // Work-item 0 in workgroup 0:
    test_barrier(6, &(ga[3]));
    expected = 2; /* returns bool */ atomic_compare_exchange_strong_explicit(ga[1], &expected, 3, memory_order_release, memory_order_relaxed, memory_scope_work_group);
    atomic_store_explicit(&ga[1], 4, memory_order_relaxed, memory_scope_work_group);
    }
 else if (TEST_THREAD(1,10)) {
    // Work-item 1 in workgroup 10:
    test_barrier(6, &(ga[3]));
    int tmp1 = atomic_load_explicit(&ga[0], memory_order_relaxed, memory_scope_work_group);
    atomic_work_item_fence(0, memory_order_acq_rel, memory_scope_work_group);
    atomic_store_explicit(&ga[1], 1, memory_order_relaxed, memory_scope_work_group);
    out[0] = tmp0;
    }
 else if (TEST_THREAD(2,2)) {
    // Work-item 2 in workgroup 2:
    test_barrier(6, &(ga[3]));
    expected = 2; /* returns bool */ atomic_compare_exchange_strong_explicit(ga[0], &expected, 3, memory_order_release, memory_order_relaxed, memory_scope_work_group);
    atomic_store_explicit(&ga[0], 4, memory_order_relaxed, memory_scope_work_group);
    }
 else if (TEST_THREAD(3,5)) {
    // Work-item 3 in workgroup 5:
    test_barrier(6, &(ga[3]));
    int tmp6 = atomic_load_explicit(&ga[1], memory_order_relaxed, memory_scope_work_group);
    atomic_work_item_fence(0, memory_order_acq_rel, memory_scope_work_group);
    atomic_store_explicit(&ga[0], 1, memory_order_relaxed, memory_scope_work_group);
    out[1] = tmp1;
    }
 else if (TEST_THREAD(4,8)) {
    // Work-item 4 in workgroup 8:
    test_barrier(6, &(ga[3]));
    expected = 1; /* returns bool */ atomic_compare_exchange_strong_explicit(ga[0], &expected, 2, memory_order_acquire, memory_order_relaxed, memory_scope_work_group);
    }
 else if (TEST_THREAD(5,9)) {
    // Work-item 5 in workgroup 9:
    test_barrier(6, &(ga[3]));
    expected = 1; /* returns bool */ atomic_compare_exchange_strong_explicit(ga[1], &expected, 2, memory_order_acquire, memory_order_relaxed, memory_scope_work_group);
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
      if (out[0] == 2 && out[3] == 2 && out[6] == 4 && out[10] == 1 && out[15] == 1 && out[1] == 4 && ga[0] == 4 && ga[1] == 4) {
        *result=1;
      }
      else {
        *result=0;
      }
    }
}
