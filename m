From: John Tobias <john.tobias.ph@gmail.com>
Subject: Kernel 3.19 on iMX6SL
Date: Fri, 13 Feb 2015 17:10:11 -0800
Message-ID: <CACUGKYMC-_F9fwXgM7jz4J3vabF6Sq-sh3=WdqO_doj1+rvmDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:39925 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbBNBKN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Feb 2015 20:10:13 -0500
Received: by labgq15 with SMTP id gq15so19648460lab.6
        for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2015 17:10:12 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Aisheng Dong <Aisheng.Dong@freescale.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <dongas86@gmail.com>

Hello Guys,

I tried to use kernel 3.19 on my iMX6SL custom board and my eMMC is
running DDR50 mode.

Any available patch for this?.

Regards,

John


[   14.802775] mmc0: Timeout waiting for hardware interrupt.
[   14.808261] ------------[ cut here ]------------
[   14.812936] WARNING: CPU: 0 PID: 0 at drivers/mmc/host/sdhci.c:1013
sdhci_send_command+0x77c/0xfac()
[   14.822084] Modules linked in:
[   14.825190] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.19.0 #16
[   14.831218] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
[   14.837327] Backtrace:
[   14.839843] [<80012630>] (dump_backtrace) from [<8001284c>]
(show_stack+0x18/0x1c)
[   14.847429]  r7:803cd6b4 r6:80829eec r5:00000000 r4:00000000
[   14.853210] [<80012834>] (show_stack) from [<805bba1c>]
(dump_stack+0x8c/0xa4)
[   14.860476] [<805bb990>] (dump_stack) from [<8002ae10>]
(warn_slowpath_common+0x7c/0xb8)
[   14.868582]  r7:803cd6b4 r6:000003f5 r5:00000009 r4:00000000
[   14.874362] [<8002ad94>] (warn_slowpath_common) from [<8002aef0>]
(warn_slowpath_null+0x24/0x2c)
[   14.883162]  r8:9e5bbc80 r7:00000002 r6:00000001 r5:9e6ea680 r4:9e6ea64c
[   14.890010] [<8002aecc>] (warn_slowpath_null) from [<803cd6b4>]
(sdhci_send_command+0x77c/0xfac)
[   14.898827] [<803ccf38>] (sdhci_send_command) from [<803cf0f4>]
(sdhci_finish_data+0x124/0x378)
[   14.907541]  r10:9e5bbc80 r9:8007bae0 r8:9e5bbc80 r7:00000002
r6:00000001 r5:9e6ea680
[   14.915500]  r4:9e5bbc80
[   14.918083] [<803cefd0>] (sdhci_finish_data) from [<803cf55c>]
(sdhci_timeout_timer+0x78/0xc0)
[   14.926711]  r10:9e5bbc80 r9:8007bae0 r8:9e5bbc80 r7:00000100
r6:800f0113 r5:9e5bbdf8
[   14.934668]  r4:9e5bbc80
[   14.937264] [<803cf4e4>] (sdhci_timeout_timer) from [<8007bb50>]
(call_timer_fn+0x70/0xfc)
[   14.945544]  r7:00000100 r6:803cf4e4 r5:00000001 r4:80807df8
[   14.951326] [<8007bae0>] (call_timer_fn) from [<8007c844>]
(run_timer_softirq+0x1d0/0x268)
[   14.959606]  r9:803cf4e4 r8:00200200 r7:00000000 r6:80807e38
r5:81049940 r4:9e5bbeb0
[   14.967493] [<8007c674>] (run_timer_softirq) from [<8002e6a0>]
(__do_softirq+0x138/0x2c4)
[   14.975685]  r10:00000100 r9:80808080 r8:40000001 r7:80808080
r6:00000001 r5:80808084
[   14.983641]  r4:00000000
[   14.986221] [<8002e568>] (__do_softirq) from [<8002eb6c>]
(irq_exit+0xc4/0x138)
[   14.993545]  r10:00000000 r9:9e406000 r8:00000001 r7:00000000
r6:8080ed80 r5:00000000
[   15.001499]  r4:80803c74
[   15.004085] [<8002eaa8>] (irq_exit) from [<8006dfd8>]
(__handle_domain_irq+0x74/0xe8)
[   15.011930]  r5:00000000 r4:80803c74
[   15.015575] [<8006df64>] (__handle_domain_irq) from [<800087a0>]
(gic_handle_irq+0x28/0x68)
[   15.023941]  r9:808596d9 r8:808596d9 r7:a080e100 r6:8080eee4
r5:80807f18 r4:a080e10c
[   15.031821] [<80008778>] (gic_handle_irq) from [<800133a4>]
(__irq_svc+0x44/0x5c)
[   15.039323] Exception stack(0x80807f18 to 0x80807f60)
[   15.044396] 7f00:
    00000001 00000001
[   15.052600] 7f20: 00000000 80812038 80806000 8080e97c 8080e9c8
805c6854 808596d9 808596d9
[   15.060802] 7f40: 00000000 80807f6c 80807f30 80807f60 80061c34
8000f898 200f0013 ffffffff
[   15.068994]  r7:80807f4c r6:ffffffff r5:200f0013 r4:8000f898
[   15.074779] [<8000f870>] (arch_cpu_idle) from [<8005ccd8>]
(cpu_startup_entry+0x104/0x170)
[   15.083080] [<8005cbd4>] (cpu_startup_entry) from [<805b8e54>]
(rest_init+0xa8/0xd0)
[   15.090837]  r7:8080e8c0 r4:8081fe0c
[   15.094495] [<805b8dac>] (rest_init) from [<807b1c94>]
(start_kernel+0x35c/0x3d0)
[   15.101993]  r5:808598c0 r4:8080ea80
[   15.105641] [<807b1938>] (start_kernel) from [<80008074>] (0x80008074)
[   15.112188] ---[ end trace 6e256218d1342a6f ]---
[   15.122734] mmcblk0: error -110 sending status command, retrying
[   15.130269] mmcblk0: error -110 sending status command, retrying
[   15.136422] mmcblk0: error -110 sending status command, aborting
[   15.143632] EXT4-fs error (device mmcblk0p2): ext4_find_entry:1289:
inode #34062: comm systemd-udevd: reading directory lblock 0
[   15.155299] EXT4-fs (mmcblk0p2): previous I/O error to superblock detected
[   15.162684] mmc0: card 0001 removed
[   15.474577] EXT4-fs error (device mmcblk0p2): ext4_find_entry:1289:
inode #76: comm systemd: reading directory lblock 0
[   15.485447] EXT4-fs (mmcblk0p2): previous I/O error to superblock detected
[   15.504872] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:674: error -5 reading directory block (ino 1641,
block 0)
[   15.516960] EXT4-fs error (device mmcblk0p2): ext4_find_entry:1289:
inode #76: comm systemd: reading directory lblock 0
[   15.530808] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:674: error -5 reading directory block (ino 1641,
block 0)
[   15.545607] EXT4-fs error (device mmcblk0p2): ext4_find_entry:1289:
inode #76: comm systemd: reading directory lblock 0
[   15.563961] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:674: error -5 reading directory block (ino 1641,
block 0)
[   15.576783] EXT4-fs error (device mmcblk0p2): ext4_find_entry:1289:
inode #76: comm systemd: reading directory lblock 0
[   15.593002] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:674: error -5 reading directory block (ino 1641,
block 0)
[   15.611407] EXT4-fs error (device mmcblk0p2): ext4_find_entry:1289:
inode #76: comm systemd: reading directory lblock 0
[   15.627345] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:674: error -5 reading directory block (ino 1641,
block 0)
[   15.641492] EXT4-fs error (device mmcblk0p2): ext4_find_entry:1289:
inode #76: comm systemd: reading directory lblock 0
[   15.660660] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:674: error -5 reading directory block (ino 1641,
block 0)
[   15.673743] EXT4-fs error (device mmcblk0p2): ext4_find_entry:1289:
inode #76: comm systemd: reading directory lblock 0
[   15.685066] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:674: error -5 reading directory block (ino 1641,
block 0)
[   15.699344] EXT4-fs error (device mmcblk0p2): ext4_find_entry:1289:
inode #76: comm systemd: reading directory lblock 0
[   15.710926] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:674: error -5 reading directory block (ino 1641,
block 0)
[   15.722999] EXT4-fs error (device mmcblk0p2): ext4_find_entry:1289:
inode #76: comm systemd: reading directory lblock 0
[   15.736645] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:674: error -5 reading directory block (ino 1641,
block 0)
[   15.756361] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:674: error -5 reading directory block (ino 1641,
block 0)
Login incorrect
