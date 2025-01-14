; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=constraint-elimination -S %s | FileCheck %s

define i1 @test_gep_sext_known_positive_part_1(i16* readonly %src, i16* readnone %max, i8 %idx) {
; CHECK-LABEL: @test_gep_sext_known_positive_part_1(
; CHECK-NEXT:  check.0.min:
; CHECK-NEXT:    [[ADD_10:%.*]] = getelementptr inbounds i16, ptr [[SRC:%.*]], i16 10
; CHECK-NEXT:    [[C_ADD_10_MAX:%.*]] = icmp ult ptr [[ADD_10]], [[MAX:%.*]]
; CHECK-NEXT:    [[IDX_EXT:%.*]] = sext i8 [[IDX:%.*]] to i16
; CHECK-NEXT:    [[IDX_POS:%.*]] = icmp sge i16 [[IDX_EXT]], 0
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[C_ADD_10_MAX]], [[IDX_POS]]
; CHECK-NEXT:    br i1 [[AND]], label [[CHECK_IDX:%.*]], label [[TRAP:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret i1 false
; CHECK:       check.idx:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i16 [[IDX_EXT]], 5
; CHECK-NEXT:    br i1 [[CMP]], label [[CHECK_MAX:%.*]], label [[TRAP]]
; CHECK:       check.max:
; CHECK-NEXT:    [[GEP_IDX:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i16 [[IDX_EXT]]
; CHECK-NEXT:    [[IDX_1:%.*]] = add nuw nsw i16 [[IDX_EXT]], 1
; CHECK-NEXT:    [[GEP_IDX_1:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i16 [[IDX_1]]
; CHECK-NEXT:    [[R_1:%.*]] = xor i1 true, true
; CHECK-NEXT:    ret i1 [[R_1]]
;
check.0.min:
  %add.10 = getelementptr inbounds i16, i16* %src, i16 10
  %c.add.10.max = icmp ult i16* %add.10, %max
  %idx.ext = sext i8 %idx to i16
  %idx.pos = icmp sge i16 %idx.ext, 0
  %and = and i1 %c.add.10.max, %idx.pos
  br i1 %and, label %check.idx, label %trap

trap:
  ret i1 0

check.idx:
  %cmp = icmp ult i16 %idx.ext, 5
  br i1 %cmp, label %check.max, label %trap

check.max:
  %gep.idx = getelementptr inbounds i16, i16* %src, i16 %idx.ext
  %c.max.0 = icmp ult i16* %gep.idx, %max

  %idx.1 = add nuw nsw i16 %idx.ext, 1
  %gep.idx.1 = getelementptr inbounds i16, i16* %src, i16 %idx.1
  %c.max.1 = icmp ult i16* %gep.idx.1, %max

  %r.1 = xor i1 %c.max.0, %c.max.1
  ret i1 %r.1
}

define i1 @test_gep_sext_known_positive_part_2(i16* readonly %src, i16* readnone %max, i8 %idx) {
; CHECK-LABEL: @test_gep_sext_known_positive_part_2(
; CHECK-NEXT:  check.0.min:
; CHECK-NEXT:    [[ADD_10:%.*]] = getelementptr inbounds i16, ptr [[SRC:%.*]], i16 10
; CHECK-NEXT:    [[C_ADD_10_MAX:%.*]] = icmp ult ptr [[ADD_10]], [[MAX:%.*]]
; CHECK-NEXT:    [[IDX_EXT:%.*]] = sext i8 [[IDX:%.*]] to i16
; CHECK-NEXT:    [[IDX_POS:%.*]] = icmp sge i16 [[IDX_EXT]], 0
; CHECK-NEXT:    [[AND:%.*]] = and i1 [[C_ADD_10_MAX]], [[IDX_POS]]
; CHECK-NEXT:    br i1 [[AND]], label [[CHECK_IDX:%.*]], label [[TRAP:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret i1 false
; CHECK:       check.idx:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i16 [[IDX_EXT]], 5
; CHECK-NEXT:    br i1 [[CMP]], label [[CHECK_MAX:%.*]], label [[TRAP]]
; CHECK:       check.max:
; CHECK-NEXT:    [[IDX_5:%.*]] = add nuw nsw i16 [[IDX_EXT]], 5
; CHECK-NEXT:    [[GEP_IDX_5:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i16 [[IDX_5]]
; CHECK-NEXT:    [[IDX_6:%.*]] = add nuw nsw i16 [[IDX_EXT]], 6
; CHECK-NEXT:    [[GEP_IDX_6:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i16 [[IDX_6]]
; CHECK-NEXT:    [[R_3:%.*]] = xor i1 true, true
; CHECK-NEXT:    [[IDX_10:%.*]] = add nuw nsw i16 [[IDX_EXT]], 10
; CHECK-NEXT:    [[GEP_IDX_10:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i16 [[IDX_10]]
; CHECK-NEXT:    [[C_MAX_10:%.*]] = icmp ult ptr [[GEP_IDX_10]], [[MAX]]
; CHECK-NEXT:    [[R_4:%.*]] = xor i1 [[R_3]], [[C_MAX_10]]
; CHECK-NEXT:    ret i1 [[R_4]]
;
check.0.min:
  %add.10 = getelementptr inbounds i16, i16* %src, i16 10
  %c.add.10.max = icmp ult i16* %add.10, %max
  %idx.ext = sext i8 %idx to i16
  %idx.pos = icmp sge i16 %idx.ext, 0
  %and = and i1 %c.add.10.max, %idx.pos
  br i1 %and, label %check.idx, label %trap

trap:
  ret i1 0

check.idx:
  %cmp = icmp ult i16 %idx.ext, 5
  br i1 %cmp, label %check.max, label %trap

check.max:
  %idx.5 = add nuw nsw i16 %idx.ext, 5
  %gep.idx.5 = getelementptr inbounds i16, i16* %src, i16 %idx.5
  %c.max.5 = icmp ult i16* %gep.idx.5, %max

  %idx.6 = add nuw nsw i16 %idx.ext, 6
  %gep.idx.6 = getelementptr inbounds i16, i16* %src, i16 %idx.6
  %c.max.6 = icmp ult i16* %gep.idx.6, %max

  %r.3 = xor i1 %c.max.5, %c.max.6

  %idx.10 = add nuw nsw i16 %idx.ext, 10
  %gep.idx.10 = getelementptr inbounds i16, i16* %src, i16 %idx.10
  %c.max.10 = icmp ult i16* %gep.idx.10, %max

  %r.4 = xor i1 %r.3, %c.max.10
  ret i1 %r.4
}

define void @test_gep_sext_not_known_positive(i16* readonly %src, i16* readnone %max, i8 %idx) {
; CHECK-LABEL: @test_gep_sext_not_known_positive(
; CHECK-NEXT:  check.0.min:
; CHECK-NEXT:    [[ADD_10:%.*]] = getelementptr inbounds i16, ptr [[SRC:%.*]], i16 10
; CHECK-NEXT:    [[C_ADD_10_MAX:%.*]] = icmp ult ptr [[ADD_10]], [[MAX:%.*]]
; CHECK-NEXT:    [[IDX_EXT:%.*]] = sext i8 [[IDX:%.*]] to i16
; CHECK-NEXT:    br i1 [[C_ADD_10_MAX]], label [[CHECK_IDX:%.*]], label [[TRAP:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret void
; CHECK:       check.idx:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i16 [[IDX_EXT]], 5
; CHECK-NEXT:    br i1 [[CMP]], label [[CHECK_MAX:%.*]], label [[TRAP]]
; CHECK:       check.max:
; CHECK-NEXT:    [[GEP_IDX:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i16 [[IDX_EXT]]
; CHECK-NEXT:    [[C_MAX_0:%.*]] = icmp ult ptr [[GEP_IDX]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_0]])
; CHECK-NEXT:    [[IDX_1:%.*]] = add nuw nsw i16 [[IDX_EXT]], 1
; CHECK-NEXT:    [[GEP_IDX_1:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i16 [[IDX_1]]
; CHECK-NEXT:    [[C_MAX_1:%.*]] = icmp ult ptr [[GEP_IDX_1]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_1]])
; CHECK-NEXT:    [[IDX_5:%.*]] = add nuw nsw i16 [[IDX_EXT]], 5
; CHECK-NEXT:    [[GEP_IDX_5:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i16 [[IDX_5]]
; CHECK-NEXT:    [[C_MAX_5:%.*]] = icmp ult ptr [[GEP_IDX_5]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_5]])
; CHECK-NEXT:    [[IDX_6:%.*]] = add nuw nsw i16 [[IDX_EXT]], 6
; CHECK-NEXT:    [[GEP_IDX_6:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i16 [[IDX_6]]
; CHECK-NEXT:    [[C_MAX_6:%.*]] = icmp ult ptr [[GEP_IDX_6]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_6]])
; CHECK-NEXT:    [[IDX_10:%.*]] = add nuw nsw i16 [[IDX_EXT]], 10
; CHECK-NEXT:    [[GEP_IDX_10:%.*]] = getelementptr inbounds i16, ptr [[SRC]], i16 [[IDX_10]]
; CHECK-NEXT:    [[C_MAX_10:%.*]] = icmp ult ptr [[GEP_IDX_10]], [[MAX]]
; CHECK-NEXT:    call void @use(i1 [[C_MAX_10]])
; CHECK-NEXT:    ret void
;
check.0.min:
  %add.10 = getelementptr inbounds i16, i16* %src, i16 10
  %c.add.10.max = icmp ult i16* %add.10, %max
  %idx.ext = sext i8 %idx to i16
  br i1 %c.add.10.max, label %check.idx, label %trap

trap:
  ret void

check.idx:
  %cmp = icmp ult i16 %idx.ext, 5
  br i1 %cmp, label %check.max, label %trap

check.max:
  %gep.idx = getelementptr inbounds i16, i16* %src, i16 %idx.ext
  %c.max.0 = icmp ult i16* %gep.idx, %max
  call void @use(i1 %c.max.0)

  %idx.1 = add nuw nsw i16 %idx.ext, 1
  %gep.idx.1 = getelementptr inbounds i16, i16* %src, i16 %idx.1
  %c.max.1 = icmp ult i16* %gep.idx.1, %max
  call void @use(i1 %c.max.1)

  %idx.5 = add nuw nsw i16 %idx.ext, 5
  %gep.idx.5 = getelementptr inbounds i16, i16* %src, i16 %idx.5
  %c.max.5 = icmp ult i16* %gep.idx.5, %max
  call void @use(i1 %c.max.5)

  %idx.6 = add nuw nsw i16 %idx.ext, 6
  %gep.idx.6 = getelementptr inbounds i16, i16* %src, i16 %idx.6
  %c.max.6 = icmp ult i16* %gep.idx.6, %max
  call void @use(i1 %c.max.6)

  %idx.10 = add nuw nsw i16 %idx.ext, 10
  %gep.idx.10 = getelementptr inbounds i16, i16* %src, i16 %idx.10
  %c.max.10 = icmp ult i16* %gep.idx.10, %max
  call void @use(i1 %c.max.10)

  ret void
}

declare void @use(i1)
