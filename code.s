    .data
Numbers:
    .long 1
    .long 15
    .long 4
    .long 2
    .long 7
    .long 9
    .long 23
    .long 7
    .long 3
    .long 11
Array_length:
    .long 10

msg:
    .string "The max is %d\n"

    .text
    .globl main
main:
    pushl %ebp
    movl  %esp, %ebp

    movl  $0, %ecx              # i = 0
    movl  Numbers, %eax         # max = Numbers[0]
    jmp   check               # while pattern: jump to the test first

loop:
    movl  Numbers(,%ecx,4), %edx   # edx = Numbers[i]
    cmpl  %eax, %edx               # compare Numbers[i] with max
    jle   next                   # if Numbers[i] <= max, skip update
    movl  %edx, %eax               # max = Numbers[i]
next:
    addl  $1, %ecx                 # i++

check:
    cmpl  Array_length, %ecx       # compare i with 10
    jl    loop                   # if i < 10, repeat the body

    subl  $8, %esp              # keep stack 16-byte aligned for printf
    pushl %eax                  # argument: max
    pushl $msg                 # argument: format string
    call  printf
    addl  $16, %esp

    movl  $0, %eax              # return 0
    leave
    ret