;==============================================================================
; Linux x64 ABI
;---------------------------------------
; Author: Lauri Koivuniemi
; Asm:    NASM version 2.16.03
;---------------------------------------
; Linux x64 ABI systemcalls, constants and macroes
;


%ifndef SYSCALL.ASM
%define SYSCALL.ASM


%define SYS_READ                   0
%define SYS_WRITE                  1
%define SYS_OPEN                   2
%define SYS_CLOSE                  3
%define SYS_STAT                   4
%define SYS_FSTAT                  5
%define SYS_LSTAT                  6
%define SYS_POLL                   7
%define SYS_LSEEK                  8
%define SYS_MMAP                   9
%define SYS_MPROTECT               10
%define SYS_MUNMAP                 11
%define SYS_BRK                    12
%define SYS_RT_SIGACTION           13
%define SYS_RT_SIGPROCMASK         14
%define SYS_RT_SIGRETURN           15
%define SYS_IOCTL                  16
%define SYS_PREAD64                17
%define SYS_PWRITE64               18
%define SYS_READV                  19
%define SYS_WRITEV                 20
%define SYS_ACCESS                 21
%define SYS_PIPE                   22
%define SYS_SELECT                 23
%define SYS_SCHED_YIELD            24
%define SYS_MREMAP                 25
%define SYS_MSYNC                  26
%define SYS_MINCORE                27
%define SYS_MADVISE                28
%define SYS_SHMGET                 29
%define SYS_SHMAT                  30
%define SYS_SHMCTL                 31
%define SYS_DUP                    32
%define SYS_DUP2                   33
%define SYS_PAUSE                  34
%define SYS_NANOSLEEP              35
%define SYS_GETITIMER              36
%define SYS_ALARM                  37
%define SYS_SETITIMER              38
%define SYS_GETPID                 39
%define SYS_SENDFILE               40
%define SYS_SOCKET                 41
%define SYS_CONNECT                42
%define SYS_ACCEPT                 43
%define SYS_SENDTO                 44
%define SYS_RECVFROM               45
%define SYS_SENDMSG                46
%define SYS_RECVMSG                47
%define SYS_SHUTDOWN               48
%define SYS_BIND                   49
%define SYS_LISTEN                 50
%define SYS_GETSOCKNAME            51
%define SYS_GETPEERNAME            52
%define SYS_SOCKETPAIR             53
%define SYS_SETSOCKOPT             54
%define SYS_GETSOCKOPT             55
%define SYS_CLONE                  56
%define SYS_FORK                   57
%define SYS_VFORK                  58
%define SYS_EXECVE                 59
%define SYS_EXIT                   60
%define SYS_WAIT4                  61
%define SYS_KILL                   62
%define SYS_UNAME                  63
%define SYS_SEMGET                 64
%define SYS_SEMOP                  65
%define SYS_SEMCTL                 66
%define SYS_SHMDT                  67
%define SYS_MSGGET                 68
%define SYS_MSGSND                 69
%define SYS_MSGRCV                 70
%define SYS_MSGCTL                 71
%define SYS_FCNTL                  72
%define SYS_FLOCK                  73
%define SYS_FSYNC                  74
%define SYS_FDATASYNC              75
%define SYS_TRUNCATE               76
%define SYS_FTRUNCATE              77
%define SYS_GETDENTS               78
%define SYS_GETCWD                 79
%define SYS_CHDIR                  80
%define SYS_FCHDIR                 81
%define SYS_RENAME                 82
%define SYS_MKDIR                  83
%define SYS_RMDIR                  84
%define SYS_CREAT                  85
%define SYS_LINK                   86
%define SYS_UNLINK                 87
%define SYS_SYMLINK                88
%define SYS_READLINK               89
%define SYS_CHMOD                  90
%define SYS_FCHMOD                 91
%define SYS_CHOWN                  92
%define SYS_FCHOWN                 93
%define SYS_LCHOWN                 94
%define SYS_UMASK                  95
%define SYS_GETTIMEOFDAY           96
%define SYS_GETRLIMIT              97
%define SYS_GETRUSAGE              98
%define SYS_SYSINFO                99
%define SYS_TIMES                  100
%define SYS_PTRACE                 101
%define SYS_GETUID                 102
%define SYS_SYSLOG                 103
%define SYS_GETGID                 104
%define SYS_SETUID                 105
%define SYS_SETGID                 106
%define SYS_GETEUID                107
%define SYS_GETEGID                108
%define SYS_SETPGID                109
%define SYS_GETPPID                110
%define SYS_GETPGRP                111
%define SYS_SETSID                 112
%define SYS_SETREUID               113
%define SYS_SETREGID               114
%define SYS_GETGROUPS              115
%define SYS_SETGROUPS              116
%define SYS_SETRESUID              117
%define SYS_GETRESUID              118
%define SYS_SETRESGID              119
%define SYS_GETRESGID              120
%define SYS_GETPGID                121
%define SYS_SETFSUID               122
%define SYS_SETFSGID               123
%define SYS_GETSID                 124
%define SYS_CAPGET                 125
%define SYS_CAPSET                 126
%define SYS_RT_SIGPENDING          127
%define SYS_RT_SIGTIMEDWAIT        128
%define SYS_RT_SIGQUEUEINFO        129
%define SYS_RT_SIGSUSPEND          130
%define SYS_SIGALTSTACK            131
%define SYS_UTIME                  132
%define SYS_MKNOD                  133
%define SYS_USELIB                 134
%define SYS_PERSONALITY            135
%define SYS_USTAT                  136
%define SYS_STATFS                 137
%define SYS_FSTATFS                138
%define SYS_SYSFS                  139
%define SYS_GETPRIORITY            140
%define SYS_SETPRIORITY            141
%define SYS_SCHED_SETPARAM         142
%define SYS_SCHED_GETPARAM         143
%define SYS_SCHED_SETSCHEDULER     144
%define SYS_SCHED_GETSCHEDULER     145
%define SYS_SCHED_GET_PRIORITY_MAX 146
%define SYS_SCHED_GET_PRIORITY_MIN 147
%define SYS_SCHED_RR_GET_INTERVAL  148
%define SYS_MLOCK                  149
%define SYS_MUNLOCK                150
%define SYS_MLOCKALL               151
%define SYS_MUNLOCKALL             152
%define SYS_VHANGUP                153
%define SYS_MODIFY_LDT             154
%define SYS_PIVOT_ROOT             155
%define SYS__SYSCTL                156
%define SYS_PRCTL                  157
%define SYS_ARCH_PRCTL             158
%define SYS_ADJTIMEX               159
%define SYS_SETRLIMIT              160
%define SYS_CHROOT                 161
%define SYS_SYNC                   162
%define SYS_ACCT                   163
%define SYS_SETTIMEOFDAY           164
%define SYS_MOUNT                  165
%define SYS_UMOUNT2                166
%define SYS_SWAPON                 167
%define SYS_SWAPOFF                168
%define SYS_REBOOT                 169
%define SYS_SETHOSTNAME            170
%define SYS_SETDOMAINNAME          171
%define SYS_IOPL                   172
%define SYS_IOPERM                 173
%define SYS_CREATE_MODULE          174
%define SYS_INIT_MODULE            175
%define SYS_DELETE_MODULE          176
%define SYS_GET_KERNEL_SYMS        177
%define SYS_QUERY_MODULE           178
%define SYS_QUOTACTL               179
%define SYS_NFSSERVCTL             180
%define SYS_GETPMSG                181
%define SYS_PUTPMSG                182
%define SYS_AFS_SYSCALL            183
%define SYS_TUXCALL                184
%define SYS_SECURITY               185
%define SYS_GETTID                 186
%define SYS_READAHEAD              187
%define SYS_SETXATTR               188
%define SYS_LSETXATTR              189
%define SYS_FSETXATTR              190
%define SYS_GETXATTR               191
%define SYS_LGETXATTR              192
%define SYS_FGETXATTR              193
%define SYS_LISTXATTR              194
%define SYS_LLISTXATTR             195
%define SYS_FLISTXATTR             196
%define SYS_REMOVEXATTR            197
%define SYS_LREMOVEXATTR           198
%define SYS_FREMOVEXATTR           199
%define SYS_TKILL                  200
%define SYS_TIME                   201
%define SYS_FUTEX                  202
%define SYS_CHED_SETAFFINITY       203
%define SYS_CHED_GETAFFINITY       204
%define SYS_SET_THREAD_AREA        205
%define SYS_IO_SETUP               206
%define SYS_IO_DESTROY             207
%define SYS_IO_GETEVENTS           208
%define SYS_IO_SUMBIT              209
%define SYS_IO_CANCEL              210
%define SYS_GET_THREAD_AREA        211
%define SYS_LOOKUP_DCOOKIE         212
%define SYS_EPOLL_CREATE           213
%define SYS_EPOLL_CTL_OLD          214
%define SYS_EPOLL_WAIT_OLD         215
%define SYS_REMAP_FILE_PAGES       216
%define SYS_GETDENTS64             217
%define SYS_SET_TID_ADDRESS        218
%define SYS_RESTART_SYSCALL        219
%define SYS_SEMTIMEDOP             220
%define SYS_FADVISE64              221
%define SYS_TIMER_CREATE           222
%define SYS_TIMER_SETTIME          223
%define SYS_TIMER_GETTIME          224
%define SYS_TIMER_GETOVERRUN       225
%define SYS_TIMER_DELETE           226
%define SYS_CLOCK_SETTIME          227
%define SYS_CLOCK_GETTIME          228
%define SYS_CLOCK_GETRES           229
%define SYS_LOCK_NANOSLEEP         230
%define SYS_EXIT_GROUP             231
%define SYS_EPOLL_WAIT             232
%define SYS_EPOLL_CTL              233
%define SYS_TGKILL                 234
%define SYS_UTIMES                 235
%define SYS_VSERVER                236
%define SYS_MBIND                  237
%define SYS_SET_MEMPOLICY          238
%define SYS_GET_MEMPOLICY          239
%define SYS_MQ_OPEN                240
%define SYS_MQ_UNLINK              241
%define SYS_MQ_TIMEDSEND           242
%define SYS_MQ_TIMEDRECEIVE        243
%define SYS_MQ_NOTIFY              244
%define SYS_MQ_GETSETATTR          245
%define SYS_KEXEC_LOAD             246
%define SYS_WAITID                 247
%define SYS_ADD_KEY                248
%define SYS_REQUEST_KEY            249
%define SYS_KEYCTL                 250
%define SYS_IOPRIO_SET             251
%define SYS_IOPRIO_GET             252
%define SYS_INOTIFY_INIT           253
%define SYS_INOTIFY_ADD_WATCH      254
%define SYS_INOTIFY_RM_WATCH       255
%define SYS_MIGRATE_PAGES          256
%define SYS_OPENAT                 257
%define SYS_MKDIRAT                258
%define SYS_MKNODAT                259
%define SYS_FCHOWNAT               260
%define SYS_FUTIMESAT              261
%define SYS_NEWFSTATAT             262
%define SYS_UNLINKAT               263
%define SYS_RENAMEAT               264
%define SYS_LINKAT                 265
%define SYS_SYMLINKAT              266
%define SYS_READLINKAT             267
%define SYS_FCHMODAT               268
%define SYS_FACCESSAT              269
%define SYS_PSELECT6               270
%define SYS_PPOLL                  271
%define SYS_UNSHARE                272
%define SYS_SET_ROBUST_LIST        273
%define SYS_GET_ROBUST_LIST        274
%define SYS_SPLICE                 275
%define SYS_TEE                    276
%define SYS_SYNC_FILE_RANGE        277
%define SYS_VMSPLICE               278
%define SYS_MOVE_PAGES             279
%define SYS_UTIMENSAT              280
%define SYS_EPOLL_PWAIT            281
%define SYS_SIGNALFD               282
%define SYS_TIMERFD_CREATE         283
%define SYS_EVENTFD                284
%define SYS_FALLOCATE              285
%define SYS_TIMERFD_SETTIME        286
%define SYS_TIMERFD_GETTIME        287
%define SYS_ACCEPT4                288
%define SYS_SIGNALFD4              289
%define SYS_EVENTFD2               290
%define SYS_EPOLL_CREATE1          291
%define SYS_DUP23                  292
%define SYS_PIPE2                  293
%define SYS_INOTIFY_INIT1          294
%define SYS_PREADV                 295
%define SYS_PWRITEV                296
%define SYS_RT_TGSIGQUEUEINFO      297
%define SYS_PERF_EVENT_OPEN        298
%define SYS_RECVMMSG               299
%define SYS_FANOTIFY_INIT          300
%define SYS_FANOTIFY_MARK          301
%define SYS_PRLIMIT64              302
%define SYS_NAME_TO_HANDLE_AT      303
%define SYS_OPEN_BY_HANDLE_AT      304
%define SYS_CLOCK_ADJTIME          305
%define SYS_SYNCFS                 306
%define SYS_SENDMMSG               307
%define SYS_SETNS                  308
%define SYS_GETCPU                 309
%define SYS_PROCESS_VM_READV       310
%define SYS_PROCESS_VM_WRITEV      311
%define SYS_KCMP                   312
%define SYS_FINIT_MODULE           313
%define SYS_SCHED_SETATTR          314
%define SYS_SCHED_GETATTR          315
%define SYS_RENAMEAT2              316
%define SYS_SECCOMP                317
%define SYS_GETRANDOM              318
%define SYS_MEMFD_CREATE           319
%define SYS_KEXEC_FILE_LOAD        320
%define SYS_BPF                    321
%define SYS_EXECVEAT               322
%define SYS_USERFAULTFD            323
%define SYS_MEMBARRIER             324
%define SYS_MLOCK2                 325
%define SYS_COPY_FILE_RANGE        326
%define SYS_PREADV2                327
%define SYS_PWRITEV2               328
%define SYS_PKEY_MPROTECT          329
%define SYS_PKEY_ALLOC             330
%define SYS_PKEY_FREE              331
%define SYS_STATX                  332



%macro syscall1 1
	mov rax, %1
	syscall
%endmacro
%macro syscall2 2
	mov rdi, %2
	syscall1 %1
%endmacro
%macro syscall3 3
	mov rsi, %3
	syscall2 %1, %2
%endmacro
%macro syscall4 4
	mov rdx, %4
	syscall3 %1, %2, %3
%endmacro
%macro syscall5 5
	mov r10, %5
	syscall4 %1, %2, %3, %4
%endmacro
%macro syscall6 6
	mov r8, %6
	syscall5 %1, %2, %3, %4, %5
%endmacro
%macro syscall7 7
	mov r9, %7
	syscall6 %1, %2, %3, %4, %5, %6
%endmacro


%define sys_read                   syscall4 SYS_READ,
%define sys_write                  syscall4 SYS_WRITE,
%define sys_open                   syscall4 SYS_OPEN,
%define sys_close                  syscall2 SYS_CLOSE,
%define sys_stat                   syscall3 SYS_STAT,
%define sys_fstat                  syscall3 SYS_FSTAT,
%define sys_lstat                  syscall3 SYS_LSTAT,
%define sys_poll                   syscall4 SYS_POLL,
%define sys_lseek                  syscall4 SYS_LSEEK,
; %define sys_mmap                   syscall? SYS_MMAP,
%define sys_mprotect               syscall4 SYS_MPROTECT,
%define sys_munmap                 syscall3 SYS_MUNMAP,
%define sys_brk                    syscall2 SYS_BRK,
%define sys_rt_sigaction           syscall5 SYS_RT_SIGACTION,
%define sys_rt_sigprocmask         syscall5 SYS_RT_SIGPROCMASK,
; %define sys_rt_sigreturn           syscall? SYS_RT_SIGRETURN,
%define sys_ioctl                  syscall4 SYS_IOCTL,
%define sys_pread64                syscall5 SYS_PREAD64,
%define sys_pwrite64               syscall5 SYS_PWRITE64,
%define sys_readv                  syscall4 SYS_READV,
%define sys_writev                 syscall4 SYS_WRITEV,
%define sys_access                 syscall3 SYS_ACCESS,
%define sys_pipe                   syscall2 SYS_PIPE,
%define sys_select                 syscall6 SYS_SELECT,
%define sys_sched_yield            syscall1 SYS_SCHED_YIELD,
%define sys_mremap                 syscall6 SYS_MREMAP,
%define sys_msync                  syscall4 SYS_MSYNC,
%define sys_mincore                syscall4 SYS_MINCORE,
%define sys_madvise                syscall4 SYS_MADVISE,
%define sys_shmget                 syscall4 SYS_SHMGET,
%define sys_shmat                  syscall4 SYS_SHMAT,
%define sys_shmctl                 syscall4 SYS_SHMCTL,
%define sys_dup                    syscall2 SYS_DUP,
%define sys_dup2                   syscall3 SYS_DUP2,
%define sys_pause                  syscall1 SYS_PAUSE,
%define sys_nanosleep              syscall3 SYS_NANOSLEEP,
%define sys_getitimer              syscall3 SYS_GETITIMER,
%define sys_alarm                  syscall2 SYS_ALARM,
%define sys_setitimer              syscall4 SYS_SETITIMER,
%define sys_getpid                 syscall1 SYS_GETPID,
%define sys_sendfile               syscall5 SYS_SENDFILE,
%define sys_socket                 syscall4 SYS_SOCKET,
%define sys_connect                syscall4 SYS_CONNECT,
%define sys_accept                 syscall4 SYS_ACCEPT,
%define sys_sendto                 syscall7 SYS_SENDTO,
%define sys_recvfrom               syscall7 SYS_RECVFROM,
%define sys_sendmsg                syscall4 SYS_SENDMSG,
%define sys_recvmsg                syscall4 SYS_RECVMSG,
%define sys_shutdown               syscall3 SYS_SHUTDOWN,
%define sys_bind                   syscall4 SYS_BIND,
%define sys_listen                 syscall3 SYS_LISTEN,
%define sys_getsockname            syscall4 SYS_GETSOCKNAME,
%define sys_getpeername            syscall4 SYS_GETPEERNAME,
%define sys_socketpair             syscall5 SYS_SOCKETPAIR,
%define sys_setsockopt             syscall6 SYS_SETSOCKOPT,
%define sys_getsockopt             syscall6 SYS_GETSOCKOPT,
%define sys_clone                  syscall6 SYS_CLONE,
%define sys_fork                   syscall1 SYS_FORK,
%define sys_vfork                  syscall1 SYS_VFORK,
%define sys_execve                 syscall4 SYS_EXECVE,
%define sys_exit                   syscall2 SYS_EXIT,
%define sys_wait4                  syscall5 SYS_WAIT4,
%define sys_kill                   syscall3 SYS_KILL,
%define sys_uname                  syscall2 SYS_UNAME,
%define sys_semget                 syscall4 SYS_SEMGET,
%define sys_semop                  syscall4 SYS_SEMOP,
%define sys_semctl                 syscall5 SYS_SEMCTL,
%define sys_shmdt                  syscall2 SYS_SHMDT,
%define sys_msgget                 syscall3 SYS_MSGGET,
%define sys_msgsnd                 syscall5 SYS_MSGSND,
%define sys_msgrcv                 syscall6 SYS_MSGRCV,
%define sys_msgctl                 syscall4 SYS_MSGCTL,
%define sys_fcntl                  syscall4 SYS_FCNTL,
%define sys_flock                  syscall3 SYS_FLOCK,
%define sys_fsync                  syscall2 SYS_FSYNC,
%define sys_fdatasync              syscall2 SYS_FDATASYNC,
%define sys_truncate               syscall3 SYS_TRUNCATE,
%define sys_ftruncate              syscall3 SYS_FTRUNCATE,
%define sys_getdents               syscall4 SYS_GETDENTS,
%define sys_getcwd                 syscall3 SYS_GETCWD,
%define sys_chdir                  syscall2 SYS_CHDIR,
%define sys_fchdir                 syscall2 SYS_FCHDIR,
%define sys_rename                 syscall3 SYS_RENAME,
%define sys_mkdir                  syscall3 SYS_MKDIR,
%define sys_rmdir                  syscall2 SYS_RMDIR,
%define sys_creat                  syscall3 SYS_CREAT,
%define sys_link                   syscall3 SYS_LINK,
%define sys_unlink                 syscall2 SYS_UNLINK,
%define sys_symlink                syscall3 SYS_SYMLINK,
%define sys_readlink               syscall4 SYS_READLINK,
%define sys_chmod                  syscall3 SYS_CHMOD,
%define sys_fchmod                 syscall3 SYS_FCHMOD,
%define sys_chown                  syscall4 SYS_CHOWN,
%define sys_fchown                 syscall4 SYS_FCHOWN,
%define sys_lchown                 syscall4 SYS_LCHOWN,
%define sys_umask                  syscall2 SYS_UMASK,
%define sys_gettimeofday           syscall3 SYS_GETTIMEOFDAY,
%define sys_getrlimit              syscall3 SYS_GETRLIMIT,
%define sys_getrusage              syscall3 SYS_GETRUSAGE,
%define sys_sysinfo                syscall2 SYS_SYSINFO,
%define sys_times                  syscall2 SYS_TIMES,
%define sys_ptrace                 syscall5 SYS_PTRACE,
%define sys_getuid                 syscall1 SYS_GETUID,
%define sys_syslog                 syscall4 SYS_SYSLOG,
%define sys_getgid                 syscall1 SYS_GETGID,
%define sys_setuid                 syscall2 SYS_SETUID,
%define sys_setgid                 syscall2 SYS_SETGID,
%define sys_geteuid                syscall1 SYS_GETEUID,
%define sys_getegid                syscall1 SYS_GETEGID,
%define sys_setpgid                syscall3 SYS_SETPGID,
%define sys_getppid                syscall1 SYS_GETPPID,
%define sys_getpgrp                syscall1 SYS_GETPGRP,
%define sys_setsid                 syscall1 SYS_SETSID,
%define sys_setreuid               syscall3 SYS_SETREUID,
%define sys_setregid               syscall3 SYS_SETREGID,
%define sys_getgroups              syscall3 SYS_GETGROUPS,
%define sys_setgroups              syscall3 SYS_SETGROUPS,
%define sys_setresuid              syscall4 SYS_SETRESUID,
%define sys_getresuid              syscall4 SYS_GETRESUID,
%define sys_setresgid              syscall4 SYS_SETRESGID,
%define sys_getresgid              syscall4 SYS_GETRESGID,
%define sys_getpgid                syscall2 SYS_GETPGID,
%define sys_setfsuid               syscall2 SYS_SETFSUID,
%define sys_setfsgid               syscall2 SYS_SETFSGID,
%define sys_getsid                 syscall2 SYS_GETSID,
%define sys_capget                 syscall3 SYS_CAPGET,
%define sys_capset                 syscall3 SYS_CAPSET,
%define sys_rt_sigpending          syscall3 SYS_RT_SIGPENDING,
%define sys_rt_sigtimedwait        syscall5 SYS_RT_SIGTIMEDWAIT,
%define sys_rt_sigqueueinfo        syscall4 SYS_RT_SIGQUEUEINFO,
%define sys_rt_sigsuspend          syscall3 SYS_RT_SIGSUSPEND,
%define sys_sigaltstack            syscall3 SYS_SIGALTSTACK,
%define sys_utime                  syscall3 SYS_UTIME,
%define sys_mknod                  syscall4 SYS_MKNOD,
%define sys_uselib                 syscall2 SYS_USELIB,
%define sys_personality            syscall2 SYS_PERSONALITY,
%define sys_ustat                  syscall3 SYS_USTAT,
%define sys_statfs                 syscall3 SYS_STATFS,
%define sys_fstatfs                syscall3 SYS_FSTATFS,
%define sys_sysfs                  syscall4 SYS_SYSFS,
%define sys_getpriority            syscall3 SYS_GETPRIORITY,
%define sys_setpriority            syscall4 SYS_SETPRIORITY,
%define sys_sched_setparam         syscall3 SYS_SCHED_SETPARAM,
%define sys_sched_getparam         syscall3 SYS_SCHED_GETPARAM,
%define sys_sched_setscheduler     syscall4 SYS_SCHED_SETSCHEDULER,
%define sys_sched_getscheduler     syscall2 SYS_SCHED_GETSCHEDULER,
%define sys_sched_get_priority_max syscall2 SYS_SCHED_GET_PRIORITY_MAX,
%define sys_sched_get_priority_min syscall2 SYS_SCHED_GET_PRIORITY_MIN,
%define sys_sched_rr_get_interval  syscall3 SYS_SCHED_RR_GET_INTERVAL,
%define sys_mlock                  syscall3 SYS_MLOCK,
%define sys_munlock                syscall3 SYS_MUNLOCK,
%define sys_mlockall               syscall2 SYS_MLOCKALL,
%define sys_munlockall             syscall1 SYS_MUNLOCKALL,
%define sys_vhangup                syscall1 SYS_VHANGUP,
; %define sys_modify_ldt             syscall? SYS_MODIFY_LDT,
%define sys_pivot_root             syscall3 SYS_PIVOT_ROOT,
; %define sys__sysctl                syscall? SYS__SYSCTL,
%define sys_prctl                  syscall6 SYS_PRCTL,
; %define sys_arch_prctl             syscall? SYS_ARCH_PRCTL,
%define sys_adjtimex               syscall2 SYS_ADJTIMEX,
%define sys_setrlimit              syscall3 SYS_SETRLIMIT,
%define sys_chroot                 syscall2 SYS_CHROOT,
%define sys_sync                   syscall1 SYS_SYNC,
%define sys_acct                   syscall2 SYS_ACCT,
%define sys_settimeofday           syscall3 SYS_SETTIMEOFDAY,
%define sys_mount                  syscall6 SYS_MOUNT,
; %define sys_umount2                syscall? SYS_UMOUNT2,
%define sys_swapon                 syscall3 SYS_SWAPON,
%define sys_swapoff                syscall2 SYS_SWAPOFF,
%define sys_reboot                 syscall5 SYS_REBOOT,
%define sys_sethostname            syscall3 SYS_SETHOSTNAME,
%define sys_setdomainname          syscall3 SYS_SETDOMAINNAME,
; %define sys_iopl                   syscall? SYS_IOPL,
%define sys_ioperm                 syscall4 SYS_IOPERM,
; %define sys_create_module          syscall? SYS_CREATE_MODULE,
%define sys_init_module            syscall4 SYS_INIT_MODULE,
%define sys_delete_module          syscall3 SYS_DELETE_MODULE,
; %define sys_get_kernel_syms        syscall? SYS_GET_KERNEL_SYMS,
; %define sys_query_module           syscall? SYS_QUERY_MODULE,
%define sys_quotactl               syscall5 SYS_QUOTACTL,
%define sys_nfsservctl             syscall1 SYS_NFSSERVCTL,
%define sys_getpmsg                syscall1 SYS_GETPMSG,
%define sys_putpmsg                syscall1 SYS_PUTPMSG,
%define sys_afs_syscall            syscall1 SYS_AFS_SYSCALL,
%define sys_tuxcall                syscall1 SYS_TUXCALL,
%define sys_security               syscall1 SYS_SECURITY,
%define sys_gettid                 syscall1 SYS_GETTID,
%define sys_readahead              syscall4 SYS_READAHEAD,
%define sys_setxattr               syscall6 SYS_SETXATTR,
%define sys_lsetxattr              syscall6 SYS_LSETXATTR,
%define sys_fsetxattr              syscall6 SYS_FSETXATTR,
%define sys_getxattr               syscall5 SYS_GETXATTR,
%define sys_lgetxattr              syscall5 SYS_LGETXATTR,
%define sys_fgetxattr              syscall5 SYS_FGETXATTR,
%define sys_listxattr              syscall4 SYS_LISTXATTR,
%define sys_llistxattr             syscall4 SYS_LLISTXATTR,
%define sys_flistxattr             syscall4 SYS_FLISTXATTR,
%define sys_removexattr            syscall3 SYS_REMOVEXATTR,
%define sys_lremovexattr           syscall3 SYS_LREMOVEXATTR,
%define sys_fremovexattr           syscall3 SYS_FREMOVEXATTR,
%define sys_tkill                  syscall3 SYS_TKILL,
%define sys_time                   syscall2 SYS_TIME,
%define sys_futex                  syscall7 SYS_FUTEX,
%define sys_ched_setaffinity       syscall4 SYS_CHED_SETAFFINITY,
%define sys_ched_getaffinity       syscall4 SYS_CHED_GETAFFINITY,
; %define sys_set_thread_area        syscall? SYS_SET_THREAD_AREA,
%define sys_io_setup               syscall3 SYS_IO_SETUP,
%define sys_io_destroy             syscall2 SYS_IO_DESTROY,
%define sys_io_getevents           syscall7 SYS_IO_GETEVENTS,
%define sys_io_sumbit              syscall4 SYS_IO_SUMBIT,
%define sys_io_cancel              syscall4 SYS_IO_CANCEL,
; %define sys_get_thread_area        syscall? SYS_GET_THREAD_AREA,
%define sys_lookup_dcookie         syscall4 SYS_LOOKUP_DCOOKIE,
%define sys_epoll_create           syscall2 SYS_EPOLL_CREATE,
; %define sys_epoll_ctl_old          syscall? SYS_EPOLL_CTL_OLD,
; %define sys_epoll_wait_old         syscall? SYS_EPOLL_WAIT_OLD,
%define sys_remap_file_pages       syscall6 SYS_REMAP_FILE_PAGES,
%define sys_getdents64             syscall4 SYS_GETDENTS64,
%define sys_set_tid_address        syscall2 SYS_SET_TID_ADDRESS,
%define sys_restart_syscall        syscall1 SYS_RESTART_SYSCALL,
%define sys_semtimedop             syscall5 SYS_SEMTIMEDOP,
%define sys_fadvise64              syscall5 SYS_FADVISE64,
%define sys_timer_create           syscall4 SYS_TIMER_CREATE,
%define sys_timer_settime          syscall5 SYS_TIMER_SETTIME,
%define sys_timer_gettime          syscall4 SYS_TIMER_GETTIME,
%define sys_timer_getoverrun       syscall2 SYS_TIMER_GETOVERRUN,
%define sys_timer_delete           syscall2 SYS_TIMER_DELETE,
%define sys_clock_settime          syscall3 SYS_CLOCK_SETTIME,
%define sys_clock_gettime          syscall3 SYS_CLOCK_GETTIME,
%define sys_clock_getres           syscall3 SYS_CLOCK_GETRES,
%define sys_lock_nanosleep         syscall5 SYS_LOCK_NANOSLEEP,
%define sys_exit_group             syscall2 SYS_EXIT_GROUP,
%define sys_epoll_wait             syscall5 SYS_EPOLL_WAIT,
%define sys_epoll_ctl              syscall5 SYS_EPOLL_CTL,
%define sys_tgkill                 syscall4 SYS_TGKILL,
%define sys_utimes                 syscall3 SYS_UTIMES,
; %define sys_vserver                syscall? SYS_VSERVER,
%define sys_mbind                  syscall7 SYS_MBIND,
%define sys_set_mempolicy          syscall4 SYS_SET_MEMPOLICY,
%define sys_get_mempolicy          syscall6 SYS_GET_MEMPOLICY,
%define sys_mq_open                syscall5 SYS_MQ_OPEN,
%define sys_mq_unlink              syscall2 SYS_MQ_UNLINK,
%define sys_mq_timedsend           syscall6 SYS_MQ_TIMEDSEND,
%define sys_mq_timedreceive        syscall6 SYS_MQ_TIMEDRECEIVE,
%define sys_mq_notify              syscall3 SYS_MQ_NOTIFY,
%define sys_mq_getsetattr          syscall4 SYS_MQ_GETSETATTR,
%define sys_kexec_load             syscall5 SYS_KEXEC_LOAD,
%define sys_waitid                 syscall6 SYS_WAITID,
%define sys_add_key                syscall6 SYS_ADD_KEY,
%define sys_request_key            syscall5 SYS_REQUEST_KEY,
%define sys_keyctl                 syscall6 SYS_KEYCTL,
%define sys_ioprio_set             syscall4 SYS_IOPRIO_SET,
%define sys_ioprio_get             syscall3 SYS_IOPRIO_GET,
%define sys_inotify_init           syscall1 SYS_INOTIFY_INIT,
%define sys_inotify_add_watch      syscall4 SYS_INOTIFY_ADD_WATCH,
%define sys_inotify_rm_watch       syscall3 SYS_INOTIFY_RM_WATCH,
%define sys_migrate_pages          syscall5 SYS_MIGRATE_PAGES,
%define sys_openat                 syscall5 SYS_OPENAT,
%define sys_mkdirat                syscall4 SYS_MKDIRAT,
%define sys_mknodat                syscall5 SYS_MKNODAT,
%define sys_fchownat               syscall6 SYS_FCHOWNAT,
%define sys_futimesat              syscall4 SYS_FUTIMESAT,
%define sys_newfstatat             syscall5 SYS_NEWFSTATAT,
%define sys_unlinkat               syscall4 SYS_UNLINKAT,
%define sys_renameat               syscall5 SYS_RENAMEAT,
%define sys_linkat                 syscall6 SYS_LINKAT,
%define sys_symlinkat              syscall4 SYS_SYMLINKAT,
%define sys_readlinkat             syscall5 SYS_READLINKAT,
%define sys_fchmodat               syscall4 SYS_FCHMODAT,
%define sys_faccessat              syscall4 SYS_FACCESSAT,
%define sys_pselect6               syscall7 SYS_PSELECT6,
%define sys_ppoll                  syscall6 SYS_PPOLL,
%define sys_unshare                syscall2 SYS_UNSHARE,
%define sys_set_robust_list        syscall3 SYS_SET_ROBUST_LIST,
%define sys_get_robust_list        syscall4 SYS_GET_ROBUST_LIST,
%define sys_splice                 syscall7 SYS_SPLICE,
%define sys_tee                    syscall5 SYS_TEE,
%define sys_sync_file_range        syscall5 SYS_SYNC_FILE_RANGE,
%define sys_vmsplice               syscall5 SYS_VMSPLICE,
%define sys_move_pages             syscall7 SYS_MOVE_PAGES,
%define sys_utimensat              syscall5 SYS_UTIMENSAT,
%define sys_epoll_pwait            syscall7 SYS_EPOLL_PWAIT,
%define sys_signalfd               syscall4 SYS_SIGNALFD,
%define sys_timerfd_create         syscall3 SYS_TIMERFD_CREATE,
%define sys_eventfd                syscall2 SYS_EVENTFD,
%define sys_fallocate              syscall5 SYS_FALLOCATE,
%define sys_timerfd_settime        syscall5 SYS_TIMERFD_SETTIME,
%define sys_timerfd_gettime        syscall4 SYS_TIMERFD_GETTIME,
%define sys_accept4                syscall5 SYS_ACCEPT4,
%define sys_signalfd4              syscall5 SYS_SIGNALFD4,
%define sys_eventfd2               syscall3 SYS_EVENTFD2,
%define sys_epoll_create1          syscall2 SYS_EPOLL_CREATE1,
%define sys_dup23                  syscall4 SYS_DUP23,
%define sys_pipe2                  syscall3 SYS_PIPE2,
%define sys_inotify_init1          syscall2 SYS_INOTIFY_INIT1,
%define sys_preadv                 syscall6 SYS_PREADV,
%define sys_pwritev                syscall6 SYS_PWRITEV,
%define sys_rt_tgsigqueueinfo      syscall5 SYS_RT_TGSIGQUEUEINFO,
%define sys_perf_event_open        syscall6 SYS_PERF_EVENT_OPEN,
%define sys_recvmmsg               syscall6 SYS_RECVMMSG,
%define sys_fanotify_init          syscall3 SYS_FANOTIFY_INIT,
%define sys_fanotify_mark          syscall6 SYS_FANOTIFY_MARK,
%define sys_prlimit64              syscall5 SYS_PRLIMIT64,
%define sys_name_to_handle_at      syscall6 SYS_NAME_TO_HANDLE_AT,
%define sys_open_by_handle_at      syscall4 SYS_OPEN_BY_HANDLE_AT,
%define sys_clock_adjtime          syscall3 SYS_CLOCK_ADJTIME,
%define sys_syncfs                 syscall2 SYS_SYNCFS,
%define sys_sendmmsg               syscall5 SYS_SENDMMSG,
%define sys_setns                  syscall3 SYS_SETNS,
%define sys_getcpu                 syscall4 SYS_GETCPU,
%define sys_process_vm_readv       syscall7 SYS_PROCESS_VM_READV,
%define sys_process_vm_writev      syscall7 SYS_PROCESS_VM_WRITEV,
%define sys_kcmp                   syscall6 SYS_KCMP,
%define sys_finit_module           syscall4 SYS_FINIT_MODULE,
%define sys_sched_setattr          syscall4 SYS_SCHED_SETATTR,
%define sys_sched_getattr          syscall5 SYS_SCHED_GETATTR,
%define sys_renameat2              syscall6 SYS_RENAMEAT2,
%define sys_seccomp                syscall4 SYS_SECCOMP,
%define sys_getrandom              syscall4 SYS_GETRANDOM,
%define sys_memfd_create           syscall3 SYS_MEMFD_CREATE,
%define sys_kexec_file_load        syscall6 SYS_KEXEC_FILE_LOAD,
%define sys_bpf                    syscall4 SYS_BPF,
%define sys_execveat               syscall6 SYS_EXECVEAT,
%define sys_userfaultfd            syscall2 SYS_USERFAULTFD,
%define sys_membarrier             syscall3 SYS_MEMBARRIER,
%define sys_mlock2                 syscall4 SYS_MLOCK2,
%define sys_copy_file_range        syscall7 SYS_COPY_FILE_RANGE,
%define sys_preadv2                syscall7 SYS_PREADV2,
%define sys_pwritev2               syscall7 SYS_PWRITEV2,
%define sys_pkey_mprotect          syscall5 SYS_PKEY_MPROTECT,
%define sys_pkey_alloc             syscall3 SYS_PKEY_ALLOC,
%define sys_pkey_free              syscall2 SYS_PKEY_FREE,
%define sys_statx                  syscall6 SYS_STATX,


%endif ; SYSCALL.ASM
