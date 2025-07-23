;==============================================================================
; Memory library
;--------------------------------------
; Author: Lauri Koivuniemi
; Asm:    NASM version 2.16.03
; ABI:    System V
;--------------------------------------
; CAPITAL letter denote constant values
; p: parameters
; r: return
; g: globbered registers
; Work in progress


global mcpy
; global mmove



;==============================================================================
; Takes destination address and capacity, source address and length
; checks how much can be written and writes from source to destination
;--------------------------------------
; p: dest_addr, cap, src_addr, len
; r: write_len
; g: TODO:
mcpy: ; TODO: make less naive (64bit mov)

%define dest rdi
%define cap  rsi
%define src  rdx
%define len  r8

        cmp   len, cap
        cmova len, cap ; if (len > cap) len = cap
        mov   rax, len ; return len

        jmp .b
.t      mov cl, byte [src + len]
        mov byte [dest + len], cl
.b      dec len
        jnz .t

        ret


; p: dest_addr, cap, src_addr, len
; r: write_len
; g: ?
mmove: ; TODO:
        ret
