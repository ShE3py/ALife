(module $gray-scott
  (type $t0 (func (param i32 f32)))
  (type $t1 (func (param i32)))
  (type $t2 (func (param i32 f32 f32 f32)))
  (type $t3 (func (result i32)))
  (type $t4 (func (param i32 i32 i32) (result i32)))
  (type $t5 (func (param i32 i32) (result i32)))
  (type $t6 (func (param i32 i32)))
  (type $t7 (func (param i32 i32 i32)))
  (type $t8 (func (param i32 i32 i32 i32 i32 i32 i32 i32 i32)))
  (type $t9 (func (param i32 i32 i32 i32 i32)))
  (type $t10 (func (param i32 i32 i32 i32)))
  (type $t11 (func (param i32 i32 i32 i32 i32 i32)))
  (type $t12 (func (param f32 f32 f32 f32)))
  (type $t13 (func (param i32 i32 i32 i32 i32 i32 i32 i32)))
  (type $t14 (func (param f32) (result f32)))
  (type $t15 (func (param f32 f32) (result f32)))
  (type $t16 (func (param f32 f32)))
  (type $t17 (func (param f32)))
  (type $t18 (func (param f32 f32 f32)))
  (type $t19 (func (param f32 f32 i32 i32 i32)))
  (type $t20 (func))
  (type $t21 (func (param i32) (result i32)))
  (type $t22 (func (param f32 i32) (result f32)))
  (import "common" "glUniform1f" (func $glUniform1f (type $t0)))
  (import "common" "glUseProgram" (func $glUseProgram (type $t1)))
  (import "common" "glUniform3f" (func $glUniform3f (type $t2)))
  (import "libc" "rand" (func $rand (type $t3)))
  (import "common" "createShader" (func $createShader (type $t4)))
  (import "common" "glGetUniformLocation" (func $glGetUniformLocation (type $t5)))
  (import "common" "glGenTextures" (func $glGenTextures (type $t6)))
  (import "common" "glBindTexture" (func $glBindTexture (type $t6)))
  (import "common" "glTexParameteri" (func $glTexParameteri (type $t7)))
  (import "common" "glTexImage2D" (func $glTexImage2D (type $t8)))
  (import "common" "glGenFramebuffers" (func $glGenFramebuffers (type $t6)))
  (import "common" "glBindFramebuffer" (func $glBindFramebuffer (type $t6)))
  (import "common" "glFramebufferTexture2D" (func $glFramebufferTexture2D (type $t9)))
  (import "common" "glDrawBuffers" (func $glDrawBuffers (type $t6)))
  (import "common" "glGenVertexArrays" (func $glGenVertexArrays (type $t6)))
  (import "common" "glBindVertexArray" (func $glBindVertexArray (type $t1)))
  (import "common" "glGenBuffers" (func $glGenBuffers (type $t6)))
  (import "common" "glBindBuffer" (func $glBindBuffer (type $t6)))
  (import "common" "glBufferData" (func $glBufferData (type $t10)))
  (import "common" "glVertexAttribPointer" (func $glVertexAttribPointer (type $t11)))
  (import "common" "glEnableVertexAttribArray" (func $glEnableVertexAttribArray (type $t1)))
  (import "common" "glClearColor" (func $glClearColor (type $t12)))
  (import "common" "glDrawArrays" (func $glDrawArrays (type $t7)))
  (import "common" "glCopyTexSubImage2D" (func $glCopyTexSubImage2D (type $t13)))
  (import "common" "glCreateProgram" (func $glCreateProgram (type $t3)))
  (import "common" "glAttachShader" (func $glAttachShader (type $t6)))
  (import "common" "glLinkProgram" (func $glLinkProgram (type $t1)))
  (import "common" "glGetProgramiv" (func $glGetProgramiv (type $t7)))
  (import "common" "glGetProgramInfoLog" (func $glGetProgramInfoLog (type $t10)))
  (import "libc" "grow" (func $grow (type $t1)))
  (import "libc" "fprint" (func $fprint (type $t7)))
  (import "libm" "cosf" (func $cosf_hack (type $t14)))
  (import "libm" "fmodf" (func $fmodf_hack (type $t15)))
  (func $set_fk (export "set_fk") (type $t16) (param $p0 f32) (param $p1 f32)
    i32.const 0
    i32.load offset=1232
    local.get $p0
    call $glUniform1f
    i32.const 0
    i32.load offset=1236
    local.get $p1
    call $glUniform1f
    i32.const 0
    local.get $p1
    f32.store offset=1268
    i32.const 0
    local.get $p0
    f32.store offset=1264)
  (func $set_f (export "set_f") (type $t17) (param $p0 f32)
    i32.const 0
    i32.load offset=1232
    local.get $p0
    call $glUniform1f
    i32.const 0
    local.get $p0
    f32.store offset=1264)
  (func $set_k (export "set_k") (type $t17) (param $p0 f32)
    i32.const 0
    i32.load offset=1236
    local.get $p0
    call $glUniform1f
    i32.const 0
    local.get $p0
    f32.store offset=1268)
  (func $set_ru (export "set_ru") (type $t17) (param $p0 f32)
    i32.const 0
    i32.load offset=1240
    local.get $p0
    call $glUniform1f)
  (func $set_rv (export "set_rv") (type $t17) (param $p0 f32)
    i32.const 0
    i32.load offset=1244
    local.get $p0
    call $glUniform1f)
  (func $set_Dt (export "set_Dt") (type $t17) (param $p0 f32)
    i32.const 0
    i32.load offset=1248
    local.get $p0
    call $glUniform1f)
  (func $set_rgb (export "set_color") (type $t18) (param $p0 f32) (param $p1 f32) (param $p2 f32)
    (local $l3 f32)
    i32.const 0
    i32.load offset=1272
    call $glUseProgram
    i32.const 0
    i32.load offset=1252
    f32.const 0x1p+0 (;=1;)
    local.get $p2
    local.get $p0
    local.get $p1
    local.get $p0
    local.get $p1
    f32.gt
    select
    f32.max
    f32.div
    local.tee $l3
    local.get $p0
    f32.mul
    local.get $l3
    local.get $p1
    f32.mul
    local.get $l3
    local.get $p2
    f32.mul
    call $glUniform3f
    i32.const 0
    i32.load offset=1276
    call $glUseProgram)
  (func $set_frame (export "set_frame") (type $t1) (param $p0 i32)
    (local $l1 i32) (local $l2 i32) (local $l3 i32) (local $l4 i32) (local $l5 f32) (local $l6 f32) (local $l7 i32) (local $l8 i32) (local $l9 i32) (local $l10 i32) (local $l11 i32) (local $l12 i32) (local $l13 i32) (local $l14 i32) (local $l15 i32) (local $l16 i32) (local $l17 i32)
    i32.const 0
    i32.load offset=1192
    local.tee $l1
    i32.const 0
    i32.load offset=1188
    local.tee $l2
    i32.mul
    local.set $l3
    block $B0
      block $B1
        block $B2
          block $B3
            block $B4
              block $B5
                block $B6
                  block $B7
                    block $B8
                      local.get $p0
                      i32.const -1
                      i32.add
                      br_table $B4 $B5 $B6 $B7 $B8 $B2 $B3 $B1
                    end
                    local.get $l3
                    i32.eqz
                    br_if $B0
                    local.get $l2
                    i32.const 6
                    i32.div_u
                    local.set $l4
                    f32.const 0x1p+0 (;=1;)
                    local.get $l1
                    f32.convert_i32_s
                    f32.div
                    local.set $l5
                    f32.const 0x1p+0 (;=1;)
                    local.get $l2
                    f32.convert_i32_s
                    f32.div
                    local.set $l6
                    local.get $l2
                    i32.const 5
                    i32.mul
                    i32.const 6
                    i32.div_u
                    local.set $l7
                    i32.const 0
                    i32.load offset=1280
                    local.set $p0
                    i32.const 0
                    local.set $l1
                    loop $L9
                      local.get $p0
                      i32.const 1065353216
                      i32.store
                      local.get $p0
                      i32.const 8
                      i32.add
                      i32.const 0
                      i32.store
                      local.get $p0
                      i32.const 4
                      i32.add
                      local.get $l1
                      local.get $l1
                      local.get $l2
                      i32.div_u
                      local.tee $l8
                      local.get $l2
                      i32.mul
                      i32.sub
                      local.tee $l9
                      local.get $l4
                      i32.ge_u
                      local.get $l8
                      f32.convert_i32_u
                      f32.const -0x1p+1 (;=-2;)
                      f32.mul
                      local.get $l5
                      f32.mul
                      f32.const 0x1p+0 (;=1;)
                      f32.add
                      local.get $l9
                      f32.convert_i32_u
                      f32.const 0x1.4p+3 (;=10;)
                      f32.mul
                      local.get $l6
                      f32.mul
                      call $cosf
                      f64.promote_f32
                      f64.const 0x1.570a3d70a3d71p-1 (;=0.67;)
                      f64.mul
                      f32.demote_f64
                      f32.add
                      f32.abs
                      f64.promote_f32
                      f64.const 0x1.47ae147ae147bp-7 (;=0.01;)
                      f64.le
                      i32.and
                      local.get $l9
                      local.get $l7
                      i32.le_u
                      i32.and
                      f32.convert_i32_u
                      f32.store
                      local.get $p0
                      i32.const 12
                      i32.add
                      local.set $p0
                      local.get $l3
                      local.get $l1
                      i32.const 1
                      i32.add
                      local.tee $l1
                      i32.ne
                      br_if $L9
                      br $B0
                    end
                  end
                  local.get $l3
                  i32.eqz
                  br_if $B0
                  local.get $l1
                  i32.const 2
                  i32.div_s
                  local.set $l7
                  local.get $l2
                  i32.const 2
                  i32.div_s
                  local.set $l10
                  local.get $l2
                  i32.const 3
                  i32.div_s
                  local.tee $l9
                  i32.const 5
                  i32.mul
                  local.set $l11
                  i32.const 0
                  i32.load offset=1280
                  local.set $p0
                  i32.const 0
                  local.set $l1
                  loop $L10
                    local.get $p0
                    i32.const 1065353216
                    i32.store
                    local.get $p0
                    i32.const 8
                    i32.add
                    i32.const 0
                    i32.store
                    local.get $p0
                    i32.const 4
                    i32.add
                    f32.const 0x1p+0 (;=1;)
                    f32.const 0x0p+0 (;=0;)
                    local.get $l10
                    local.get $l1
                    local.get $l2
                    i32.div_u
                    local.tee $l8
                    local.get $l2
                    i32.mul
                    local.get $l1
                    i32.sub
                    i32.add
                    local.tee $l4
                    local.get $l9
                    i32.add
                    local.get $l4
                    local.get $l9
                    i32.sub
                    i32.mul
                    local.get $l7
                    local.get $l8
                    i32.sub
                    local.tee $l8
                    local.get $l8
                    i32.mul
                    i32.add
                    local.tee $l8
                    local.get $l8
                    i32.const 31
                    i32.shr_s
                    local.tee $l8
                    i32.xor
                    local.get $l8
                    i32.sub
                    local.get $l11
                    i32.le_s
                    select
                    f32.store
                    local.get $p0
                    i32.const 12
                    i32.add
                    local.set $p0
                    local.get $l3
                    local.get $l1
                    i32.const 1
                    i32.add
                    local.tee $l1
                    i32.ne
                    br_if $L10
                    br $B0
                  end
                end
                local.get $l3
                i32.eqz
                br_if $B0
                local.get $l1
                i32.const 2
                i32.div_s
                local.set $l4
                local.get $l2
                i32.const 2
                i32.div_s
                local.set $l7
                local.get $l2
                i32.const 3
                i32.div_s
                local.tee $p0
                local.get $p0
                i32.mul
                local.set $l10
                i32.const 0
                i32.load offset=1280
                local.set $p0
                i32.const 0
                local.set $l1
                loop $L11
                  local.get $p0
                  i32.const 1065353216
                  i32.store
                  local.get $p0
                  i32.const 8
                  i32.add
                  i32.const 0
                  i32.store
                  local.get $p0
                  i32.const 4
                  i32.add
                  f32.const 0x1p+0 (;=1;)
                  f32.const 0x0p+0 (;=0;)
                  local.get $l4
                  local.get $l1
                  local.get $l2
                  i32.div_u
                  local.tee $l9
                  i32.sub
                  local.tee $l8
                  local.get $l8
                  i32.mul
                  local.get $l7
                  local.get $l9
                  local.get $l2
                  i32.mul
                  local.get $l1
                  i32.sub
                  i32.add
                  local.tee $l9
                  local.get $l9
                  i32.mul
                  i32.add
                  local.get $l10
                  i32.le_u
                  select
                  f32.store
                  local.get $p0
                  i32.const 12
                  i32.add
                  local.set $p0
                  local.get $l3
                  local.get $l1
                  i32.const 1
                  i32.add
                  local.tee $l1
                  i32.ne
                  br_if $L11
                  br $B0
                end
              end
              local.get $l3
              i32.eqz
              br_if $B0
              local.get $l2
              i32.const -3
              i32.div_s
              local.set $l12
              local.get $l2
              i32.const 2
              i32.div_s
              local.set $l13
              local.get $l1
              i32.const -3
              i32.div_s
              local.set $l14
              local.get $l1
              i32.const 2
              i32.div_s
              local.set $l15
              local.get $l1
              i32.const 6
              i32.div_u
              i32.const -5
              i32.add
              local.set $l10
              local.get $l2
              i32.const 6
              i32.div_u
              i32.const -5
              i32.add
              local.set $l11
              local.get $l1
              i32.const 5
              i32.mul
              i32.const 6
              i32.div_u
              i32.const 5
              i32.add
              local.set $l16
              local.get $l2
              i32.const 5
              i32.mul
              i32.const 6
              i32.div_u
              i32.const 5
              i32.add
              local.set $l17
              i32.const 0
              i32.load offset=1280
              local.set $p0
              i32.const 0
              local.set $l1
              loop $L12
                i32.const 0
                local.set $l8
                block $B13
                  local.get $l1
                  local.get $l1
                  local.get $l2
                  i32.div_u
                  local.tee $l9
                  local.get $l2
                  i32.mul
                  i32.sub
                  local.tee $l7
                  local.get $l11
                  i32.lt_u
                  br_if $B13
                  i32.const 0
                  local.set $l8
                  local.get $l7
                  local.get $l17
                  i32.gt_u
                  br_if $B13
                  local.get $l15
                  local.get $l9
                  i32.sub
                  local.tee $l8
                  local.get $l8
                  i32.const 31
                  i32.shr_s
                  local.tee $l8
                  i32.xor
                  local.get $l8
                  i32.sub
                  local.get $l14
                  i32.add
                  local.tee $l8
                  local.get $l8
                  i32.const 31
                  i32.shr_s
                  local.tee $l8
                  i32.xor
                  local.get $l8
                  i32.sub
                  i32.const 6
                  i32.lt_u
                  local.set $l8
                end
                i32.const 0
                local.set $l4
                block $B14
                  local.get $l9
                  local.get $l10
                  i32.lt_u
                  br_if $B14
                  local.get $l9
                  local.get $l16
                  i32.gt_u
                  br_if $B14
                  local.get $l13
                  local.get $l7
                  i32.sub
                  local.tee $l9
                  local.get $l9
                  i32.const 31
                  i32.shr_s
                  local.tee $l9
                  i32.xor
                  local.get $l9
                  i32.sub
                  local.get $l12
                  i32.add
                  local.tee $l9
                  local.get $l9
                  i32.const 31
                  i32.shr_s
                  local.tee $l9
                  i32.xor
                  local.get $l9
                  i32.sub
                  i32.const 6
                  i32.lt_u
                  local.set $l4
                end
                local.get $p0
                i32.const 1065353216
                i32.store
                local.get $p0
                i32.const 8
                i32.add
                i32.const 0
                i32.store
                local.get $p0
                i32.const 4
                i32.add
                local.get $l8
                local.get $l4
                i32.or
                f32.convert_i32_u
                f32.store
                local.get $p0
                i32.const 12
                i32.add
                local.set $p0
                local.get $l3
                local.get $l1
                i32.const 1
                i32.add
                local.tee $l1
                i32.ne
                br_if $L12
                br $B0
              end
            end
            local.get $l3
            i32.eqz
            br_if $B0
            local.get $l1
            i32.const 6
            i32.div_u
            local.set $l10
            local.get $l2
            i32.const 6
            i32.div_u
            local.set $l7
            local.get $l1
            i32.const 5
            i32.mul
            i32.const 6
            i32.div_u
            local.set $l11
            local.get $l2
            i32.const 5
            i32.mul
            i32.const 6
            i32.div_u
            local.set $l16
            i32.const 0
            i32.load offset=1280
            local.set $p0
            i32.const 0
            local.set $l1
            loop $L15
              local.get $p0
              i32.const 1065353216
              i32.store
              i32.const 0
              local.set $l9
              block $B16
                local.get $l1
                local.get $l1
                local.get $l2
                i32.div_u
                local.tee $l8
                local.get $l2
                i32.mul
                i32.sub
                local.tee $l4
                local.get $l7
                i32.lt_u
                br_if $B16
                local.get $l4
                local.get $l16
                i32.le_u
                local.get $l8
                local.get $l11
                i32.le_u
                i32.and
                local.get $l8
                local.get $l10
                i32.ge_u
                i32.and
                local.set $l9
              end
              local.get $p0
              i32.const 8
              i32.add
              i32.const 0
              i32.store
              local.get $p0
              i32.const 4
              i32.add
              local.get $l9
              f32.convert_i32_u
              f32.store
              local.get $p0
              i32.const 12
              i32.add
              local.set $p0
              local.get $l3
              local.get $l1
              i32.const 1
              i32.add
              local.tee $l1
              i32.ne
              br_if $L15
              br $B0
            end
          end
          local.get $l3
          i32.eqz
          br_if $B0
          i32.const 0
          i32.load offset=1280
          local.set $l9
          i32.const 8
          local.set $p0
          i32.const 0
          local.set $l1
          loop $L17
            i32.const 0
            f32.load offset=1264
            i32.const 0
            f32.load offset=1268
            local.get $l9
            local.get $p0
            i32.add
            i32.const -8
            i32.add
            local.get $l1
            local.get $l1
            local.get $l2
            i32.div_u
            local.tee $l9
            local.get $l2
            i32.mul
            i32.sub
            local.get $l9
            call $noise
            i32.const 0
            i32.load offset=1280
            local.tee $l9
            local.get $p0
            i32.add
            i32.const 0
            i32.store
            local.get $p0
            i32.const 12
            i32.add
            local.set $p0
            local.get $l3
            local.get $l1
            i32.const 1
            i32.add
            local.tee $l1
            i32.ne
            br_if $L17
            br $B0
          end
        end
        local.get $l3
        i32.eqz
        br_if $B0
        local.get $l2
        i32.const 6
        i32.div_u
        local.set $l4
        local.get $l1
        i32.const 1
        i32.shr_u
        local.set $l7
        local.get $l2
        i32.const 5
        i32.mul
        i32.const 6
        i32.div_u
        local.set $l10
        i32.const 0
        i32.load offset=1280
        local.set $p0
        i32.const 0
        local.set $l1
        loop $L18
          local.get $p0
          i32.const 1065353216
          i32.store
          local.get $p0
          i32.const 8
          i32.add
          i32.const 0
          i32.store
          local.get $p0
          i32.const 4
          i32.add
          local.get $l1
          local.get $l1
          local.get $l2
          i32.div_u
          local.tee $l9
          local.get $l2
          i32.mul
          i32.sub
          local.tee $l8
          local.get $l4
          i32.ge_u
          local.get $l9
          local.get $l7
          i32.eq
          i32.and
          local.get $l8
          local.get $l10
          i32.le_u
          i32.and
          f32.convert_i32_u
          f32.store
          local.get $p0
          i32.const 12
          i32.add
          local.set $p0
          local.get $l3
          local.get $l1
          i32.const 1
          i32.add
          local.tee $l1
          i32.ne
          br_if $L18
          br $B0
        end
      end
      local.get $l3
      i32.eqz
      br_if $B0
      i32.const 0
      i32.load offset=1280
      local.set $p0
      i32.const 8
      local.set $l2
      loop $L19
        local.get $p0
        local.get $l2
        i32.add
        i32.const -8
        i32.add
        i32.const 1065353216
        i32.store
        call $rand
        local.set $l1
        i32.const 0
        i32.load offset=1280
        local.tee $p0
        local.get $l2
        i32.add
        local.tee $l9
        i32.const 0
        i32.store
        local.get $l9
        i32.const -4
        i32.add
        f32.const 0x1p+0 (;=1;)
        f32.const 0x0p+0 (;=0;)
        local.get $l1
        f32.convert_i32_s
        f32.const 0x1p-31 (;=4.65661e-10;)
        f32.mul
        f64.promote_f32
        f64.const 0x1.fd70a3d70a3d7p-1 (;=0.995;)
        f64.gt
        select
        f32.store
        local.get $l2
        i32.const 12
        i32.add
        local.set $l2
        local.get $l3
        i32.const -1
        i32.add
        local.tee $l3
        br_if $L19
      end
    end)
  (func $__original_main (export "_initialize") (type $t3) (result i32)
    (local $l0 i32) (local $l1 i32) (local $l2 i32) (local $l3 i32) (local $l4 i32)
    call $create_rcx
    i32.const 1035
    i32.const 35633
    i32.const 1128
    call $createShader
    local.set $l0
    i32.const 1091
    i32.const 35632
    i32.const 1128
    call $createShader
    local.set $l1
    i32.const 1062
    i32.const 35632
    i32.const 1128
    call $createShader
    local.set $l2
    i32.const 0
    local.get $l0
    local.get $l1
    call $createProgram
    i32.store offset=1272
    i32.const 0
    local.get $l0
    local.get $l2
    call $createProgram
    local.tee $l0
    i32.store offset=1276
    i32.const 0
    i32.const 0
    i32.load offset=1192
    i32.const 0
    i32.load offset=1188
    i32.mul
    local.tee $l2
    i32.const 12
    i32.mul
    call $malloc
    local.tee $l1
    i32.store offset=1280
    block $B0
      local.get $l1
      i32.eqz
      br_if $B0
      block $B1
        local.get $l2
        i32.eqz
        br_if $B1
        i32.const 8
        local.set $l0
        loop $L2
          local.get $l1
          local.get $l0
          i32.add
          i32.const -8
          i32.add
          i32.const 1065353216
          i32.store
          call $rand
          local.set $l3
          i32.const 0
          i32.load offset=1280
          local.tee $l1
          local.get $l0
          i32.add
          local.tee $l4
          i32.const 0
          i32.store
          local.get $l4
          i32.const -4
          i32.add
          f32.const 0x1p+0 (;=1;)
          f32.const 0x0p+0 (;=0;)
          local.get $l3
          f32.convert_i32_s
          f32.const 0x1p-31 (;=4.65661e-10;)
          f32.mul
          f64.promote_f32
          f64.const 0x1.fd70a3d70a3d7p-1 (;=0.995;)
          f64.gt
          select
          f32.store
          local.get $l0
          i32.const 12
          i32.add
          local.set $l0
          local.get $l2
          i32.const -1
          i32.add
          local.tee $l2
          br_if $L2
        end
        i32.const 0
        i32.load offset=1276
        local.set $l0
      end
      local.get $l1
      i32.const 0
      i32.load offset=1272
      local.get $l0
      call $setup
      i32.const 0
      i32.const 0
      i32.load offset=1276
      i32.const 1119
      call $glGetUniformLocation
      i32.store offset=1232
      i32.const 0
      i32.const 0
      i32.load offset=1276
      i32.const 1033
      call $glGetUniformLocation
      i32.store offset=1236
      i32.const 0
      i32.const 0
      i32.load offset=1276
      i32.const 1027
      call $glGetUniformLocation
      i32.store offset=1240
      i32.const 0
      i32.const 0
      i32.load offset=1276
      i32.const 1024
      call $glGetUniformLocation
      i32.store offset=1244
      i32.const 0
      i32.const 0
      i32.load offset=1276
      i32.const 1030
      call $glGetUniformLocation
      i32.store offset=1248
      i32.const 0
      i32.const 0
      i32.load offset=1272
      i32.const 1152
      call $glGetUniformLocation
      i32.store offset=1252
      i32.const 0
      i32.load offset=1232
      f32.const 0x1.78d4fep-5 (;=0.046;)
      call $glUniform1f
      i32.const 0
      i32.load offset=1236
      f32.const 0x1.e353f8p-5 (;=0.059;)
      call $glUniform1f
      i32.const 0
      i32.const 1030859260
      i32.store offset=1268
      i32.const 0
      i32.const 1027369599
      i32.store offset=1264
      i32.const 0
      i32.load offset=1240
      f32.const 0x1p+0 (;=1;)
      call $glUniform1f
      i32.const 0
      i32.load offset=1244
      f32.const 0x1p-1 (;=0.5;)
      call $glUniform1f
      i32.const 0
      i32.load offset=1248
      f32.const 0x1p+0 (;=1;)
      call $glUniform1f
      i32.const 0
      i32.load offset=1272
      call $glUseProgram
      i32.const 0
      i32.load offset=1252
      f32.const 0x1.e147aep-3 (;=0.235;)
      f32.const 0x1p+0 (;=1;)
      f32.const 0x1.a5e354p-2 (;=0.412;)
      call $glUniform3f
      i32.const 0
      i32.load offset=1276
      call $glUseProgram
      call $main_loop
      i32.const 0
      return
    end
    i32.const 1121
    call $perror
    i32.const 1
    call $exit
    unreachable)
  (func $noise (type $t19) (param $p0 f32) (param $p1 f32) (param $p2 i32) (param $p3 i32) (param $p4 i32)
    (local $l5 f64) (local $l6 f64) (local $l7 f32)
    local.get $p2
    f32.const 0x0p+0 (;=0;)
    local.get $p3
    f32.convert_i32_u
    i32.const 0
    i32.load offset=1188
    f32.convert_i32_s
    f32.div
    f64.promote_f32
    local.tee $l5
    f64.const -0x1p-2 (;=-0.25;)
    f64.add
    local.get $l5
    f64.const 0x1.999999999999ap-4 (;=0.1;)
    f64.mul
    f32.demote_f64
    local.get $p4
    f32.convert_i32_u
    i32.const 0
    i32.load offset=1192
    f32.convert_i32_s
    f32.div
    f64.promote_f32
    local.tee $l6
    f64.const 0x1.999999999999ap-4 (;=0.1;)
    f64.mul
    f32.demote_f64
    call $snoise
    local.get $l5
    f64.const 0x1.47ae147ae147bp-3 (;=0.16;)
    f64.mul
    f32.demote_f64
    local.get $l6
    f64.const 0x1.47ae147ae147bp-3 (;=0.16;)
    f64.mul
    f32.demote_f64
    call $snoise
    f32.add
    f32.const 0x1p-1 (;=0.5;)
    f32.mul
    f64.promote_f32
    f64.add
    f32.demote_f64
    local.tee $l7
    f32.const 0x1p+0 (;=1;)
    f32.min
    local.get $l7
    f32.const 0x0p+0 (;=0;)
    f32.lt
    select
    f32.store
    local.get $p2
    f32.const 0x0p+0 (;=0;)
    local.get $l6
    f64.const -0x1p-2 (;=-0.25;)
    f64.add
    f64.const 0x1.3333333333333p-2 (;=0.3;)
    local.get $l5
    f64.const 0x1.0a3d70a3d70a4p-3 (;=0.13;)
    f64.mul
    f64.sub
    f32.demote_f64
    f64.const 0x1.3333333333333p-2 (;=0.3;)
    local.get $l6
    f64.const 0x1.0a3d70a3d70a4p-3 (;=0.13;)
    f64.mul
    f64.sub
    f32.demote_f64
    call $snoise
    f64.const 0x1.6666666666666p-1 (;=0.7;)
    local.get $l5
    f64.const 0x1.ae147ae147ae1p-3 (;=0.21;)
    f64.mul
    f64.sub
    f32.demote_f64
    f64.const 0x1.6666666666666p-1 (;=0.7;)
    local.get $l6
    f64.const 0x1.ae147ae147ae1p-3 (;=0.21;)
    f64.mul
    f64.sub
    f32.demote_f64
    call $snoise
    f32.add
    f32.const 0x1p-1 (;=0.5;)
    f32.mul
    f64.promote_f32
    f64.add
    f32.demote_f64
    local.tee $l7
    f32.const 0x1p+0 (;=1;)
    f32.min
    local.get $l7
    f32.const 0x0p+0 (;=0;)
    f32.lt
    select
    f32.store offset=4)
  (func $snoise (type $t15) (param $p0 f32) (param $p1 f32) (result f32)
    (local $l2 i32) (local $l3 f32) (local $l4 f32) (local $l5 f32) (local $l6 f32) (local $l7 f32) (local $l8 f64) (local $l9 f32) (local $l10 f32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee $l2
    global.set $__stack_pointer
    local.get $p1
    local.get $p0
    f32.add
    f32.const 0x1.76cf5ep-2 (;=0.366025;)
    f32.mul
    local.tee $l3
    local.get $p1
    f32.add
    f32.floor
    local.tee $l4
    f32.const 0x1.21p+8 (;=289;)
    call $fmodf
    local.set $l5
    local.get $l3
    local.get $p0
    f32.add
    f32.floor
    local.tee $l3
    f32.const 0x1.21p+8 (;=289;)
    call $fmodf
    local.tee $l6
    f32.const 0x1p+0 (;=1;)
    f32.const 0x0p+0 (;=0;)
    local.get $l3
    local.get $l4
    f32.add
    f32.const 0x1.b0cb18p-3 (;=0.211325;)
    f32.mul
    local.tee $l7
    local.get $p0
    local.get $l3
    f32.sub
    f32.add
    local.tee $p0
    local.get $l7
    local.get $p1
    local.get $l4
    f32.sub
    f32.add
    local.tee $p1
    f32.gt
    select
    local.tee $l3
    f32.add
    local.get $l5
    f32.const 0x1p+0 (;=1;)
    f32.const 0x0p+0 (;=0;)
    local.get $p0
    local.get $p1
    f32.le
    select
    local.tee $l7
    f32.add
    f64.promote_f32
    local.tee $l8
    f64.const 0x1.1p+5 (;=34;)
    f64.mul
    f64.const 0x1p+0 (;=1;)
    f64.add
    local.get $l8
    f64.mul
    f32.demote_f64
    f32.const 0x1.21p+8 (;=289;)
    call $fmodf
    f32.add
    f64.promote_f32
    local.tee $l8
    f64.const 0x1.1p+5 (;=34;)
    f64.mul
    f64.const 0x1p+0 (;=1;)
    f64.add
    local.get $l8
    f64.mul
    f32.demote_f64
    f32.const 0x1.21p+8 (;=289;)
    call $fmodf
    local.set $l4
    local.get $l6
    local.get $l5
    f64.promote_f32
    local.tee $l8
    f64.const 0x1.1p+5 (;=34;)
    f64.mul
    f64.const 0x1p+0 (;=1;)
    f64.add
    local.get $l8
    f64.mul
    f32.demote_f64
    f32.const 0x1.21p+8 (;=289;)
    call $fmodf
    f32.add
    f64.promote_f32
    local.tee $l8
    f64.const 0x1.1p+5 (;=34;)
    f64.mul
    f64.const 0x1p+0 (;=1;)
    f64.add
    local.get $l8
    f64.mul
    f32.demote_f64
    f32.const 0x1.21p+8 (;=289;)
    call $fmodf
    f32.const 0x1.8f9c18p-6 (;=0.0243902;)
    f32.mul
    local.get $l2
    i32.const 12
    i32.add
    call $modff
    local.set $l9
    local.get $l4
    f32.const 0x1.8f9c18p-6 (;=0.0243902;)
    f32.mul
    local.get $l2
    i32.const 12
    i32.add
    call $modff
    local.set $l4
    local.get $l6
    f32.const 0x1p+0 (;=1;)
    f32.add
    local.get $l5
    f32.const 0x1p+0 (;=1;)
    f32.add
    f64.promote_f32
    local.tee $l8
    f64.const 0x1.1p+5 (;=34;)
    f64.mul
    f64.const 0x1p+0 (;=1;)
    f64.add
    local.get $l8
    f64.mul
    f32.demote_f64
    f32.const 0x1.21p+8 (;=289;)
    call $fmodf
    f32.add
    f64.promote_f32
    local.tee $l8
    f64.const 0x1.1p+5 (;=34;)
    f64.mul
    f64.const 0x1p+0 (;=1;)
    f64.add
    local.get $l8
    f64.mul
    f32.demote_f64
    f32.const 0x1.21p+8 (;=289;)
    call $fmodf
    f32.const 0x1.8f9c18p-6 (;=0.0243902;)
    f32.mul
    local.get $l2
    i32.const 12
    i32.add
    call $modff
    local.set $l10
    local.get $l2
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get $l4
    f64.promote_f32
    local.tee $l8
    local.get $l8
    f64.add
    f64.const -0x1p+0 (;=-1;)
    f64.add
    f32.demote_f64
    local.tee $l5
    local.get $l5
    f32.const 0x1p-1 (;=0.5;)
    f32.add
    f32.floor
    f32.sub
    local.tee $l4
    local.get $p0
    f32.const 0x1.b0cb18p-3 (;=0.211325;)
    f32.add
    local.get $l3
    f32.sub
    local.tee $l3
    f32.mul
    local.get $l5
    f32.abs
    f32.const -0x1p-1 (;=-0.5;)
    f32.add
    local.tee $l5
    local.get $p1
    f32.const 0x1.b0cb18p-3 (;=0.211325;)
    f32.add
    local.get $l7
    f32.sub
    local.tee $l6
    f32.mul
    f32.add
    f64.const 0x1.caf7c0d2808e3p+0 (;=1.79284;)
    local.get $l4
    local.get $l4
    f32.mul
    local.get $l5
    local.get $l5
    f32.mul
    f32.add
    f64.promote_f32
    f64.const 0x1.b51cb7a3e826fp-1 (;=0.853735;)
    f64.mul
    f64.sub
    f32.const 0x1p-1 (;=0.5;)
    local.get $l3
    local.get $l3
    f32.mul
    local.get $l6
    local.get $l6
    f32.mul
    f32.add
    f32.sub
    f32.const 0x0p+0 (;=0;)
    f32.max
    local.tee $l5
    local.get $l5
    f32.mul
    local.tee $l5
    local.get $l5
    f32.mul
    f64.promote_f32
    f64.mul
    f32.demote_f64
    f32.mul
    local.get $l9
    f64.promote_f32
    local.tee $l8
    local.get $l8
    f64.add
    f64.const -0x1p+0 (;=-1;)
    f64.add
    f32.demote_f64
    local.tee $l5
    local.get $l5
    f32.const 0x1p-1 (;=0.5;)
    f32.add
    f32.floor
    f32.sub
    local.tee $l4
    local.get $p0
    f32.mul
    local.get $l5
    f32.abs
    f32.const -0x1p-1 (;=-0.5;)
    f32.add
    local.tee $l5
    local.get $p1
    f32.mul
    f32.add
    f64.const 0x1.caf7c0d2808e3p+0 (;=1.79284;)
    local.get $l4
    local.get $l4
    f32.mul
    local.get $l5
    local.get $l5
    f32.mul
    f32.add
    f64.promote_f32
    f64.const 0x1.b51cb7a3e826fp-1 (;=0.853735;)
    f64.mul
    f64.sub
    f32.const 0x1p-1 (;=0.5;)
    local.get $p0
    local.get $p0
    f32.mul
    local.get $p1
    local.get $p1
    f32.mul
    f32.add
    f32.sub
    f32.const 0x0p+0 (;=0;)
    f32.max
    local.tee $l5
    local.get $l5
    f32.mul
    local.tee $l5
    local.get $l5
    f32.mul
    f64.promote_f32
    f64.mul
    f32.demote_f64
    f32.mul
    f32.add
    local.get $l10
    f64.promote_f32
    local.tee $l8
    local.get $l8
    f64.add
    f64.const -0x1p+0 (;=-1;)
    f64.add
    f32.demote_f64
    local.tee $l5
    local.get $l5
    f32.const 0x1p-1 (;=0.5;)
    f32.add
    f32.floor
    f32.sub
    local.tee $l4
    local.get $p0
    f32.const -0x1.279a74p-1 (;=-0.57735;)
    f32.add
    local.tee $p0
    f32.mul
    local.get $l5
    f32.abs
    f32.const -0x1p-1 (;=-0.5;)
    f32.add
    local.tee $l5
    local.get $p1
    f32.const -0x1.279a74p-1 (;=-0.57735;)
    f32.add
    local.tee $p1
    f32.mul
    f32.add
    f64.const 0x1.caf7c0d2808e3p+0 (;=1.79284;)
    local.get $l4
    local.get $l4
    f32.mul
    local.get $l5
    local.get $l5
    f32.mul
    f32.add
    f64.promote_f32
    f64.const 0x1.b51cb7a3e826fp-1 (;=0.853735;)
    f64.mul
    f64.sub
    f32.const 0x1p-1 (;=0.5;)
    local.get $p0
    local.get $p0
    f32.mul
    local.get $p1
    local.get $p1
    f32.mul
    f32.add
    f32.sub
    f32.const 0x0p+0 (;=0;)
    f32.max
    local.tee $p0
    local.get $p0
    f32.mul
    local.tee $p0
    local.get $p0
    f32.mul
    f64.promote_f32
    f64.mul
    f32.demote_f64
    f32.mul
    f32.add
    f32.const 0x1.04p+7 (;=130;)
    f32.mul)
  (func $create_rcx (type $t20)
    i32.const 0
    i32.const 0
    i32.load offset=1188
    i32.store offset=1284
    i32.const 0
    i32.const 0
    i32.load offset=1192
    i32.store offset=1288)
  (func $setup (type $t7) (param $p0 i32) (param $p1 i32) (param $p2 i32)
    (local $l3 i32)
    global.get $__stack_pointer
    i32.const 64
    i32.sub
    local.tee $l3
    global.set $__stack_pointer
    i32.const 0
    local.get $p1
    i32.store offset=1296
    i32.const 0
    local.get $p0
    i32.store offset=1292
    i32.const 0
    local.get $p2
    i32.store offset=1300
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
    i32.load offset=1284
    i32.const 0
    i32.load offset=1288
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
    i32.load offset=1284
    i32.const 0
    i32.load offset=1288
    i32.const 0
    i32.const 6407
    i32.const 5126
    i32.const 0
    i32.load offset=1292
    call $glTexImage2D
    i32.const 1
    i32.const 1304
    call $glGenFramebuffers
    i32.const 36160
    i32.const 0
    i32.load offset=1304
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
    i64.load offset=1224
    i64.store
    local.get $l3
    i32.const 32
    i32.add
    i32.const 0
    i64.load offset=1216
    i64.store
    local.get $l3
    i32.const 0
    i64.load offset=1208
    i64.store offset=24
    local.get $l3
    i32.const 0
    i64.load offset=1200
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
    i32.load offset=1300
    call $glUseProgram
    local.get $l3
    i32.const 64
    i32.add
    global.set $__stack_pointer)
  (func $reset_frame (export "reset_frame") (type $t20)
    i32.const 3553
    i32.const 0
    i32.const 6407
    i32.const 0
    i32.load offset=1284
    i32.const 0
    i32.load offset=1288
    i32.const 0
    i32.const 6407
    i32.const 5126
    i32.const 0
    i32.load offset=1292
    call $glTexImage2D)
  (func $next_frame (export "next_frame") (type $t20)
    i32.const 36160
    i32.const 0
    i32.load offset=1304
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
    i32.load offset=1284
    i32.const 0
    i32.load offset=1288
    call $glCopyTexSubImage2D
    i32.const 36160
    i32.const 0
    call $glBindFramebuffer
    i32.const 0
    i32.load offset=1296
    call $glUseProgram
    i32.const 5
    i32.const 0
    i32.const 4
    call $glDrawArrays
    call $write_frame
    i32.const 0
    i32.load offset=1300
    call $glUseProgram)
  (func $main_loop (type $t20))
  (func $createProgram (type $t5) (param $p0 i32) (param $p1 i32) (result i32)
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
        i32.const 1156
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
    i32.const 1121
    call $perror
    i32.const 1
    call $exit
    unreachable)
  (func $write_frame (type $t20))
  (func $malloc (type $t21) (param $p0 i32) (result i32)
    (local $l1 i32)
    block $B0
      i32.const 0
      i32.load offset=1256
      local.tee $l1
      i32.const 66848
      i32.sub
      i32.const 0
      i32.load offset=1260
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
      i32.load offset=1260
      local.get $l1
      i32.add
      i32.store offset=1260
      i32.const 0
      i32.load offset=1256
      local.set $l1
    end
    i32.const 0
    local.get $l1
    local.get $p0
    i32.add
    i32.store offset=1256
    local.get $l1)
  (func $free (type $t1) (param $p0 i32))
  (func $exit (type $t1) (param $p0 i32)
    unreachable
    unreachable)
  (func $fprintf (type $t4) (param $p0 i32) (param $p1 i32) (param $p2 i32) (result i32)
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
  (func $perror (type $t1) (param $p0 i32)
    i32.const 1
    local.get $p0
    local.get $p0
    call $strlen
    call $fprint)
  (func $strlen (type $t21) (param $p0 i32) (result i32)
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
  (func $cosf (type $t14) (param $p0 f32) (result f32)
    local.get $p0
    call $cosf_hack)
  (func $fmodf (type $t15) (param $p0 f32) (param $p1 f32) (result f32)
    local.get $p0
    local.get $p1
    call $fmodf_hack)
  (func $modff (type $t22) (param $p0 f32) (param $p1 i32) (result f32)
    (local $l2 f32)
    local.get $p1
    local.get $p0
    local.get $p0
    f32.const 0x1p+0 (;=1;)
    call $fmodf
    local.tee $l2
    f32.sub
    f32.store
    local.get $l2)
  (table $T0 1 1 funcref)
  (memory $memory (export "memory") 2)
  (global $__stack_pointer (mut i32) (i32.const 66848))
  (data $.rodata (i32.const 1024) "rv\00ru\00Dt\00k\00src/common/passthrough.vsh\00src/gray-scott/simulator.fsh\00src/gray-scott/renderer.fsh\00f\00malloc\00src/gray-scott/config.c\00rgb\00could not link %u and %u: %s\0a\00\00\00\d0\02\00\00\d0\02\00\00\00\00\00\00\00\00\80\bf\00\00\80\bf\00\00\80\bf\00\00\80?\00\00\80?\00\00\80\bf\00\00\80?\00\00\80?")
  (data $.data (i32.const 1232) "\ff\ff\ff\7f\ff\ff\ff\7f\ff\ff\ff\7f\ff\ff\ff\7f\ff\ff\ff\7f\ff\ff\ff\7f \05\01\00\01\00\00\00"))
