From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Thu, 1 Apr 2010 12:04:43 -0500
Message-ID: <008601cad1bd$6d0022b0$544ff780@am.dhcp.ti.com>
References: <37310.192.168.10.89.1270081542.squirrel@dbdmail.itg.ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030D32CEE8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0087_01CAD193.842A1AB0"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45133 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780Ab0DAREs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Apr 2010 13:04:48 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030D32CEE8@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'Ghorai, Sukumar'" <s-ghorai@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0087_01CAD193.842A1AB0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Ghorai, Sukumar [mailto:s-ghorai@ti.com]
> Sent: Wednesday, March 31, 2010 11:03 PM
> To: Chikkature Rajashekar, Madhusudhan; tony@atomide.com
> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org
> Subject: RE: [PATCH] Disable the non working eMMC on Zoom2/3
> 
> Madhu,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Chikkature Rajashekar, Madhusudhan
> > Sent: 2010-04-01 05:56
> > To: tony@atomide.com
> > Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org
> > Subject: [PATCH] Disable the non working eMMC on Zoom2/3
> >
> > From: Madhusudhan Chikkature <madhu.cr@ti.com>
> > Date: Wed, 31 Mar 2010 12:29:19 -0400
> > Subject: [PATCH] Zoom2/3: Disable MMC
> >
> > The eMMC on Zoom2/3 seems to have a lower EXT_CSD Rev.This causes the
> > writes to fail since the card size is not detected correctly by the MMC
> > core. Disable the MMC2 support for Zoom2/3.
> 
> 
> [Ghorai] Please let us know the EXT_CSD Rev you see in zoom3 and the exact
> problem. Because we never face any issue for eMMC in ZOOM3. Because we
> have the same eMMC device in 3630-SDP and could have the same problem.
>

On Zoom3 the EXT_CSD Rev reported by eMMC is zero. See the log attached.

Hence the failures which are reported by people on the list. I had already
bought this problem up on the list previously and was discussed, right?
>From the log you can also see that a 16GB device is detected as a 1GB.

Regards,
Madhu

> >
> > Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-zoom-peripherals.c |   30 -------------------
> --
> > -----
> >  1 files changed, 0 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
> > b/arch/arm/mach-omap2/board-zoom-peripherals.c
> > index 6b39849..ac791d2 100644
> > --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> > +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> > @@ -102,10 +102,6 @@ static struct regulator_consumer_supply
> > zoom_vsim_supply = {
> >  	.supply		= "vmmc_aux",
> >  };
> >
> > -static struct regulator_consumer_supply zoom_vmmc2_supply = {
> > -	.supply		= "vmmc",
> > -};
> > -
> >  /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
> >  static struct regulator_init_data zoom_vmmc1 = {
> >  	.constraints = {
> > @@ -121,21 +117,6 @@ static struct regulator_init_data zoom_vmmc1 = {
> >  	.consumer_supplies      = &zoom_vmmc1_supply,
> >  };
> >
> > -/* VMMC2 for MMC2 card */
> > -static struct regulator_init_data zoom_vmmc2 = {
> > -	.constraints = {
> > -		.min_uV			= 1850000,
> > -		.max_uV			= 1850000,
> > -		.apply_uV		= true,
> > -		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> > -					| REGULATOR_MODE_STANDBY,
> > -		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> > -					| REGULATOR_CHANGE_STATUS,
> > -	},
> > -	.num_consumer_supplies  = 1,
> > -	.consumer_supplies      = &zoom_vmmc2_supply,
> > -};
> > -
> >  /* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
> >  static struct regulator_init_data zoom_vsim = {
> >  	.constraints = {
> > @@ -159,15 +140,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
> >  		.gpio_wp	= -EINVAL,
> >  		.power_saving	= true,
> >  	},
> > -	{
> > -		.name		= "internal",
> > -		.mmc		= 2,
> > -		.wires		= 8,
> > -		.gpio_cd	= -EINVAL,
> > -		.gpio_wp	= -EINVAL,
> > -		.nonremovable	= true,
> > -		.power_saving	= true,
> > -	},
> >  	{}      /* Terminator */
> >  };
> >
> > @@ -183,7 +155,6 @@ static int zoom_twl_gpio_setup(struct device *dev,
> >  	*/
> >  	zoom_vmmc1_supply.dev = mmc[0].dev;
> >  	zoom_vsim_supply.dev = mmc[0].dev;
> > -	zoom_vmmc2_supply.dev = mmc[1].dev;
> >
> >  	return 0;
> >  }
> > @@ -241,7 +212,6 @@ static struct twl4030_platform_data zoom_twldata = {
> >  	.keypad		= &zoom_kp_twl4030_data,
> >  	.codec		= &zoom_codec_data,
> >  	.vmmc1          = &zoom_vmmc1,
> > -	.vmmc2          = &zoom_vmmc2,
> >  	.vsim           = &zoom_vsim,
> >
> >  };
> > --
> > 1.6.3.3
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

------=_NextPart_000_0087_01CAD193.842A1AB0
Content-Type: text/plain;
	name="EXT_CSD_REV_ZOOM3.TXT"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="EXT_CSD_REV_ZOOM3.TXT"

dhcp 0x80000000 madhu/uImagelo=0D
LAN9x18 (0x92210000) detected.
Read mac address: 00:08:EE:03:2A:5B
start Auto negotiation... (take ~2sec)
Auto negotiation complete, 100BaseTX, full duplex
BOOTP broadcast 1
*** Unhandled DHCP Option in OFFER/ACK: 43
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
*** Unhandled DHCP Option in OFFER/ACK: 43
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 46
DHCP client bound to address 128.247.79.222
TFTP from server 128.247.75.101; our IP address is 128.247.79.222; =
sending through gateway 128.247.78.2
Filename 'madhu/uImagelo'.
Load address: 0x80000000
Loading: =
*=08#################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ############################################################
done
Bytes transferred =3D 1968152 (1e0818 hex)
OMAP36XX ZOOM3 # bootm=0D
## Booting image at 80000000 ...
   Image Name:   Linux-2.6.34-rc3-07875-geba0147-
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1968088 Bytes =3D  1.9 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.34-rc3-07875-geba0147-dirty (madhu@praneeth) (gcc =
version 4.3.2 (Sourcery G++ Lite 2008q3-72) ) #7 Thu Apr 1 12:17:57 EDT =
2010
CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP Zoom3 board
Memory policy: ECC disabled, Data cache writeback
OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
130048
Kernel command line: console=3DttyS0,115200n8 noinitrd root=3D/dev/nfs =
rw =
nfsroot=3D128.247.75.252:/filesystems/madhu/target,nolock,tcp,tcp,wsize=3D=
1024,rsize=3D1024 ip=3Ddhcp devfs=3Dmount
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256MB 256MB =3D 512MB total
Memory: 515812k/515812k available, 8476k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xe0800000 - 0xf8000000   ( 376 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc002c000   ( 144 kB)
      .text : 0xc002c000 - 0xc0378000   (3376 kB)
      .data : 0xc0396000 - 0xc03cab80   ( 211 kB)
Hierarchical RCU implementation.
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
 (null): Could not get uart4_ick
 (null): Could not get uart4_fck
Reprogramming SDRC clock to 400000000 Hz
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 597.64 BogoMIPS (lpj=3D2334720)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
NET: Registered protocol family 16
mux: Unknown ball offset 0x5e
mux: Unknown ball offset 0x60
mux: Unknown ball offset 0x62
mux: Unknown ball offset 0x64
mux: Unknown ball offset 0x66
mux: Unknown ball offset 0x68
mux: Unknown ball offset 0x6a
mux: Unknown ball offset 0x6c
mux: Unknown ball offset 0x90
mux: Unknown ball offset 0x7e
mux: Unknown ball offset 0x92
mux: Unknown ball offset 0x94
mux: Unknown ball offset 0x9c
mux: Unknown ball offset 0x18a
mux: Unknown ball offset 0x18c
mux: Unknown ball offset 0xa1e
mux: Unknown ball offset 0x9ee
mux: Unknown ball offset 0x9f2
mux: Unknown ball offset 0xa20
mux: Unknown ball offset 0x9f0
mux: Unknown ball offset 0x574
mux: Unknown ball offset 0x576
mux: Unknown ball offset 0x588
mux: Unknown ball offset 0x58a
mux: Unknown ball offset 0x58c
mux: Unknown ball offset 0x58e
mux: Unknown ball offset 0x590
mux: Unknown ball offset 0x578
mux: Unknown ball offset 0x57a
mux: Unknown ball offset 0x57c
mux: Unknown ball offset 0x57e
mux: Unknown ball offset 0x580
mux: Unknown ball offset 0x582
mux: Unknown ball offset 0x584
mux: Unknown ball offset 0x586
mux: Unknown ball offset 0x570
mux: Unknown ball offset 0x572
mux: Unknown ball offset 0x40
mux: Unknown ball offset 0x0
mux: Unknown ball offset 0x2
mux: Unknown ball offset 0x14
mux: Unknown ball offset 0x16
mux: Unknown ball offset 0x18
mux: Unknown ball offset 0x1a
mux: Unknown ball offset 0x1c
mux: Unknown ball offset 0x1e
mux: Unknown ball offset 0x20
mux: Unknown ball offset 0x22
mux: Unknown ball offset 0x24
mux: Unknown ball offset 0x26
mux: Unknown ball offset 0x4
mux: Unknown ball offset 0x28
mux: Unknown ball offset 0x2a
mux: Unknown ball offset 0x2c
mux: Unknown ball offset 0x2e
mux: Unknown ball offset 0x30
mux: Unknown ball offset 0x32
mux: Unknown ball offset 0x34
mux: Unknown ball offset 0x36
mux: Unknown ball offset 0x38
mux: Unknown ball offset 0x3a
mux: Unknown ball offset 0x6
mux: Unknown ball offset 0x3c
mux: Unknown ball offset 0x3e
mux: Unknown ball offset 0x8
mux: Unknown ball offset 0xa
mux: Unknown ball offset 0xc
mux: Unknown ball offset 0xe
mux: Unknown ball offset 0x10
mux: Unknown ball offset 0x12
mux: Unknown ball offset 0x59e
mux: Unknown ball offset 0x5a0
mux: Unknown ball offset 0x5a2
mux: Unknown ball offset 0x5a4
mux: Unknown ball offset 0x42
mux: Unknown ball offset 0x44
mux: Unknown ball offset 0x46
mux: Unknown ball offset 0x48
mux: Unknown ball offset 0x59a
mux: Unknown ball offset 0x596
mux: Unknown ball offset 0x592
mux: Unknown ball offset 0x594
mux: Unknown ball offset 0x598
mux: Unknown ball offset 0x59c
mux: Unknown ball offset 0x9d4
OMAP DMA hardware revision 5.0
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c_omap i2c_omap.1: bus 1 rev4.0 at 2400 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
regulator: VMMC2: 1850 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
i2c_omap i2c_omap.2: bus 2 rev4.0 at 400 kHz
i2c_omap i2c_omap.3: bus 3 rev4.0 at 400 kHz
Advanced Linux Sound Architecture Driver Version 1.0.22.1.
Switching to clocksource 32k_counter
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
musb_hdrc musb_hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ =
92
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 1007
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x10000000 (irq =3D 262) is a ST16654
console [ttyS0] enabled
brd: module loaded
loop: module loaded
smsc911x: Driver version 2008-10-21.
smsc911x-mdio: probed
eth0: attached PHY driver [SMSC LAN8700] =
(mii_bus:phy_addr=3Dffffffff:01, irq=3D-1)
net eth0: MAC Address: 00:08:ee:03:2a:5b
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
input: TWL4030 Keypad as /class/input/input0
twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
i2c /dev entries driver
Driver for 1-wire Dallas network protocol.
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
ALSA device list:
  No soundcards found.
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
NET: Registered protocol family 15
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
twl_rtc twl_rtc: setting system clock to 2000-01-07 17:10:01 UTC =
(947265001)

............ EXT CSD REV 0
mmc1: new high speed MMC card at address 0001
mmcblk0: mmc1:0001 STM16G 1.00 GiB=20
 mmcblk0: p1 p2
mmcblk0: p2 size 4294817100 exceeds device capacity, limited to end of =
disk
net eth0: SMSC911x/921x identified at 0xe080c000, IRQ: 318
Sending DHCP requests .., OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 128.247.79.222
IP-Config: Complete:
     device=3Deth0, addr=3D128.247.79.222, mask=3D255.255.254.0, =
gw=3D128.247.78.2,
     host=3D128.247.79.222, domain=3Dam.dhcp.ti.com, =
nis-domain=3D(none),
     bootserver=3D0.0.0.0, rootserver=3D128.247.75.252, rootpath=3D
Looking up port of RPC 100003/2 on 128.247.75.252
Looking up port of RPC 100005/1 on 128.247.75.252
VFS: Mounted root (nfs filesystem) on device 0:11.
Freeing init memory: 144K

******************************************
Starting System Init for 12.0.1
Release: 12.0.1
******************************************
Saving kernel ring buffer : OK
Mounting devpts : OK
Setting up networking
Configuring lo : OK
Configuring eth0 : OK - 128.247.79.222
Starting telnetd : OK
Starting syslogd : OK
Starting klogd : OK
Mounting filesystems : mount: Mounting none on /dev/gadget failed: No =
such file or directory

Please press Enter to activate this console.=20


BusyBox v1.2.1 (2007.08.06-21:03+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

# 
------=_NextPart_000_0087_01CAD193.842A1AB0--

