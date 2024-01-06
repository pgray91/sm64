.set noat      // allow manual use of $at
.set noreorder // don't insert nops after branches

.equ K0BASE, 0x80000000

.data 
    testv: .word 23

.text

.global pgInvalDCache

.balign 4
pgInvalDCache:
    li    $t3, 8192
    sltu  $at, $a1, $t3
    move  $t0, $a0          // addr pointer
    addu  $t1, $a0, $a1     // addr + 64 -> shifting pointer
    sltu  $at, $t0, $t1
    andi  $t2, $t0, 0xf     //
    andi  $t2, $t1, 0xf
    beqz  $t2, .L803234F0
     nop
    subu  $t1, $t1, $t2
    cache 0x15, 0x10($t1)
    sltu  $at, $t1, $t0
    bnez  $at, .L80323500
     nop
.L803234F0:
    cache 0x11, ($t0)
    sltu  $at, $t0, $t1
    bnez  $at, .L803234F0
     addiu $t0, $t0, 0x10
.L80323500:
    jr    $ra
     nop

    // move $v0, $t2
    // jr $ra
    //   nop