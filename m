Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F46C433EF
	for <linux-mmc@archiver.kernel.org>; Sat,  7 May 2022 09:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383657AbiEGJKx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 May 2022 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiEGJKx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 May 2022 05:10:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5E41AF2A
        for <linux-mmc@vger.kernel.org>; Sat,  7 May 2022 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651914425; x=1683450425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HZyNei2jFECEYBeJ9AcYzqYAeKwN50ZEXcW+MJUUwqk=;
  b=bNsfw9GIxJvgqMpc58PwSzat3BEfzpdQ63gdD74njYC9n0Z26ZVGgzyb
   8RXLN7orbeANKsdPnROGFJog2elZEElgPU9Hk5y4Hxo83P53NND4zeZf4
   n67RELIUVP8LpdwC+5O0Nos0Ke4Xj5V3Gt4YjFGJig1czlzZsxFhF0ans
   LFol46kjDc08l/eQKAEd62MGD4c2DP2iC2OOKBonUlRHaL4jjpxfDcMGK
   T9KzhCySkMo4Q0EuJ+n1LQADTQ0jzz9XEut7GzdTZx1YmA0cefTq+MiuE
   UZ+MrC3EsbYBy6pS4qoM6TsnBdxU1ewIWHn7PpHRv0oUAYROMiJS/vB85
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268579047"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="268579047"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 02:07:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="600926539"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 02:07:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nnGOy-00D1dU-V0;
        Sat, 07 May 2022 12:07:00 +0300
Date:   Sat, 7 May 2022 12:07:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     xc zhang <yujianxuechuan@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     cloehle@hyperstone.com, linux-mmc@vger.kernel.org
Subject: Re: About "mmc: block: Check for errors after write on SPI"
Message-ID: <YnY2tFwiIfdT9ATX@smile.fi.intel.com>
References: <CANugAwZbxm=enE9rN80cx7seKWJatO_Seye7NxryfLoeSue30A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANugAwZbxm=enE9rN80cx7seKWJatO_Seye7NxryfLoeSue30A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+Cc: ML and maintainer

On Sat, May 07, 2022 at 10:16:43AM +0800, xc zhang wrote:
> Hi Christian
> 
> I am using a sbc named rock pi 4(based on rk3399，with emmc5.1 card), with
> upstream linux kernel 5.15.37 , sbc cannot boot(5.15.32 is ok), and I
> revert this patch , it boots normaly , I am not familier with mmc/sd，here
> is log , hope you can give some advice.

Thank you for your report!

Is there the dmesg for good boot available?
Also, what DTS is used?

Have you tried to boot with or without card in the SPI slot? (Interesting to
know how many SD/MMC slots you have and how they are being utilized).

> Starting kernel ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version 5.15.37-dirty (zxc@zxc-QiTianM425-N000)
> (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture
> 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for the
> A-profile Architecture 10.3-2021.07 (arm-10.29)) 2.36.1.20210621) #2 SMP
> PREEMPT Fri May 6 14:30:45 CST 2022
> [    0.000000] Machine model: Radxa ROCK Pi 4B
> [    0.000000] efi: UEFI not found.
> [    0.000000] earlycon: uart0 at MMIO32 0x00000000ff1a0000 (options
> '1500000n8')
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem
> 0x0000000000200000-0x000000007fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x7fba7c00-0x7fba9fff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000200000-0x000000007fffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000200000-0x000000007fffffff]
> [    0.000000] Initmem setup node 0 [mem
> 0x0000000000200000-0x000000007fffffff]
> [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
> [    0.000000] cma: Reserved 32 MiB at 0x000000007b800000
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.0 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.0
> [    0.000000] percpu: Embedded 28 pages/cpu s74520 r8192 d31976 u114688
> [    0.000000] pcpu-alloc: s74520 r8192 d31976 u114688 alloc=28*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5
> [    0.000000] Detected VIPT I-cache on CPU0
> [    0.000000] CPU features: detected: GIC system register CPU interface
> [    0.000000] CPU features: detected: ARM erratum 845719
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 515592
> [    0.000000] Policy zone: DMA
> [    0.000000] Kernel command line:
> root=UUID=9e30106a-e841-4a98-8b1f-a54a4122c16e rootwait rootfstype=ext4
> bootsplash.bootfile=bootsplash.armbian earlycon console=ttyS2,1500000
>  consoleblank=0 loglevel=8 ubootpart=7f91284d-01
> usb-storage.quirks=0x2537:0x1066:u,0x2537:0x1068:u   cgroup_enable=cpuset
> cgroup_memory=1 cgroup_enable=memory swapaccount=1
> [    0.000000] Unknown kernel command line parameters
> "ubootpart=7f91284d-01 cgroup_enable=memory cgroup_memory=1", will be
> passed to user space.
> [    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152
> bytes, linear)
> [    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576
> bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 1970224K/2095104K available (16512K kernel code,
> 3916K rwdata, 8920K rodata, 7168K init, 511K bss, 92112K reserved, 32768K
> cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
> [    0.000000] trace event string verifier disabled
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu: RCU event tracing is enabled.
> [    0.000000] rcu: RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=6.
> [    0.000000] Trampoline variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is
> 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> [    0.000000] GICv3: 256 SPIs implemented
> [    0.000000] GICv3: 0 Extended SPIs implemented
> [    0.000000] GICv3: Distributor has no Range Selector support
> [    0.000000] Root IRQ handler: gic_handle_irq
> [    0.000000] GICv3: 16 PPIs implemented
> [    0.000000] GICv3: CPU0: found redistributor 0 region
> 0:0x00000000fef00000
> [    0.000000] ITS [mem 0xfee20000-0xfee3ffff]
> [    0.000000] ITS@0x00000000fee20000: allocated 65536 Devices @500000
> (flat, esz 8, psz 64K, shr 0)
> [    0.000000] ITS: using cache flushing for cmd queue
> [    0.000000] GICv3: using LPI property table @0x00000000004d0000
> [    0.000000] GIC: using cache flushing for LPI property table
> [    0.000000] GICv3: CPU0: using allocated LPI pending table
> @0x00000000004e0000
> [    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] {
> /cpus/cpu@0[0] /cpus/cpu@1[1] /cpus/cpu@2[2] /cpus/cpu@3[3] }
> [    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] {
> /cpus/cpu@100[4] /cpus/cpu@101[5] }
> [    0.000000] random: get_random_bytes called from
> start_kernel+0x4d8/0x6c8 with crng_init=0
> [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000001] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every
> 4398046511097ns
> [    0.004409] Console: colour dummy device 80x25
> [    0.004953] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 48.00 BogoMIPS (lpj=96000)
> [    0.005939] pid_max: default: 32768 minimum: 301
> [    0.006502] LSM: Security Framework initializing
> [    0.007095] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes,
> linear)
> [    0.007816] Mountpoint-cache hash table entries: 4096 (order: 3, 32768
> bytes, linear)
> [    0.011180] rcu: Hierarchical SRCU implementation.
> [    0.012038] Platform MSI: interrupt-controller@fee20000 domain created
> [    0.013124] PCI/MSI: /interrupt-controller@fee00000
> /interrupt-controller@fee20000 domain created
> [    0.014231] fsl-mc MSI: interrupt-controller@fee20000 domain created
> [    0.020632] EFI services will not be available.
> [    0.021556] smp: Bringing up secondary CPUs ...
> [    0.022857] Detected VIPT I-cache on CPU1
> [    0.022920] GICv3: CPU1: found redistributor 1 region
> 0:0x00000000fef20000
> [    0.022942] GICv3: CPU1: using allocated LPI pending table
> @0x00000000004f0000
> [    0.023009] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
> [    0.024109] Detected VIPT I-cache on CPU2
> [    0.024170] GICv3: CPU2: found redistributor 2 region
> 0:0x00000000fef40000
> [    0.024193] GICv3: CPU2: using allocated LPI pending table
> @0x0000000000580000
> [    0.024258] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
> [    0.025328] Detected VIPT I-cache on CPU3
> [    0.025391] GICv3: CPU3: found redistributor 3 region
> 0:0x00000000fef60000
> [    0.025413] GICv3: CPU3: using allocated LPI pending table
> @0x0000000000590000
> [    0.025477] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
> [    0.026671] CPU features: detected: Spectre-v2
> [    0.026683] CPU features: detected: Spectre-v3a
> [    0.026689] CPU features: detected: Spectre-v4
> [    0.026694] CPU features: detected: Spectre-BHB
> [    0.026704] CPU features: detected: ARM errata 1165522, 1319367, or
> 1530923
> [    0.026709] Detected PIPT I-cache on CPU4
> [    0.026746] GICv3: CPU4: found redistributor 100 region
> 0:0x00000000fef80000
> [    0.026764] GICv3: CPU4: using allocated LPI pending table
> @0x00000000005a0000
> [    0.026808] CPU4: Booted secondary processor 0x0000000100 [0x410fd082]
> [    0.027747] Detected PIPT I-cache on CPU5
> [    0.027792] GICv3: CPU5: found redistributor 101 region
> 0:0x00000000fefa0000
> [    0.027812] GICv3: CPU5: using allocated LPI pending table
> @0x00000000005b0000
> [    0.027856] CPU5: Booted secondary processor 0x0000000101 [0x410fd082]
> [    0.027994] smp: Brought up 1 node, 6 CPUs
> [    0.042468] SMP: Total of 6 processors activated.
> [    0.042922] CPU features: detected: 32-bit EL0 Support
> [    0.043411] CPU features: detected: 32-bit EL1 Support
> [    0.043904] CPU features: detected: CRC32 instructions
> [    0.062178] CPU: All CPU(s) started at EL2
> [    0.062666] alternatives: patching kernel code
> [    0.065599] devtmpfs: initialized
> [    0.076690] KASLR disabled due to lack of seed
> [    0.077317] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.078282] futex hash table entries: 2048 (order: 5, 131072 bytes,
> linear)
> [    0.079888] pinctrl core: initialized pinctrl subsystem
> [    0.081448] DMI not present or invalid.
> [    0.082336] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.085186] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic
> allocations
> [    0.086094] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic
> allocations
> [    0.087082] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for
> atomic allocations
> [    0.087904] audit: initializing netlink subsys (disabled)
> [    0.088632] audit: type=2000 audit(0.084:1): state=initialized
> audit_enabled=0 res=1
> [    0.089935] thermal_sys: Registered thermal governor 'step_wise'
> [    0.089944] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.090962] cpuidle: using governor menu
> [    0.092219] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
> [    0.093088] ASID allocator initialised with 65536 entries
> [    0.095524] Serial: AMBA PL011 UART driver
> [    0.126007] platform ff770000.syscon:phy@f780: Fixing up cyclic
> dependency with fe330000.mmc
> [    0.134846] platform ff940000.hdmi: Fixing up cyclic dependency with
> ff8f0000.vop
> [    0.135643] platform ff940000.hdmi: Fixing up cyclic dependency with
> ff900000.vop
> [    0.144052] rockchip-gpio ff720000.gpio0: probed /pinctrl/gpio0@ff720000
> [    0.145417] rockchip-gpio ff730000.gpio1: probed /pinctrl/gpio1@ff730000
> [    0.146711] rockchip-gpio ff780000.gpio2: probed /pinctrl/gpio2@ff780000
> [    0.148009] rockchip-gpio ff788000.gpio3: probed /pinctrl/gpio3@ff788000
> [    0.149307] rockchip-gpio ff790000.gpio4: probed /pinctrl/gpio4@ff790000
> [    0.166056] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.166721] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
> [    0.167379] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.168034] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
> [    0.170455] cryptd: max_cpu_qlen set to 1000
> [    0.174457] ACPI: Interpreter disabled.
> [    0.178235] vcc5v0_sys: supplied by vcc12v_dcin
> [    0.179100] vcc3v3_pcie: supplied by vcc5v0_sys
> [    0.179816] vcc3v3_sys: supplied by vcc5v0_sys
> [    0.180619] vcc5v0_host: supplied by vcc5v0_sys
> [    0.181425] vcc5v0_typec: supplied by vcc5v0_sys
> [    0.183112] iommu: Default domain type: Translated
> [    0.183596] iommu: DMA domain TLB invalidation policy: strict mode
> [    0.186646] vgaarb: loaded
> [    0.187203] SCSI subsystem initialized
> [    0.187743] libata version 3.00 loaded.
> [    0.188342] usbcore: registered new interface driver usbfs
> [    0.188921] usbcore: registered new interface driver hub
> [    0.189496] usbcore: registered new device driver usb
> [    0.191452] pps_core: LinuxPPS API ver. 1 registered
> [    0.191940] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo
> Giometti <giometti@linux.it>
> [    0.192838] PTP clock support registered
> [    0.193427] EDAC MC: Ver: 3.0.0
> [    0.196386] FPGA manager framework
> [    0.196809] Advanced Linux Sound Architecture Driver Initialized.
> [    0.198370] clocksource: Switched to clocksource arch_sys_counter
> [    0.242478] VFS: Disk quotas dquot_6.6.0
> [    0.242933] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
> bytes)
> [    0.243821] pnp: PnP ACPI: disabled
> [    0.252914] NET: Registered PF_INET protocol family
> [    0.253584] IP idents hash table entries: 32768 (order: 6, 262144 bytes,
> linear)
> [    0.256161] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2,
> 16384 bytes, linear)
> [    0.257043] TCP established hash table entries: 16384 (order: 5, 131072
> bytes, linear)
> [    0.257989] TCP bind hash table entries: 16384 (order: 6, 262144 bytes,
> linear)
> [    0.259064] TCP: Hash tables configured (established 16384 bind 16384)
> [    0.259836] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
> [    0.260569] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes,
> linear)
> [    0.261452] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.262629] RPC: Registered named UNIX socket transport module.
> [    0.263213] RPC: Registered udp transport module.
> [    0.263674] RPC: Registered tcp transport module.
> [    0.264135] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.264767] PCI: CLS 0 bytes, default 64
> [    0.265431] Unpacking initramfs...
> [    0.275287] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7
> counters available
> [    0.276498] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7
> counters available
> [    0.277828] kvm [1]: IPA Size Limit: 40 bits
> [    0.279895] kvm [1]: vgic-v2@fff20000
> [    0.280283] kvm [1]: GIC system register CPU interface enabled
> [    0.281081] kvm [1]: vgic interrupt IRQ18
> [    0.281734] kvm [1]: Hyp mode initialized successfully
> [    0.287881] Initialise system trusted keyrings
> [    0.288510] workingset: timestamp_bits=42 max_order=19 bucket_order=0
> [    0.296242] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.297615] NFS: Registering the id_resolver key type
> [    0.298139] Key type id_resolver registered
> [    0.298601] Key type id_legacy registered
> [    0.299094] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> [    0.299747] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
> Registering...
> [    0.300731] 9p: Installing v9fs 9p2000 file system support
> [    0.372956] Key type asymmetric registered
> [    0.373363] Asymmetric key parser 'x509' registered
> [    0.373967] Block layer SCSI generic (bsg) driver version 0.4 loaded
> (major 245)
> [    0.374702] io scheduler mq-deadline registered
> [    0.375139] io scheduler kyber registered
> [    0.415310] EINJ: ACPI disabled.
> [    0.435288] dma-pl330 ff6d0000.dma-controller: Loaded driver for PL330
> DMAC-241330
> [    0.436029] dma-pl330 ff6d0000.dma-controller: DBUFF-32x8bytes
> Num_Chans-6 Num_Peri-12 Num_Events-12
> [    0.438814] dma-pl330 ff6e0000.dma-controller: Loaded driver for PL330
> DMAC-241330
> [    0.439544] dma-pl330 ff6e0000.dma-controller: DBUFF-128x8bytes
> Num_Chans-8 Num_Peri-20 Num_Events-16
> [    0.457157] vdd_log: supplied by regulator-dummy
> [    0.466745] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.471093] ff180000.serial: ttyS0 at MMIO 0xff180000 (irq = 42,
> base_baud = 1500000) is a 16550A
> [    0.472158] serial serial0: tty port ttyS0 registered
> [    0.473741] ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq = 43,
> base_baud = 1500000) is a 16550A
> [    0.474884] printk: console [ttyS2] enabled
> [    0.474884] printk: console [ttyS2] enabled
> [    0.475655] printk: bootconsole [uart0] disabled
> [    0.475655] printk: bootconsole [uart0] disabled
> [    0.480092] SuperH (H)SCI(F) driver initialized
> [    0.482035] msm_serial: driver initialized
> [    0.486876] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [    0.497074] loop: module loaded
> [    0.499733] megasas: 07.717.02.00-rc1
> [    0.514734] tun: Universal TUN/TAP device driver, 1.6
> [    0.517453] thunder_xcv, ver 1.0
> [    0.517807] thunder_bgx, ver 1.0
> [    0.518149] nicpf, ver 1.0
> [    0.521724] hclge is initializing
> [    0.522057] hns3: Hisilicon Ethernet Network Driver for Hip08 Family -
> version
> [    0.522723] hns3: Copyright (c) 2017 Huawei Corporation.
> [    0.523283] e1000: Intel(R) PRO/1000 Network Driver
> [    0.523718] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    0.524291] e1000e: Intel(R) PRO/1000 Network Driver
> [    0.524732] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    0.525322] igb: Intel(R) Gigabit Ethernet Network Driver
> [    0.525801] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    0.526338] igbvf: Intel(R) Gigabit Virtual Function Network Driver
> [    0.526911] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> [    0.528319] sky2: driver version 1.30
> [    0.531604] VFIO - User Level meta-driver version: 0.3
> [    0.555560] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    0.556158] ehci-pci: EHCI PCI platform driver
> [    0.556618] ehci-platform: EHCI generic platform driver
> [    0.559607] ehci-platform fe380000.usb: EHCI Host Controller
> [    0.560141] ehci-platform fe380000.usb: new USB bus registered, assigned
> bus number 1
> [    0.560992] ehci-platform fe380000.usb: irq 35, io mem 0xfe380000
> [    0.574412] ehci-platform fe380000.usb: USB 2.0 started, EHCI 1.00
> [    0.575881] hub 1-0:1.0: USB hub found
> [    0.576261] hub 1-0:1.0: 1 port detected
> [    0.579518] ehci-platform fe3c0000.usb: EHCI Host Controller
> [    0.580045] ehci-platform fe3c0000.usb: new USB bus registered, assigned
> bus number 2
> [    0.580865] ehci-platform fe3c0000.usb: irq 37, io mem 0xfe3c0000
> [    0.594409] ehci-platform fe3c0000.usb: USB 2.0 started, EHCI 1.00
> [    0.595752] hub 2-0:1.0: USB hub found
> [    0.596126] hub 2-0:1.0: 1 port detected
> [    0.597328] ehci-orion: EHCI orion driver
> [    0.598116] ehci-exynos: EHCI Exynos driver
> [    0.598826] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    0.599400] ohci-pci: OHCI PCI platform driver
> [    0.599876] ohci-platform: OHCI generic platform driver
> [    0.600765] ohci-platform fe3a0000.usb: Generic Platform OHCI controller
> [    0.601381] ohci-platform fe3a0000.usb: new USB bus registered, assigned
> bus number 3
> [    0.602209] ohci-platform fe3a0000.usb: irq 36, io mem 0xfe3a0000
> [    0.667242] hub 3-0:1.0: USB hub found
> [    0.667627] hub 3-0:1.0: 1 port detected
> [    0.668744] ohci-platform fe3e0000.usb: Generic Platform OHCI controller
> [    0.669359] ohci-platform fe3e0000.usb: new USB bus registered, assigned
> bus number 4
> [    0.670196] ohci-platform fe3e0000.usb: irq 38, io mem 0xfe3e0000
> [    0.735195] hub 4-0:1.0: USB hub found
> [    0.735571] hub 4-0:1.0: 1 port detected
> [    0.736745] ohci-exynos: OHCI Exynos driver
> [    0.738525] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> [    0.739040] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned
> bus number 5
> [    0.739878] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe64 hci version
> 0x110 quirks 0x0000000002010010
> [    0.740780] xhci-hcd xhci-hcd.0.auto: irq 76, io mem 0xfe800000
> [    0.742420] hub 5-0:1.0: USB hub found
> [    0.742799] hub 5-0:1.0: 1 port detected
> [    0.743593] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> [    0.744097] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned
> bus number 6
> [    0.744788] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
> [    0.745450] usb usb6: We don't know the algorithms for LPM for this
> host, disabling LPM.
> [    0.746939] hub 6-0:1.0: USB hub found
> [    0.747315] hub 6-0:1.0: 1 port detected
> [    0.748368] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> [    0.748878] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned
> bus number 7
> [    0.749721] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe64 hci version
> 0x110 quirks 0x0000000002010010
> [    0.750651] xhci-hcd xhci-hcd.1.auto: irq 77, io mem 0xfe900000
> [    0.752180] hub 7-0:1.0: USB hub found
> [    0.752555] hub 7-0:1.0: 1 port detected
> [    0.753333] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> [    0.753835] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned
> bus number 8
> [    0.754551] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
> [    0.755215] usb usb8: We don't know the algorithms for LPM for this
> host, disabling LPM.
> [    0.756682] hub 8-0:1.0: USB hub found
> [    0.757055] hub 8-0:1.0: 1 port detected
> [    0.759120] usbcore: registered new interface driver usb-storage
> [    0.766840] i2c_dev: i2c /dev entries driver
> [    0.774467] rk808 0-001b: chip id: 0x0
> [    0.780425] rk808-regulator rk808-regulator: there is no dvs0 gpio
> [    0.781021] rk808-regulator rk808-regulator: there is no dvs1 gpio
> [    0.782098] vdd_center: supplied by vcc5v0_sys
> [    0.783321] vdd_cpu_l: supplied by vcc5v0_sys
> [    0.784011] vcc_ddr: supplied by vcc5v0_sys
> [    0.784991] vcc_1v8: supplied by vcc5v0_sys
> [    0.785968] vcc1v8_codec: supplied by vcc5v0_sys
> [    0.787526] vcc1v8_hdmi: supplied by vcc5v0_sys
> [    0.789091] vcca_1v8: supplied by vcc5v0_sys
> [    0.790604] vcc_sdio: supplied by vcc5v0_sys
> [    0.791991] vcca3v0_codec: supplied by vcc5v0_sys
> [    0.793568] vcc_1v5: supplied by vcc5v0_sys
> [    0.794937] vcc0v9_hdmi: supplied by vcc5v0_sys
> [    0.796476] vcc_3v0: supplied by vcc5v0_sys
> [    0.797728] vcc_cam: supplied by vcc3v3_sys
> [    0.798423] vcc_mipi: supplied by vcc3v3_sys
> [    0.801316] fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1]
> Detected!
> [    0.802661] vdd_cpu_b: supplied by vcc5v0_sys
> [    0.805416] fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1]
> Detected!
> [    0.806706] vdd_gpu: supplied by vcc5v0_sys
> [    0.819985] dw_wdt ff848000.watchdog: No valid TOPs array specified
> [    0.825784] cpu cpu0: EM: created perf domain
> [    0.827910] cpu cpu4: EM: created perf domain
> [    0.831873] sdhci: Secure Digital Host Controller Interface driver
> [    0.832430] sdhci: Copyright(c) Pierre Ossman
> [    0.833804] Synopsys Designware Multimedia Card Interface Driver
> [    0.835668] dwmmc_rockchip fe310000.mmc: IDMAC supports 32-bit address
> mode.
> [    0.835799] dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit address
> mode.
> [    0.836088] sdhci-pltfm: SDHCI platform and OF driver helper
> [    0.836316] dwmmc_rockchip fe310000.mmc: Using internal DMA controller.
> [    0.836923] dwmmc_rockchip fe320000.mmc: Using internal DMA controller.
> [    0.837411] dwmmc_rockchip fe310000.mmc: Version ID is 270a
> [    0.837903] mmc1: CQHCI version 5.10
> [    0.837987] dwmmc_rockchip fe320000.mmc: Version ID is 270a
> [    0.838710] dwmmc_rockchip fe310000.mmc: DW MMC controller at irq 32,32
> bit host data width,256 deep fifo
> [    0.839122] dwmmc_rockchip fe320000.mmc: DW MMC controller at irq 33,32
> bit host data width,256 deep fifo
> [    0.839198] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.839659] dwmmc_rockchip fe310000.mmc: allocated mmc-pwrseq
> [    0.839988] dwmmc_rockchip fe320000.mmc: Got CD GPIO
> [    0.840702] mmc_host mmc2: card is non-removable.
> [    0.841737] usbcore: registered new interface driver usbhid
> [    0.843909] usbhid: USB HID core driver
> [    0.851700] NET: Registered PF_PACKET protocol family
> [    0.852284] 9pnet: Installing 9P2000 support
> [    0.852709] Key type dns_resolver registered
> [    0.854024] Loading compiled-in X.509 certificates
> [    0.854585] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req
> 400000Hz, actual 400000HZ div = 0)
> [    0.854753] mmc_host mmc2: Bus speed (slot 0) = 400000Hz (slot req
> 400000Hz, actual 400000HZ div = 0)
> [    0.860237] Freeing initrd memory: 13904K
> [    0.862502] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] using
> ADMA
> [    0.873812] vcc_0v9: supplied by vcc3v3_sys
> [    0.874203] random: fast init done
> [    0.898381] mmc_host mmc2: Bus speed (slot 0) = 300000Hz (slot req
> 300000Hz, actual 300000HZ div = 0)
> [    0.911007] ALSA device list:
> [    0.911278]   No soundcards found.
> [    0.911713] dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
> [    0.915111] Freeing unused kernel memory: 7168K
> [    0.926547] Run /init as init process
> [    0.926871]   with arguments:
> [    0.927129]     /init
> [    0.927330]   with environment:
> [    0.927604]     HOME=/
> [    0.927812]     TERM=linux
> [    0.928050]     ubootpart=7f91284d-01
> [    0.928370]     cgroup_enable=memory
> [    0.928682]     cgroup_memory=1
> [    0.946246] mmc_host mmc2: Bus speed (slot 0) = 200000Hz (slot req
> 200000Hz, actual 200000HZ div = 0)
> Loading, please wait...
> [    0.958681] mmc1: Command Queue Engine enabled
> [    0.959107] mmc1: new HS400 Enhanced strobe MMC card at address 0001
> [    0.960404] mmcblk1: mmc1:0001 SLD32G 28.9 GiB
> Starting version 245.4-4ubuntu3.16
> [    0.987817]  mmcblk1: p1
> [    0.988726] mmcblk1boot0: mmc1:0001 SLD32G 4.00 MiB
> [    0.990645] mmcblk1boot1: mmc1:0001 SLD32G 4.00 MiB
> [    0.995628] mmcblk1rpmb: mmc1:0001 SLD32G 4.00 MiB, chardev (234:0)
> [    0.997067] mmc_host mmc2: Bus speed (slot 0) = 100000Hz (slot req
> 100000Hz, actual 100000HZ div = 0)
> [    1.241453] mmc1: running CQE recovery
> [    1.242151] ------------[ cut here ]------------
> [    1.242580] mmc1: cqhci: spurious TCN for tag 11
> [    1.243048] WARNING: CPU: 0 PID: 186 at
> drivers/mmc/host/cqhci-core.c:786 cqhci_irq+0x31c/0x640
> [    1.243827] Modules linked in:
> [    1.244105] CPU: 0 PID: 186 Comm: kworker/0:1H Not tainted 5.15.37-dirty
> #2
> [    1.244723] Hardware name: Radxa ROCK Pi 4B (DT)
> [    1.245141] Workqueue: kblockd blk_mq_run_work_fn
> [    1.245571] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    1.246182] pc : cqhci_irq+0x31c/0x640
> [    1.246525] lr : cqhci_irq+0x31c/0x640
> [    1.246862] sp : ffff800008003d80
> [    1.247155] x29: ffff800008003d80 x28: ffff000006798000 x27:
> ffff0000049b7580
> [    1.247787] x26: 0000000000000001 x25: ffff8000097eb1d0 x24:
> ffff0000049ed098
> [    1.248420] x23: ffff80000a394974 x22: ffff0000049b7000 x21:
> 0000000000000002
> [    1.249051] x20: ffff0000049ed080 x19: 000000000000000b x18:
> 0000000000000030
> [    1.249682] x17: ffff80007609e000 x16: ffff800008004000 x15:
> ffffffffffffffff
> [    1.250312] x14: 0000000000000000 x13: ffff80000a01be10 x12:
> 0000000000000459
> [    1.250943] x11: 0000000000000173 x10: ffff80000a073e10 x9 :
> 00000000fffff000
> [    1.251573] x8 : ffff80000a01be10 x7 : ffff80000a073e10 x6 :
> 0000000000000000
> [    1.252204] x5 : 000000000000bff4 x4 : 0000000000000000 x3 :
> 0000000000000000
> [    1.252834] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> ffff000006798000
> [    1.253465] Call trace:
> [    1.253685]  cqhci_irq+0x31c/0x640
> [    1.253998]  sdhci_arasan_cqhci_irq+0x54/0x84
> [    1.254391]  sdhci_irq+0xb4/0xdc0
> [    1.254693]  __handle_irq_event_percpu+0x64/0x25c
> [    1.255117]  handle_irq_event+0x64/0x150
> [    1.255468]  handle_fasteoi_irq+0xa8/0x19c
> [    1.255834]  handle_domain_irq+0x64/0x94
> [    1.256184]  gic_handle_irq+0xbc/0x140
> [    1.256520]  call_on_irq_stack+0x2c/0x60
> [    1.256871]  do_interrupt_handler+0x54/0x60
> [    1.257245]  el1_interrupt+0x30/0x80
> [    1.257569]  el1h_64_irq_handler+0x1c/0x30
> [    1.257935]  el1h_64_irq+0x78/0x7c
> [    1.258241]  sdhci_arasan_cqe_enable+0xac/0xf0
> [    1.258640]  mmc_cqe_start_req+0x70/0x110
> [    1.259000]  mmc_blk_mq_issue_rq+0x4d8/0xa60
> [    1.259381]  mmc_mq_queue_rq+0x120/0x2bc
> [    1.259731]  blk_mq_dispatch_rq_list+0x118/0x800
> [    1.260143]  __blk_mq_sched_dispatch_requests+0xb4/0x160
> [    1.260615]  blk_mq_sched_dispatch_requests+0x3c/0x80
> [    1.261065]  __blk_mq_run_hw_queue+0x54/0x90
> [    1.261449]  blk_mq_run_work_fn+0x24/0x30
> [    1.261810]  process_one_work+0x1d4/0x480
> [    1.262172]  worker_thread+0x13c/0x470
> [    1.262509]  kthread+0x154/0x160
> [    1.262803]  ret_from_fork+0x10/0x20
> [    1.263127] ---[ end trace 1f38c121ed6ab84b ]---
> [    1.264149] mmc1: running CQE recovery
> [    1.265266] mmc1: running CQE recovery
> [    1.265823] blk_update_request: I/O error, dev mmcblk1, sector 136 op
> 0x0:(READ) flags 0x80700 phys_seg 8 prio class 0
> [    1.269914] mmc1: running CQE recovery
> [    1.270856] mmc1: running CQE recovery
> [    1.271768] mmc1: running CQE recovery
> [    1.272325] blk_update_request: I/O error, dev mmcblk1, sector 216 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [    1.273256] Buffer I/O error on dev mmcblk1, logical block 27, async
> page read
> [    1.274774] mmc1: running CQE recovery
> [    1.275700] mmc1: running CQE recovery
> [    1.276616] mmc1: running CQE recovery
> [    1.277168] blk_update_request: I/O error, dev mmcblk1, sector 216 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [    1.278096] Buffer I/O error on dev mmcblk1, logical block 27, async
> page read
> [    1.279322] mmc1: running CQE recovery
> Begin: Loading essential drivers ... done.
> Begin: Running /scripts/init-premount ... done.
> Begin: Mounting root file system ... Begin: Running /scripts/local-top ...
> done.
> Begin: Running /scripts/local-premount ... done.
> Begin: Will now check root file system ... fsck from util-linux 2.34
> [/usr/sbin/fsck.ext4 (1) -- /dev/mmcblk1p1] fsck.ext4 -a -C0 /dev/mmcblk1p1
> /dev/mmcblk1p1 contains a file system with errors, check forced.
> [    1.436424] mmc1: running CQE recovery
> [    1.439079] mmc1: running CQE recovery
> [    1.440298] mmc1: running CQE recovery
> [    1.440894] blk_update_request: I/O error, dev mmcblk1, sector 34760 op
> 0x0:(READ) flags 0x80700 phys_seg 8 prio class 0
> [    1.543306] mmc1: running CQE recovery
> [    1.544544] mmc1: running CQE recovery
> [    1.545336] mmc1: running CQE recovery
> [    1.545837] blk_update_request: I/O error, dev mmcblk1, sector 35104 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [    1.546809] Buffer I/O error on dev mmcblk1p1, logical block 292, async
> page read
> [    1.548043] mmc1: running CQE recovery
> [    1.548801] mmc1: running CQE recovery
> [    1.549556] mmc1: running CQE recovery
> [    1.550031] blk_update_request: I/O error, dev mmcblk1, sector 35104 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [    1.550961] Buffer I/O error on dev mmcblk1p1, logical block 292, async
> page read
> [    1.552051] mmc1: running CQE recovery
> [    1.552811] mmc1: running CQE recovery
> [    1.553565] mmc1: running CQE recovery
> [    1.554051] blk_update_request: I/O error, dev mmcblk1, sector 35104 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [    1.555020] Buffer I/O error on dev mmcblk1p1, logical block 292, async
> page read
> [    1.556251] mmc1: running CQE recovery
> [    1.557296] mmc1: running CQE recovery
> [    1.558286] mmc1: running CQE recovery
> [    1.558896] blk_update_request: I/O error, dev mmcblk1, sector 35104 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [    1.559846] Buffer I/O error on dev mmcblk1p1, logical block 292, async
> page read
> [    1.561036] mmc1: running CQE recovery
> [    1.561982] mmc1: running CQE recovery
> [    1.562957] mmc1: running CQE recovery
> [    1.563531] blk_update_request: I/O error, dev mmcblk1, sector 35104 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [    1.564479] Buffer I/O error on dev mmcblk1p1, logical block 292, async
> page read
> [    1.565665] mmc1: running CQE recovery
> [    1.566724] mmc1: running CQE recovery
> [    1.567572] mmc1: running CQE recovery
> [    1.568049] blk_update_request: I/O error, dev mmcblk1, sector 35104 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [    1.568972] Buffer I/O error on dev mmcblk1p1, logical block 292, async
> page read
> Error reading block 292 (Input/output error) while getting next inode from
> scan.
> 
> /dev/mmcblk1p1: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
> (i.e., without -a or -p options)
> fsck exited with status code 4
> done.
> Failure: File system check of the root filesystem failed
> The root filesystem on /dev/mmcblk1p1 requires a manual fsck
> 
> 
> BusyBox v1.30.1 (Ubuntu 1:1.30.1-4ubuntu6.4) built-in shell (ash)
> Enter 'help' for a list of built-in commands.
> 
> (initramfs)

-- 
With Best Regards,
Andy Shevchenko


