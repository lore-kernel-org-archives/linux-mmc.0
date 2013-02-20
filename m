From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP4 bust: MMC causes hung tasks
Date: Wed, 20 Feb 2013 17:00:03 +0000
Message-ID: <20130220170003.GW17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

MMC looks sick - not sure what's going on with it though.  mmc0 I believe
is the onboard eMMC, mmc1 is the external SD card with the rootfs.  Any
ideas?

[    0.000000] Linux version 3.8.0-rc7+ (rmk@rmk-PC.arm.linux.org.uk) (gcc version 4.5.4 (GCC) ) #468 SMP Wed Feb 20 16:44:50 GMT 2013
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: OMAP4430 4430SDP board
[    0.000000] cma: CMA: reserved 16 MiB at 9ec00000
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] OMAP4430 ES2.2
...
[    1.077819] omap-dma-engine omap-dma-engine: allocating channel for 48
[    1.084686] omap-dma-engine omap-dma-engine: allocating channel for 47
[    1.135467] omap-dma-engine omap-dma-engine: allocating channel for 62
[    1.142303] omap-dma-engine omap-dma-engine: allocating channel for 61
[    1.197967] omap-dma-engine omap-dma-engine: allocating channel for 60
[    1.204833] omap-dma-engine omap-dma-engine: allocating channel for 59
[    1.253265] mmc0: new high speed MMC card at address 0001
[    1.260650] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
[    1.265594] mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
[    1.272003] mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
[    1.278411] mmcblk0rpmb: mmc0:0001 SEM08G partition 3 128 KiB
[    1.289947]  mmcblk0: unknown partition table
[    1.297851]  mmcblk0boot1: unknown partition table
[    1.304321]  mmcblk0boot0: unknown partition table
[    1.471282] twl6040 1-004b: timeout waiting for READYINT
...
[    1.603820] mmc1: host does not support reading read-only switch. assuming wr
ite-enable.
[    1.614105] mmc1: new high speed SD card at address 0002
[    1.620086] mmcblk1: mmc1:0002 00000 971 MiB
[    1.626129]  mmcblk1: p1 p2
...
[    4.698455] VFS: Mounted root (ext3 filesystem) on device 179:34.
...
[   10.123077] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
[   13.911163] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
[   17.699371] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
[   17.708526] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
[   17.717742] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
[   17.726867] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900
[   17.735961] end_request: I/O error, dev mmcblk0rpmb, sector 0
[   17.743438] FAT-fs (mmcblk0rpmb): unable to read boot sector
...
[  240.276000] INFO: task mmcqd/0boot0:680 blocked for more than 120 seconds.
[  240.283203] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  240.291442] mmcqd/0boot0    D c0353600     0   680      2 0x00000000
[  240.298126] Backtrace:
[  240.300720] [<c035324c>] (__schedule+0x0/0x47c) from [<c03537f0>] (schedule+0x84/0x88)
[  240.309020] [<c035376c>] (schedule+0x0/0x88) from [<c02343dc>] (__mmc_claim_host+0xc8/0x194)
[  240.317871] [<c0234314>] (__mmc_claim_host+0x0/0x194) from [<c024132c>] (mmc_blk_issue_rq+0x3c/0x448)
[  240.327545] [<c02412f0>] (mmc_blk_issue_rq+0x0/0x448) from [<c0241bd4>] (mmc_queue_thread+0xbc/0x120)
[  240.337249] [<c0241b18>] (mmc_queue_thread+0x0/0x120) from [<c0050368>] (kthread+0xac/0xb8)
[  240.346008] [<c00502bc>] (kthread+0x0/0xb8) from [<c0013298>] (ret_from_fork+0x14/0x3c)
[  240.354400]  r8:00000000 r7:00000000 r6:00000000 r5:c00502bc r4:de861c24
[  240.361450] INFO: task mmcqd/0boot1:681 blocked for more than 120 seconds.
[  240.368652] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  240.376861] mmcqd/0boot1    D c0353600     0   681      2 0x00000000
[  240.383544] Backtrace:
[  240.386108] [<c035324c>] (__schedule+0x0/0x47c) from [<c03537f0>] (schedule+0x84/0x88)
[  240.394409] [<c035376c>] (schedule+0x0/0x88) from [<c02343dc>] (__mmc_claim_host+0xc8/0x194)
[  240.403259] [<c0234314>] (__mmc_claim_host+0x0/0x194) from [<c024132c>] (mmc_blk_issue_rq+0x3c/0x448)
[  240.412933] [<c02412f0>] (mmc_blk_issue_rq+0x0/0x448) from [<c0241bd4>] (mmc_queue_thread+0xbc/0x120)
[  240.422607] [<c0241b18>] (mmc_queue_thread+0x0/0x120) from [<c0050368>] (kthread+0xac/0xb8)
[  240.431396] [<c00502bc>] (kthread+0x0/0xb8) from [<c0013298>] (ret_from_fork+0x14/0x3c)
[  240.439788]  r8:00000000 r7:00000000 r6:00000000 r5:c00502bc r4:de861c24
[  240.446838] INFO: task mmcqd/0rpmb:682 blocked for more than 120 seconds.
[  240.453948] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  240.462158] mmcqd/0rpmb     D c0353600     0   682      2 0x00000000
[  240.468811] Backtrace:
[  240.471405] [<c035324c>] (__schedule+0x0/0x47c) from [<c03537f0>] (schedule+0x84/0x88)
[  240.479705] [<c035376c>] (schedule+0x0/0x88) from [<c0351c30>] (schedule_timeout+0x20/0x194)
[  240.488555] [<c0351c10>] (schedule_timeout+0x0/0x194) from [<c03530f8>] (wait_for_common+0xe8/0x190)
[  240.498138] [<c0353010>] (wait_for_common+0x0/0x190) from [<c0353248>] (wait_for_completion+0x18/0x1c)
[  240.507904] [<c0353230>] (wait_for_completion+0x0/0x1c) from [<c0234968>] (mmc_wait_for_req_done+0x24/0x7c)
[  240.518127] [<c0234944>] (mmc_wait_for_req_done+0x0/0x7c) from [<c0235058>] (mmc_start_req+0x58/0x164)
[  240.527893]  r7:deb5d534 r6:00000000 r5:deb5d528 r4:de943800
[  240.533843] [<c0235000>] (mmc_start_req+0x0/0x164) from [<c0240258>] (mmc_blk_issue_rw_rq+0xac/0x36c)
[  240.543518] [<c02401ac>] (mmc_blk_issue_rw_rq+0x0/0x36c) from [<c02416f8>] (mmc_blk_issue_rq+0x408/0x448)
[  240.553558] [<c02412f0>] (mmc_blk_issue_rq+0x0/0x448) from [<c0241bd4>] (mmc_queue_thread+0xbc/0x120)
[  240.563232] [<c0241b18>] (mmc_queue_thread+0x0/0x120) from [<c0050368>] (kthread+0xac/0xb8)
[  240.571990] [<c00502bc>] (kthread+0x0/0xb8) from [<c0013298>] (ret_from_fork+0x14/0x3c)
[  240.580383]  r8:00000000 r7:00000000 r6:00000000 r5:c00502bc r4:de861c24
[  240.587463] INFO: task mount:1408 blocked for more than 120 seconds.
[  240.594116] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  240.602325] mount           D c0353600     0  1408   1364 0x00000000
[  240.609008] Backtrace:
[  240.611572] [<c035324c>] (__schedule+0x0/0x47c) from [<c03537f0>] (schedule+0x84/0x88)
[  240.619873] [<c035376c>] (schedule+0x0/0x88) from [<c035386c>] (io_schedule+0x78/0xa4)
[  240.628173] [<c03537f4>] (io_schedule+0x0/0xa4) from [<c00e3bbc>] (sleep_on_buffer+0x10/0x18)
[  240.637115]  r6:c00e3bac r5:c08fa0dc r4:de0b7d8c r3:00000002
[  240.643066] [<c00e3bac>] (sleep_on_buffer+0x0/0x18) from [<c0351fb4>] (__wait_on_bit+0x5c/0xa4)
[  240.652191] [<c0351f58>] (__wait_on_bit+0x0/0xa4) from [<c035207c>] (out_of_line_wait_on_bit+0x80/0x8c)
[  240.662048] [<c0351ffc>] (out_of_line_wait_on_bit+0x0/0x8c) from [<c00e3b54>] (__wait_on_buffer+0x28/0x30)
[  240.672180] [<c00e3b2c>] (__wait_on_buffer+0x0/0x30) from [<c00e5fb0>] (__bread+0xa0/0xc8)
[  240.680877] [<c00e5f10>] (__bread+0x0/0xc8) from [<c012fed8>] (ext2_fill_super+0x164/0xc18)
[  240.689636]  r5:dd82ae00 r4:de019800
[  240.693389] [<c012fd74>] (ext2_fill_super+0x0/0xc18) from [<c00bce2c>] (mount_bdev+0x124/0x1ac)
[  240.702514] [<c00bcd08>] (mount_bdev+0x0/0x1ac) from [<c012eb70>] (ext2_mount+0x1c/0x28)
[  240.711029] [<c012eb54>] (ext2_mount+0x0/0x28) from [<c00bd7d0>] (mount_fs+0x1c/0xc4)
[  240.719238] [<c00bd7b4>] (mount_fs+0x0/0xc4) from [<c00d5490>] (vfs_kern_mount+0x54/0xc8)
[  240.727813]  r6:00008010 r5:de028380 r4:de0a9780
[  240.732666] [<c00d543c>] (vfs_kern_mount+0x0/0xc8) from [<c00d74e0>] (do_mount+0x744/0x858)
[  240.741424]  r8:de0286c0 r7:00008010 r6:c04bcbc8 r5:de028380 r4:00000020
r3:00000000
[  240.749694] [<c00d6d9c>] (do_mount+0x0/0x858) from [<c00d7680>] (sys_mount+0x8c/0xc0)
[  240.757904] [<c00d75f4>] (sys_mount+0x0/0xc0) from [<c0013200>] (ret_fast_syscall+0x0/0x30)
[  240.766662]  r7:00000015 r6:00083e6c r5:00008010 r4:00000000
[  240.772613] INFO: task mount:1417 blocked for more than 120 seconds.
[  240.779266] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  240.787475] mount           D c0353600     0  1417   1366 0x00000000
[  240.794158] Backtrace:
[  240.796722] [<c035324c>] (__schedule+0x0/0x47c) from [<c03537f0>] (schedule+0x84/0x88)
[  240.805023] [<c035376c>] (schedule+0x0/0x88) from [<c035386c>] (io_schedule+0x78/0xa4)
[  240.813323] [<c03537f4>] (io_schedule+0x0/0xa4) from [<c00e3bbc>] (sleep_on_buffer+0x10/0x18)
[  240.822265]  r6:c00e3bac r5:c08fa9b8 r4:de14bd5c r3:00000002
[  240.828247] [<c00e3bac>] (sleep_on_buffer+0x0/0x18) from [<c0351fb4>] (__wait_on_bit+0x5c/0xa4)
[  240.837371] [<c0351f58>] (__wait_on_bit+0x0/0xa4) from [<c035207c>] (out_of_line_wait_on_bit+0x80/0x8c)
[  240.847229] [<c0351ffc>] (out_of_line_wait_on_bit+0x0/0x8c) from [<c00e3b54>] (__wait_on_buffer+0x28/0x30)
[  240.857360] [<c00e3b2c>] (__wait_on_buffer+0x0/0x30) from [<c00e5fb0>] (__bread+0xa0/0xc8)
[  240.866027] [<c00e5f10>] (__bread+0x0/0xc8) from [<c012517c>] (ext3_fill_super+0x170/0x164c)
[  240.874877]  r5:de0a2800 r4:deb72000
[  240.878631] [<c012500c>] (ext3_fill_super+0x0/0x164c) from [<c00bce2c>] (mount_bdev+0x124/0x1ac)
[  240.887878] [<c00bcd08>] (mount_bdev+0x0/0x1ac) from [<c0122bb0>] (ext3_mount+0x1c/0x28)
[  240.896362] [<c0122b94>] (ext3_mount+0x0/0x28) from [<c00bd7d0>] (mount_fs+0x1c/0xc4)
[  240.904571] [<c00bd7b4>] (mount_fs+0x0/0xc4) from [<c00d5490>] (vfs_kern_mount+0x54/0xc8)
[  240.913146]  r6:00008011 r5:de07a040 r4:de36c3c0
[  240.917999] [<c00d543c>] (vfs_kern_mount+0x0/0xc8) from [<c00d74e0>] (do_mount+0x744/0x858)
[  240.926757]  r8:de07a6c0 r7:00008011 r6:c04bcba4 r5:de07a040 r4:00000060
r3:00000000
[  240.935028] [<c00d6d9c>] (do_mount+0x0/0x858) from [<c00d7680>] (sys_mount+0x8c/0xc0)
[  240.943237] [<c00d75f4>] (sys_mount+0x0/0xc0) from [<c0013200>] (ret_fast_syscall+0x0/0x30)
[  240.951995]  r7:00000015 r6:00083e6c r5:00008011 r4:00000000
[  240.957946] INFO: task mount:1426 blocked for more than 120 seconds.
[  240.964599] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  240.972808] mount           D c0353600     0  1426   1365 0x00000000
[  240.979492] Backtrace:
[  240.982055] [<c035324c>] (__schedule+0x0/0x47c) from [<c03537f0>] (schedule+0x84/0x88)
[  240.990356] [<c035376c>] (schedule+0x0/0x88) from [<c035386c>] (io_schedule+0x78/0xa4)
[  240.998657] [<c03537f4>] (io_schedule+0x0/0xa4) from [<c00e3bbc>] (sleep_on_buffer+0x10/0x18)
[  241.007598]  r6:c00e3bac r5:c08fb5dc r4:de24dd5c r3:00000002
[  241.013580] [<c00e3bac>] (sleep_on_buffer+0x0/0x18) from [<c0351fb4>] (__wait_on_bit+0x5c/0xa4)
[  241.022705] [<c0351f58>] (__wait_on_bit+0x0/0xa4) from [<c035207c>] (out_of_line_wait_on_bit+0x80/0x8c)
[  241.032562] [<c0351ffc>] (out_of_line_wait_on_bit+0x0/0x8c) from [<c00e3b54>] (__wait_on_buffer+0x28/0x30)
[  241.042694] [<c00e3b2c>] (__wait_on_buffer+0x0/0x30) from [<c00e5fb0>] (__bread+0xa0/0xc8)
[  241.051361] [<c00e5f10>] (__bread+0x0/0xc8) from [<c012517c>] (ext3_fill_super+0x170/0x164c)
[  241.060211]  r5:de0ffc00 r4:de01a000
[  241.063964] [<c012500c>] (ext3_fill_super+0x0/0x164c) from [<c00bce2c>] (mount_bdev+0x124/0x1ac)
[  241.073181] [<c00bcd08>] (mount_bdev+0x0/0x1ac) from [<c0122bb0>] (ext3_mount+0x1c/0x28)
[  241.081665] [<c0122b94>] (ext3_mount+0x0/0x28) from [<c00bd7d0>] (mount_fs+0x1c/0xc4)
[  241.089874] [<c00bd7b4>] (mount_fs+0x0/0xc4) from [<c00d5490>] (vfs_kern_mount+0x54/0xc8)
[  241.098449]  r6:00008011 r5:de028700 r4:de0a9540
[  241.103302] [<c00d543c>] (vfs_kern_mount+0x0/0xc8) from [<c00d74e0>] (do_mount+0x744/0x858)
[  241.112060]  r8:de0288c0 r7:00008011 r6:c04bcba4 r5:de028700 r4:00000060
r3:00000000
[  241.120330] [<c00d6d9c>] (do_mount+0x0/0x858) from [<c00d7680>] (sys_mount+0x8c/0xc0)
[  241.128540] [<c00d75f4>] (sys_mount+0x0/0xc0) from [<c0013200>] (ret_fast_syscall+0x0/0x30)
[  241.137298]  r7:00000015 r6:00083e6c r5:00008011 r4:00000000


