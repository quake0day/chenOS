; bootloader.asm

[org 0x7c00]        ; BIOS 将引导扇区加载到 0x7c00 内存地址处

; 初始化堆栈
mov ax, 0x07C0
add ax, 0x20
mov ss, ax
mov sp, 0x1000

; 清除方向标志位
cld

; 通过 BIOS 中断显示 "Hello, World!"
mov ah, 0x0E          ; 视频功能 - 在 TTY 模式下输出字符

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, ','
int 0x10
mov al, ' '
int 0x10
mov al, 'W'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'd'
int 0x10
mov al, '!'
int 0x10

; clean screen

;mov ax, 0600h
;mov bx, 0700h
;mov cx, 0
;mov dx, 0184fh
;int 10h


; set focus
mov ax, 0200h
mov bx, 0000h
mov dx, 0000h
int 10h

; display on screen

mov ax, 1301h
mov bx, 000fh
mov dx, 0000h
mov cx, 10
push ax
mov ax, ds
mov es, ax
pop ax
mov bp, StartBootMessage
int 10h

; reset floppy
xor ah, ah
xor dl, dl
int 13h

jmp $

StartBootMessage: db "Start Boot"

; 进入死循环以防止 CPU 继续执行未知代码
hang:
jmp hang

; 填充引导扇区余下部分
times 510-($-$$) db 0
dw 0xAA55

