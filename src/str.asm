;==============================================================================
; String Library
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


global is_alphanumeric
global is_numeric
global str_to_u64
global str_to_s64
global u64_to_str
global s64_to_str

extern mcpy ; mem.asm


;==============================================================================
; Returns true if character is alphanumeric, false otherwise
;--------------------------------------
; p: character
; r: true == 1 or false == 0
; g: rax
is_alphanumeric:
        cmp dl, 48  ;[0, 48)    false
        jb  .false
        cmp dl, 58  ;[48, 58)   true
        jb  .true
        cmp dl, 65  ;[58, 65)   false
        jb  .false
        cmp dl, 91  ;[65, 91)   true
        jb  .true
        cmp dl, 97  ;[91, 97)   false
        jb  .false
        cmp dl, 123 ;[97, 123)  true
        jb  .true
                    ;[123, 255] false
.false: xor rax, rax
        ret
.true:  mov rax, 1
        ret

;==============================================================================
; Returns true if character is numeric, false otherwise
;--------------------------------------
; p: character
; r: true == 1 or false == 0
; g: rax
is_numeric:
        cmp dl, 48  ;[0, 48)   false
        jb  .false
        cmp dl, 58  ;[48, 58)  true
        jb  .true
                    ;[58, 255] false
.false: xor rax, rax
        ret
.true:  mov rax, 1
        ret


;==============================================================================
; Takes a string and length, checks if all chars are numeric,
; returns unsigned 64bit value of string
;--------------------------------------
; p: addr len
; r: u64
; g: r8, r9, rcx, rax
; TODO: what if len == 0, optimize
str_to_u64:
%define addr r8
%define len  r9
        mov  addr, rdi
        mov  len, rsi

; check if all chars are numeric
        xor  rcx, rcx
.l0:    mov  dl, byte [addr + rcx]
        call is_numeric
        cmp  rax, 0         ; if is_numeric == false
        je   .out           ;     exit with 0
        inc  rcx
        cmp  rcx, len
        jb   .l0

; all chars are numberic, proceed to convertion
        xor  rcx, rcx               ; i = 0
        xor  rax, rax               ; acc = 0
        mov  rdi, 10
.l1:    mul  rdi                    ; acc *= 10
        add  al, byte [addr + rcx]  ; acc += ascii val from [addr + i]
        sub  al, 48                 ; numeric_ascii to num
        inc  rcx
        cmp  rcx, len               ; repeat while i++ < len
        jb   .l1

.out:   ret

;==============================================================================
; Takes a string and length, checks if all chars are numeric,
; returns singed 64bit value of string
;--------------------------------------
; p: addr len
; r: u64
; g: r8, r9, rcx, rax
str_to_s64:
; TODO:
        ret


;==============================================================================
;--------------------------------------
; p: u64 addr cap
; r: len
; g: ?
u64_to_str:
; TODO:
        ret

;==============================================================================
;--------------------------------------
; p: s64 addr cap
; r: len
; g: ?
s64_to_str:
; TODO:
        ret


;==============================================================================
; Takes destination string buffer, string length and capacity,
; source string and source length then
; appends source string to the destination buffer
; Note: parameter order for optimized mcpy call
;--------------------------------------
; p: dest_addr dcap src_addr slen dlen
; r: write_len
; g: rax
str_append:

%define dest rdi
%define dlen r9

; TODO: check if dlen > dcap

        add dest, dlen
        call mcpy

        ret


; p: dest_addr dcap dlen char
; r: write_len
; g: --
str_append_char:

%define dest rdi
%define dcap rsi
%define dlen r8
%define char r9

; TODO: check fi dlen >= dcap

        mov [dest + dlen], char
        mov rax, 1
        ret
