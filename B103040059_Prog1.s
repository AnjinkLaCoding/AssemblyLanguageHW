text:
    .text
    .align 2
    .global main
    .type main, %function
main:
    stmfd   sp!, {fp, lr}
    add     fp, sp, #4
    sub     sp, sp, #28            @ Reserve stack space for variables
    str     r0, [fp, #-24]         @ Store argc
    str     r1, [fp, #-28]         @ Store argv

    ldr     r4, [fp, #-28]         @ Load argv
    ldr     r4, [r4, #4]           @ Load argv[1] into r4
    mov     r3, #0                 @ r3 = i = 0, index for reading argv[1]
    str     r3, [fp, #-8]          @ store i
    mov     r5, #0                 @ r5 = write_index = 0, index for writing to argv[1]
    mov     r0, r4
    bl      strlen                 @ Get the length of argv[1]
    mov     r3, r0                 @ Store length in r3 for later comparison
    ldr     r4, [fp, #-28]         @ Load argv
    ldr     r4, [r4, #4]           @ Load argv[1] into r4

Loop:
    ldr     r2, [fp, #-24]         @ Load argc into r2 for check
    cmp     r2, #2                 @ Ensure there are enough arguments
    blt     end_loop               @ If not, skip the loop

    ldr     r2, [fp, #-8]          @ Load i into r2
    cmp     r2, r3                 @ Compare i with adjusted length
    bge     end_loop               @ If i is not less than length, branch to end_loop

    add     r1, r4, r2             @ Add i to argv[1] to get the current character address
    ldrb    r1, [r1]               @ Load the current character from argv[1]

    cmp     r1, #'0'               @ Check if character is less than '0'
    blt     check_alpha            @ Branch if it might be alphabetic
    cmp     r1, #'9'               @ Check if character is greater than '9'
    bgt     check_alpha            @ Branch if it might be alphabetic
    b       skip_char              @ It's a numeric character, skip it

check_alpha:
    cmp     r1, #'A'               @ Check if character is less than 'A'
    blt     skip_char              @ It's not alphabetic, skip it
    cmp     r1, #'Z'               @ Check if character is greater than 'Z'
    ble     to_lower               @ If it's uppercase, convert to lowercase
    cmp     r1, #'a'               @ Check if character is less than 'a'
    blt     skip_char              @ It's not alphabetic, skip it
    cmp     r1, #'z'               @ Check if character is greater than 'z'
    bgt     skip_char              @ It's not alphabetic, skip it

    @ If it's lowercase alphabetic, fall through to store the character
    b       store_char

to_lower:
    add     r1, r1, #32            @ Convert uppercase letter to lowercase

store_char:
    strb    r1, [r4, r5]           @ Store the character at the current write position
    add     r5, r5, #1             @ Increment the write position index

skip_char:
    add     r2, r2, #1             @ Increment i
    str     r2, [fp, #-8]          @ Store updated i
    b       Loop                   @ Continue the loop

end_loop:
    mov     r2, #0                 @ Null-terminator
    strb    r2, [r4, r5]           @ Store null-terminator after the last character
    ldr     r0, =string0           @ Load format string address into r0
    mov     r1, r4                 @ Load pointer to modified string (argv[1]) into r1
    bl      printf                 @ Print the filtered string
    mov     r0, #0                 @ Return 0; traditionally used to indicate 'success'

cleanup:
    add     sp, sp, #28            @ Clean up the stack pointer
    ldmfd   sp!, {fp, lr}          @ Restore frame pointer and link register
    bx      lr                     @ Return from function

    .data
Link:
    .word   string0
string0:
    .asciz  "prog1 result: %s\n"

.end
