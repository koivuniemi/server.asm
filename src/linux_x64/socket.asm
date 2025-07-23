;==============================================================================
; Linux x64 ABI Socket
;--------------------------------------
; Author: Lauri Koivuniemi
; Asm:    NASM version 2.16.03
;--------------------------------------
; Constant and helper when working with linux x64 sockets
;



%ifndef SOCKET.ASM
%define SOCKET.ASM


; Domain
%define AF_INET  2
%define AF_INET6 10
; TODO: add more

; Type
%define SOCK_STREAM    1
%define SOCK_DGRAM     2
%define SOCK_RAW       3
%define SOCK_RDM       4
%define SOCK_SEQPACKET 5
%define SOCK_DCCP      6
%define SOCK_PACKET    6
%define SOCK_PACKET    10
%define SOCK_CLOEXEC   02000000
%define SOCK_NONBLOCK  04000

; Protocol
; TODO: add more


; TODO: some sort of helper function to initialize this and others?
; https://www.man7.org/linux/man-pages/man3/sockaddr.3type.html
; https://learn.microsoft.com/en-us/windows/win32/api/ws2def/ns-ws2def-sockaddr_in
; sockaddr_in
; struct sockaddr_in {
;       short          sin_family;        e.g. AF_INET
;       unsigned short sin_port;          e.g. 8080
;       uint32_t       sin_addr;          e.g. 127.0.0.1
;       char           sin_zero[8];       reserved, all zeroes
; };


%define MSG_OOB          0x01           ; Process out-of-band data
%define MSG_PEEK         0x02           ; Peek at incoming messages
%define MSG_DONTROUTE    0x04           ; Don't use local routing
%define MSG_TRYHARD      MSG_DONTROUTE
%define MSG_CTRUNC       0x08           ; Control data lost before delivery
%define MSG_PROXY        0x10           ; Supply or ask second address
%define MSG_TRUNC        0x20
%define MSG_DONTWAIT     0x40           ; Nonblocking IO
%define MSG_EOR          0x80           ; End of record
%define MSG_WAITALL      0x100          ; Wait for a full request
%define MSG_FIN          0x200
%define MSG_SYN          0x400
%define MSG_CONFIRM      0x800          ; Confirm path validity
%define MSG_RST          0x1000
%define MSG_ERRQUEUE     0x2000         ; Fetch message from error queue
%define MSG_NOSIGNAL     0x4000         ; Do not generate SIGPIPE
%define MSG_MORE         0x8000         ; Sender will send more
%define MSG_WAITFORONE   0x10000        ; Wait for at least one packet to return
%define MSG_BATCH        0x40000        ; sendmmsg: more messages coming
%define MSG_SOCK_DEVMEM  0x2000000      ; Receive devmem skbs as cmsg
%define MSG_ZEROCOPY     0x4000000      ; Use user data in kernel path
%define MSG_FASTOPEN     0x20000000     ; Send data in TCP SYN
%define MSG_CMSG_CLOEXEC 0x40000000     ; Set close_on_exit for file


%endif ; SOCKET.ASM
