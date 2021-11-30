	.globl _start
	.globl _print_string
	.text
	

_start:
	movq	$MSG2,	%rdi
	call _get_names_array
	call _get_random_number
	movq	%rax,	%rdi
	call _func
	movq	%rax,	%rdi
	movq	$60,	%rax
	syscall

_func:	
	movq	$9,	%rax
	.loop3:
	cmpq	$0,	%rax
	je .end3
	pushq	%rax
	movq	%rdi,	%rax
	popq	%rdi
	movq	$0,	%rdx
	div	%rdi
	pushq	%rax
	pushq	%rdi
	pushq	%rdx
	movq	%rdx,	%rdi
	call _print_and_destroy
	popq	%rdx
	popq	%rdi
	popq	%rax
	
	pushq	%rdi
	movq	%rax,	%rdi
	popq	%rax
	dec	%rax
	jmp	.loop3
	.end3:
	ret
	
_print_start:
	incb	(num)
	pushq	%rax
	pushq	%rdx
	pushq	%rdi
	pushq	%rsi
	movq	$num,	%rdi
	call	_print_string
	popq	%rsi
	popq	%rdi
	popq	%rdx
	popq	%rax
	ret

_print_and_destroy:
	call	_print_start
	pushq	%rdi
	movq	%rdi,	%rax
	movq	$8,	%rdi
	mulq	%rdi
	movq	%rax,	%rdi
	movq	$sacr,	%rax
	addq	%rdi,	%rax
	movq	(%rax),	%rdi
	call	_print_string_nl
	popq	%rdi
	call	_shift
	ret


_shift:
	.loop4:
	cmpq	$12,	%rdi
	je	.end4
	movq	$8,	%rax
	mulq	%rdi
	addq	$sacr,	%rax
	movq	%rax,	%rdx
	addq	$8,	%rdx
	mov	(%rdx),	%rdx
	movq	%rdx,	(%rax)
	inc	%rdi
	jmp	.loop4
	.end4:
	ret
	
_print_string:
	movq	%rdi,	%rsi
	.loop2:
	cmpb	$0,	(%rsi)
	je	.end1
	movq	$1,	%rax
	movq	$1,	%rdi
	movq	$1,	%rdx
	syscall
	inc	%rsi
	jmp	.loop2
	.end1:
	ret

_print_string_nl:
	movq	$0x0a,	%rax
	pushq	%rsi
	pushq	%rax
	call _print_string
	movq	$1,	%rax
	movq	$1,	%rdi
	movq	$1,	%rdx
	movq	%rsp,	%rsi
	syscall
	popq	%rsi
	popq	%rax
	ret


_get_random_number:
	movq	$2,	%rax
	movq	$random_file, %rdi
	movq	$0,	%rsi
	movq	$0,	%rdx
	syscall
	pushq	$0
	movq	%rax,	%rdi
	movq	%rsp,	%rsi
	movq	$0,	%rax
	movq	$8,	%rdx
	syscall
	popq	%rax
	pushq	%rax
	movq	$3,	%rax
	movq	%rdi,	%rdx
	syscall
	popq	%rax	
	ret

_get_names_array:	
	movq	$MSG1,	(sacr + 0)
	movq	$MSG2,	(sacr + 8)
	movq	$MSG3,	(sacr + 16)
	movq	$MSG4,	(sacr + 24)
	movq	$MSG5,	(sacr + 32)
	movq	$MSG6,	(sacr + 40)
	movq	$MSG7,	(sacr + 48)
	movq	$MSG8,	(sacr + 56)
	movq	$MSG9,	(sacr + 64)
	ret


	.data
random_file:	.ascii "/dev/random\0"
MSG1:	.asciz "1st"
MSG2:	.asciz "2nd"
MSG3:	.asciz "3rd"
MSG4:	.asciz "4th"
MSG5:	.asciz "5th"
MSG6:	.asciz "6th"
MSG7:	.asciz "7th"
MSG8:	.asciz "8th"
MSG9:	.asciz "9th"
MSG10:	.asciz "10th"
	
sacr:	.quad 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
num:	.asciz "0: "

sacr2:	.quad 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
