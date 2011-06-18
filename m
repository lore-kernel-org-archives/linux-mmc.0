From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
Date: Sat, 18 Jun 2011 22:20:23 +0200
Message-ID: <201106182220.24848.heiko@sntech.de>
References: <201106022149.47936.heiko@sntech.de> <201106162214.11084.heiko@sntech.de> <BANLkTin3knd8CUP4wSrXYio-asrM+Omrhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IiQ/N7NoNTjZ5v3"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from s15407518.onlinehome-server.info ([82.165.136.167]:34250 "EHLO
	s15407518.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876Ab1FRUUd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Jun 2011 16:20:33 -0400
In-Reply-To: <BANLkTin3knd8CUP4wSrXYio-asrM+Omrhg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Boundary-00=_IiQ/N7NoNTjZ5v3
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi again,

Am Donnerstag 16 Juni 2011, 22:35:52 schrieb Andrei Warkentin:
> On Thu, Jun 16, 2011 at 3:14 PM, Heiko St=FCbner <heiko@sntech.de> wrote:
> > Am Dienstag 14 Juni 2011, 22:32:41 schrieb Andrei Warkentin:
> >> Hi Heiko,
> >>=20
> >> On Tue, Jun 14, 2011 at 9:10 AM, Heiko St=FCbner <heiko@sntech.de> wro=
te:
> >> > nope, no updates yet. The flood also only starts when udev wants to
> >> > create its device nodes, meaning the initial detection seems not to
> >> > produce this problem
> >> >=20
> >> > But when I disable the whole boot partition stuff, it works as before
> >> > without irq storms.
> >> >=20
> >> > As there don't seem to exist reports from other emmc users about this
> >> > I guess the problem lays somewhere between the boot-partitions-patch
> >> > and the sdhci-s3c driver (for s3c2416 at least).
> >>=20
> >> Alright. Curious. Can you let me know what eMMC device you are
> >> connecting to the controller? What is the eMMC revision?
> >=20
> > hmm ... how do I find these?
>=20
> The simplest is probably knowing what part is in your platform. The
> slightly more involved is adding a relevant printk for
> card->ext_csd.rev inside drivers/mmc/core/mmc.c.

ext_csd.rev is 3

> Can you provide me dmesg for both patches?

I've attached a dmesg from booting with both of your patches. To get=20
meaningful output I disabled the "got data interrupt xxx even though no dat=
a=20
=2E.." message flood.
But it seems your code isn't called (I'm not seeing the ">>>" line)

But I did find other peculiarities after enabling mmc-debugging - a log ful=
l of=20
the following three lines repeating endlessly: (i.e. it never stops)

[...]
mmc1: starting CMD13 arg 00010000 flags 00000195
sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
mmc1: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
[...]
repeat exactly the same lines over and over


As I wrote, this whole thing happens when udev starts and if I let it run l=
ong=20
enough udev produces the following error messages:

udevadm settle - timeout of 180 seconds reached, the event queue contains:
  /sys/devices/platform/s3c-
sdhci.1/mmc_host/mmc1/mmc1:0001/block/mmcblk1/mmcblk1boot0 (470)
  /sys/devices/platform/s3c-
sdhci.1/mmc_host/mmc1/mmc1:0001/block/mmcblk1/mmcblk1boot1 (471)
  /sys/devices/platform/s3c-
sdhci.1/mmc_host/mmc1/mmc1:0001/block/mmcblk1/mmcblk1p1 (472)
  /sys/devices/platform/s3c-
sdhci.1/mmc_host/mmc1/mmc1:0001/block/mmcblk1/mmcblk1p2 (473)
  /sys/devices/platform/s3c-
sdhci.1/mmc_host/mmc1/mmc1:0001/block/mmcblk1/mmcblk1p3 (474)

udevd[362]: worker [379] unexpectedly returned with status 0x0100

udevd[362]: worker [379] failed while handling '/devices/platform/s3c-
sdhci.1/mmc_host/mmc1/mmc1:0001/block/mmcblk1/mmcblk1boot0'


Heiko

--Boundary-00=_IiQ/N7NoNTjZ5v3
Content-Type: text/plain;
  charset="UTF-8";
  name="dmesg_20110618.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_20110618.txt"

Linux version 3.0.0-rc1+ (hstuebner@marty) (gcc version 4.3.5 (Debian 4.3.5-2) ) #134 Sat Jun 18 21:22:31 CEST 2011
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: SG060
Ignoring unrecognised tag 0x23520001
Ignoring unrecognised tag 0x23520002
Ignoring unrecognised tag 0x23520003
Ignoring unrecognised tag 0x23520004
Memory policy: ECC disabled, Data cache writeback
CPU S3C2416/S3C2450 (id 0x32450003)
S3C24XX Clocks, Copyright 2004 Simtec Electronics
CPU: MPLL on 800.000 MHz, cpu 400.000 MHz, mem 133.333 MHz, pclk 66.666 MHz
CPU: EPLL on 96.000 MHz, usb-bus 48.000 MHz
 i2sepll_div 96.000 MHz, i2s 96.000 MHz, iis 66.666 MHz
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c02bebec, node_mem_map c02eb000
  Normal zone: 256 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32512 pages, LIFO batch:7
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: root=/dev/nfs nfsroot=192.168.0.200:/home/devel/hstuebner/debianroot ip=192.168.0.202:192.168.0.200:192.168.0.200:255.255.255.0:ezx:usb0:off rootdelay=5 console=ttySAC0,115200 ro init=/sbin/init
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 125112k/125112k available, 5960k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc8800000 - 0xf6000000   ( 728 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0026000   ( 120 kB)
      .text : 0xc0026000 - 0xc02a5000   (2556 kB)
      .data : 0xc02a6000 - 0xc02c1180   ( 109 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:99
irq: clearing pending ext status 00000200
irq: clearing subpending status 00000402
irq: clearing subpending status 00000002
timer tcon=00500000, tcnt d902, tcfg 00000200,00000000, usec 0000170a
Console: colour dummy device 80x30
console [ttySAC0] enabled
Calibrating delay loop... 199.47 BogoMIPS (lpj=498688)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
devtmpfs: initialized
print_constraints: dummy: 
NET: Registered protocol family 16
s3c2416_spi_set_info: Invalid SPI configuration
S3C Power Management, Copyright 2004 Simtec Electronics
S3C2416: Initializing architecture
S3C2416: IRQ Support
S3C24XX DMA Driver, Copyright 2003-2006 Simtec Electronics
DMA channel 0 at c8804000, irq 88
DMA channel 1 at c8804100, irq 89
DMA channel 2 at c8804200, irq 90
DMA channel 3 at c8804300, irq 91
DMA channel 4 at c8804400, irq 92
DMA channel 5 at c8804500, irq 93
s3c-adc s3c24xx-adc: attached adc driver
bio: create slab <bio-0> at 0
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 1784K
msgmni has been set to 247
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered (default)
s3c2440-uart.0: ttySAC0 at MMIO 0x50000000 (irq = 70) is a S3C2440
s3c2440-uart.1: ttySAC1 at MMIO 0x50004000 (irq = 73) is a S3C2440
s3c2440-uart.2: ttySAC2 at MMIO 0x50008000 (irq = 76) is a S3C2440
brd: module loaded
gpio-vbus gpio-vbus: can't get vbus_draw regulator, err: -19
mousedev: PS/2 mouse device common for all mice
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
s3c-sdhci s3c-sdhci.0: clock source 0: hsmmc (133333333 Hz)
s3c-sdhci s3c-sdhci.0: clock source 1: hsmmc (133333333 Hz)
s3c-sdhci s3c-sdhci.0: clock source 2: hsmmc-if (96000000 Hz)
mmc0: no vmmc regulator found
Registered led device: mmc0::
mmc0: SDHCI controller on samsung-hsmmc [s3c-sdhci.0] using ADMA
s3c-sdhci s3c-sdhci.1: clock source 0: hsmmc (133333333 Hz)
s3c-sdhci s3c-sdhci.1: clock source 1: hsmmc (133333333 Hz)
s3c-sdhci s3c-sdhci.1: clock source 2: hsmmc-if (96000000 Hz)
mmc1: no vmmc regulator found
Registered led device: mmc1::
mmc1: SDHCI controller on samsung-hsmmc [s3c-sdhci.1] using ADMA
TCP cubic registered
NET: Registered protocol family 17
VFP support v0.3: not present
Kernel not built with RTC support, ALARM timers will not wake from suspend
Freeing init memory: 120K
mmc0: new SDHC card at address 9c57
mmcblk0: mmc0:9c57 SU04G 3.69 GiB 
 mmcblk0: p1 p2
mmc1: found EXT_CSD revision 3
mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 HYNIX  1.88 GiB 
mmcblk1boot0: mmc1:0001 HYNIX  partition 1 256 KiB
mmcblk1boot1: mmc1:0001 HYNIX  partition 2 256 KiB
 mmcblk1: p1 p2 p3
 mmcblk1boot1: unknown partition table
 mmcblk1boot0: unknown partition table
udevd (32): /proc/32/oom_adj is deprecated, please use /proc/32/oom_score_adj instead.
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mode
udev: starting version 154
s3c-i2c s3c2410-i2c: slave address 0x10
s3c-i2c s3c2410-i2c: bus frequency set to 378 KHz
s3c-i2c s3c2410-i2c: i2c-0: S3C I2C adapter
Registered led device: led4
Registered led device: led5
Registered led device: led6
Registered led device: led7
s3c64xx-spi s3c64xx-spi.0: Board init must call s3c64xx_spi_set_info()
s3c64xx-spi: probe of s3c64xx-spi.0 failed with error -22
input: auo_pixcir_ts as /devices/platform/s3c2410-i2c/i2c-0/0-005c/input/input0
auo_pixcir_ts: Firmware Version is 0x14
snd-soc-dummy snd-soc-dummy: platform register snd-soc-dummy
Registered platform 'snd-soc-dummy'
samsung-audio samsung-audio: platform register samsung-audio
Registered platform 'samsung-audio'
samsung-i2s samsung-i2s: dai register samsung-i2s
Registered DAI 'samsung-i2s'
alc562x-codec 0-0018: Found codec id : alc5620
alc562x-codec 0-0018: codec register 0-0018
alc562x-codec 0-0018: dai register 0-0018 #1
Registered DAI 'alc5624-hifi'
Registered codec 'alc562x-codec.0-0018'
EXT3-fs (mmcblk0p2): using internal journal
g_ether gadget: using random self ethernet address
g_ether gadget: using random host ethernet address
usb0: MAC 1e:96:62:b4:93:dd
usb0: HOST MAC a2:91:d0:61:f0:a5
g_ether gadget: adding config #2 'RNDIS'/bf0b9378
g_ether gadget: adding 'rndis'/c79fbd80 to config 'RNDIS'/bf0b9378
rndis_register: configNr = 0
rndis_set_param_medium: 0 0
g_ether gadget: RNDIS: dual speed IN/ep1in OUT/ep2out NOTIFY/ep3in
g_ether gadget: cfg 2/bf0b9378 speeds: high full
g_ether gadget:   interface 0 = rndis/c79fbd80
g_ether gadget:   interface 1 = rndis/c79fbd80
g_ether gadget: adding config #1 'CDC Ethernet (ECM)'/bf0b9308
g_ether gadget: adding 'cdc_ethernet'/c79fbb40 to config 'CDC Ethernet (ECM)'/bf0b9308
g_ether gadget: CDC Ethernet: dual speed IN/ep1in OUT/ep2out NOTIFY/ep3in
g_ether gadget: cfg 1/bf0b9308 speeds: high full
g_ether gadget:   interface 0 = cdc_ethernet/c79fbb40
g_ether gadget:   interface 1 = cdc_ethernet/c79fbb40
g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget: g_ether ready
g_ether gadget: suspend
s3c-hsudc s3c-hsudc: bound driver g_ether
g_ether gadget: suspend
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
g_ether gadget: high speed config #1: CDC Ethernet (ECM)
g_ether gadget: init ecm
g_ether gadget: notify connect false
g_ether gadget: notify speed 425984000
g_ether gadget: activate ecm
usb0: qlen 10
g_ether gadget: ecm_close
usb0: eth_open
usb0: eth_start
g_ether gadget: ecm_open
NET: Registered protocol family 10
usb0: no IPv6 routers present

--Boundary-00=_IiQ/N7NoNTjZ5v3--
