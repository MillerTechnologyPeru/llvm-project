// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --replace-value-regex "!annotation ![0-9]+" "!tbaa ![0-9]+" "!tbaa\.struct ![0-9]+" "!nosanitize ![0-9]+" "!srcloc ![0-9]+" --version 5

// RUN: %clang_cc1 -O2 -triple x86_64 -fbounds-safety -emit-llvm %s -o - | FileCheck %s
// RUN: %clang_cc1 -O2 -triple x86_64 -fbounds-safety -x objective-c -fbounds-attributes-objc-experimental -emit-llvm %s -o - | FileCheck %s

#include <ptrcheck.h>

static const int ints[__null_terminated 2] = {42, 0};
static const char *__null_terminated chars = "Hello";

// CHECK-LABEL: define dso_local { ptr, ptr } @good_ints(
// CHECK-SAME: ) local_unnamed_addr #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    ret { ptr, ptr } { ptr @ints, ptr getelementptr inbounds nuw (i8, ptr @ints, i64 4) }
//
const int *__indexable good_ints(void) {
  return __terminated_by_to_indexable(ints);
}

// CHECK-LABEL: define dso_local { ptr, ptr } @good_ints_unsafe(
// CHECK-SAME: ) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    ret { ptr, ptr } { ptr @ints, ptr getelementptr inbounds nuw (i8, ptr @ints, i64 8) }
//
const int *__indexable good_ints_unsafe(void) {
  return __unsafe_terminated_by_to_indexable(ints);
}

// CHECK-LABEL: define dso_local { ptr, ptr } @good_chars(
// CHECK-SAME: ) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    ret { ptr, ptr } { ptr @.str, ptr getelementptr inbounds nuw (i8, ptr @.str, i64 5) }
//
const char *__indexable good_chars(void) {
  return __terminated_by_to_indexable(chars);
}

// CHECK-LABEL: define dso_local { ptr, ptr } @good_chars_unsafe(
// CHECK-SAME: ) local_unnamed_addr #[[ATTR0]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    ret { ptr, ptr } { ptr @.str, ptr getelementptr inbounds nuw (i8, ptr @.str, i64 6) }
//
const char *__indexable good_chars_unsafe(void) {
  return __unsafe_terminated_by_to_indexable(chars);
}

// CHECK-LABEL: define dso_local noundef { ptr, ptr } @bad_null(
// CHECK-SAME: ) local_unnamed_addr #[[ATTR1:[0-9]+]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    unreachable
//
int *__indexable bad_null(void) {
  int *__null_terminated p = 0;
  return __terminated_by_to_indexable(p);
}

// CHECK-LABEL: define dso_local noundef { ptr, ptr } @bad_null_unsafe(
// CHECK-SAME: ) local_unnamed_addr #[[ATTR1]] {
// CHECK-NEXT:  [[ENTRY:.*:]]
// CHECK-NEXT:    unreachable
//
int *__indexable bad_null_unsafe(void) {
  int *__null_terminated p = 0;
  return __unsafe_terminated_by_to_indexable(p);
}
