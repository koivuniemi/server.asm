;==============================================================================
; Simple HTTP Server
;--------------------------------------
; Author: Lauri Koivuniemi
; Asm:    NASM version 2.16.03
; ABI:    System V
;--------------------------------------
; CAPITAL letters denote constant values
; p: Parameters
; r: Return
; g: Globbered



%include "linux_x64/syscall.asm"
%include "linux_x64/socket.asm"
%include "linux_x64/file.asm"

global _start


; str.asm
extern str_to_u64
extern u64_to_str



section .data

; STRINGS
SSOCKET_ERR     db "Failed to create socket", 0xa
.LEN            equ $ - SSOCKET_ERR
SBIND_ERR       db "Failed to bind (cant bind to same port too quickly)", 0xa
.LEN            equ $ - SBIND_ERR
SLISTEN_ERR     db "Failed to listen", 0xa
.LEN            equ $ - SLISTEN_ERR
SINDEX_ERR      db "Failed to open index.html", 0xa
.LEN            equ $ - SINDEX_ERR
SACCEPT_ERR     db "Failed to accept", 0xa
.LEN            equ $ - SACCEPT_ERR
SSENDFILE_ERR   db "Failed to sendfile", 0xa
.LEN            equ $ - SSENDFILE_ERR
SSEND_TO_ERR    db "Failed to sendto", 0xa
.LEN            equ $ - SSEND_TO_ERR
SLSEEK_ERR      db "Failed to lseek", 0xa
.LEN            equ $ - SLSEEK_ERR
SFILE_SIZE_ERR  db "Error reading file size", 0xa
.LEN            equ $ - SFILE_SIZE_ERR

INDEX_PATH      db "static/index.html", 0x0
.LEN            equ $ - INDEX_PATH

HTTP_200_HTML   db "HTTP/1.1 200 OK",        0xd, 0xa
                db "Content-Type:text/html", 0xd, 0xa
                db                           0xd, 0xa
.LEN            equ $ - HTTP_200_HTML
HTTP_404        db "HTTP/1.1 404 Not Found", 0xd, 0xa
                db                           0xd, 0xa
.LEN            equ $ - HTTP_404


; CONSTANTS
SOCKADDR_IN:
.SIN_FAMILY     dw AF_INET
.SIN_PORT       db 0x05, 0x39   ; 1337      -- network byte order
.SIN_ADDRESS    db 127, 0, 0, 1 ; 127.0.0.1 -- network byte order
.SIN_ZERO       times 8 db 0
.LEN            equ $ - SOCKADDR_IN


; VARIABLES
buf     dq 0    ; address
.len    dq 0
.CAP    equ 1000




section .text
_start:

%define rsocket r15
%define rclient r14
%define rindex  r13
%define rbuffer r12

; Initialize, bind and listen socket
        sys_socket      AF_INET, SOCK_STREAM, 0
        cmp             rax, 0
        jl              .socket_err
        mov             rsocket, rax
        sys_bind        rsocket, SOCKADDR_IN, SOCKADDR_IN.LEN
        cmp             rax, 0
        jl              .bind_err
        sys_listen      rsocket, 10
        cmp             rax, 0
        jl              .listen_err


; Open index.html for sendfile
        sys_open        INDEX_PATH, O_RDONLY, 0
        cmp             rax, 0
        jl              .index_err
        mov             rindex, rax

; Create input buffer
        mov             [buf], rsp
        sub             rsp, buf.CAP

; Start accepting client connections
.accept sys_accept      rsocket, 0, 0   ; client file descriptor or -1 error
        cmp             rax, 0
        jl              .accept_err
        mov             rclient, rax

.read   sys_read        rclient, [buf], buf.CAP
        sys_write       STDOUT, [buf], rax
        cmp             rax, buf.CAP                 ; if (written == cap)
        je              .read                        ;    read rest of msg

        sys_sendto      rclient, HTTP_200_HTML, HTTP_200_HTML.LEN, MSG_MORE, 0, 0
        cmp             rax, 0
        jl              .sendto_err

; TODO: maybe better way e.g. mmapping file to memory and writing to client?
        sys_sendfile    rclient, rindex, 0, 10000000 ; max file size
        cmp             rax, 0
        jl              .sendfile_err
        sys_lseek       rindex, SEEK_SET, 0          ; reset offset
        cmp             rax, 0
        jl              .lseek_err

        sys_close       rclient
        jmp             .accept

        sys_close       rindex


        mov             rdi, 0
        jmp             exit

.socket_err:    sys_write       STDOUT, SSOCKET_ERR, SSOCKET_ERR.LEN
                mov             rdi, 1
                jmp             exit
.bind_err:      sys_write       STDOUT, SBIND_ERR, SBIND_ERR.LEN
                mov             rdi, 2
                jmp             exit
.listen_err:    sys_write       STDOUT, SLISTEN_ERR, SLISTEN_ERR.LEN
                mov             rdi, 3
                jmp             exit
.index_err:     sys_write       STDOUT, SINDEX_ERR, SINDEX_ERR.LEN
                mov             rdi, 4
                jmp             exit
.accept_err:    sys_write       STDOUT, SACCEPT_ERR, SACCEPT_ERR.LEN
                mov             rdi, 5
                jmp             exit
.sendfile_err: sys_write        STDOUT, SSENDFILE_ERR, SSENDFILE_ERR.LEN
                mov             rdi, 6
                jmp             exit
.sendto_err:    sys_write       STDOUT, SSEND_TO_ERR, SSEND_TO_ERR.LEN
                mov             rdi, 7
                jmp             exit
.lseek_err:     sys_write       STDOUT, SLSEEK_ERR, SLSEEK_ERR.LEN
                mov             rdi, 8

exit:           mov             rax, SYS_EXIT
                syscall



; p: filename_addr, filename_len
; r: file size, -1 on error
; g: rax, rdx
file_size:
%define name rdi
%define len  rsi
%define fd   rdx

        sys_open    name, O_RDONLY, 0
        cmp         rax, 0
        jl          .err
        mov         fd, rax

        sys_lseek   fd, SEEK_END, 0     ; offset to the end of file
        cmp         rax, 0
        jl          .err
        mov         r8, rax             ; save file offset == size
        sys_lseek   fd, SEEK_SET, 0     ; reset offset
        cmp         rax, 0
        jl          .err

        sys_close   fd

        mov         rax, r8
        ret

.err    sys_write   STDOUT, SFILE_SIZE_ERR, SFILE_SIZE_ERR.LEN
        sys_write   STDOUT, name, len
        ret ; returning -1
