;==============================================================================
; Linux x64 ABI File
;--------------------------------------
; Author: Lauri Koivuniemi
; Asm:    NASM version 2.16.03
;--------------------------------------
; Constant and helpers when working with linux x64 file system
;


%ifndef FILE.ASM
%define FILE.ASM


%define STDIN  0
%define STDOUT 1
%define STDERR 2


%define O_ACCMODE  0003
%define O_RDONLY   00
%define O_WRONLY   01
%define O_RDWR     02
%define O_CREAT    0100
%define O_EXCL     0200
%define O_NOCTTY   0400
%define O_TRUNC    01000
%define O_APPEND   02000
%define O_NONBLOCK 04000
%define O_NDELAY   O_NONBLOCK
%define O_SYNC     04010000
%define O_FSYNC    O_SYNC
%define O_ASYNC    020000


%define SEEK_SET   0
%define SEEK_CUR   1
%define SEEK_END   2


%endif ; FILE.ASM
