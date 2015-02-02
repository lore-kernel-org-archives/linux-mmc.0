From: Jonas Jensen <jonas.jensen@gmail.com>
Subject: Re: [PATCH v2] mmc: moxart: fix probe logic
Date: Mon, 2 Feb 2015 11:52:44 +0100
Message-ID: <CACmBeS0RGJUzqztQLZtHyTYgCd=jpAoYYk-roH7_VLbfy-+ftw@mail.gmail.com>
References: <8340872.32GezMfzR1@wuerfel>
	<20150129170104.GD26493@n2100.arm.linux.org.uk>
	<1862200.Pj3heKAtuk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:48547 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbbBBKwq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Feb 2015 05:52:46 -0500
Received: by mail-la0-f52.google.com with SMTP id ge10so39439923lab.11
        for <linux-mmc@vger.kernel.org>; Mon, 02 Feb 2015 02:52:44 -0800 (PST)
In-Reply-To: <1862200.Pj3heKAtuk@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Thanks for taking the time.


On 29 January 2015 at 23:06, Arnd Bergmann <arnd@arndb.de> wrote:
> Jonas Jensen wanted to submit a patch for these, but apparently
> forgot about it. I stumbled over this symptom first:

Sorry about this, I remember thinking about the changes but only made
a mental note (which was lost over time). I was sidetracked with other
changes and work.


> @@ -586,10 +586,10 @@ static int moxart_probe(struct platform_device =
*pdev)
>                 goto out;
>         }
>
> -       clk =3D of_clk_get(node, 0);
> -       if (IS_ERR(clk)) {
> +       host->clk =3D of_clk_get(node, 0);

host->clk is a NULL dereference at this point in probe() (log below).

I moved the single line "host =3D mmc_priv(mmc);" to happen just before=
,
and everything is working normally again.


Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.17.0-00628-g572d48d-dirty (i@Ildjarn)
(gcc version 4.9.1 (crosstool-NG 1.20.0) ) #3509 PREEMPT Mon Feb 2
10:57:21 CET 2015
[    0.000000] CPU: FA526 [66015261] revision 1 (ARMv4), cr=3D0000397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: MOXA UC-7112-LX
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 8192
[    0.000000] free_area_init_node: node 0, pgdat c03633c4,
node_mem_map c1fba000
[    0.000000]   Normal zone: 64 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 8192 pages, LIFO batch:0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 8128
[    0.000000] Kernel command line: console=3DttyS0,115200n8 earlyprint=
k
root=3D/dev/mmcblk0p1 rw rootwait debug
[    0.000000] PID hash table entries: 128 (order: -3, 512 bytes)
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 b=
ytes)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 byt=
es)
[    0.000000] Memory: 28824K/32768K available (2710K kernel code, 94K
rwdata, 508K rodata, 116K init, 125K bss, 3944K reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xc2800000 - 0xff000000   ( 968 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
[    0.000000]       .text : 0xc0008000 - 0xc032ccd0   (3220 kB)
[    0.000000]       .init : 0xc032d000 - 0xc034a390   ( 117 kB)
[    0.000000]       .data : 0xc034c000 - 0xc0363b20   (  95 kB)
[    0.000000]        .bss : 0xc0363b20 - 0xc03831c8   ( 126 kB)
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D=
1, Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns,
wraps every 21474836480000000ns
[    0.010000] Calibrating delay loop... 146.84 BogoMIPS (lpj=3D734208)
[    0.100000] pid_max: default: 4096 minimum: 301
[    0.100000] Mount-cache hash table entries: 1024 (order: 0, 4096 byt=
es)
[    0.110000] Mountpoint-cache hash table entries: 1024 (order: 0, 409=
6 bytes)
[    0.120000] CPU: Testing write buffer coherency: ok
[    0.130000] Setting up static identity map for 0x2955c8 - 0x295610
[    0.150000] devtmpfs: initialized
[    0.170000] NET: Registered protocol family 16
[    0.180000] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.280000] Switched to clocksource moxart_timer
[    0.290000] NET: Registered protocol family 2
[    0.300000] TCP established hash table entries: 1024 (order: 0, 4096=
 bytes)
[    0.310000] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.320000] TCP: Hash tables configured (established 1024 bind 1024)
[    0.330000] TCP: reno registered
[    0.330000] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.340000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.350000] NET: Registered protocol family 1
[    0.360000] futex hash table entries: 16 (order: -5, 192 bytes)
[    0.410000] jffs2: version 2.2. (NAND) =C3=82=C2=A9 2001-2006 Red Ha=
t, Inc.
[    0.420000] msgmni has been set to 56
[    0.430000] io scheduler noop registered
[    0.430000] io scheduler cfq registered (default)
[    0.440000] gpiochip_find_base: found new base at 224
[    0.440000] gpiochip_add: registered GPIOs 224 to 255 on device: mox=
art-gpio
[    0.450000] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
[    0.470000] console [ttyS0] disabled
[    0.470000] 98200000.uart0: ttyS0 at MMIO 0x98200000 (irq =3D 21,
base_baud =3D 921600) is a 16550A
[    0.480000] console [ttyS0] enabled
[    0.480000] console [ttyS0] enabled
[    0.490000] bootconsole [earlycon0] disabled
[    0.490000] bootconsole [earlycon0] disabled
[    0.500000] MOXA Smartio/Industio family driver version 2.0.5
[    0.510000] mxser: found MOXA UC-7112-LX board (CAP=3D0x0)
[    0.510000] ttyMX0 at I/O 0xf9820040 (irq =3D 21, base_baud =3D 0) i=
s a 16550A
[    0.520000] ttyMX1 at I/O 0xf9820060 (irq =3D 21, base_baud =3D 0) i=
s a 16550A
[    0.530000] mxser: mxser_initbrd success IRQ=3D21 max baud=3D921600 =
bps
[    0.570000] loop: module loaded
[    0.600000] 80000000.flash: Found 1 x16 devices at 0x0 in 16-bit
bank. Manufacturer ID 0x000089 Chip ID 0x000018
[    0.610000] Intel/Sharp Extended Query Table at 0x0031
[    0.620000] Intel/Sharp Extended Query Table at 0x0031
[    0.620000] Using buffer write method
[    0.620000] cfi_cmdset_0001: Erase suspend on write enabled
[    0.630000] erase region 0: offset=3D0x0,size=3D0x20000,blocks=3D128
[    0.640000] 4 ofpart partitions found on MTD device 80000000.flash
[    0.640000] Creating 4 MTD partitions on "80000000.flash":
[    0.650000] 0x000000000000-0x000000040000 : "bootloader"
[    0.660000] 0x000000040000-0x000000200000 : "linux kernel"
[    0.680000] 0x000000200000-0x000000a00000 : "root filesystem"
[    0.690000] 0x000000a00000-0x000001000000 : "user filesystem"
[    1.300000] libphy: MOXA ART Ethernet MII: probed
[    1.920000] libphy: MOXA ART Ethernet MII: probed
[    1.960000] of_get_named_gpiod_flags: parsed 'gpios' property of
node '/gpio_keys_polled/button@25[0]' - status (0)
[    1.970000] gpiod_request: __gpiod_request() status=3D0
[    1.970000] input: gpio_keys_polled as /devices/gpio_keys_polled/inp=
ut/input0
[    1.980000] evbug: Connected device: input0 (gpio_keys_polled at
gpio-keys-polled/input0)
[    1.990000] of_get_named_gpiod_flags: parsed 'gpio-rtc-data'
property of node '/soc/rtc[0]' - status (0)
[    2.000000] of_get_named_gpiod_flags: parsed 'gpio-rtc-sclk'
property of node '/soc/rtc[0]' - status (0)
[    2.010000] of_get_named_gpiod_flags: parsed 'gpio-rtc-reset'
property of node '/soc/rtc[0]' - status (0)
[    2.020000] gpiod_request: __gpiod_request() status=3D0
[    2.030000] gpiod_request: __gpiod_request() status=3D0
[    2.030000] gpiod_request: __gpiod_request() status=3D0
[    2.040000] moxart-rtc 90000000.soc:rtc: rtc core: registered
90000000.soc:rtc as rtc0
[    2.060000] Unable to handle kernel NULL pointer dereference at
virtual address 00000020
[    2.070000] pgd =3D c0004000
[    2.070000] [00000020] *pgd=3D00000000
[    2.070000] Internal error: Oops: 805 [#1] PREEMPT ARM
[    2.070000] CPU: 0 PID: 1 Comm: swapper Not tainted
3.17.0-00628-g572d48d-dirty #3509
[    2.070000] task: c1828000 ti: c182a000 task.ti: c182a000
[    2.070000] PC is at moxart_probe+0xa0/0x378
[    2.070000] LR is at of_clk_get_by_clkspec+0x38/0x48
[    2.070000] pc : [<c01a241c>]    lr : [<c01b2de4>]    psr: 80000013
[    2.070000] sp : c182be10  ip : c182a000  fp : 00000000
[    2.070000] r10: c0363b20  r9 : 00000012  r8 : c1862100
[    2.070000] r7 : c1862110  r6 : c1fb831c  r5 : 00000000  r4 : c18d54=
00
[    2.070000] r3 : 00000000  r2 : 00000001  r1 : c18090c0  r0 : c18090=
c0
[    2.070000] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    2.070000] Control: 0000397f  Table: 00004000  DAC: 00000017
[    2.070000] Process swapper (pid: 1, stack limit =3D 0xc182a1c0)
[    2.070000] Stack: (0xc182be10 to 0xc182c000)
[    2.070000] be00:                                     c198a860
c198a860 c03795d0 00000004
[    2.070000] be20: 98e00000 98e00fff c1fb8374 00000200 00000000
00000000 00000000 c00da538
[    2.070000] be40: c1991870 c1991910 00000001 c1991910 c02fe5f3
c1861820 c1991870 00000001
[    2.070000] be60: c03466bc c1862110 c035c5f4 c035c5f4 c037d5f0
00000000 c03466bc c0363b20
[    2.070000] be80: 00000000 c016e940 c016e914 c1862110 c1862144
c016d9ac c1862110 c1862144
[    2.070000] bea0: c035c5f4 c035a648 c03466bc c016db9c 00000000
c035c5f4 c016db34 c016c4bc
[    2.070000] bec0: c1807f4c c18565d0 c035c5f4 00000000 c197ea80
c016cc00 c030404e c0304050
[    2.070000] bee0: 00000000 c035c5f4 c033c6d8 c182a008 00000000
c016e0c8 00000000 c198a800
[    2.070000] bf00: c033c6d8 c032dc5c c1809f60 c1856000 c1856000
c0296be0 c0375a00 00000000
[    2.070000] bf20: 00000000 c00d2320 c02eedd6 c1809f60 c0314584
00000000 c1ffce23 c0027ab0
[    2.070000] bf40: c0314584 0000003d 00000006 00000006 00000000
00000006 0000003d 00000006
[    2.070000] bf60: 0000003d c0346ee8 c034a29c c0363b20 c0346ef0
c032de08 00000006 00000006
[    2.070000] bf80: c032d50c c182a000 00000000 c028eee8 00000000
00000000 00000000 00000000
[    2.070000] bfa0: 00000000 c028eef0 00000000 c0009230 00000000
00000000 00000000 00000000
[    2.070000] bfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    2.070000] bfe0: 00000000 00000000 00000000 00000000 00000013
00000000 ffffffff ffffffff
[    2.070000] [<c01a241c>] (moxart_probe) from [<c016e940>]
(platform_drv_probe+0x2c/0x60)
[    2.070000] [<c016e940>] (platform_drv_probe) from [<c016d9ac>]
(driver_probe_device+0xa8/0x1e8)
[    2.070000] [<c016d9ac>] (driver_probe_device) from [<c016db9c>]
(__driver_attach+0x68/0x88)
[    2.070000] [<c016db9c>] (__driver_attach) from [<c016c4bc>]
(bus_for_each_dev+0x70/0x94)
[    2.070000] [<c016c4bc>] (bus_for_each_dev) from [<c016cc00>]
(bus_add_driver+0xd0/0x1b8)
[    2.070000] [<c016cc00>] (bus_add_driver) from [<c016e0c8>]
(driver_register+0x9c/0xe0)
[    2.070000] [<c016e0c8>] (driver_register) from [<c032dc5c>]
(do_one_initcall+0x108/0x1bc)
[    2.070000] [<c032dc5c>] (do_one_initcall) from [<c032de08>]
(kernel_init_freeable+0xf8/0x1b0)
[    2.070000] [<c032de08>] (kernel_init_freeable) from [<c028eef0>]
(kernel_init+0x8/0xe0)
[    2.070000] [<c028eef0>] (kernel_init) from [<c0009230>]
(ret_from_fork+0x14/0x24)
[    2.070000] Code: e1a00006 e1a01005 eb004276 e3700a01 (e5850020)
[    2.080000] ---[ end trace b4cd6d53de4c770d ]---
[    2.090000] Kernel panic - not syncing: Fatal exception
[    2.090000] Rebooting in 10 seconds..


Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
