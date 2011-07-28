From: takasi-y@ops.dti.ne.jp
Subject: Re: shdma: (or tmio_mmc?) inconsistent lock state detected on
 ag5evm
Date: Thu, 28 Jul 2011 14:47:25 +0900
Message-ID: <20110728144725.67675b6c.takasi-y@ops.dti.ne.jp>
References: <4E2D3733.6080607@renesas.com>
	<Pine.LNX.4.64.1107270946030.7435@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__28_Jul_2011_14_47_25_+0900_c5l0qWdl.SuMULpm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw.cm.dream.jp ([59.157.128.2]:34806 "EHLO vsmtp01.cm.dti.ne.jp"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752732Ab1G1GHj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jul 2011 02:07:39 -0400
In-Reply-To: <Pine.LNX.4.64.1107270946030.7435@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__28_Jul_2011_14_47_25_+0900_c5l0qWdl.SuMULpm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thank you for your reply.

> Thanks for the report! It is interesting. From your backtrace it looks 
> like the spin_lock_bh() in sh_dmae_alloc_chan_resources() gets interrupted 
> by an interrupt on the same channel! I do not understand this, because, 
> normally no interrupts on DMAC channels occur until data transfers begin 
> over them.
Right. The message/trace looks as if things happen in unexpected order.
But after tracing, I found the order is not really bad.
1. sh_dmae_alloc_chan_resources() called and returned
2. sh_dmae_memcpy_issue_pending() -> sh_chan_xfer_ld_queue() -> dma_start()
3. sh_dmae_interrupt() invoked
4. the INFO message printed.

Perhaps lockdep issue, or more possibly I've miss-understood the meaning of the
 checking system and the message?
 
> So, a simple fix would be to replace calls to spin_(un)lock_bh() with 
> spin_(un)lock_irq() in sh_dmae_alloc_chan_resources(), 
Yeah! Now it moved to sh_dmae_prep_sg()
  [<c06b6b50>] __lock_acquire+0x5c4/0xbb4
  [<c06b7718>] lock_acquire+0x60/0x74
  [<c08bce9c>] _raw_spin_lock_bh+0x3c/0x4c
  [<c07c3a5c>] sh_dmae_prep_sg+0x110/0x29c
  [<c07c3c34>] sh_dmae_prep_slave_sg+0x4c/0x88
  [<c0815184>] tmio_mmc_start_dma+0x30c/0x3bc
  [<c0813fd4>] tmio_mmc_request+0xe0/0x2d8
  [<c0807bbc>] mmc_wait_for_req+0x12c/0x184
  [<c080ca0c>] mmc_app_send_scr+0x15c/0x1e0
  [<c080b284>] mmc_sd_setup_card+0x80/0x4a8
  [<c080bb20>] mmc_sd_init_card+0xcc/0x664
  [<c080c190>] mmc_attach_sd+0xd8/0x228
  [<c08078f8>] mmc_rescan+0x24c/0x3e4
  [<c06992ec>] process_one_work+0x170/0x4c4
  [<c06999d4>] worker_thread+0x19c/0x470
  [<c06a041c>] kthread+0x8c/0x90
  [<c06675a8>] kernel_thread_exit+0x0/0x8

And then s/_bh/_irq/ in sh_dmae_prep_sg(), it moved to sh_dmae_tx_submit()...
  [<c06b6b50>] __lock_acquire+0x5c4/0xbb4
  [<c06b7718>] lock_acquire+0x60/0x74
  [<c08bce9c>] _raw_spin_lock_bh+0x3c/0x4c
  [<c07c318c>] sh_dmae_tx_submit+0x30/0x138
  [<c0815194>] tmio_mmc_start_dma+0x31c/0x3bc
  ...

> .. but I would like to 
> understand, what kind of interrupts are occurring at that time and why. 
> Could you please apply the attached below debugging patch and send me the 
> resulting complete dmesg output?
Sure. Attached. Nothing seems to have happened, though.

> .. Alternatively, you can choose to wait 
> until a detailed SMP testing of the SDHI driver takes place, hopefully, in 
> approximately a week or a bit more.
That sounds promising! I would be happy if you spend more time on it than this issue.
I think I will study this some more on dma side.
Thank you. And sorry for bothering.
/yoshii

--Multipart=_Thu__28_Jul_2011_14_47_25_+0900_c5l0qWdl.SuMULpm
Content-Type: text/plain;
 name="dmesg_test_ld_queue.txt"
Content-Disposition: attachment;
 filename="dmesg_test_ld_queue.txt"
Content-Transfer-Encoding: 7bit

Linux version 3.0.0-00004-g65ae30f-dirty (yoshii@genny) (gcc version 4.4.1 (SG++Re-Built 4.4-93) ) #3701 SMP Wed Jul 27 21:56:24 JST 2011
CPU: ARMv7 Processor [412fc098] revision 8 (ARMv7), cr=10c5347f
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: ag5evm
Memory policy: ECC disabled, Data cache writealloc
bootconsole [early_ttySC2] enabled
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat c09a7cc0, node_mem_map c0ec7000
  Normal zone: 960 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 121920 pages, LIFO batch:31
  HighMem zone: 64 pages used for memmap
  HighMem zone: 8128 pages, LIFO batch:0
PERCPU: Embedded 7 pages/cpu @c12cf000 s4608 r8192 d15872 u32768
pcpu-alloc: s4608 r8192 d15872 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttySC2,115200 earlyprintk=sh-sci.2 memchunk.ceu0=4M debug
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 512MB = 512MB total
Memory: 504572k/504572k available, 19716k reserved, 32768K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xf6000000 - 0xffe00000   ( 158 MB)
    vmalloc : 0xde800000 - 0xe6000000   ( 120 MB)
    lowmem  : 0xc0000000 - 0xde000000   ( 480 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .init : 0xc0008000 - 0xc0660000   (6496 kB)
      .text : 0xc0660000 - 0xc097e99c   (3195 kB)
      .data : 0xc0980000 - 0xc09a8860   ( 163 kB)
       .bss : 0xc09a8884 - 0xc0ec6490   (5240 kB)
Hierarchical RCU implementation.
NR_IRQS:1024 nr_irqs:1024 1024
intc: Registered controller 'sh73a0-intcs' with 77 IRQs
Console: colour dummy device 80x30
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3695 kB
 per task-struct memory footprint: 1152 bytes
 sh_tmu.0: used for clock events
 sh_tmu.0: used for periodic clock events
 sh_tmu.1: used as clock source
Calibrating delay loop... 72.46 BogoMIPS (lpj=282624)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Calibrating local timer... 98.28MHz.
CPU1: failed to come online
Brought up 1 CPUs
SMP: Total of 1 processors activated (72.46 BogoMIPS).
NET: Registered protocol family 16
pfc: sh73a0_pfc handling gpio 0 -> 908
L310 cache controller enabled
l2x0: 8 ways, CACHE_ID 0x410000c7, AUX_CTRL 0x02460000, Cache size: 524288 B
bio: create slab <bio-0> at 0
i2c-sh_mobile i2c-sh_mobile.0: I2C adapter 0 with bus speed 100000 Hz
i2c-sh_mobile i2c-sh_mobile.1: I2C adapter 1 with bus speed 100000 Hz
i2c-sh_mobile i2c-sh_mobile.2: I2C adapter 2 with bus speed 100000 Hz
i2c-sh_mobile i2c-sh_mobile.3: I2C adapter 3 with bus speed 100000 Hz
i2c-sh_mobile i2c-sh_mobile.4: I2C adapter 4 with bus speed 100000 Hz
Switching to clocksource sh_tmu.1
platform sh_tmu.0: used for oneshot clock events
Switched to NOHz mode on CPU #0
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 7, 589824 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
UDP hash table entries: 256 (order: 2, 20480 bytes)
UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
highmem bounce pool size: 64 pages
msgmni has been set to 921
io scheduler noop registered (default)
start plist test
end plist test
Console: switching to colour frame buffer device 68x60
graphics fb0: registered sh_mobile_lcdc_fb/mainlcd as 544x961 16bpp.
SuperH SCI(F) driver initialized
sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 104) is a scifa
console [ttySC2] enabled, bootconsole disabled
sh-sci.1: ttySC1 at MMIO 0xe6c50000 (irq = 105) is a scifa
sh-sci.2: ttySC2 at MMIO 0xe6c60000 (irq = 106) is a scifa
sh-sci.3: ttySC3 at MMIO 0xe6c70000 (irq = 107) is a scifa
sh-sci.4: ttySC4 at MMIO 0xe6c80000 (irq = 110) is a scifa
sh-sci.5: ttySC5 at MMIO 0xe6cb0000 (irq = 111) is a scifa
sh-sci.6: ttySC6 at MMIO 0xe6cc0000 (irq = 188) is a scifa
sh-sci.7: ttySC7 at MMIO 0xe6cd0000 (irq = 175) is a scifa
sh-sci.8: ttySC8 at MMIO 0xe6c30000 (irq = 112) is a scifb
smsc911x: Driver version 2008-10-21
smsc911x-mdio: probed
smsc911x smsc911x.0: eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=0:01, irq=-1)
smsc911x smsc911x.0: eth0: MAC Address: 02:00:00:73:a0:02
mousedev: PS/2 mouse device common for all mice
sh_mobile_sdhi sh_mobile_sdhi.0: mmc0 base at 0xee100000 clock rate 69 MHz
sh_mobile_sdhi sh_mobile_sdhi.1: mmc1 base at 0xee120000 clock rate 69 MHz
sh_cmt sh_cmt.10: used for clock events
sh_cmt sh_cmt.10: used as clock source
sh_tmu sh_tmu.0: kept as earlytimer
sh_tmu sh_tmu.1: kept as earlytimer
TCP cubic registered
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 2
Freeing init memory: 6496K

=================================
[ INFO: inconsistent lock state ]
3.0.0-00004-g65ae30f-dirty #3701
---------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
mdev/284 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&(&new_sh_chan->desc_lock)->rlock){?.-...}, at: [<c07c3014>] sh_dmae_interrupt+0x14/0xb0
{HARDIRQ-ON-W} state was registered at:
  [<c06b6b50>] __lock_acquire+0x5c4/0xbb4
  [<c06b7718>] lock_acquire+0x60/0x74
  [<c08bce9c>] _raw_spin_lock_bh+0x3c/0x4c
  [<c07c4014>] sh_dmae_alloc_chan_resources+0x1d0/0x2bc
  [<c07c1d20>] dma_chan_get+0xd8/0x17c
  [<c07c25d8>] __dma_request_channel+0x140/0x1e4
  [<c0814d00>] tmio_mmc_request_dma+0x74/0x10c
  [<c08b5f98>] tmio_mmc_host_probe+0x228/0x2cc
  [<c08b618c>] sh_mobile_sdhi_probe+0x150/0x274
  [<c07eaa24>] platform_drv_probe+0x18/0x1c
  [<c07e957c>] driver_probe_device+0x9c/0x1a4
  [<c07e9718>] __driver_attach+0x94/0x98
  [<c07e8d48>] bus_for_each_dev+0x60/0x8c
  [<c07e8530>] bus_add_driver+0xa8/0x2a4
  [<c07e9d14>] driver_register+0x78/0x18c
  [<c0660530>] do_one_initcall+0x34/0x184
  [<c00083d8>] kernel_init+0xa8/0x134
  [<c06675a8>] kernel_thread_exit+0x0/0x8
irq event stamp: 11477
hardirqs last  enabled at (11476): [<c08bbecc>] mutex_lock_nested+0x298/0x350
hardirqs last disabled at (11477): [<c0666674>] __irq_svc+0x34/0xa0
softirqs last  enabled at (11395): [<c06897a4>] irq_exit+0xa0/0xa4
softirqs last disabled at (11380): [<c06897a4>] irq_exit+0xa0/0xa4

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&new_sh_chan->desc_lock)->rlock);
  <Interrupt>
    lock(&(&new_sh_chan->desc_lock)->rlock);

 *** DEADLOCK ***

1 lock held by mdev/284:
 #0:  (sysfs_mutex){+.+.+.}, at: [<c075175c>] sysfs_permission+0x34/0x64

stack backtrace:
[<c066c730>] (unwind_backtrace+0x0/0xfc) from [<c06b3378>] (print_usage_bug+0x21c/0x2bc)
[<c06b3378>] (print_usage_bug+0x21c/0x2bc) from [<c06b3928>] (mark_lock+0x510/0x740)
[<c06b3928>] (mark_lock+0x510/0x740) from [<c06b6bc4>] (__lock_acquire+0x638/0xbb4)
[<c06b6bc4>] (__lock_acquire+0x638/0xbb4) from [<c06b7718>] (lock_acquire+0x60/0x74)
[<c06b7718>] (lock_acquire+0x60/0x74) from [<c08bcc88>] (_raw_spin_lock+0x34/0x44)
[<c08bcc88>] (_raw_spin_lock+0x34/0x44) from [<c07c3014>] (sh_dmae_interrupt+0x14/0xb0)
[<c07c3014>] (sh_dmae_interrupt+0x14/0xb0) from [<c06c5f70>] (handle_irq_event_percpu+0x54/0x184)
[<c06c5f70>] (handle_irq_event_percpu+0x54/0x184) from [<c06c60dc>] (handle_irq_event+0x3c/0x5c)
[<c06c60dc>] (handle_irq_event+0x3c/0x5c) from [<c06c8708>] (handle_fasteoi_irq+0x9c/0x104)
[<c06c8708>] (handle_fasteoi_irq+0x9c/0x104) from [<c06c5f0c>] (generic_handle_irq+0x28/0x30)
[<c06c5f0c>] (generic_handle_irq+0x28/0x30) from [<c0660058>] (asm_do_IRQ+0x58/0xb8)
[<c0660058>] (asm_do_IRQ+0x58/0xb8) from [<c0671aec>] (shmobile_handle_irq_gic+0xc/0x80)
Exception stack(0xddb21d78 to 0xddb21dc0)
1d60:                                                       00000000 00000001
1d80: dd98d108 dd4b46e8 00000000 00000000 dd4b46e8 00000001 dd85c808 ddb20000
1da0: 00000015 ddb21e14 00000008 ddb21dc0 c0751768 c0751704 a0000013 ffffffff
[<c0671aec>] (shmobile_handle_irq_gic+0xc/0x80) from [<00000001>] (0x1)
mmc0: new high speed SD card at address b368
mmcblk0: mmc0:b368 SDC   489 MiB 
 mmcblk0: p1
smsc911x smsc911x.0: eth0: SMSC911x/921x identified at 0xde860000, IRQ: 65
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD5)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD5)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD55)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD55)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD55)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD55)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD1)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD5)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD55)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD55)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD55)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD55)
sh_mobile_sdhi sh_mobile_sdhi.1: timeout waiting for hardware interrupt (CMD1)

--Multipart=_Thu__28_Jul_2011_14_47_25_+0900_c5l0qWdl.SuMULpm--
