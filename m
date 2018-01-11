From: "Wladimir J. van der Laan" <laanwj@gmail.com>
Subject: 4.15.0-rc5 fails boot on MX53 LOCO board due to MMC (clock?) issue
Date: Thu, 11 Jan 2018 18:15:38 +0100
Message-ID: <20180111171538.GA32086@amethyst.visucore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:45268 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754070AbeAKRPn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Jan 2018 12:15:43 -0500
Received: by mail-wm0-f43.google.com with SMTP id i186so6926052wmi.4
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jan 2018 09:15:42 -0800 (PST)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Healy <cphealy@gmail.com>

Hello,

I'm experiencing issues with kernel 4.15.0-rc5 on a MX53 LOCO board.

Setup is two 32GB Samsung microSD SDHC cards plugged in

mmc0 plugged indirectly: contains boot and auxiliary data
mmc1 through SD->microSD adapter that came with the card: contains root fs

Initial error is "mmcblk1: error -84 transferring data, sector 2048, nr 8, cmd
response 0x900, card status 0xc00".  Then various SDHCI REGISTER DUMP follow
after timeouts and CRC errors. It looks like the filesystem is corrupting,
resulting in a failed boot.

Bisection gives me:

5143c953a7864c7abacf1c167c4350d641626949 is the first bad commit
commit 5143c953a7864c7abacf1c167c4350d641626949
Author: Benoît Thébaudeau <benoit@wsystem.com>
Date:   Tue May 30 11:14:10 2017 +0200

    mmc: sdhci-esdhc-imx: Allow all supported prescaler values

    On i.MX, SYSCTL.SDCLKFS may always be set to 0 in order to make the SD
    clock frequency prescaler divide by 1 in SDR mode, even with the eSDHC.
    The previous minimum prescaler value of 2 in SDR mode with the eSDHC was
    a code remnant from PowerPC, which actually has this limitation on
    earlier revisions.

    In DDR mode, the prescaler can divide by up to 512.

    The maximum SD clock frequency in High Speed mode is 50 MHz. On i.MX25,
    this change makes it possible to get 48 MHz from the USB PLL
    (240 MHz / 5 / 1) instead of only 40 MHz from the USB PLL
    (240 MHz / 3 / 2) or 33.25 MHz from the AHB clock (133 MHz / 2 / 2).

    Signed-off-by: Benoît Thébaudeau <benoit@wsystem.com>
    Acked-by: Adrian Hunter <adrian.hunter@intel.com>
    Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

And indeed, after reverting this particular commit on top of 4.15.0-rc5, the problem goes away.

This could be a clock rate tolerance issue with the particular brand/type of
SD card, however I've not experienced any issues with them before.

Boot log
============

U-Boot 2016.11-rc1-dirty (Feb 17 2017 - 22:05:28 +0800)

Board: MX53 LOCO
I2C:   ready
DRAM:  1 GiB
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
In:    serial
Out:   serial
Err:   serial
Net:   FEC
=> run xenial
21541 bytes read in 111 ms (189.5 KiB/s)
6661872 bytes read in 425 ms (14.9 MiB/s)
Kernel image @ 0x70010000 [ 0x000000 - 0x65a6f0 ]
## Flattened Device Tree blob at 71ff0000
   Booting using the fdt blob at 0x71ff0000
   Using Device Tree in place at 71ff0000, end 71ff8424

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.15.0-rc5 (user@aithra) (gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4)) #1 SMP Thu Jan 11 11:43:21 UTC 2018
[    0.000000] CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Freescale i.MX53 Quick Start-R Board
[    0.000000] Memory policy: Data cache writeback
[    0.000000] cma: Reserved 128 MiB at 0xc8000000
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s35096 r8192 d22248 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 261120
[    0.000000] Kernel command line: console=ttymxc0,115200 video=mxcdi1fb:GBR24,VGA-XGA di1_primary vga root=/dev/mmcblk1p1 rw
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 894536K/1048576K available (9216K kernel code, 433K rwdata, 2944K rodata, 1024K init, 456K bss, 22968K reserved, 131072K cma-reserved, 393216K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (10208 kB)
[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 434 kB)
[    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 457 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU event tracing is enabled.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] TrustZone Interrupt Controller (TZIC) initialized
[    0.000000] CPU identified as i.MX53, silicon rev 2.1
[    0.000000] Switching to timer-based delay loop, resolution 29ns
[    0.000011] sched_clock: 32 bits at 33MHz, resolution 29ns, wraps every 64424507889ns
[    0.000031] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 57337812242 ns
[    0.000944] Console: colour dummy device 80x30
[    0.000983] Calibrating delay loop (skipped), value calculated using timer frequency.. 66.66 BogoMIPS (lpj=333333)
[    0.001005] pid_max: default: 32768 minimum: 301
[    0.001155] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.001174] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.001950] CPU: Testing write buffer coherency: ok
[    0.002374] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.002911] Setting up static identity map for 0x70100000 - 0x70100078
[    0.003104] Hierarchical SRCU implementation.
[    0.003718] smp: Bringing up secondary CPUs ...
[    0.003733] smp: Brought up 1 node, 1 CPU
[    0.003744] SMP: Total of 1 processors activated (66.66 BogoMIPS).
[    0.003753] CPU: All CPU(s) started in SVC mode.
[    0.005798] devtmpfs: initialized
[    0.014688] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 2
[    0.015076] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.015108] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.022303] pinctrl core: initialized pinctrl subsystem
[    0.023641] NET: Registered protocol family 16
[    0.025865] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.029624] cpuidle: using governor menu
[    0.030160] No ATAGs?
[    0.030173] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.035590] imx53-pinctrl 53fa8000.iomuxc: initialized IMX pinctrl driver
[    0.063847] vgaarb: loaded
[    0.064386] SCSI subsystem initialized
[    0.064975] usbcore: registered new interface driver usbfs
[    0.065043] usbcore: registered new interface driver hub
[    0.065138] usbcore: registered new device driver usb
[    0.065353] usb_phy_generic 50000000.aips:usbphy-0: 50000000.aips:usbphy-0 supply vcc not found, using dummy regulator
[    0.065573] usb_phy_generic 50000000.aips:usbphy-1: 50000000.aips:usbphy-1 supply vcc not found, using dummy regulator
[    0.066761] i2c i2c-1: IMX I2C adapter registered
[    0.066788] i2c i2c-1: can't use DMA, using PIO instead.
[    0.071747] mc13xxx 0-0008: mc34708: rev 2.4, fin: 0, fab: 0
[    0.142279] i2c i2c-0: IMX I2C adapter registered
[    0.142307] i2c i2c-0: can't use DMA, using PIO instead.
[    0.142484] Linux video capture interface: v2.00
[    0.142571] pps_core: LinuxPPS API ver. 1 registered
[    0.142581] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.142608] PTP clock support registered
[    0.142940] Advanced Linux Sound Architecture Driver Initialized.
[    0.144097] Bluetooth: Core ver 2.22
[    0.144165] NET: Registered protocol family 31
[    0.144175] Bluetooth: HCI device and connection manager initialized
[    0.144198] Bluetooth: HCI socket layer initialized
[    0.144212] Bluetooth: L2CAP socket layer initialized
[    0.144286] Bluetooth: SCO socket layer initialized
[    0.145058] clocksource: Switched to clocksource mxc_timer1
[    0.145206] VFS: Disk quotas dquot_6.6.0
[    0.145312] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.155195] NET: Registered protocol family 2
[    0.155978] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.156045] TCP bind hash table entries: 4096 (order: 4, 81920 bytes)
[    0.156175] TCP: Hash tables configured (established 4096 bind 4096)
[    0.156347] UDP hash table entries: 256 (order: 1, 12288 bytes)
[    0.156382] UDP-Lite hash table entries: 256 (order: 1, 12288 bytes)
[    0.156583] NET: Registered protocol family 1
[    0.157090] RPC: Registered named UNIX socket transport module.
[    0.157108] RPC: Registered udp transport module.
[    0.157117] RPC: Registered tcp transport module.
[    0.157125] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.158870] hw perfevents: no interrupt-affinity property for /soc/pmu, guessing.
[    0.159046] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
[    0.160289] Initialise system trusted keyrings
[    0.160600] workingset: timestamp_bits=30 max_order=18 bucket_order=0
[    0.166195] NFS: Registering the id_resolver key type
[    0.166252] Key type id_resolver registered
[    0.166263] Key type id_legacy registered
[    0.166318] jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    0.166926] fuse init (API version 7.26)
[    0.172516] Key type asymmetric registered
[    0.172536] Asymmetric key parser 'x509' registered
[    0.172622] bounce: pool size: 64 pages
[    0.172648] io scheduler noop registered
[    0.172657] io scheduler deadline registered
[    0.172852] io scheduler cfq registered (default)
[    0.172865] io scheduler mq-deadline registered
[    0.172874] io scheduler kyber registered
[    0.177007] imx-sdma 63fb0000.sdma: Direct firmware load for imx/sdma/sdma-imx53.bin failed with error -2
[    0.177037] imx-sdma 63fb0000.sdma: external firmware not found, using ROM firmware
[    0.181196] 53fbc000.serial: ttymxc0 at MMIO 0x53fbc000 (irq = 47, base_baud = 4166666) is a IMX
[    0.874780] console [ttymxc0] enabled
[    0.884149] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.890890] [drm] No driver support for vblank timestamp query.
[    0.897093] imx-drm display-subsystem: bound imx-ipuv3-crtc.2 (ops ipu_crtc_ops)
[    0.904625] imx-drm display-subsystem: bound imx-ipuv3-crtc.3 (ops ipu_crtc_ops)
[    0.912875] imx-drm display-subsystem: bound 63ff0000.tve (ops imx_tve_ops)
[    0.981640] Console: switching to colour frame buffer device 128x48
[    1.004195] imx-drm display-subsystem: fb0:  frame buffer device
[    1.010883] [drm] Initialized imx-drm 1.0.0 20120507 for display-subsystem on minor 0
[    1.018899] imx-ipuv3 18000000.ipu: IPUv3M probed
[    1.035777] brd: module loaded
[    1.048800] loop: module loaded
[    1.053109] ahci-imx 10000000.sata: hwmon0: sensor 'sata_ahci'
[    1.061266] ahci-imx 10000000.sata: SSS flag set, parallel bus scan disabled
[    1.068407] ahci-imx 10000000.sata: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl platform mode
[    1.077341] ahci-imx 10000000.sata: flags: ncq sntf stag pm led clo only pmp pio slum part ccc
[    1.087542] scsi host0: ahci-imx
[    1.091087] ata1: SATA max UDMA/133 mmio [mem 0x10000000-0x10000fff] port 0x100 irq 44
[    1.102247] libphy: Fixed MDIO Bus: probed
[    1.106862] CAN device driver interface
[    1.112083] fec 63fec000.ethernet: 63fec000.ethernet supply phy not found, using dummy regulator
[    1.127643] libphy: fec_enet_mii_bus: probed
[    1.133272] usbcore: registered new interface driver asix
[    1.138969] usbcore: registered new interface driver ax88179_178a
[    1.145282] usbcore: registered new interface driver cdc_ether
[    1.151163] usbcore: registered new interface driver net1080
[    1.156949] usbcore: registered new interface driver cdc_subset
[    1.162940] usbcore: registered new interface driver zaurus
[    1.168651] usbcore: registered new interface driver cdc_ncm
[    1.174319] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.180902] ehci-pci: EHCI PCI platform driver
[    1.185440] ehci-mxc: Freescale On-Chip EHCI Host driver
[    1.191092] usbcore: registered new interface driver usb-storage
[    1.205518] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    1.210492] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
[    1.245079] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    1.251488] hub 1-0:1.0: USB hub found
[    1.255423] hub 1-0:1.0: 1 port detected
[    1.261095] mousedev: PS/2 mouse device common for all mice
[    1.268281] input: mma8450 as /devices/platform/soc/60000000.aips/63fc8000.i2c/i2c-0/0-001c/input/input0
[    1.279032] i2c /dev entries driver
[    1.283196] IR NEC protocol handler initialized
[    1.287861] IR RC5(x/sz) protocol handler initialized
[    1.292923] IR RC6 protocol handler initialized
[    1.297528] IR JVC protocol handler initialized
[    1.302065] IR Sony protocol handler initialized
[    1.306712] IR SANYO protocol handler initialized
[    1.311440] IR Sharp protocol handler initialized
[    1.316218] IR MCE Keyboard/mouse protocol handler initialized
[    1.322089] IR XMP protocol handler initialized
[    1.331041] coda 63ff4000.vpu: Direct firmware load for vpu_fw_imx53.bin failed with error -2
[    1.340025] imx2-wdt 53f98000.wdog: timeout 60 sec (nowayout=0)
[    1.346321] Bluetooth: HCI UART driver ver 2.3
[    1.350781] Bluetooth: HCI UART protocol H4 registered
[    1.356208] coda 63ff4000.vpu: Direct firmware load for vpu/vpu_fw_imx53.bin failed with error -2
[    1.365388] coda 63ff4000.vpu: Direct firmware load for v4l-coda7541-imx53.bin failed with error -2
[    1.374473] coda 63ff4000.vpu: firmware request failed
[    1.380201] sdhci: Secure Digital Host Controller Interface driver
[    1.386471] sdhci: Copyright(c) Pierre Ossman
[    1.390836] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.427121] ata1: SATA link down (SStatus 0 SControl 300)
[    1.432591] ahci-imx 10000000.sata: no device found, disabling link.
[    1.438991] ahci-imx 10000000.sata: pass ahci_imx..hotplug=1 to enable hotplug
[    1.455094] mmc0: SDHCI controller on 50004000.esdhc [50004000.esdhc] using ADMA
[    1.463372] sdhci-esdhc-imx 50020000.esdhc: Got CD GPIO
[    1.468983] sdhci-esdhc-imx 50020000.esdhc: Got WP GPIO
[    1.513247] mmc0: host does not support reading read-only switch, assuming write-enable
[    1.524179] mmc0: new high speed SDHC card at address 0001
[    1.530278] mmcblk0: mmc0:0001 00000 29.8 GiB
[    1.535433] mmc1: SDHCI controller on 50020000.esdhc [50020000.esdhc] using ADMA
[    1.546373]  mmcblk0: p1
[    1.554442] sahara 63ff8000.crypto: SAHARA version 4 initialized
[    1.561243] usbcore: registered new interface driver usbhid
[    1.566926] usbhid: USB HID core driver
[    1.577312] sgtl5000 1-000a: sgtl5000 revision 0x11
[    1.583977] sgtl5000 1-000a: Using internal LDO instead of VDDD: check ER1
[    1.615171] mmc1: new high speed SDHC card at address 0001
[    1.621312] mmcblk1: mmc1:0001 00000 29.8 GiB
[    1.627566]  mmcblk1: p1
[    1.636266] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
[    1.643374] fsl-ssi-dai 50014000.ssi: No cache defaults, reading back from HW
[    1.668548] imx-sgtl5000 sound: sgtl5000 <-> 50014000.ssi mapping ok
[    1.677780] NET: Registered protocol family 10
[    1.683528] Segment Routing with IPv6
[    1.687474] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.694204] NET: Registered protocol family 17
[    1.698754] can: controller area network core (rev 20170425 abi 9)
[    1.705222] NET: Registered protocol family 29
[    1.709681] can: raw protocol (rev 20170425)
[    1.713989] can: broadcast manager protocol (rev 20170425 t)
[    1.719696] can: netlink gateway (rev 20170425) max_hops=1
[    1.725429] Key type dns_resolver registered
[    1.730275] Registering SWP/SWPB emulation handler
[    1.735927] Loading compiled-in X.509 certificates
[    1.758191] input: gpio-keys as /devices/platform/gpio-keys/input/input1
[    1.765739] hctosys: unable to open rtc device (rtc0)
[    1.771041] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.782403] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.789628] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.798374] cfg80211: failed to load regulatory.db
[    1.803213] ALSA device list:
[    1.806280]   #0: imx53-qsb-sgtl5000
[    1.812694] EXT4-fs (mmcblk1p1): couldn't mount as ext3 due to feature incompatibilities
[    1.827259] EXT4-fs (mmcblk1p1): warning: mounting unchecked fs, running e2fsck is recommended
[    1.882668] mmcblk1: error -84 transferring data, sector 2048, nr 8, cmd response 0x900, card status 0xc00
[    2.002255] mmcblk1: error -84 transferring data, sector 2050, nr 6, cmd response 0x900, card status 0xc00
[   12.645056] mmc1: Timeout waiting for hardware interrupt.
[   12.650473] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[   12.656921] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001201
[   12.663366] mmc1: sdhci: Blk size:  0x00000004 | Blk cnt:  0x00000000
[   12.669813] mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
[   12.676258] mmc1: sdhci: Present:   0x01f8028f | Host ctl: 0x00000013
[   12.682703] mmc1: sdhci: Power:     0x00000002 | Blk gap:  0x00000000
[   12.689148] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000003f
[   12.695594] mmc1: sdhci: Timeout:   0x0000008e | Int stat: 0x00000000
[   12.702039] mmc1: sdhci: Int enab:  0x107f004b | Sig enab: 0x107f004b
[   12.708485] mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00001201
[   12.714930] mmc1: sdhci: Caps:      0x07eb0000 | Caps_1:   0x08100810
[   12.721375] mmc1: sdhci: Cmd:       0x0000163a | Max curr: 0x00000000
[   12.727821] mmc1: sdhci: Resp[0]:   0x00000920 | Resp[1]:  0x00000000
[   12.734265] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[   12.740709] mmc1: sdhci: Host ctl2: 0x00000000
[   12.745157] mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xc8049200
[   12.751601] mmc1: sdhci: ============================================
[   12.758110] print_req_error: I/O error, dev mmcblk1, sector 2050
[   12.764135] Buffer I/O error on dev mmcblk1p1, logical block 0, lost sync page write
[   12.775163] EXT4-fs (mmcblk1p1): mounted filesystem without journal. Opts: (null)
[   12.782746] VFS: Mounted root (ext4 filesystem) on device 179:9.
[   12.789151] mmcblk1: response CRC error sending SET_BLOCK_COUNT command, card status 0x900

[   22.885054] mmc1: Timeout waiting for hardware interrupt.
[   22.890469] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[   22.896917] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001201
[   22.903362] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
[   22.909807] mmc1: sdhci: Argument:  0x00012888 | Trn mode: 0x00000033
[   22.916254] mmc1: sdhci: Present:   0x01f8028f | Host ctl: 0x00000013
[   22.922699] mmc1: sdhci: Power:     0x00000002 | Blk gap:  0x00000000
[   22.929143] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000003f
[   22.935588] mmc1: sdhci: Timeout:   0x0000008e | Int stat: 0x00000000
[   22.942033] mmc1: sdhci: Int enab:  0x107f004b | Sig enab: 0x107f004b
[   22.948479] mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00001201
[   22.954924] mmc1: sdhci: Caps:      0x07eb0000 | Caps_1:   0x08100810
[   22.961369] mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
[   22.967813] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
[   22.974258] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[   22.980703] mmc1: sdhci: Host ctl2: 0x00000000
[   22.985152] mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xc8049200
[   22.991596] mmc1: sdhci: ============================================
[   22.998153] mmcblk1: error -110 sending stop command, original cmd response 0x0, card status 0xc00900
[   23.007416] mmcblk1: error -110 transferring data, sector 75912, nr 8, cmd response 0x0, card status 0x0

[   33.125054] mmc1: Timeout waiting for hardware interrupt.
[   33.130466] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[   33.136914] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001201
[   33.143358] mmc1: sdhci: Blk size:  0x00000040 | Blk cnt:  0x00000000
[   33.149803] mmc1: sdhci: Argument:  0x80fffff1 | Trn mode: 0x00000013
[   33.156248] mmc1: sdhci: Present:   0x01f8028f | Host ctl: 0x00000011
[   33.162692] mmc1: sdhci: Power:     0x00000002 | Blk gap:  0x00000000
[   33.169138] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x000010ff
[   33.175583] mmc1: sdhci: Timeout:   0x0000008e | Int stat: 0x00000000
[   33.182027] mmc1: sdhci: Int enab:  0x107f004b | Sig enab: 0x107f004b
[   33.188471] mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00001201
[   33.194917] mmc1: sdhci: Caps:      0x07eb0000 | Caps_1:   0x08100810
[   33.201362] mmc1: sdhci: Cmd:       0x0000063a | Max curr: 0x00000000
[   33.207807] mmc1: sdhci: Resp[0]:   0x00000700 | Resp[1]:  0x3010a58c
[   33.214252] mmc1: sdhci: Resp[2]:   0x30303030 | Resp[3]:  0x001b534d
[   33.220696] mmc1: sdhci: Host ctl2: 0x00000000
[   33.225144] mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xc8049200
[   33.231587] mmc1: sdhci: ============================================
[   33.238121] mmc1: tried to reset card, got error -110
[   33.243183] mmcblk1: retrying using single block read
[   43.365053] mmc1: Timeout waiting for hardware interrupt.
[   43.370464] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[   43.376909] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001201
[   43.383354] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
[   43.389799] mmc1: sdhci: Argument:  0x00012888 | Trn mode: 0x00000013
[   43.396244] mmc1: sdhci: Present:   0x01f8028f | Host ctl: 0x00000011
[   43.402688] mmc1: sdhci: Power:     0x00000002 | Blk gap:  0x00000000
[   43.409133] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x000010ff
[   43.415578] mmc1: sdhci: Timeout:   0x0000008e | Int stat: 0x00000000
[   43.422023] mmc1: sdhci: Int enab:  0x107f004b | Sig enab: 0x107f004b
[   43.428467] mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00001201
[   43.434912] mmc1: sdhci: Caps:      0x07eb0000 | Caps_1:   0x08100810
[   43.441357] mmc1: sdhci: Cmd:       0x0000113a | Max curr: 0x00000000
[   43.447801] mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
[   43.454246] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[   43.460690] mmc1: sdhci: Host ctl2: 0x00000000
[   43.465137] mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xc8049200
[   43.471581] mmc1: sdhci: ============================================
[   43.478414] mmcblk1: error -110 transferring data, sector 75912, nr 8, cmd response 0x0, card status 0x0
[   43.487949] print_req_error: I/O error, dev mmcblk1, sector 75912
[   53.605050] mmc1: Timeout waiting for hardware interrupt.
[   53.610460] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[   53.616906] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001201
[   53.623351] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
[   53.629795] mmc1: sdhci: Argument:  0x00012889 | Trn mode: 0x00000013
[   53.636239] mmc1: sdhci: Present:   0x01f8028f | Host ctl: 0x00000011
[   53.642685] mmc1: sdhci: Power:     0x00000002 | Blk gap:  0x00000000
[   53.649129] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x000010ff
[   53.655573] mmc1: sdhci: Timeout:   0x0000008e | Int stat: 0x00000000
[   53.662018] mmc1: sdhci: Int enab:  0x107f004b | Sig enab: 0x107f004b
[   53.668462] mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00001201
[   53.674908] mmc1: sdhci: Caps:      0x07eb0000 | Caps_1:   0x08100810
[   53.681352] mmc1: sdhci: Cmd:       0x0000113a | Max curr: 0x00000000
[   53.687796] mmc1: sdhci: Resp[0]:   0x00800900 | Resp[1]:  0x00000000
[   53.694240] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[   53.700683] mmc1: sdhci: Host ctl2: 0x00000000
[   53.705131] mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xc8049200
[   53.711574] mmc1: sdhci: ============================================
[   53.718136] mmcblk1: error -110 sending status command, retrying
[   53.724451] mmcblk1: error -84 sending status command, retrying
[   53.730726] mmcblk1: error -84 sending status command, aborting
[   53.736687] print_req_error: I/O error, dev mmcblk1, sector 75913
[   53.742873] EXT4-fs error (device mmcblk1p1): ext4_find_entry:1436: inode #2: comm swapper/0: reading directory lblock 0
[   53.753828] EXT4-fs (mmcblk1p1): previous I/O error to superblock detected

Regards,
Wladimir
