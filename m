From: Paul Schilling <paul.s.schilling@gmail.com>
Subject: mmc0: Too large timeout requested for CMD38!
Date: Fri, 18 Nov 2011 16:59:53 -0600
Message-ID: <CAC=G6swWj3=eUYUczCqcNJq7Nj177nis4817+bg-qS0dUic=Xg@mail.gmail.com>
References: <CAC=G6szdK=6wR4xiZk9mhBofEf7DHeuAcpeeTiVCdiK1aUyeOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42173 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002Ab1KRW7y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2011 17:59:54 -0500
Received: by vcbfk1 with SMTP id fk1so3770889vcb.19
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2011 14:59:53 -0800 (PST)
In-Reply-To: <CAC=G6szdK=6wR4xiZk9mhBofEf7DHeuAcpeeTiVCdiK1aUyeOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I am getting the following error when trying to use a swap file on a
large 32GB SD card formated with EXT4.

Thanks,
Paul Schilling

Swap file /external_flash_a/swap_file being enabled.
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
Adding 131068k swap on /external_flash_a/swap_file.=A0 Priority:-1
extents:3 across:135104k SS



Linux version 3.2.0-rc2+ (#######) (gcc version 4.3.3 (GCC) ) #77
PREEMPT Fri Nov 18 13:37:37 CST 2011
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: CONDOR2416
Memory policy: ECC disabled, Data cache writeback
CPU S3C2416/S3C2450 (id 0x32450003)
S3C24XX Clocks, Copyright 2004 Simtec Electronics
CPU: MPLL on 800.000 MHz, cpu 400.000 MHz, mem 133.333 MHz, pclk 66.666=
 MHz
CPU: EPLL on 96.000 MHz, usb-bus 48.000 MHz
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c051b06c, node_mem_map c0550000
=A0 Normal zone: 384 pages used for memmap
=A0 Normal zone: 0 pages reserved
=A0 Normal zone: 32384 pages, LIFO batch:7
pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
pcpu-alloc: [0] 0
Built 1 zonelists in Zone order, mobility grouping on.=A0 Total pages: =
32384
Kernel command line: console=3DttySAC0,115200 loglevel=3D8
s3cfb=3Ddev:0,depth:16,xres:480,
yres:272,vslen:60,hslen:17,left:41,right:68,upper:26,lower:6,pixclock:0
root=3D/dev/mtdblock4 rw rootfstype=3Djffs2 ethaddr=3D12:23:34:88:99:00
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 64MB 64MB =3D 128MB total
Memory: 124472k/124472k available, 6600k reserved, 0K highmem
Virtual kernel memory layout:
=A0=A0=A0 vector=A0 : 0xffff0000 - 0xffff1000=A0=A0 (=A0=A0 4 kB)
=A0=A0=A0 fixmap=A0 : 0xfff00000 - 0xfffe0000=A0=A0 ( 896 kB)
=A0=A0=A0 vmalloc : 0xcc800000 - 0xf6000000=A0=A0 ( 664 MB)
=A0=A0=A0 lowmem=A0 : 0xc0000000 - 0xcc000000=A0=A0 ( 192 MB)
=A0=A0=A0 modules : 0xbf000000 - 0xc0000000=A0=A0 (=A0 16 MB)
=A0=A0=A0=A0=A0 .text : 0xc0008000 - 0xc0492ec4=A0=A0 (4652 kB)
=A0=A0=A0=A0=A0 .init : 0xc0493000 - 0xc04f2000=A0=A0 ( 380 kB)
=A0=A0=A0=A0=A0 .data : 0xc04f2000 - 0xc051b700=A0=A0 ( 166 kB)
=A0=A0=A0=A0=A0=A0 .bss : 0xc051b724 - 0xc054f6c4=A0=A0 ( 208 kB)
SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D=
1, Nodes=3D1
NR_IRQS:99
irq: clearing subpending status 00000002
timer tcon=3D00500000, tcnt 2b66, tcfg 00000200,00000000, usec 0000170a
Console: colour dummy device 80x30
Calibrating delay loop... 197.88 BogoMIPS (lpj=3D98944)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
s3c_fb_setup: option dev:0
s3c_fb_setup: option depth:16
s3c_fb_setup: option xres:480
s3c_fb_setup: option yres:272
s3c_fb_setup: option vslen:60
s3c_fb_setup: option hslen:17
s3c_fb_setup: option left:41
s3c_fb_setup: option right:68
s3c_fb_setup: option upper:26
s3c_fb_setup: option lower:6
s3c_fb_setup: option pixclock:0
Condor2416:=A0 Start Set DM9K
S3C Power Management, Copyright 2004 Simtec Electronics
S3C2416: Initializing architecture
S3C2416: IRQ Support
S3C24XX DMA Driver, Copyright 2003-2006 Simtec Electronics
DMA channel 0 at cc804000, irq 88
DMA channel 1 at cc804100, irq 89
DMA channel 2 at cc804200, irq 90
DMA channel 3 at cc804300, irq 91
DMA channel 4 at cc804400, irq 92
DMA channel 5 at cc804500, irq 93
s3c24xx-pwm s3c24xx-pwm.0: tin at 33333333, tdiv at 33333333, tin=3Ddiv=
clk, base 0
bio: create slab <bio-0> at 0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
s3c-i2c s3c2410-i2c: slave address 0x10
s3c-i2c s3c2410-i2c: bus frequency set to 65 KHz
s3c-i2c s3c2410-i2c: i2c-0: S3C I2C adapter
Advanced Linux Sound Architecture Driver Version 1.0.24.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
s3c-adc s3c-adc: attached adc driver
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) (SUMMARY)=A0 =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 243
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
Console: switching to colour frame buffer device 60x34
s3c-fb s3c-fb: window 0: fb
s3c2440-uart s3c2440-uart.0: port TX GPIO (-1)
s3c2440-uart s3c2440-uart.0: port TX GPIO (-1)
s3c2440-uart.0: ttySAC0 at MMIO 0x50000000 (irq =3D 70) is a S3C2440
console [ttySAC0] enabled
s3c2440-uart s3c2440-uart.1: port TX GPIO (13)
s3c2440-uart s3c2440-uart.1: port TX GPIO (12)
s3c2440-uart s3c2440-uart.1: Enable Hi Res Timer
s3c2440-uart s3c2440-uart.1: Port (1) 485 Enabled
s3c2440-uart.1: ttySAC1 at MMIO 0x50004000 (irq =3D 73) is a S3C2440
s3c2440-uart s3c2440-uart.1: Initialize TX(1) GPIO
s3c2440-uart s3c2440-uart.1: Initialize RX(1) GPIO
s3c2440-uart s3c2440-uart.2: port TX GPIO (42)
s3c2440-uart s3c2440-uart.2: port TX GPIO (41)
s3c2440-uart s3c2440-uart.2: Enable Hi Res Timer
s3c2440-uart s3c2440-uart.2: Port (2) 485 Enabled
s3c2440-uart.2: ttySAC2 at MMIO 0x50008000 (irq =3D 76) is a S3C2440
s3c2440-uart s3c2440-uart.2: Initialize TX(2) GPIO
s3c2440-uart s3c2440-uart.2: Initialize RX(2) GPIO
s3c2440-uart s3c2440-uart.3: port TX GPIO (-1)
s3c2440-uart s3c2440-uart.3: port TX GPIO (-1)
s3c2440-uart.3: ttySAC3 at MMIO 0x5000c000 (irq =3D 94) is a S3C2440
brd: module loaded
at24 0-0050: 512 byte 24c04 EEPROM, writable, 16 bytes/write
mtdoops: mtd device (mtddev=3Dname/number) must be supplied
S3C24XX NAND Driver, (c) 2004 Simtec Electronics
s3c24xx-nand s3c2412-nand: Tacls=3D3, 22ns Twrph0=3D8 60ns, Twrph1=3D3 =
22ns
s3c24xx-nand s3c2412-nand: System booted from NAND
s3c24xx-nand s3c2412-nand: NAND soft ECC
NAND device: Manufacturer ID: 0xec, Chip ID: 0xda (Samsung NAND 256MiB
3,3V 8-bit)
Scanning device for bad blocks
Bad eraseblock 0 at 0x000000000000
Bad eraseblock 1 at 0x000000020000
Bad eraseblock 864 at 0x000006c00000
Bad eraseblock 1304 at 0x00000a300000
Bad eraseblock 1336 at 0x00000a700000
Creating 5 MTD partitions on "NAND":
0x000000000000-0x000000040000 : "u-boot"
0x000000040000-0x000000060000 : "u-boot-env"
0x000000060000-0x000000560000 : "kernel"
0x000000560000-0x000000660000 : "log"
0x000000660000-0x000010000000 : "root"
dm9000 Ethernet Driver, V1.31
eth0: dm9000a at cc85e300,cc860308 IRQ 53 MAC: 12:23:34:88:99:00 (platf=
orm data)
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
s3c2410-ohci s3c2410-ohci: S3C24XX OHCI
s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number =
1
s3c2410-ohci s3c2410-ohci: irq 42, io mem 0x49000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new interface driver libusual
mousedev: PS/2 mouse device common for all mice
input: matrix-keypad as /devices/platform/matrix-keypad/input/input0
S3C24XX RTC, (c) 2004,2006 Simtec Electronics
s3c-rtc s3c2410-rtc: rtc disabled, re-enabling
s3c-rtc s3c2410-rtc: rtc core: registered s3c as rtc0
i2c /dev entries driver
S3C2410 Watchdog Timer, (c) 2004 Simtec Electronics
s3c2410-wdt s3c2410-wdt: watchdog inactive, reset disabled, irq enabled
cpuidle: using governor ladder
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
s3c-sdhci s3c-sdhci.1: clock source 0: hsmmc (133333333 Hz)
s3c-sdhci s3c-sdhci.1: clock source 1: hsmmc (133333333 Hz)
s3c-sdhci s3c-sdhci.1: clock source 2: hsmmc-if (96000000 Hz)
Registered led device: mmc0::
mmc0: SDHCI controller on samsung-hsmmc [s3c-sdhci.1] using ADMA
sdhci-pltfm: SDHCI platform and OF driver helper
Registered led device: led1
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
samsung_UDA134X SoC Audio driver
UDA134X SoC Audio Codec
asoc: uda134x-hifi <-> samsung-i2s.0 mapping ok
ALSA device list:
=A0 #0: SAMSUNG_UDA134X
TCP cubic registered
NET: Registered protocol family 17
Registering the dns_resolver key type
mmc0: new high speed SDHC card at address 0001
mmcblk0: mmc0:0001 00000 29.6 GiB
s3c-rtc s3c2410-rtc: setting system clock to 2011-11-08 06:08:23 UTC
(1320732503)
=A0mmcblk0: unknown partition table
usb 1-1: new full-speed USB device number 2 using s3c2410-ohci
VFS: Mounted root (jffs2 filesystem) on device 31:4.
=46reeing init memory: 380K
EXT4-fs: Warning: mounting with data=3Djournal disables delayed
allocation and O_DIRECT support!
EXT4-fs (mmcblk0): mounted filesystem with journalled data mode. Opts:
errors=3Dremount-ro,data=3Djournal,commit=3D30,journal_checksum,barrier=
,nodelalloc
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
mmc0: Too large timeout requested for CMD38!
Adding 131068k swap on /external_flash_a/swap_file.=A0 Priority:-1
extents:3 across:135104k SS
dm9000 dm9000: eth0: link down
dm9000 dm9000: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
JFFS2 warning: (1073) jffs2_sum_write_data: Not enough space for
summary, padsize =3D -1156
Alignment trap: apexngc-ui (1195) PC=3D0x42c5f254 Instr=3D0xe5823000
Address=3D0xbefcf20f FSR 0x801
mapped channel 10 to 0
Alignment trap: wavparse0:sink (1285) PC=3D0x41e6f63c Instr=3D0xe594100=
8
Address=3D0x003570e7 FSR 0x001
