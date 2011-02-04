From: Philip Rakity <prakity@marvell.com>
Subject: [BUG] CMD52 sent as first command not CMD0
Date: Fri, 4 Feb 2011 14:53:59 -0800
Message-ID: <C85F98EE-B8C5-4037-A0FF-203265A7575C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:41995 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752631Ab1BDWyG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Feb 2011 17:54:06 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

using mmc-next -- NO changes -- last checkin was from linux Jan 26


[    1.881003] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
[    1.902580] NET: Registered protocol family 17
[    1.916121] Registering the dns_resolver key type
[    1.930357] VFP support v0.3: 
[    1.939016] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    1.962417] implementor 56 architecture 2 part 20 variant 9 rev 5
[    1.980607] ThumbEE CPU extension supported.
[    1.993589] PJ4 iWMMXt coprocessor enabled.
[    2.008449] max8925-rtc max8925-rtc: setting system clock to 2007-02-05 00:51:33 UTC (1170636693)
[    2.034998] mmc0: starting CMD52 arg 00000c00 flags 00000195
[    2.052704] Waiting 15sec before mounting root device...
[    2.068948] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    2.087707] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    2.109069] mmc0: starting CMD52 arg 80000c08 flags 00000195
[    2.126291] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    2.145002] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    2.166321] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0


longer log

[    0.000000] Linux version 2.6.38-rc2-22248-g6663050-dirty (philip@philip-laptop) (gcc version 4.2.0 20070413 (prerelease) (CodeSourcery 2007q1
[    0.000000] CPU: ARMv7 Processor [560f5815] revision 5 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Brownstone Development Platform
[    0.000000] Ignoring unrecognised tag 0x41000403
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 131072
[    0.000000] free_area_init_node: node 0, pgdat c03771c8, node_mem_map c0396000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130048 pages, LIFO batch:31
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: debug rootdelay=15 root=/dev/mmcblk0p1 rootfstype=ext3 console=ttyS2,38400 mem=512M uart_dma mbr_offset=0x48 
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 512MB = 512MB total
[    0.000000] Memory: 516084k/516084k available, 8204k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xe0800000 - 0xfe000000   ( 472 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc001f000   (  92 kB)
[    0.000000]       .text : 0xc001f000 - 0xc035b0f0   (3313 kB)
[    0.000000]       .data : 0xc035c000 - 0xc03789e0   ( 115 kB)
[    0.000000] Preemptable hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000]  Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:320 nr_irqs:360 360
[    0.000000] sched_clock: 32 bits at 6MHz, resolution 153ns, wraps every 660764ms
[    0.000000] Console: colour dummy device 80x30
[    0.000642] Calibrating delay loop... 199.06 BogoMIPS (lpj=995328)
[    0.200611] pid_max: default: 32768 minimum: 301
[    0.201201] Mount-cache hash table entries: 512
[    0.202298] CPU: Testing write buffer coherency: ok
[    0.216586] print_constraints: dummy: 
[    0.217107] NET: Registered protocol family 16
[    0.217256] Tauros2: Disabling L2 prefetch.
[    0.217303] Tauros2: Enabling L2 cache.
[    0.217342] Tauros2: L2 cache support initialised in ARMv7 mode.
[    0.226952] bio: create slab <bio-0> at 0
[    0.229449] max8649 0-0060: Detected MAX8649 (ID:20)
[    0.232597] print_constraints: vcc_core range: 1150 <--> 1280 mV at 1350 mV 
[    0.232809] max8649 0-0060: Max8649 regulator device is detected.
[    0.239168] max8925 0-003c: No interrupt support on TSC IRQ
[    0.240351] I2C: i2c-0: PXA I2C adapter
[    0.242014] Switching to clocksource clocksource
[    0.256623] NET: Registered protocol family 2
[    0.257127] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.258084] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.259147] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.259611] TCP: Hash tables configured (established 16384 bind 16384)
[    0.259659] TCP reno registered
[    0.259707] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.259792] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.260740] NET: Registered protocol family 1
[    0.261823] RPC: Registered udp transport module.
[    0.261872] RPC: Registered tcp transport module.
[    0.261910] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.267089] JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
[    0.267953] msgmni has been set to 1007
[    0.269488] io scheduler noop registered
[    0.269534] io scheduler deadline registered
[    0.269713] io scheduler cfq registered (default)
[    0.270745] pxa2xx-uart.0: ttyS0 at MMIO 0xd4030000 (irq = 27) is a FFUART
[    0.271191] pxa2xx-uart.2: ttyS2 at MMIO 0xd4018000 (irq = 24) is a STUART
[    1.470447] console [ttyS2] enabled
[    1.483131] mousedev: PS/2 mouse device common for all mice
[    1.501122] max8925-rtc max8925-rtc: rtc core: registered max8925-rtc as rtc0
[    1.522800] sdhci: Secure Digital Host Controller Interface driver
[    1.541258] sdhci: Copyright(c) Pierre Ossman
[    1.554557] mmc0: no vmmc regulator found
[    1.566568] sdhci: =========== REGISTER DUMP (mmc0)===========
[    1.583976] sdhci: Sys addr: 0x00000000 | Version:  0x00000002
[    1.601394] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    1.618815] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[    1.636236] sdhci: Present:  0x01ff0000 | Host ctl: 0x00000000
[    1.653654] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[    1.671070] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
[    1.688494] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[    1.705916] sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff0003
[    1.723334] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    1.740752] sdhci: Caps:     0x25fcc8b2 | Caps_1:   0x00002f77
[    1.758174] sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
[    1.775595] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[    1.793010] sdhci: ===========================================
[    1.810666] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
[    1.832358] mmc0: SDHCI controller on MMC [sdhci-pxa.0] using ADMA
[    1.850929] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
[    1.871287] TCP cubic registered
[    1.881003] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
[    1.902580] NET: Registered protocol family 17
[    1.916121] Registering the dns_resolver key type
[    1.930357] VFP support v0.3: 
[    1.939016] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    1.962417] implementor 56 architecture 2 part 20 variant 9 rev 5
[    1.980607] ThumbEE CPU extension supported.
[    1.993589] PJ4 iWMMXt coprocessor enabled.
[    2.008449] max8925-rtc max8925-rtc: setting system clock to 2007-02-05 00:51:33 UTC (1170636693)
[    2.034998] mmc0: starting CMD52 arg 00000c00 flags 00000195
[    2.052704] Waiting 15sec before mounting root device...
[    2.068948] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    2.087707] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    2.109069] mmc0: starting CMD52 arg 80000c08 flags 00000195
[    2.126291] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    2.145002] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    2.166321] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
[    2.190178] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    2.206971] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    2.225689] mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
[    2.246970] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
[    2.270840] mmc0: starting CMD8 arg 000001aa flags 000002f5
[    2.287769] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    2.306484] mmc0: req done (CMD8): 0: 000001aa 00000000 00000000 00000000
[    2.326761] mmc0: starting CMD5 arg 00000000 flags 000002e1
[    2.343734] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    2.362434] mmc0: req failed (CMD5): -110, retrying...
[    2.378087] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    2.396780] mmc0: req failed (CMD5): -110, retrying...
[    2.412441] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    2.431149] mmc0: req failed (CMD5): -110, retrying...
[    2.446788] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    2.465489] mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
[    2.486546] mmc0: starting CMD55 arg 00000000 flags 000000f5
[    2.503754] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    2.522482] mmc0: req done (CMD55): 0: 00400120 00000000 00000000 00000000
[    2.543011] mmc0: starting CMD41 arg 00000000 flags 000000e1
[    2.560182] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[    2.578901] mmc0: req done (CMD41): 0: 40ff8000 00000000 00000000 00000000
[    2.599452] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
[    2.622315] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
[    2.646171] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    2.662972] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001

