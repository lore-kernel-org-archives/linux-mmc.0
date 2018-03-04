From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
Date: Sun, 4 Mar 2018 16:57:17 +0100
Message-ID: <20180304165717.6d4d8e68@naga.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
        <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
        <20180214163649.3a0c9476@kitsune.suse.cz>
        <20180214165827.386b9bb1@kitsune.suse.cz>
        <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
        <20180214202454.6e7ebeaf@naga.suse.cz>
        <431948292.48734.1518640216077@email.1und1.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/Ts4IeaB5.FyMOaeICxbplSh"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <431948292.48734.1518640216077@email.1und1.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, Phil Elwell <phil@raspberrypi.org>, Gerd Hoffmann <kraxel@redhat.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Julia Lawall <Julia.Lawall@lip6.fr>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--MP_/Ts4IeaB5.FyMOaeICxbplSh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 14 Feb 2018 21:30:16 +0100 (CET)
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi Michal,
>=20
> > Michal Such=C3=A1nek <msuchanek@suse.de> hat am 14. Februar 2018 um
> > 20:24 geschrieben:
> >=20
> >=20
> > On Wed, 14 Feb 2018 17:49:31 +0100
> > Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >  =20
> > > Hi Michal,
> > >=20
> > > [add Phil]
> > >=20
> > > Am 14.02.2018 um 17:13 schrieb Michal Such=C3=A1nek: =20
> > > > On Wed, 14 Feb 2018 16:36:49 +0100
> > > > Michal Such=C3=A1nek <msuchanek@suse.de> wrote:
> > > >   =20
> > > >> On Wed, 14 Feb 2018 15:58:31 +0100
> > > >> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > > >>   =20
> > > >>> Hi Michal,
> > > >>>
> > > >>> Am 14.02.2018 um 15:38 schrieb Michal Suchanek:     =20
> > > >>>> The bcm2835 mmc host tends to lock up for unknown reason so
> > > >>>> reset it on timeout. The upper mmc block layer tries
> > > >>>> retransimitting with single blocks which tends to work out
> > > >>>> after a long wait.
> > > >>>>
> > > >>>> This is better than giving up and leaving the machine broken
> > > >>>> for no obvious reason.       =20
> > > >>> could you please provide more information about this issue
> > > >>> (affected hardware, kernel config, version, dmesg,
> > > >>> reproducible scenario)?  =20
> > > > It tends to reproduce when upgrading a few packages with zypper
> > > > and otherwise at random during system operation. It seems that
> > > > for my card it worsens with age to some degree so perhaps it
> > > > depends on the fragmentation of the internal card flash.
> > > >
> > > > Attaching dmesg and kernel config.   =20
> > >=20
> > > do you noticed this issue before 4.15-rc4? =20
> >=20
> > I initially noticed it with 4.4 kernel with some backports to make
> > it bootable on RPi. =20
>=20
> this confuses me. Gerd and i ported this driver from downstream and
> finally it's got merged in 4.12.=20
>=20
> So do you mean that you backported the mainline version to 4.4 or the
> downstream version of 4.4?

I did not backport it but looking at the changelog it is backport of
the 4.12 driver. It does not look as the 4.15 driver though. Looks like
there was some reorganization of the bcm mmc since then.

>=20
> On a quick look they seems identical, but they aren't.
>=20
> > >=20
> > > Could you please test with 4.15 final again? =20
> >

I tried upgrading to the current master (4.16-rc3+) and the issue is
still reproducible although less frequent. I did full upgrade from the
install image which installs over 300 packages and the issue triggered
somewhere around 200th while before installing a half dozen packages
would usually trigger it.

=20
> > Right, I can apply the patches on something more recent.
> >  =20
> > >=20
> > > What kind of SD card (name) triggers the issue? =20
> >=20
> > Samsung EVO MB-MP16D =20
>=20
> Thanks
>=20
> >=20
> > Also see https://elinux.org/RPi_SD_cards#Which_SD_card.3F =20
>=20
> I'm very sceptical about this list. The card above is listed as OK
> and NOK. The experienced issues doesn't need to be direct related to
> the card (unproperly umounted, bad driver, ...).

Right, it just shows that this is not an isolated problem. Not all test
results are reliable, of course. Some include interesting details,
though.

Thanks

Michal

--MP_/Ts4IeaB5.FyMOaeICxbplSh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg.4.16.txt

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 4.16.0-rc3-6.g005d1b3-default (geeko@buildhost) (gcc version 7.3.0 (SUSE Linux)) #1 SMP Sun Mar 4 10:10:16 UTC 2018 (005d1b3)
[    0.000000] Machine model: Raspberry Pi 3 Model B
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.05 by Das U-boot
[    0.000000] efi:  SMBIOS=0x35b0e000 
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x0000000036ffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x36fdf300-0x36fe0dff]
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x0000000036ffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000000000fff]
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000035b0dfff]
[    0.000000]   node   0: [mem 0x0000000035b0e000-0x0000000035b0efff]
[    0.000000]   node   0: [mem 0x0000000035b0f000-0x0000000036f86fff]
[    0.000000]   node   0: [mem 0x0000000036f87000-0x0000000036f87fff]
[    0.000000]   node   0: [mem 0x0000000036f88000-0x0000000036ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000036ffffff]
[    0.000000] On node 0 totalpages: 225280
[    0.000000]   DMA32 zone: 3520 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 225280 pages, LIFO batch:31
[    0.000000] random: fast init done
[    0.000000] percpu: Embedded 25 pages/cpu @        (ptrval) s65048 r8192 d29160 u102400
[    0.000000] pcpu-alloc: s65048 r8192 d29160 u102400 alloc=25*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 221760
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/Image-4.16.0-rc3-6.g005d1b3-default root=UUID=e70a1a15-cf94-46da-9a9c-5cb5abc296ad root=/dev/disk/by-id/mmc-00000_0x55353082-part2 disk=/dev/disk/by-id/mmc-00000_0x55353082 resume=/dev/disk/by-id/mmc-00000_0x55353082-part3 quiet splash=silent plymouth.enable=0 console=ttyS0,115200n8 console=tty quiet
[    0.000000] Memory: 844284K/901120K available (9404K kernel code, 1642K rwdata, 4168K rodata, 5248K init, 1031K bss, 56836K reserved, 0K cma-reserved)
[    0.000000] ftrace: allocating 35374 entries in 139 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=4.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] arch_timer: WARNING: Invalid trigger for IRQ75, assuming level low
[    0.000000] arch_timer: WARNING: Please fix your firmware
[    0.000000] arch_timer: cp15 timer(s) running at 19.20MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.000007] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
[    0.000528] Console: colour dummy device 80x25
[    0.000550] console [tty0] enabled
[    0.000647] Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
[    0.000664] pid_max: default: 32768 minimum: 301
[    0.000876] Security Framework initialized
[    0.001000] AppArmor: AppArmor initialized
[    0.002588] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.003281] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.003368] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.003401] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.005538] ASID allocator initialised with 32768 entries
[    0.005688] Hierarchical SRCU implementation.
[    0.009053] Remapping and enabling EFI services.
[    0.009116]   EFI remap 0x0000000035b0e000 =>         (ptrval)
[    0.009126]   EFI remap 0x0000000036f87000 =>         (ptrval)
[    0.009134]   EFI remap 0x000000003f100000 =>         (ptrval)
[    0.009733] smp: Bringing up secondary CPUs ...
[    0.010846] Detected VIPT I-cache on CPU1
[    0.010911] arch_timer: WARNING: Invalid trigger for IRQ75, assuming level low
[    0.010914] arch_timer: WARNING: Please fix your firmware
[    0.010930] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.012168] Detected VIPT I-cache on CPU2
[    0.012214] arch_timer: WARNING: Invalid trigger for IRQ75, assuming level low
[    0.012217] arch_timer: WARNING: Please fix your firmware
[    0.012229] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.013385] Detected VIPT I-cache on CPU3
[    0.013421] arch_timer: WARNING: Invalid trigger for IRQ75, assuming level low
[    0.013424] arch_timer: WARNING: Please fix your firmware
[    0.013435] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.013643] smp: Brought up 1 node, 4 CPUs
[    0.013652] SMP: Total of 4 processors activated.
[    0.013661] CPU features: detected feature: 32-bit EL0 Support
[    0.013668] CPU features: detected feature: Kernel page table isolation (KPTI)
[    0.019389] CPU: All CPU(s) started at EL2
[    0.019418] alternatives: patching kernel code
[    0.021061] devtmpfs: initialized
[    0.028700] evm: security.selinux
[    0.028710] evm: security.apparmor
[    0.028715] evm: security.ima
[    0.028721] evm: security.capability
[    0.029302] Registered cp15_barrier emulation handler
[    0.029321] Registered setend emulation handler
[    0.029875] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.029966] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.030430] pinctrl core: initialized pinctrl subsystem
[    0.031873] SMBIOS 3.0 present.
[    0.031894] DMI: raspberrypi rpi/rpi, BIOS 2017.05 05/08/2017
[    0.032741] NET: Registered protocol family 16
[    0.035560] audit: initializing netlink subsys (disabled)
[    0.035814] audit: type=2000 audit(0.030:1): state=initialized audit_enabled=0 res=1
[    0.037373] cpuidle: using governor ladder
[    0.037557] cpuidle: using governor menu
[    0.038012] vdso: 2 pages (1 code @ 00000000bc8db256, 1 data @ 00000000238b0543)
[    0.038034] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.038562] DMA: preallocated 256 KiB pool for atomic allocations
[    0.039381] Serial: AMBA PL011 UART driver
[    0.044609] uart-pl011 3f201000.serial: could not find pctldev for node /soc/gpio@7e200000/uart0_ctsrts_gpio32, deferring probe
[    0.063474] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.065311] ACPI: Interpreter disabled.
[    0.066207] vgaarb: loaded
[    0.066922] SCSI subsystem initialized
[    0.067185] libata version 3.00 loaded.
[    0.067753] EDAC MC: Ver: 3.0.0
[    0.067954] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.068375] Registered efivars operations
[    0.068404] efivars: get_next_variable: status=8000000000000007
[    0.069788] NetLabel: Initializing
[    0.069795] NetLabel:  domain hash size = 128
[    0.069801] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.069926] NetLabel:  unlabeled traffic allowed by default
[    0.070560] clocksource: Switched to clocksource arch_sys_counter
[    0.173668] VFS: Disk quotas dquot_6.6.0
[    0.173796] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.174666] AppArmor: AppArmor Filesystem Enabled
[    0.174769] pnp: PnP ACPI: disabled
[    0.187310] NET: Registered protocol family 2
[    0.188138] tcp_listen_portaddr_hash hash table entries: 512 (order: 1, 8192 bytes)
[    0.188213] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.188385] TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
[    0.188592] TCP: Hash tables configured (established 8192 bind 8192)
[    0.188875] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.188935] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.189282] NET: Registered protocol family 1
[    0.189323] PCI: CLS 0 bytes, default 128
[    0.189824] Unpacking initramfs...
[    9.062128] Freeing initrd memory: 16252K
[    9.063128] kvm [1]: 8-bit VMID
[    9.063137] kvm [1]: IDMAP page: 9a4000
[    9.063144] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    9.064354] kvm [1]: Invalid trigger for IRQ76, assuming level low
[    9.064418] kvm [1]: virtual timer IRQ76
[    9.064594] kvm [1]: Hyp mode initialized successfully
[    9.067299] Initialise system trusted keyrings
[    9.067574] workingset: timestamp_bits=44 max_order=18 bucket_order=0
[    9.067848] zbud: loaded
[    9.076403] Key type asymmetric registered
[    9.076417] Asymmetric key parser 'x509' registered
[    9.076601] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    9.076799] io scheduler noop registered
[    9.076807] io scheduler deadline registered
[    9.076901] io scheduler cfq registered (default)
[    9.076909] io scheduler kyber registered
[    9.076956] io scheduler bfq registered
[    9.085523] efifb: probing for efifb
[    9.085726] efifb: framebuffer at 0x3d513000, using 7012k, total 7011k
[    9.085735] efifb: mode is 1824x984x32, linelength=7296, pages=1
[    9.085740] efifb: scrolling: redraw
[    9.085750] efifb: Truecolor: size=8:8:8:8, shift=24:0:8:16
[    9.129154] Console: switching to colour frame buffer device 228x61
[    9.171661] fb0: EFI VGA frame buffer device
[    9.181531] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    9.184389] console [ttyS0] disabled
[    9.184439] 3f215040.serial: ttyS0 at MMIO 0x0 (irq = 61, base_baud = 31249999) is a 16550
[    9.190836] console [ttyS0] enabled
[    9.191987] Serial: AMBA driver
[    9.192584] msm_serial: driver initialized
[    9.194032] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    9.195127] libphy: Fixed MDIO Bus: probed
[    9.195753] mousedev: PS/2 mouse device common for all mice
[    9.198724] ledtrig-cpu: registered to indicate activity on CPUs
[    9.199069] EFI Variables Facility v0.08 2004-May-17
[    9.199096] efivars: get_next_variable: status=8000000000000007
[    9.199199] hidraw: raw HID events driver (C) Jiri Kosina
[    9.199575] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
[    9.201882] NET: Registered protocol family 10
[    9.227523] Segment Routing with IPv6
[    9.228961] registered taskstats version 1
[    9.228985] Loading compiled-in X.509 certificates
[    9.242732] Loaded X.509 cert 'home:michals OBS Project: 544f3f8a786dbbef2bc5f439f86f094f2347e991'
[    9.242883] zswap: loaded using pool lzo/zbud
[    9.266738] Key type big_key registered
[    9.278414] Key type encrypted registered
[    9.278437] AppArmor: AppArmor sha1 policy hashing enabled
[    9.278452] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    9.278605] evm: HMAC attrs: 0x1
[    9.284131] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 66, base_baud = 0) is a PL011 rev2
[    9.286607] raspberrypi-firmware soc:firmware: Attached to firmware from 2016-09-02 11:49
[    9.288723] hctosys: unable to open rtc device (rtc0)
[    9.315948] Freeing unused kernel memory: 5248K
[    9.345959] efivars: get_next_variable: status=8000000000000007
[    9.355500] systemd[1]: systemd 228 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[    9.356743] systemd[1]: Detected architecture arm64.
[    9.356763] systemd[1]: Running in initial RAM disk.
[    9.356917] systemd[1]: Set hostname to <linux>.
[    9.638640] systemd[1]: Reached target Timers.
[    9.642236] systemd[1]: Created slice System Slice.
[    9.642504] systemd[1]: Listening on udev Kernel Socket.
[    9.643411] systemd[1]: Created slice system-systemd\x2dhibernate\x2dresume.slice.
[    9.643693] systemd[1]: Listening on Journal Socket (/dev/log).
[    9.643973] systemd[1]: Listening on udev Control Socket.
[   10.483945] sdhost-bcm2835 3f202000.sdhost: unable to initialise DMA channel. Falling back to PIO
[   10.498917] sdhci: Secure Digital Host Controller Interface driver
[   10.498931] sdhci: Copyright(c) Pierre Ossman
[   10.504426] sdhci-pltfm: SDHCI platform and OF driver helper
[   10.586429] sdhost-bcm2835 3f202000.sdhost: loaded - DMA disabled
[   10.587211] sdhost-bcm2835 3f202000.sdhost: resetting
[   10.618898] mmc1: SDHCI controller on 3f300000.sdhci [3f300000.sdhci] using PIO
[   10.643482] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[   10.645234] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[   10.646980] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[   10.650113] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[   10.694224] mmc0: host does not support reading read-only switch, assuming write-enable
[   10.695999] mmc0: new high speed SDHC card at address 0001
[   10.710758] mmcblk0: mmc0:0001 00000 14.6 GiB 
[   10.715732]  mmcblk0: p1 p2 p3
[   10.805776] mmc1: new high speed SDIO card at address 0001
[   10.866739] usbcore: registered new interface driver usbfs
[   10.866834] usbcore: registered new interface driver hub
[   10.867021] usbcore: registered new device driver usb
[   10.988211] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   10.989936] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   10.990224] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   10.990238] cfg80211: failed to load regulatory.db
[   11.123585] PM: Starting manual resume from disk
[   11.124345] PM: Image not found (code -22)
[   11.335132] random: crng init done
[   11.359854] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[   12.100186] systemd-journald[157]: Received SIGTERM from PID 1 (systemd).
[   12.238771] systemd: 16 output lines suppressed due to ratelimiting
[   13.595204] EXT4-fs (mmcblk0p2): re-mounted. Opts: nobarrier
[   13.892099] systemd-journald[363]: Received request to flush runtime journal from PID 1
[   15.397135] bcm2835-wdt 3f100000.watchdog: Broadcom BCM2835 watchdog timer
[   16.413335] bcm2835-rng 3f104000.rng: hwrng registered
[   16.416059] i2c-bcm2835 3f805000.i2c: Could not read clock-frequency property
[   16.417899] dwc2 3f980000.usb: 3f980000.usb supply vusb_d not found, using dummy regulator
[   16.418029] dwc2 3f980000.usb: 3f980000.usb supply vusb_a not found, using dummy regulator
[   16.484647] Adding 505172k swap on /dev/mmcblk0p3.  Priority:-2 extents:1 across:505172k SSFS
[   16.633867] brcmfmac: probe of mmc1:0001:1 failed with error -110
[   16.634398] brcmfmac: probe of mmc1:0001:2 failed with error -110
[   16.634626] usbcore: registered new interface driver brcmfmac
[   16.716968] FAT-fs (mmcblk0p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   16.920804] dwc2 3f980000.usb: dwc2_check_params: Invalid parameter g_np_tx_fifo_size=1024
[   16.920872] dwc2 3f980000.usb: EPs: 8, dedicated fifos, 4080 entries in SPRAM
[   16.921404] dwc2 3f980000.usb: DWC OTG Controller
[   16.921443] dwc2 3f980000.usb: new USB bus registered, assigned bus number 1
[   16.921500] dwc2 3f980000.usb: irq 41, io mem 0x3f980000
[   16.921979] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   16.921993] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   16.922003] usb usb1: Product: DWC OTG Controller
[   16.922013] usb usb1: Manufacturer: Linux 4.16.0-rc3-6.g005d1b3-default dwc2_hsotg
[   16.922023] usb usb1: SerialNumber: 3f980000.usb
[   16.924951] hub 1-0:1.0: USB hub found
[   16.925579] hub 1-0:1.0: 1 port detected
[   17.163362] rc_core: IR Remote Control driver registered, major 239
[   17.370705] usb 1-1: new high-speed USB device number 2 using dwc2
[   17.640963] usb 1-1: New USB device found, idVendor=0424, idProduct=9514
[   17.640980] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   17.641982] hub 1-1:1.0: USB hub found
[   17.642079] hub 1-1:1.0: 5 ports detected
[   17.930635] Registered IR keymap rc-cec
[   17.930977] rc rc0: RC for vc4 as /devices/platform/soc/3f902000.hdmi/rc/rc0
[   17.931295] input: RC for vc4 as /devices/platform/soc/3f902000.hdmi/rc/rc0/input0
[   17.932069] vc4_hdmi 3f902000.hdmi: 'dmas' DT property is missing, no HDMI audio
[   17.932233] vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdmi_ops [vc4])
[   17.932606] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_hvs_ops [vc4])
[   17.933015] vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops vc4_crtc_ops [vc4])
[   17.933313] vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops vc4_crtc_ops [vc4])
[   17.933615] vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops vc4_crtc_ops [vc4])
[   17.933730] vc4-drm soc:gpu: swiotlb: coherent allocation failed, size=16777216
[   17.933747] CPU: 2 PID: 460 Comm: systemd-udevd Not tainted 4.16.0-rc3-6.g005d1b3-default #1
[   17.933752] Hardware name: raspberrypi rpi/rpi, BIOS 2017.05 05/08/2017
[   17.933759] Call trace:
[   17.933779]  dump_backtrace+0x0/0x1d0
[   17.933788]  show_stack+0x24/0x30
[   17.933800]  dump_stack+0xbc/0xf8
[   17.933811]  swiotlb_alloc_buffer+0x174/0x178
[   17.933818]  swiotlb_alloc+0x64/0x78
[   17.933829]  __dma_alloc+0xe0/0x1d8
[   17.934156]  drm_gem_cma_create+0xa8/0x198 [drm]
[   17.934242]  vc4_bo_create+0x134/0x4e0 [vc4]
[   17.934329]  vc4_allocate_bin_bo+0x78/0x128 [vc4]
[   17.934416]  vc4_v3d_bind+0x100/0x278 [vc4]
[   17.934432]  component_bind_all+0x108/0x2c8
[   17.934518]  vc4_drm_bind+0xac/0x188 [vc4]
[   17.934529]  try_to_bring_up_master+0x214/0x300
[   17.934539]  component_master_add_with_match+0xcc/0x120
[   17.934624]  vc4_platform_drm_probe+0xc8/0x108 [vc4]
[   17.934636]  platform_drv_probe+0x60/0xc0
[   17.934645]  driver_probe_device+0x334/0x498
[   17.934653]  __driver_attach+0x124/0x128
[   17.934661]  bus_for_each_dev+0x70/0xa8
[   17.934668]  driver_attach+0x30/0x40
[   17.934676]  bus_add_driver+0x240/0x2b8
[   17.934684]  driver_register+0x6c/0x118
[   17.934692]  __platform_driver_register+0x54/0x60
[   17.934780]  vc4_drm_register+0x40/0x68 [vc4]
[   17.934789]  do_one_initcall+0x58/0x168
[   17.934802]  do_init_module+0x64/0x1dc
[   17.934811]  load_module+0x14c8/0x1678
[   17.934820]  SyS_finit_module+0xd8/0xf0
[   17.934827]  el0_svc_naked+0x30/0x34
[   17.934887] vc4-drm soc:gpu: swiotlb: coherent allocation failed, size=16777216
[   17.934899] CPU: 2 PID: 460 Comm: systemd-udevd Not tainted 4.16.0-rc3-6.g005d1b3-default #1
[   17.934904] Hardware name: raspberrypi rpi/rpi, BIOS 2017.05 05/08/2017
[   17.934907] Call trace:
[   17.934919]  dump_backtrace+0x0/0x1d0
[   17.934925]  show_stack+0x24/0x30
[   17.934937]  dump_stack+0xbc/0xf8
[   17.934946]  swiotlb_alloc_buffer+0x174/0x178
[   17.934953]  swiotlb_alloc+0x64/0x78
[   17.934962]  __dma_alloc+0xe0/0x1d8
[   17.935247]  drm_gem_cma_create+0xa8/0x198 [drm]
[   17.935332]  vc4_bo_create+0x1a4/0x4e0 [vc4]
[   17.935419]  vc4_allocate_bin_bo+0x78/0x128 [vc4]
[   17.935506]  vc4_v3d_bind+0x100/0x278 [vc4]
[   17.935516]  component_bind_all+0x108/0x2c8
[   17.935602]  vc4_drm_bind+0xac/0x188 [vc4]
[   17.935612]  try_to_bring_up_master+0x214/0x300
[   17.935622]  component_master_add_with_match+0xcc/0x120
[   17.935708]  vc4_platform_drm_probe+0xc8/0x108 [vc4]
[   17.935718]  platform_drv_probe+0x60/0xc0
[   17.935726]  driver_probe_device+0x334/0x498
[   17.935734]  __driver_attach+0x124/0x128
[   17.935741]  bus_for_each_dev+0x70/0xa8
[   17.935749]  driver_attach+0x30/0x40
[   17.935756]  bus_add_driver+0x240/0x2b8
[   17.935764]  driver_register+0x6c/0x118
[   17.935773]  __platform_driver_register+0x54/0x60
[   17.935860]  vc4_drm_register+0x40/0x68 [vc4]
[   17.935867]  do_one_initcall+0x58/0x168
[   17.935879]  do_init_module+0x64/0x1dc
[   17.935888]  load_module+0x14c8/0x1678
[   17.935897]  SyS_finit_module+0xd8/0xf0
[   17.935904]  el0_svc_naked+0x30/0x34
[   17.935943] vc4-drm soc:gpu: swiotlb: coherent allocation failed, size=16777216
[   17.935954] CPU: 2 PID: 460 Comm: systemd-udevd Not tainted 4.16.0-rc3-6.g005d1b3-default #1
[   17.935958] Hardware name: raspberrypi rpi/rpi, BIOS 2017.05 05/08/2017
[   17.935963] Call trace:
[   17.935973]  dump_backtrace+0x0/0x1d0
[   17.935979]  show_stack+0x24/0x30
[   17.935987]  dump_stack+0xbc/0xf8
[   17.935995]  swiotlb_alloc_buffer+0x174/0x178
[   17.936001]  swiotlb_alloc+0x64/0x78
[   17.936011]  __dma_alloc+0xe0/0x1d8
[   17.936271]  drm_gem_cma_create+0xa8/0x198 [drm]
[   17.936356]  vc4_bo_create+0x36c/0x4e0 [vc4]
[   17.936443]  vc4_allocate_bin_bo+0x78/0x128 [vc4]
[   17.936531]  vc4_v3d_bind+0x100/0x278 [vc4]
[   17.936541]  component_bind_all+0x108/0x2c8
[   17.936629]  vc4_drm_bind+0xac/0x188 [vc4]
[   17.936639]  try_to_bring_up_master+0x214/0x300
[   17.936648]  component_master_add_with_match+0xcc/0x120
[   17.936735]  vc4_platform_drm_probe+0xc8/0x108 [vc4]
[   17.936745]  platform_drv_probe+0x60/0xc0
[   17.936754]  driver_probe_device+0x334/0x498
[   17.936761]  __driver_attach+0x124/0x128
[   17.936770]  bus_for_each_dev+0x70/0xa8
[   17.936777]  driver_attach+0x30/0x40
[   17.936784]  bus_add_driver+0x240/0x2b8
[   17.936792]  driver_register+0x6c/0x118
[   17.936801]  __platform_driver_register+0x54/0x60
[   17.936889]  vc4_drm_register+0x40/0x68 [vc4]
[   17.936897]  do_one_initcall+0x58/0x168
[   17.936908]  do_init_module+0x64/0x1dc
[   17.936917]  load_module+0x14c8/0x1678
[   17.936926]  SyS_finit_module+0xd8/0xf0
[   17.936933]  el0_svc_naked+0x30/0x34
[   17.937033] [drm:vc4_bo_create [vc4]] *ERROR* Failed to allocate from CMA:
[   17.944470] vc4_v3d 3fc00000.v3d: Failed to allocate memory for tile binning: -12. You may need to enable CMA or give it more memory.
[   17.957408] vc4-drm soc:gpu: failed to bind 3fc00000.v3d (ops vc4_v3d_ops [vc4]): -12
[   18.020719] usb 1-1.1: new high-speed USB device number 3 using dwc2
[   18.081881] vc4-drm soc:gpu: master bind failed: -12
[   18.081938] vc4-drm: probe of soc:gpu failed with error -12
[   18.171767] usb 1-1.1: New USB device found, idVendor=0424, idProduct=ec00
[   18.171784] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   18.300755] usb 1-1.4: new low-speed USB device number 4 using dwc2
[   18.595642] smsc95xx v1.0.6
[   18.787944] usb 1-1.4: New USB device found, idVendor=0b38, idProduct=0003
[   18.787964] usb 1-1.4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   18.787974] usb 1-1.4: Product: USB-compliant keyboard
[   18.844022] smsc95xx 1-1.1:1.0 eth0: register 'smsc95xx' at usb-3f980000.usb-1.1, smsc95xx USB 2.0 Ethernet, b8:27:eb:69:dc:65
[   18.844415] usbcore: registered new interface driver smsc95xx
[   19.549884] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote wakeup
[   19.550277] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   19.706690] usbcore: registered new interface driver usbhid
[   19.706703] usbhid: USB HID core driver
[   19.724124] input: USB-compliant keyboard as /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.4/1-1.4:1.0/0003:0B38:0003.0001/input/input1
[   19.792063] hid-generic 0003:0B38:0003.0001: input,hidraw0: USB HID v1.10 Keyboard [USB-compliant keyboard] on usb-3f980000.usb-1.4/input0
[   19.795138] input: USB-compliant keyboard as /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.4/1-1.4:1.1/0003:0B38:0003.0002/input/input2
[   19.863347] hid-generic 0003:0B38:0003.0002: input,hiddev96,hidraw1: USB HID v1.10 Mouse [USB-compliant keyboard] on usb-3f980000.usb-1.4/input1
[   21.009199] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   21.011461] smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[   21.136118] NET: Registered protocol family 17
<3>[  731.358420] sdhost-bcm2835 3f202000.sdhost: timeout waiting for hardware interrupt.
<6>[  731.366507] sdhost-bcm2835 3f202000.sdhost: resetting
<3>[  741.598499] sdhost-bcm2835 3f202000.sdhost: timeout waiting for hardware interrupt.
<6>[  741.606583] sdhost-bcm2835 3f202000.sdhost: resetting
<3>[  744.688543] mmc0: Card stuck in wrong state! mmcblk0 card_busy_detect status: 0xe00
<3>[  799.198941] sdhost-bcm2835 3f202000.sdhost: timeout waiting for hardware interrupt.
<6>[  799.207027] sdhost-bcm2835 3f202000.sdhost: resetting
<3>[  809.439021] sdhost-bcm2835 3f202000.sdhost: timeout waiting for hardware interrupt.
<6>[  809.447109] sdhost-bcm2835 3f202000.sdhost: resetting
<3>[  812.529050] mmc0: Card stuck in wrong state! mmcblk0 card_busy_detect status: 0xe00

--MP_/Ts4IeaB5.FyMOaeICxbplSh--
