Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E31C352A1
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Dec 2022 23:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiLFXEq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Dec 2022 18:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiLFXEZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2022 18:04:25 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475F94A59D
        for <linux-mmc@vger.kernel.org>; Tue,  6 Dec 2022 15:03:29 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 5C317125C;
        Wed,  7 Dec 2022 00:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1670367806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6f5AFzaX/3QLHo8LgEIajuEbDR4Ry4ij6BSZVcwdQ5E=;
        b=kSTpCMsWM1VqTbA/rdkfBKUjFMMFEEXZGr5fB1EMfDcL5l3daO2yZomwONcVdvmAWPIP+1
        iTsOOsqcPRc7fbx5XKY5ayYgYC1ymV9lfOPfdHR1Ep5wBQocgN4xmXrX/GwplwOZoQFRyj
        hXd0zK/OCVqoKCiQX9cM172tjqJQbcRTzthVQV6eOXL0o8+x576dV46Dd+N3xoXBQGXif0
        /wY0/jL3uz/pGI6OzoL+fHXMXGgeLNDo33LPN2eeP1piWjcEwy2/jy/ApZ8n+VxsFvNxDv
        MUtPUmtuTKZIav6HuPNRVLALEOda9UzOc+xZkqCn38B/SK4jFKHUpbwp0manSA==
From:   Michael Walle <michael@walle.cc>
To:     adrian.hunter@intel.com
Cc:     alcooperx@gmail.com, andrew@aj.id.au, ben-linux@fluff.org,
        briannorris@chromium.org, chevron.li@bayhubtech.com,
        eugen.hristev@microchip.com, f.fainelli@gmail.com,
        haibo.chen@nxp.com, huziji@marvell.com, jh80.chung@samsung.com,
        linux-mmc@vger.kernel.org, manjumb@synopsys.com,
        prabu.t@synopsys.com, quic_sartgarg@quicinc.com,
        s.hauer@pengutronix.de, thierry.reding@gmail.com,
        ulf.hansson@linaro.org, vigneshr@ti.com, vireshk@kernel.org,
        wenchao.chen@unisoc.com, wsa+renesas@sang-engineering.com,
        michael@walle.cc
Subject: Re: [PATCH V2 4/4] mmc: sdhci: Enable card clock instead of ->set_clock()
Date:   Wed,  7 Dec 2022 00:03:21 +0100
Message-Id: <20221206230321.3868754-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128133259.38305-5-adrian.hunter@intel.com>
References: <20221128133259.38305-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

> SDHCI has separate controls for the internal clock and enabling the
> clock signal to the card.
> 
> The card clock signal was disabled via SDHCI_CLOCK_CARD_EN to avoid
> glitches on the clock line. It is not necessary to reset the internal clock
> to re-enable it. Instead re-enable by re-asserting SDHCI_CLOCK_CARD_EN.

This commit breaks my board
(arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts). The
full bootlog is at the end of the mail. Reverting this commit will make my
board boot again on mmc/next. What is strange though, is that this board is
also in the kernelci and it doesn't happen there. At least on a quick
glance at the next-master-next runs I couldn't spot the error.

Unfortunately, I don't think I can debug that on my own. But I'm happy to
help and test suggested patches. But I really don't know whats going on
here.

-michael


[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 6.1.0-rc5-00096-g57820c1dbb82 (mwalle@mwalle01) (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1936 SMP Tue Dec  6 23:54:47 CET 2022
[    0.000000] Machine model: Kontron KBox A-230-LS
[    0.000000] efi: UEFI not found.
[    0.000000] earlycon: ns16550a0 at MMIO 0x00000000021c0500 (options '115200n8')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x00000020ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x20ff7d4100-0x20ff7d5fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000020ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   node   0: [mem 0x0000002080000000-0x00000020ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000020ffffffff]
[    0.000000] cma: Reserved 32 MiB at 0x00000000fdc00000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] percpu: Embedded 28 pages/cpu s74664 r8192 d31832 u114688
[    0.000000] pcpu-alloc: s74664 r8192 d31832 u114688 alloc=28*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Spectre-v2
[    0.000000] CPU features: detected: Spectre-v3a
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] CPU features: detected: Spectre-BHB
[    0.000000] CPU features: detected: ARM erratum 1742098
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 1530923
[    0.000000] alternatives: applying boot alternatives
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1032192
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: debug earlycon console=ttyS0,115200 rootwait root=/dev/mmcblk0p1
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] stackdepot hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] software IO TLB: area num 2.
[    0.000000] software IO TLB: mapped [mem 0x00000000f9c00000-0x00000000fdc00000] (64MB)
[    0.000000] Memory: 3978308K/4194304K available (18432K kernel code, 2598K rwdata, 6612K rodata, 6144K init, 572K bss, 183228K reserved, 32768K cma-reserved)
[    0.000000] **********************************************************
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **                                                      **
[    0.000000] ** This system shows unhashed kernel memory addresses   **
[    0.000000] ** via the console, logs, and other interfaces. This    **
[    0.000000] ** might reduce the security of your system.            **
[    0.000000] **                                                      **
[    0.000000] ** If you see this message and you are not debugging    **
[    0.000000] ** the kernel, report this immediately to your system   **
[    0.000000] ** administrator!                                       **
[    0.000000] **                                                      **
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **********************************************************
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] ftrace: allocating 59190 entries in 232 pages
[    0.000000] ftrace: allocated 232 pages with 4 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=2.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000006040000
[    0.000000] ITS [mem 0x06020000-0x0603ffff]
[    0.000000] ITS@0x0000000006020000: allocated 65536 Devices @2080300000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x0000002080290000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x00000020802a0000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 25.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x5c40939b5, max_idle_ns: 440795202646 ns
[    0.000000] sched_clock: 56 bits at 25MHz, resolution 40ns, wraps every 4398046511100ns
[    0.008297] Console: colour dummy device 80x25
[    0.012833] Calibrating delay loop (skipped), value calculated using timer frequency.. 50.00 BogoMIPS (lpj=100000)
[    0.023290] pid_max: default: 32768 minimum: 301
[    0.028034] LSM: Security Framework initializing
[    0.032804] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.040289] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.049847] cblist_init_generic: Setting adjustable number of callback queues.
[    0.057161] cblist_init_generic: Setting shift to 1 and lim to 1.
[    0.063513] rcu: Hierarchical SRCU implementation.
[    0.068350] rcu: 	Max phase no-delay instances is 1000.
[    0.073843] Platform MSI: gic-its@6020000 domain created
[    0.079307] PCI/MSI: /interrupt-controller@6000000/gic-its@6020000 domain created
[    0.087071] EFI services will not be available.
[    0.091816] smp: Bringing up secondary CPUs ...
[    0.096800] Detected PIPT I-cache on CPU1
[    0.096848] GICv3: CPU1: found redistributor 1 region 0:0x0000000006060000
[    0.096857] GICv3: CPU1: using allocated LPI pending table @0x00000020802b0000
[    0.096883] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
[    0.096937] smp: Brought up 1 node, 2 CPUs
[    0.125929] SMP: Total of 2 processors activated.
[    0.130675] CPU features: detected: 32-bit EL0 Support
[    0.135859] CPU features: detected: 32-bit EL1 Support
[    0.141045] CPU features: detected: CRC32 instructions
[    0.146270] CPU: All CPU(s) started at EL2
[    0.150415] alternatives: applying system-wide alternatives
[    0.157402] devtmpfs: initialized
[    0.169485] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.179341] futex hash table entries: 512 (order: 3, 32768 bytes, linear)
[    0.186806] pinctrl core: initialized pinctrl subsystem
[    0.192421] Machine: Kontron KBox A-230-LS
[    0.196564] SoC family: QorIQ LS1028A
[    0.200254] SoC ID: svr:0x870b0110, Revision: 1.0
[    0.205428] 
[    0.206925] *************************************************************
[    0.213780] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.220630] **                                                         **
[    0.227481] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    0.234332] **                                                         **
[    0.241182] ** This means that this kernel is built to expose internal **
[    0.248032] ** IOMMU data structures, which may compromise security on **
[    0.254882] ** your system.                                            **
[    0.261733] **                                                         **
[    0.268583] ** If you see this message and you are not debugging the   **
[    0.275433] ** kernel, report this immediately to your vendor!         **
[    0.282283] **                                                         **
[    0.289133] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.295983] *************************************************************
[    0.303059] DMI not present or invalid.
[    0.307587] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.314435] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.321788] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.329782] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.337830] audit: initializing netlink subsys (disabled)
[    0.343459] audit: type=2000 audit(0.220:1): state=initialized audit_enabled=0 res=1
[    0.344375] thermal_sys: Registered thermal governor 'step_wise'
[    0.351332] cpuidle: using governor menu
[    0.361555] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.368437] ASID allocator initialised with 65536 entries
[    0.374478] Serial: AMBA PL011 UART driver
[    0.387742] KASLR disabled due to lack of seed
[    0.411277] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.418144] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.424823] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.431677] HugeTLB: 508 KiB vmemmap can be freed for a 32.0 MiB page
[    0.438179] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.445030] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.451442] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.458292] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.931577] cryptd: max_cpu_qlen set to 1000
[    0.937123] ACPI: Interpreter disabled.
[    0.941795] iommu: Default domain type: Translated 
[    0.946716] iommu: DMA domain TLB invalidation policy: strict mode 
[    0.953578] SCSI subsystem initialized
[    0.957534] libata version 3.00 loaded.
[    0.961790] usbcore: registered new interface driver usbfs
[    0.967388] usbcore: registered new interface driver hub
[    0.972791] usbcore: registered new device driver usb
[    0.978683] imx-i2c 2000000.i2c: can't get pinctrl, bus recovery not supported
[    0.986526] i2c i2c-0: IMX I2C adapter registered
[    0.991583] imx-i2c 2030000.i2c: can't get pinctrl, bus recovery not supported
[    0.999059] i2c i2c-1: IMX I2C adapter registered
[    1.004006] imx-i2c 2040000.i2c: can't get pinctrl, bus recovery not supported
[    1.011486] i2c i2c-2: IMX I2C adapter registered
[    1.016377] mc: Linux media interface: v0.10
[    1.020732] videodev: Linux video capture interface: v2.00
[    1.026357] pps_core: LinuxPPS API ver. 1 registered
[    1.031367] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.040617] PTP clock support registered
[    1.044753] EDAC MC: Ver: 3.0.0
[    1.048932] FPGA manager framework
[    1.052543] Advanced Linux Sound Architecture Driver Initialized.
[    1.059483] nfc: nfc_init: NFC Core ver 0.1
[    1.063809] NET: Registered PF_NFC protocol family
[    1.068886] vgaarb: loaded
[    1.071912] clocksource: Switched to clocksource arch_sys_counter
[    1.078658] VFS: Disk quotas dquot_6.6.0
[    1.082718] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.090063] pnp: PnP ACPI: disabled
[    1.102554] NET: Registered PF_INET protocol family
[    1.107789] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    1.117667] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    1.126342] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.134219] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    1.142317] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    1.150489] TCP: Hash tables configured (established 32768 bind 32768)
[    1.157228] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    1.164028] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    1.171399] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.177731] RPC: Registered named UNIX socket transport module.
[    1.183719] RPC: Registered udp transport module.
[    1.188469] RPC: Registered tcp transport module.
[    1.193216] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.200304] PCI: CLS 0 bytes, default 64
[    1.204849] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 counters available
[    1.213395] kvm [1]: IPA Size Limit: 44 bits
[    1.218423] kvm [1]: GICv3: no GICV resource entry
[    1.223266] kvm [1]: disabling GICv2 emulation
[    1.227759] kvm [1]: GIC system register CPU interface enabled
[    1.233691] kvm [1]: vgic interrupt IRQ9
[    1.237701] kvm [1]: Hyp mode initialized successfully
[    1.244522] Initialise system trusted keyrings
[    1.249192] workingset: timestamp_bits=44 max_order=20 bucket_order=0
[    1.269440] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.276561] NFS: Registering the id_resolver key type
[    1.281687] Key type id_resolver registered
[    1.285909] Key type id_legacy registered
[    1.290075] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.296857] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    1.304528] 9p: Installing v9fs 9p2000 file system support
[    1.339850] NET: Registered PF_ALG protocol family
[    1.344699] Key type asymmetric registered
[    1.348833] Asymmetric key parser 'x509' registered
[    1.353860] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    1.361336] io scheduler mq-deadline registered
[    1.365908] io scheduler kyber registered
[    1.372428] pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 ranges:
[    1.380289] pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815ffff -> 0x01f8000000
[    1.389186] pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cffff -> 0x01f8160000
[    1.398075] pci-host-generic 1f0000000.pcie:      MEM 0x01f81d0000..0x01f81effff -> 0x01f81d0000
[    1.406971] pci-host-generic 1f0000000.pcie:      MEM 0x01f81f0000..0x01f820ffff -> 0x01f81f0000
[    1.415858] pci-host-generic 1f0000000.pcie:      MEM 0x01f8210000..0x01f822ffff -> 0x01f8210000
[    1.424745] pci-host-generic 1f0000000.pcie:      MEM 0x01f8230000..0x01f824ffff -> 0x01f8230000
[    1.433631] pci-host-generic 1f0000000.pcie:      MEM 0x01fc000000..0x01fc3fffff -> 0x01fc000000
[    1.442574] pci-host-generic 1f0000000.pcie: ECAM at [mem 0x1f0000000-0x1f00fffff] for [bus 00]
[    1.451521] pci-host-generic 1f0000000.pcie: PCI host bridge to bus 0000:00
[    1.458558] pci_bus 0000:00: root bus resource [mem 0x1f8000000-0x1f815ffff]
[    1.465679] pci_bus 0000:00: root bus resource [mem 0x1f8160000-0x1f81cffff pref]
[    1.473239] pci_bus 0000:00: root bus resource [mem 0x1f81d0000-0x1f81effff]
[    1.480360] pci_bus 0000:00: root bus resource [mem 0x1f81f0000-0x1f820ffff pref]
[    1.487922] pci_bus 0000:00: root bus resource [mem 0x1f8210000-0x1f822ffff]
[    1.495043] pci_bus 0000:00: root bus resource [mem 0x1f8230000-0x1f824ffff pref]
[    1.502603] pci_bus 0000:00: root bus resource [mem 0x1fc000000-0x1fc3fffff]
[    1.509750] pci 0000:00:00.0: [1957:e100] type 00 class 0x020001
[    1.515844] pci 0000:00:00.0: BAR 0: [mem 0x1f8000000-0x1f803ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.526389] pci 0000:00:00.0: BAR 2: [mem 0x1f8160000-0x1f816ffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    1.537376] pci 0000:00:00.0: VF BAR 0: [mem 0x1f81d0000-0x1f81dffff 64bit] (from Enhanced Allocation, properties 0x4)
[    1.548183] pci 0000:00:00.0: VF BAR 2: [mem 0x1f81f0000-0x1f81fffff 64bit pref] (from Enhanced Allocation, properties 0x3)
[    1.559445] pci 0000:00:00.0: PME# supported from D0 D3hot
[    1.564999] pci 0000:00:00.0: VF(n) BAR0 space: [mem 0x1f81d0000-0x1f81effff 64bit] (contains BAR0 for 2 VFs)
[    1.575019] pci 0000:00:00.0: VF(n) BAR2 space: [mem 0x1f81f0000-0x1f820ffff 64bit pref] (contains BAR2 for 2 VFs)
[    1.585743] pci 0000:00:00.1: [1957:e100] type 00 class 0x020001
[    1.591836] pci 0000:00:00.1: BAR 0: [mem 0x1f8040000-0x1f807ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.602383] pci 0000:00:00.1: BAR 2: [mem 0x1f8170000-0x1f817ffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    1.613364] pci 0000:00:00.1: VF BAR 0: [mem 0x1f8210000-0x1f821ffff 64bit] (from Enhanced Allocation, properties 0x4)
[    1.624170] pci 0000:00:00.1: VF BAR 2: [mem 0x1f8230000-0x1f823ffff 64bit pref] (from Enhanced Allocation, properties 0x3)
[    1.635432] pci 0000:00:00.1: PME# supported from D0 D3hot
[    1.640981] pci 0000:00:00.1: VF(n) BAR0 space: [mem 0x1f8210000-0x1f822ffff 64bit] (contains BAR0 for 2 VFs)
[    1.650997] pci 0000:00:00.1: VF(n) BAR2 space: [mem 0x1f8230000-0x1f824ffff 64bit pref] (contains BAR2 for 2 VFs)
[    1.661702] pci 0000:00:00.2: [1957:e100] type 00 class 0x020001
[    1.667790] pci 0000:00:00.2: BAR 0: [mem 0x1f8080000-0x1f80bffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.678334] pci 0000:00:00.2: BAR 2: [mem 0x1f8180000-0x1f818ffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    1.689329] pci 0000:00:00.2: PME# supported from D0 D3hot
[    1.695091] pci 0000:00:00.3: [1957:ee01] type 00 class 0x088001
[    1.701183] pci 0000:00:00.3: BAR 0: [mem 0x1f8100000-0x1f811ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.711729] pci 0000:00:00.3: BAR 2: [mem 0x1f8190000-0x1f819ffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    1.722723] pci 0000:00:00.3: PME# supported from D0 D3hot
[    1.728509] pci 0000:00:00.4: [1957:ee02] type 00 class 0x088001
[    1.734597] pci 0000:00:00.4: BAR 0: [mem 0x1f8120000-0x1f813ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.745142] pci 0000:00:00.4: BAR 2: [mem 0x1f81a0000-0x1f81affff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    1.756146] pci 0000:00:00.4: PME# supported from D0 D3hot
[    1.761916] pci 0000:00:00.5: [1957:eef0] type 00 class 0x020801
[    1.768005] pci 0000:00:00.5: BAR 0: [mem 0x1f8140000-0x1f815ffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.778548] pci 0000:00:00.5: BAR 2: [mem 0x1f81b0000-0x1f81bffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    1.789529] pci 0000:00:00.5: BAR 4: [mem 0x1fc000000-0x1fc3fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.800084] pci 0000:00:00.5: PME# supported from D0 D3hot
[    1.805868] pci 0000:00:00.6: [1957:e100] type 00 class 0x020001
[    1.811958] pci 0000:00:00.6: BAR 0: [mem 0x1f80c0000-0x1f80fffff 64bit] (from Enhanced Allocation, properties 0x0)
[    1.822506] pci 0000:00:00.6: BAR 2: [mem 0x1f81c0000-0x1f81cffff 64bit pref] (from Enhanced Allocation, properties 0x1)
[    1.833501] pci 0000:00:00.6: PME# supported from D0 D3hot
[    1.840011] pci 0000:00:1f.0: [1957:e001] type 00 class 0x080700
[    1.846126] OF: /soc/pcie@1f0000000: no msi-map translation for id 0xf8 on (null)
[    1.853980] OF: /soc/pcie@1f0000000: no iommu-map translation for id 0xf8 on (null)
[    1.861971] pcieport 0000:00:1f.0: PME: Signaling with IRQ 20
[    1.868119] pcieport 0000:00:1f.0: AER: enabled with IRQ 20
[    1.874505] layerscape-pcie 3400000.pcie: host bridge /soc/pcie@3400000 ranges:
[    1.881913] layerscape-pcie 3400000.pcie:       IO 0x8000010000..0x800001ffff -> 0x0000000000
[    1.890538] layerscape-pcie 3400000.pcie:      MEM 0x8040000000..0x807fffffff -> 0x0040000000
[    1.899203] layerscape-pcie 3400000.pcie: iATU unroll: disabled
[    1.905180] layerscape-pcie 3400000.pcie: iATU regions: 8 ob, 6 ib, align 4K, limit 4G
[    2.913273] layerscape-pcie 3400000.pcie: Phy link never came up
[    2.919499] layerscape-pcie 3400000.pcie: PCI host bridge to bus 0001:00
[    2.926272] pci_bus 0001:00: root bus resource [bus 00-ff]
[    2.931815] pci_bus 0001:00: root bus resource [io  0x0000-0xffff]
[    2.938060] pci_bus 0001:00: root bus resource [mem 0x8040000000-0x807fffffff] (bus address [0x40000000-0x7fffffff])
[    2.948716] pci 0001:00:00.0: [1957:82c1] type 01 class 0x060400
[    2.954840] pci 0001:00:00.0: supports D1 D2
[    2.959151] pci 0001:00:00.0: PME# supported from D0 D1 D2 D3hot
[    2.966322] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    2.973017] pci 0001:00:00.0: PCI bridge to [bus 01]
[    2.978258] layerscape-pcie 3500000.pcie: host bridge /soc/pcie@3500000 ranges:
[    2.985663] layerscape-pcie 3500000.pcie:       IO 0x8800010000..0x880001ffff -> 0x0000000000
[    2.994287] layerscape-pcie 3500000.pcie:      MEM 0x8840000000..0x887fffffff -> 0x0040000000
[    3.002946] layerscape-pcie 3500000.pcie: iATU unroll: disabled
[    3.008930] layerscape-pcie 3500000.pcie: iATU regions: 8 ob, 6 ib, align 4K, limit 4G
[    4.017022] layerscape-pcie 3500000.pcie: Phy link never came up
[    4.023219] layerscape-pcie 3500000.pcie: PCI host bridge to bus 0002:00
[    4.029993] pci_bus 0002:00: root bus resource [bus 00-ff]
[    4.035537] pci_bus 0002:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
[    4.044589] pci_bus 0002:00: root bus resource [mem 0x8840000000-0x887fffffff] (bus address [0x40000000-0x7fffffff])
[    4.055242] pci 0002:00:00.0: [1957:82c1] type 01 class 0x060400
[    4.061370] pci 0002:00:00.0: supports D1 D2
[    4.065682] pci 0002:00:00.0: PME# supported from D0 D1 D2 D3hot
[    4.072829] pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 01
[    4.079520] pci 0002:00:00.0: PCI bridge to [bus 01]
[    4.085153] EINJ: ACPI disabled.
[    4.095017] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.103574] printk: console [ttyS0] disabled
[    4.107999] 21c0500.serial: ttyS0 at MMIO 0x21c0500 (irq = 21, base_baud = 12500000) is a 16550A
[    4.116893] printk: console [ttyS0] enabled
[    4.116893] printk: console [ttyS0] enabled
[    4.125312] printk: bootconsole [ns16550a0] disabled
[    4.125312] printk: bootconsole [ns16550a0] disabled
[    4.136033] 21c0600.serial: ttyS1 at MMIO 0x21c0600 (irq = 21, base_baud = 12500000) is a 16550A
[    4.145664] 2270000.serial: ttyLP2 at MMIO 0x2270000 (irq = 22, base_baud = 12500000) is a FSL_LPUART
[    4.159420] arm-smmu 5000000.iommu: probing hardware configuration...
[    4.165899] arm-smmu 5000000.iommu: SMMUv2 with:
[    4.170536] arm-smmu 5000000.iommu: 	stage 1 translation
[    4.175867] arm-smmu 5000000.iommu: 	stage 2 translation
[    4.181195] arm-smmu 5000000.iommu: 	nested translation
[    4.186449] arm-smmu 5000000.iommu: 	stream matching with 128 register groups
[    4.193624] arm-smmu 5000000.iommu: 	64 context banks (0 stage-2 only)
[    4.200191] arm-smmu 5000000.iommu: 	Supported page sizes: 0x61311000
[    4.206655] arm-smmu 5000000.iommu: 	Stage-1: 48-bit VA -> 48-bit IPA
[    4.213122] arm-smmu 5000000.iommu: 	Stage-2: 48-bit IPA -> 48-bit PA
[    4.220241] arm-smmu 5000000.iommu: 	preserved 0 boot mappings
[    4.226621] mali-dp f080000.display: Adding to iommu group 0
[    4.233109] etnaviv-gpu f0c0000.gpu: Adding to iommu group 1
[    4.239714] etnaviv etnaviv: Adding to iommu group 1
[    4.245505] etnaviv etnaviv: bound f0c0000.gpu (ops gpu_ops)
[    4.251211] etnaviv-gpu f0c0000.gpu: model: GC7000, revision: 6202
[    4.257958] [drm] Initialized etnaviv 1.3.0 20151214 for etnaviv on minor 0
[    4.271055] loop: module loaded
[    4.274424] at24 0-0050: supply vcc not found, using dummy regulator
[    4.281801] at24 0-0050: 4096 byte 24c32 EEPROM, writable, 32 bytes/write
[    4.288753] at24 1-0057: supply vcc not found, using dummy regulator
[    4.296084] at24 1-0057: 4096 byte 24c32 EEPROM, writable, 32 bytes/write
[    4.303017] at24 2-0050: supply vcc not found, using dummy regulator
[    4.310346] at24 2-0050: 4096 byte 24c32 EEPROM, writable, 32 bytes/write
[    4.319313] simple-mfd-i2c 0-004a: mask_invert=true is deprecated; please switch to unmask_base
[    4.334307] simple-mfd-i2c 0-004a: mask_invert=true is deprecated; please switch to unmask_base
[    4.349989] simple-mfd-i2c 0-004a: mask_invert=true is deprecated; please switch to unmask_base
[    4.361226] ahci-qoriq 3200000.sata: Adding to iommu group 2
[    4.367214] ahci-qoriq 3200000.sata: supply ahci not found, using dummy regulator
[    4.374883] ahci-qoriq 3200000.sata: supply phy not found, using dummy regulator
[    4.382365] ahci-qoriq 3200000.sata: supply target not found, using dummy regulator
[    4.390236] ahci-qoriq 3200000.sata: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl platform mode
[    4.399238] ahci-qoriq 3200000.sata: flags: 64bit ncq sntf pm clo only pmp fbs pio slum part ccc sds apst 
[    4.409869] scsi host0: ahci-qoriq
[    4.413691] ata1: SATA max UDMA/133 mmio [mem 0x03200000-0x0320ffff] port 0x100 irq 97
[    4.424101] spi-nor spi0.0: w25q32dw (4096 Kbytes)
[    4.430762] 5 fixed-partitions partitions found on MTD device 20c0000.spi
[    4.437592] Creating 5 MTD partitions on "20c0000.spi":
[    4.442846] 0x000000000000-0x000000010000 : "rcw"
[    4.448921] 0x000000010000-0x0000001e0000 : "failsafe bootloader"
[    4.456317] 0x000000200000-0x000000210000 : "configuration store"
[    4.463701] 0x000000210000-0x0000003e0000 : "bootloader"
[    4.470257] 0x0000003e0000-0x000000400000 : "bootloader environment"
[    4.486458] tun: Universal TUN/TAP device driver, 1.6
[    4.491787] CAN device driver interface
[    4.496840] mscc_felix 0000:00:00.5: Adding to iommu group 3
[    4.502850] mscc_felix 0000:00:00.5: enabling device (0400 -> 0402)
[    4.510011] fsl_enetc 0000:00:00.0: Adding to iommu group 4
[    4.516120] fsl_enetc 0000:00:00.1: Adding to iommu group 5
[    4.522157] fsl_enetc 0000:00:00.2: Adding to iommu group 6
[    4.528200] fsl_enetc 0000:00:00.6: Adding to iommu group 7
[    4.534593] fsl_enetc_mdio 0000:00:00.3: Adding to iommu group 8
[    4.647922] fsl_enetc_mdio 0000:00:00.3: enabling device (0400 -> 0402)
[    4.667722] igb: Intel(R) Gigabit Ethernet Network Driver
[    4.673174] igb: Copyright (c) 2007-2014 Intel Corporation.
[    4.678828] Intel(R) 2.5G Ethernet Linux Driver
[    4.683375] Copyright(c) 2018 Intel Corporation.
[    4.688635] usbcore: registered new interface driver rt2500usb
[    4.694843] VFIO - User Level meta-driver version: 0.3
[    4.700568] dwc3 3100000.usb: Adding to iommu group 9
[    4.706681] dwc3 3110000.usb: Adding to iommu group 10
[    4.714332] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    4.719876] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
[    4.728010] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220f66d hci version 0x100 quirks 0x0000002002010010
[    4.737492] xhci-hcd xhci-hcd.0.auto: irq 103, io mem 0x03110000
[    4.742205] ata1: SATA link down (SStatus 0 SControl 300)
[    4.743723] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    4.754446] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
[    4.762144] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    4.770353] hub 1-0:1.0: USB hub found
[    4.774168] hub 1-0:1.0: 1 port detected
[    4.778621] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    4.787446] hub 2-0:1.0: USB hub found
[    4.791260] hub 2-0:1.0: 1 port detected
[    4.795706] usbcore: registered new interface driver usb-storage
[    4.802992] using random self ethernet address
[    4.807461] using random host ethernet address
[    4.812417] usb0: HOST MAC 66:d9:81:9a:da:74
[    4.816706] usb0: MAC b2:03:ea:f1:ce:7e
[    4.820603] using random self ethernet address
[    4.825066] using random host ethernet address
[    4.829598] g_ether gadget.0: Ethernet Gadget, version: Memorial Day 2008
[    4.836414] g_ether gadget.0: g_ether ready
[    4.842959] UDC core: g_mass_storage: couldn't find an available UDC
[    4.849388] UDC core: g_serial: couldn't find an available UDC
[    4.855794] input: buttons1 as /devices/platform/buttons1/input/input0
[    4.864689] ftm-alarm 2800000.timer: registered as rtc1
[    4.873259] rtc-rv8803 0-0032: registered as rtc0
[    4.879771] rtc-rv8803 0-0032: setting system clock to 2022-12-06T22:54:12 UTC (1670367252)
[    4.888539] i2c_dev: i2c /dev entries driver
[    4.905250] sp805-wdt c000000.watchdog: registration successful
[    4.911495] sp805-wdt c010000.watchdog: registration successful
[    4.919716] sl28cpld-wdt 2000000.i2c:sl28cpld@4a:watchdog@4: initial timeout 8 sec
[    4.927813] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised: dm-devel@redhat.com
[    4.936512] device-mapper: multipath round-robin: version 1.2.0 loaded
[    4.943072] device-mapper: multipath queue-length: version 0.2.0 loaded
[    4.949715] device-mapper: multipath service-time: version 0.3.0 loaded
[    4.956368] device-mapper: multipath historical-service-time: version 0.1.1 loaded
[    4.964433] EDAC MC0: Giving out device to module fsl_ddr_edac controller fsl_mc_err: DEV fsl_mc_err (INTERRUPT)
[    4.974779] fsl_ddr_edac acquired irq 105 for MC
[    4.979418] fsl_ddr_edac MC err registered
[    4.984374] qoriq-cpufreq qoriq-cpufreq: Freescale QorIQ CPU frequency scaling driver
[    4.992970] sdhci: Secure Digital Host Controller Interface driver
[    4.999182] sdhci: Copyright(c) Pierre Ossman
[    5.003738] Synopsys Designware Multimedia Card Interface Driver
[    5.010112] sdhci-pltfm: SDHCI platform and OF driver helper
[    5.016438] sdhci-esdhc 2140000.mmc: Adding to iommu group 11
[    5.016566] sdhci-esdhc 2150000.mmc: Adding to iommu group 12
[    5.031959] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    5.039631] ledtrig-cpu: registered to indicate activity on CPUs
[    5.046670] caam 8000000.crypto: device ID = 0x0a12070000000000 (Era 10)
[    5.051059] mmc1: SDHCI controller on 2140000.mmc [2140000.mmc] using ADMA
[    5.053419] caam 8000000.crypto: job rings = 4, qi = 0
[    5.060375] mmc0: SDHCI controller on 2150000.mmc [2150000.mmc] using ADMA
[    5.067049] caam_jr 8010000.jr: Adding to iommu group 13
[    5.078382] caam algorithms registered in /proc/crypto
[    5.083727] caam 8000000.crypto: registering rng-caam
[    5.088997] caam 8000000.crypto: rng crypto API alg registered prng-caam
[    5.095980] caam_jr 8020000.jr: Adding to iommu group 14
[    5.102059] caam_jr 8030000.jr: Adding to iommu group 15
[    5.108250] caam_jr 8040000.jr: Adding to iommu group 16
[    5.114977] usbcore: registered new interface driver usbhid
[    5.120597] usbhid: USB HID core driver
[    5.128255] drop_monitor: Initializing network drop monitor service
[    5.135499] NET: Registered PF_INET6 protocol family
[    5.141803] Segment Routing with IPv6
[    5.145539] In-situ OAM (IOAM) with IPv6
[    5.149556] NET: Registered PF_PACKET protocol family
[    5.149942] random: crng init done
[    5.155014] can: controller area network core
[    5.162560] NET: Registered PF_CAN protocol family
[    5.167375] can: raw protocol
[    5.168655] mmc0: new HS400 MMC card at address 0001
[    5.170355] can: broadcast manager protocol
[    5.176827] mmcblk0: mmc0:0001 S0J58X 29.6 GiB 
[    5.179545] can: netlink gateway - max_hops=1
[    5.187508] mmc0: Got data interrupt 0x00600000 even though no data operation was in progress.
[    5.188673] 8021q: 802.1Q VLAN Support v1.8
[    5.197095] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    5.197098] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00002202
[    5.197101] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000008
[    5.197105] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000033
[    5.201429] 9pnet: Installing 9P2000 support
[    5.207750] mmc0: sdhci: Present:   0x017d0008 | Host ctl: 0x00000034
[    5.207754] mmc0: sdhci: Power:     0x00000006 | Blk gap:  0x00000000
[    5.207757] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000208
[    5.214287] Key type dns_resolver registered
[    5.220670] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000001
[    5.220673] mmc0: sdhci: Int enab:  0x037f100f | Sig enab: 0x037f100b
[    5.220676] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00002202
[    5.274421] mmc0: sdhci: Caps:      0x00fa0000 | Caps_1:   0x0000af00
[    5.280881] mmc0: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
[    5.287340] mmc0: sdhci: Resp[0]:   0x00000b00 | Resp[1]:  0x0000000c
[    5.293799] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[    5.300257] mmc0: sdhci: Host ctl2: 0x00000080
[    5.304710] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xfffff200
[    5.311169] mmc0: sdhci: ============================================
[    5.317843] registered taskstats version 1
[    5.321969] Loading compiled-in X.509 certificates
[    5.328378] Key type encrypted registered
[    5.331948] mmc0: Got data interrupt 0x00600000 even though no data operation was in progress.
[    5.341041] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    5.347499] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00002202
[    5.353958] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000008
[    5.360418] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000033
[    5.366877] mmc0: sdhci: Present:   0x017d0008 | Host ctl: 0x00000034
[    5.373336] mmc0: sdhci: Power:     0x00000006 | Blk gap:  0x00000000
[    5.379795] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000208
[    5.386254] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000001
[    5.392713] mmc0: sdhci: Int enab:  0x037f100f | Sig enab: 0x037f100b
[    5.399171] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00002202
[    5.405630] mmc0: sdhci: Caps:      0x00fa0000 | Caps_1:   0x0000af00
[    5.412089] mmc0: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
[    5.418548] mmc0: sdhci: Resp[0]:   0x00000b00 | Resp[1]:  0x0000000c
[    5.425007] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[    5.431466] mmc0: sdhci: Host ctl2: 0x00000080
[    5.435919] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xfffff200
[    5.442377] mmc0: sdhci: ============================================
[    5.457459] fsl-edma 22c0000.dma-controller: Adding to iommu group 17
[    5.467435] pcieport 0001:00:00.0: Adding to iommu group 18
[    5.473530] pcieport 0001:00:00.0: PME: Signaling with IRQ 114
[    5.479801] pcieport 0001:00:00.0: AER: enabled with IRQ 114
[    5.481720] mmc1: new ultra high speed SDR50 SDHC card at address aaaa
[    5.485836] pcieport 0002:00:00.0: Adding to iommu group 19
[    5.493418] mmcblk1: mmc1:aaaa SS32G 29.7 GiB 
[    5.498233] pcieport 0002:00:00.0: PME: Signaling with IRQ 115
[    5.508478] hub 1-1:1.0: USB hub found
[    5.509436] pcieport 0002:00:00.0: AER: enabled with IRQ 115
[    5.517988] hub 1-1:1.0: 7 ports detected
[    5.522490] fsl-qdma 8380000.dma-controller: Adding to iommu group 20
[    5.535499] GPT:Primary header thinks Alt. header is not at the end of the disk.
[    5.542944] GPT:335911 != 62333951
[    5.546374] GPT:Alternate GPT header not at the end of the disk.
[    5.552408] GPT:335911 != 62333951
[    5.555815] GPT: Use GNU Parted to correct GPT errors.
[    5.560985]  mmcblk1: p1
[    5.592705] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[    5.613271] I/O error, dev mmcblk0, sector 1 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[    5.633824] I/O error, dev mmcblk0, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[    5.635923] fsl_enetc 0000:00:00.0: enabling device (0400 -> 0402)
[    5.650028] fsl_enetc 0000:00:00.0: no MAC address specified for SI1, using 36:f8:91:5e:92:4e
[    5.654379] I/O error, dev mmcblk0, sector 3 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[    5.658592] fsl_enetc 0000:00:00.0: no MAC address specified for SI2, using 36:44:6e:67:38:aa
[    5.679184] I/O error, dev mmcblk0, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[    5.699770] I/O error, dev mmcblk0, sector 5 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[    5.720324] I/O error, dev mmcblk0, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[    5.740871] I/O error, dev mmcblk0, sector 7 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[    5.749350] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[    5.783929] fsl_enetc 0000:00:00.1: enabling device (0400 -> 0402)
[    5.791624] fsl_enetc 0000:00:00.1: no MAC address specified for SI1, using c6:4d:56:a3:e6:80
[    5.800192] fsl_enetc 0000:00:00.1: no MAC address specified for SI2, using a2:a8:f4:4c:86:5c
[    5.804928] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[    5.829368] I/O error, dev mmcblk0, sector 1 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[    5.875931] usb 1-1.6: new full-speed USB device number 3 using xhci-hcd
[    5.910305] Buffer I/O error on dev mmcblk0, logical block 0, async page read
[    5.915920] fsl_enetc 0000:00:00.2: enabling device (0400 -> 0402)
[    5.917496]  mmcblk0: unable to read partition table
[    5.924282] fsl_enetc 0000:00:00.2: no MAC address specified for SI0, using 2a:36:06:e9:39:3e
[    5.929857] mmcblk0boot0: mmc0:0001 S0J58X 31.5 MiB 
[    5.946345] mmcblk0boot1: mmc0:0001 S0J58X 31.5 MiB 
[    5.954408] mmcblk0rpmb: mmc0:0001 S0J58X 4.00 MiB, chardev (239:0)
[    6.018613] hid-generic 0003:064F:2AF9.0001: device has no listeners, quitting
[    6.043934] fsl_enetc 0000:00:00.6: enabling device (0400 -> 0402)
[    6.050759] fsl_enetc 0000:00:00.6: no MAC address specified for SI0, using a6:98:1b:5f:5e:c1
[    6.070601] mscc_felix 0000:00:00.5: Found PCS at internal MDIO address 0
[    6.077468] mscc_felix 0000:00:00.5: Found PCS at internal MDIO address 1
[    6.084293] mscc_felix 0000:00:00.5: Found PCS at internal MDIO address 2
[    6.091116] mscc_felix 0000:00:00.5: Found PCS at internal MDIO address 3
[    6.125025] mscc_felix 0000:00:00.5: configuring for fixed/internal link mode
[    6.132237] mscc_felix 0000:00:00.5: Link is Up - 2.5Gbps/Full - flow control rx/tx
[    6.142325] mscc_felix 0000:00:00.5: configuring for fixed/internal link mode
[    6.149536] mscc_felix 0000:00:00.5: Link is Up - 1Gbps/Full - flow control rx/tx
[    6.214421] mscc_felix 0000:00:00.5 swp0 (uninitialized): PHY [0000:00:00.3:07] driver [Broadcom BCM54140] (irq=POLL)
[    6.286422] mscc_felix 0000:00:00.5 swp1 (uninitialized): PHY [0000:00:00.3:08] driver [Broadcom BCM54140] (irq=POLL)
[    6.362419] mscc_felix 0000:00:00.5 swp2 (uninitialized): PHY [0000:00:00.3:09] driver [Broadcom BCM54140] (irq=POLL)
[    6.438415] mscc_felix 0000:00:00.5 swp3 (uninitialized): PHY [0000:00:00.3:0a] driver [Broadcom BCM54140] (irq=POLL)
[    6.450295] device eth2 entered promiscuous mode
[    6.455121] device eth3 entered promiscuous mode
[    6.459798] DSA: tree 0 setup
[    6.465671] input: buttons0 as /devices/platform/buttons0/input/input1
[    6.472663] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    6.481728] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    6.488387] ALSA device list:
[    6.491361]   No soundcards found.
[    6.494979] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    6.503633] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[    6.511840] /dev/root: Can't open blockdev
[    6.516016] VFS: Cannot open root device "mmcblk0p1" or unknown-block(179,1): error -6
[    6.523970] Please append a correct "root=" boot option; here are the available partitions:
[    6.532361] 1f00            4096 mtdblock0 
[    6.532366]  (driver?)
[    6.538922] 1f01              64 mtdblock1 
[    6.538925]  (driver?)
[    6.545485] 1f02            1856 mtdblock2 
[    6.545489]  (driver?)
[    6.552048] 1f03              64 mtdblock3 
[    6.552051]  (driver?)
[    6.558606] 1f04            1856 mtdblock4 
[    6.558609]  (driver?)
[    6.565168] 1f05             128 mtdblock5 
[    6.565172]  (driver?)
[    6.571727] b300        30998528 mmcblk0 
[    6.571730]  driver: mmcblk
[    6.578550] b320        31166976 mmcblk1 
[    6.578553]  driver: mmcblk
[    6.585376]   b321          163840 mmcblk1p1 e1a2b0ea-7fa6-4c3b-9ce5-4be8357594ff
[    6.585381] 
[    6.594380] b340           32256 mmcblk0boot0 
[    6.594383]  (driver?)
[    6.601204] b360           32256 mmcblk0boot1 
[    6.601207]  (driver?)
[    6.608027] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(179,1)
[    6.616493] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc5-00096-g57820c1dbb82 #1936
[    6.624700] Hardware name: Kontron KBox A-230-LS (DT)
[    6.629764] Call trace:
[    6.632211]  dump_backtrace.part.0+0xe8/0xf4
[    6.636504]  show_stack+0x20/0x40
[    6.639825]  dump_stack_lvl+0x68/0x84
[    6.643497]  dump_stack+0x18/0x34
[    6.646818]  panic+0x17c/0x360
[    6.649878]  mount_block_root+0x184/0x234
[    6.653899]  mount_root+0x20c/0x248
[    6.657395]  prepare_namespace+0x138/0x178
[    6.661502]  kernel_init_freeable+0x2e0/0x30c
[    6.665870]  kernel_init+0x2c/0x140
[    6.669367]  ret_from_fork+0x10/0x20
[    6.672951] SMP: stopping secondary CPUs
[    6.676885] Kernel Offset: disabled
[    6.680378] CPU features: 0x20000,2003c084,0000421b
[    6.685268] Memory Limit: none
[    6.688330] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(179,1) ]---

