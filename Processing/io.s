.section .text
open_file:
#input: a1 - file path
#output: a0 - file descriptor id
        li a0, 0
        #li a2, 1026                  # mode read-write flag append
        li a2, 2                      # mode read-write
        li a7, 56                    # _NR_sys_openat
        ecall                        # system call

        mv t1, a0                    # store return value in t1
        bgtz a0, y                   # check if file descriptor id is grater than 0

      #else
n:      li a0, 0                     # stdout
        lui a1, %hi(no)              # load msg(hi)
        addi a1, a1, %lo(no)         # load msg(lo)
        li a2, 15                    # length
        li a3, 0
        li a7, 64                    # _NR_sys_write
        ecall                        # system call
        j end

        #then
y:      li a0, 0                     # stdout
        lui a1, %hi(yes)             # load msg(hi)
        addi a1, a1, %lo(yes)        # load msg(lo)
        li a2, 11                    # length
        li a3, 0                     #
        li a7, 64                    # _NR_sys_write
        ecall                        # system call
        mv a0, t1
        ret
        #end of function 'open_file'

.section .rodata
yes:
	.string "File found\n"
no:
	.string "File not found\n"