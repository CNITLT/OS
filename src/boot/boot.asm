;%define _BOOT_DEBUG_

%ifdef _BOOT_DEBUG_
org 0x0100 ;调试的起始位置是0x0100
		 	;nasm boot.asm -o boot.com用于调试
%else
org 0x7c00 ;设置起始位置， 这里是bios引导程序寻找的位置
%endif
	jmp START
	nop

StackBase equ 0x7c00
BootMesg db "Booting..."
START:
	mov ax, bx
	mov ds, ax
	mov ss, ax
	mov sp, StackBase

	;打印字体，调用的是bios的中断
	mov al, 1
	mov dh, 0
	mov bl, 0x07
	mov cx, 13
	mov dh, 0
	mov dh, 0
	
	push ds
	pop es
	mov bp, BootMesg
	mov ah, 0x13
	int 0x10

	jmp $
	
times 510 - ($ - $$) db 0
dw 0xaa55 
	 
