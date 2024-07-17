(module $physarum
  (type $t0 (func (result i32)))
  (type $t1 (func (param i32 i32 i32) (result i32)))
  (type $t2 (func (param i32 i32)))
  (type $t3 (func (param i32 i32 i32)))
  (type $t4 (func (param i32 i32 i32 i32 i32 i32 i32 i32 i32)))
  (type $t5 (func (param i32 i32 i32 i32 i32)))
  (type $t6 (func (param i32)))
  (type $t7 (func (param i32 i32 i32 i32)))
  (type $t8 (func (param i32 i32 i32 i32 i32 i32)))
  (type $t9 (func (param f32 f32 f32 f32)))
  (type $t10 (func (param i32 i32 i32 i32 i32 i32 i32 i32)))
  (type $t11 (func))
  (type $t12 (func (param i32 i32) (result i32)))
  (type $t13 (func (param i32) (result i32)))
  (import "libc" "rand" (func $rand (type $t0)))
  (import "common" "createShader" (func $createShader (type $t1)))
  (import "common" "glGenTextures" (func $glGenTextures (type $t2)))
  (import "common" "glBindTexture" (func $glBindTexture (type $t2)))
  (import "common" "glTexParameteri" (func $glTexParameteri (type $t3)))
  (import "common" "glTexImage2D" (func $glTexImage2D (type $t4)))
  (import "common" "glGenFramebuffers" (func $glGenFramebuffers (type $t2)))
  (import "common" "glBindFramebuffer" (func $glBindFramebuffer (type $t2)))
  (import "common" "glFramebufferTexture2D" (func $glFramebufferTexture2D (type $t5)))
  (import "common" "glDrawBuffers" (func $glDrawBuffers (type $t2)))
  (import "common" "glGenVertexArrays" (func $glGenVertexArrays (type $t2)))
  (import "common" "glBindVertexArray" (func $glBindVertexArray (type $t6)))
  (import "common" "glGenBuffers" (func $glGenBuffers (type $t2)))
  (import "common" "glBindBuffer" (func $glBindBuffer (type $t2)))
  (import "common" "glBufferData" (func $glBufferData (type $t7)))
  (import "common" "glVertexAttribPointer" (func $glVertexAttribPointer (type $t8)))
  (import "common" "glEnableVertexAttribArray" (func $glEnableVertexAttribArray (type $t6)))
  (import "common" "glClearColor" (func $glClearColor (type $t9)))
  (import "common" "glUseProgram" (func $glUseProgram (type $t6)))
  (import "common" "glDrawArrays" (func $glDrawArrays (type $t3)))
  (import "common" "glCopyTexSubImage2D" (func $glCopyTexSubImage2D (type $t10)))
  (import "common" "glCreateProgram" (func $glCreateProgram (type $t0)))
  (import "common" "glAttachShader" (func $glAttachShader (type $t2)))
  (import "common" "glLinkProgram" (func $glLinkProgram (type $t6)))
  (import "common" "glGetProgramiv" (func $glGetProgramiv (type $t3)))
  (import "common" "glGetProgramInfoLog" (func $glGetProgramInfoLog (type $t7)))
  (import "libc" "grow" (func $grow (type $t6)))
  (import "libc" "fprint" (func $fprint (type $t3)))
  (func $__original_main (export "_initialize") (type $t0) (result i32)
    (local $l0 i32) (local $l1 i32) (local $l2 i32) (local $l3 i32) (local $l4 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee $l0
    global.set $__stack_pointer
    i32.const 1716756894
    call $srand
    local.get $l0
    i32.const 1716756894
    i32.store
    i32.const 1133
    local.get $l0
    call $printf
    drop
    call $create_rcx
    block $B0
      i32.const 0
      i32.load offset=1180
      i32.const 0
      i32.load offset=1176
      i32.mul
      local.tee $l1
      i32.const 12
      i32.mul
      call $malloc
      local.tee $l2
      i32.eqz
      br_if $B0
      block $B1
        local.get $l1
        i32.eqz
        br_if $B1
        local.get $l2
        local.set $l3
        loop $L2
          local.get $l3
          f32.const 0x1p+0 (;=1;)
          f32.const 0x0p+0 (;=0;)
          call $rand
          f32.convert_i32_s
          f32.const 0x1p-31 (;=4.65661e-10;)
          f32.mul
          f64.promote_f32
          f64.const 0x1.e666666666666p-1 (;=0.95;)
          f64.gt
          select
          f32.store
          call $rand
          local.set $l4
          local.get $l3
          i32.const 8
          i32.add
          i32.const 0
          i32.store
          local.get $l3
          i32.const 4
          i32.add
          local.get $l4
          f32.convert_i32_s
          f32.const 0x1p-31 (;=4.65661e-10;)
          f32.mul
          f32.store
          local.get $l3
          i32.const 12
          i32.add
          local.set $l3
          local.get $l1
          i32.const -1
          i32.add
          local.tee $l1
          br_if $L2
        end
      end
      i32.const 1024
      i32.const 35633
      i32.const 1111
      call $createShader
      local.set $l3
      i32.const 1078
      i32.const 35632
      i32.const 1111
      call $createShader
      local.set $l1
      i32.const 1051
      i32.const 35632
      i32.const 1111
      call $createShader
      local.set $l4
      local.get $l2
      local.get $l3
      local.get $l1
      call $createProgram
      local.get $l3
      local.get $l4
      call $createProgram
      call $setup
      call $main_loop
      local.get $l0
      i32.const 16
      i32.add
      global.set $__stack_pointer
      i32.const 0
      return
    end
    i32.const 1104
    call $perror
    i32.const 1
    call $exit
    unreachable)
  (func $create_rcx (type $t11)
    i32.const 0
    i32.const 0
    i32.load offset=1176
    i32.store offset=1224
    i32.const 0
    i32.const 0
    i32.load offset=1180
    i32.store offset=1228)
  (func $setup (type $t3) (param $p0 i32) (param $p1 i32) (param $p2 i32)
    (local $l3 i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee $l3
    global.set $__stack_pointer
    i32.const 0
    local.get $p1
    i32.store offset=1236
    i32.const 0
    local.get $p0
    i32.store offset=1232
    i32.const 0
    local.get $p2
    i32.store offset=1240
    i32.const 1
    local.get $l3
    i32.const 60
    i32.add
    call $glGenTextures
    i32.const 3553
    local.get $l3
    i32.load offset=60
    call $glBindTexture
    i32.const 3553
    i32.const 10240
    i32.const 9728
    call $glTexParameteri
    i32.const 3553
    i32.const 10241
    i32.const 9728
    call $glTexParameteri
    i32.const 3553
    i32.const 0
    i32.const 6407
    i32.const 0
    i32.load offset=1224
    i32.const 0
    i32.load offset=1228
    i32.const 0
    i32.const 6407
    i32.const 5126
    i32.const 0
    call $glTexImage2D
    i32.const 1
    local.get $l3
    i32.const 56
    i32.add
    call $glGenTextures
    i32.const 3553
    local.get $l3
    i32.load offset=56
    call $glBindTexture
    i32.const 3553
    i32.const 10240
    i32.const 9728
    call $glTexParameteri
    i32.const 3553
    i32.const 10241
    i32.const 9728
    call $glTexParameteri
    i32.const 3553
    i32.const 0
    i32.const 6407
    i32.const 0
    i32.load offset=1224
    i32.const 0
    i32.load offset=1228
    i32.const 0
    i32.const 6407
    i32.const 5126
    i32.const 0
    i32.load offset=1232
    call $glTexImage2D
    i32.const 1
    i32.const 1244
    call $glGenFramebuffers
    i32.const 36160
    i32.const 0
    i32.load offset=1244
    call $glBindFramebuffer
    i32.const 36160
    i32.const 36064
    i32.const 3553
    local.get $l3
    i32.load offset=60
    i32.const 0
    call $glFramebufferTexture2D
    local.get $l3
    i32.const 36064
    i32.store offset=52
    i32.const 1
    local.get $l3
    i32.const 52
    i32.add
    call $glDrawBuffers
    local.get $l3
    i32.const 40
    i32.add
    i32.const 0
    i64.load offset=1208
    i64.store
    local.get $l3
    i32.const 32
    i32.add
    i32.const 0
    i64.load offset=1200
    i64.store
    local.get $l3
    i32.const 0
    i64.load offset=1192
    i64.store offset=24
    local.get $l3
    i32.const 0
    i64.load offset=1184
    i64.store offset=16
    i32.const 1
    local.get $l3
    i32.const 12
    i32.add
    call $glGenVertexArrays
    local.get $l3
    i32.load offset=12
    call $glBindVertexArray
    i32.const 1
    local.get $l3
    i32.const 8
    i32.add
    call $glGenBuffers
    i32.const 34962
    local.get $l3
    i32.load offset=8
    call $glBindBuffer
    i32.const 34962
    i32.const 32
    local.get $l3
    i32.const 16
    i32.add
    i32.const 35044
    call $glBufferData
    i32.const 0
    i32.const 2
    i32.const 5126
    i32.const 0
    i32.const 0
    i32.const 0
    call $glVertexAttribPointer
    i32.const 0
    call $glEnableVertexAttribArray
    f32.const 0x0p+0 (;=0;)
    f32.const 0x0p+0 (;=0;)
    f32.const 0x0p+0 (;=0;)
    f32.const 0x1p+0 (;=1;)
    call $glClearColor
    i32.const 0
    i32.load offset=1240
    call $glUseProgram
    local.get $l3
    i32.const 64
    i32.add
    global.set $__stack_pointer)
  (func $reset_frame (export "reset_frame") (type $t11)
    i32.const 3553
    i32.const 0
    i32.const 6407
    i32.const 0
    i32.load offset=1224
    i32.const 0
    i32.load offset=1228
    i32.const 0
    i32.const 6407
    i32.const 5126
    i32.const 0
    i32.load offset=1232
    call $glTexImage2D)
  (func $next_frame (export "next_frame") (type $t11)
    i32.const 36160
    i32.const 0
    i32.load offset=1244
    call $glBindFramebuffer
    i32.const 5
    i32.const 0
    i32.const 4
    call $glDrawArrays
    i32.const 3553
    i32.const 0
    i32.const 0
    i32.const 0
    i32.const 0
    i32.const 0
    i32.const 0
    i32.load offset=1224
    i32.const 0
    i32.load offset=1228
    call $glCopyTexSubImage2D
    i32.const 36160
    i32.const 0
    call $glBindFramebuffer
    i32.const 0
    i32.load offset=1236
    call $glUseProgram
    i32.const 5
    i32.const 0
    i32.const 4
    call $glDrawArrays
    call $write_frame
    i32.const 0
    i32.load offset=1240
    call $glUseProgram)
  (func $main_loop (type $t11))
  (func $createProgram (type $t12) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l2 i32) (local $l3 i32) (local $l4 i32) (local $l5 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee $l2
    global.set $__stack_pointer
    call $glCreateProgram
    local.tee $l3
    local.get $p0
    call $glAttachShader
    local.get $l3
    local.get $p1
    call $glAttachShader
    local.get $l3
    call $glLinkProgram
    local.get $l3
    i32.const 35714
    local.get $l2
    i32.const 28
    i32.add
    call $glGetProgramiv
    block $B0
      block $B1
        local.get $l2
        i32.load offset=28
        br_if $B1
        local.get $l3
        i32.const 35716
        local.get $l2
        i32.const 24
        i32.add
        call $glGetProgramiv
        local.get $l2
        i32.load offset=24
        local.tee $l4
        call $malloc
        local.tee $l5
        i32.eqz
        br_if $B0
        local.get $l3
        local.get $l4
        i32.const 0
        local.get $l5
        call $glGetProgramInfoLog
        local.get $l2
        local.get $l5
        i32.store offset=8
        local.get $l2
        local.get $p1
        i32.store offset=4
        local.get $l2
        local.get $p0
        i32.store
        i32.const 1
        i32.const 1145
        local.get $l2
        call $fprintf
        drop
        local.get $l5
        call $free
        i32.const 1
        call $exit
        unreachable
      end
      local.get $l2
      i32.const 32
      i32.add
      global.set $__stack_pointer
      local.get $l3
      return
    end
    i32.const 1104
    call $perror
    i32.const 1
    call $exit
    unreachable)
  (func $write_frame (type $t11))
  (func $malloc (type $t13) (param $p0 i32) (result i32)
    (local $l1 i32)
    block $B0
      i32.const 0
      i32.load offset=1216
      local.tee $l1
      i32.const 66784
      i32.sub
      i32.const 0
      i32.load offset=1220
      i32.const 16
      i32.shl
      i32.add
      local.get $p0
      i32.ge_u
      br_if $B0
      local.get $p0
      i32.const 65535
      i32.add
      i32.const 15
      i32.shr_u
      i32.const 131070
      i32.and
      local.tee $l1
      call $grow
      i32.const 0
      i32.const 0
      i32.load offset=1220
      local.get $l1
      i32.add
      i32.store offset=1220
      i32.const 0
      i32.load offset=1216
      local.set $l1
    end
    i32.const 0
    local.get $l1
    local.get $p0
    i32.add
    i32.store offset=1216
    local.get $l1)
  (func $free (type $t6) (param $p0 i32))
  (func $exit (type $t6) (param $p0 i32)
    unreachable
    unreachable)
  (func $srand (type $t6) (param $p0 i32))
  (func $fprintf (type $t1) (param $p0 i32) (param $p1 i32) (param $p2 i32) (result i32)
    (local $l3 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee $l3
    global.set $__stack_pointer
    local.get $l3
    local.get $p2
    i32.store offset=12
    i32.const 0
    local.set $p2
    block $B0
      local.get $p0
      i32.const 1
      i32.gt_u
      br_if $B0
      local.get $p0
      local.get $p1
      local.get $p1
      call $strlen
      local.tee $p2
      call $fprint
      local.get $p2
      i32.const 1
      i32.add
      local.set $p2
    end
    local.get $l3
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get $p2)
  (func $printf (type $t12) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l2 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee $l2
    global.set $__stack_pointer
    local.get $l2
    local.get $p1
    i32.store offset=12
    i32.const 0
    local.get $p0
    local.get $p0
    call $strlen
    local.tee $p1
    call $fprint
    local.get $l2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get $p1
    i32.const 1
    i32.add)
  (func $perror (type $t6) (param $p0 i32)
    i32.const 1
    local.get $p0
    local.get $p0
    call $strlen
    call $fprint)
  (func $strlen (type $t13) (param $p0 i32) (result i32)
    (local $l1 i32) (local $l2 i32) (local $l3 i32)
    i32.const 0
    local.set $l1
    loop $L0
      local.get $p0
      local.get $l1
      i32.add
      local.set $l2
      local.get $l1
      i32.const 1
      i32.add
      local.tee $l3
      local.set $l1
      local.get $l2
      i32.load8_u
      br_if $L0
    end
    local.get $l3
    i32.const -1
    i32.add)
  (table $T0 1 1 funcref)
  (memory $memory (export "memory") 2)
  (global $__stack_pointer (mut i32) (i32.const 66784))
  (data $.rodata (i32.const 1024) "src/common/passthrough.vsh\00src/physarum/simulator.fsh\00src/physarum/renderer.fsh\00malloc\00src/physarum/config.c\00Seed is %u\0a\00could not link %u and %u: %s\0a\00\00\d0\02\00\00\d0\02\00\00\00\00\80\bf\00\00\80\bf\00\00\80\bf\00\00\80?\00\00\80?\00\00\80\bf\00\00\80?\00\00\80?")
  (data $.data (i32.const 1216) "\e0\04\01\00\01\00\00\00"))
