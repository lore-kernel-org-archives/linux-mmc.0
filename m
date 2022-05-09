Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D38C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  9 May 2022 10:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiEIK5F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 May 2022 06:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiEIK5D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2022 06:57:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3291D5257
        for <linux-mmc@vger.kernel.org>; Mon,  9 May 2022 03:52:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i10so23049031lfg.13
        for <linux-mmc@vger.kernel.org>; Mon, 09 May 2022 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hOAC+NoqeQYZXvlV4pHGNakU3qlX7xNu4f0vPCSOPB8=;
        b=Ccz2gGen/boIT1r6tKYk77AXwWk1a4KtoUB6AxIJxCoTlJdcIOzunfHFGzlvVDMTA2
         418Yhbq6WIIYCyBlW60wYaCLdYLKdgUr4iLD4X5WvplIoCRNlsDoDtFp2W+/p0ulK8jo
         yDx3O8fCZ2CbfIxUkZTn45GMoWHi2hp/UJMp/U6z+RcLzW4iOOVv4ireBwdoV+K5CRB+
         UHB7ds9bhUr62nezER3PsEtxQvkSj3pp6OHTdZ6yOz2zm3LhhACWNyngm0kqGAFr/V6S
         XIQaJpeD5it1C0AZ7CG5CPwHuHS9fTM1eOc6bFD1oI20zdAhpySy/k4OkygNSeCvfLBu
         n7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hOAC+NoqeQYZXvlV4pHGNakU3qlX7xNu4f0vPCSOPB8=;
        b=0CmwtxXl6OeH3B8mkWU0L7+jW4z5Gr9NYPhakDDHK3VLdkAQ7HBu+fKzBEtf3bm1g8
         ezsP63s2nJ6Cp63g531bpEBzK0B6cMm4giHKEz0NuD96s1rB2bScdQMyrdlplFGt2RdM
         8MFblHxfw378CYXkrzImz+YlhUrpgyYBM7Ng3I52o7vudYuzXAYint2JQILqbcdXzaiC
         WOnmOS/T7solQwNudFjUxEeSUcyXRTj2eWONYqmj/AItqFu5vxsfdFBUyc29o2M3dC+2
         eOcytXUyBrKgqcWWu75REHiRstVkNLCZhOFX02bodjmdIgU3VuG36jBY/gaWi10AdS6I
         32TA==
X-Gm-Message-State: AOAM532Z43vyjrYHKOxEjnIk3bTjFjBeTc/rRUVSLh2YSpgSgh30ubcP
        8qNCLPbuJ0nLBKGTV5nbs5xaqFfgRtBlKLDVXQY=
X-Google-Smtp-Source: ABdhPJzLKuEhAIOdOtrJkDBkBt2E2Zgsknlbh50BcbPQp5sT3DLRP97PgEIQ2RIyv6lxeTuv53yLMvsf+6gIMCgLdRI=
X-Received: by 2002:a05:6512:10c2:b0:473:b559:2016 with SMTP id
 k2-20020a05651210c200b00473b5592016mr12366779lfg.641.1652093572728; Mon, 09
 May 2022 03:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <CANugAwZbxm=enE9rN80cx7seKWJatO_Seye7NxryfLoeSue30A@mail.gmail.com>
 <YnY2tFwiIfdT9ATX@smile.fi.intel.com> <CANugAwb-eO86E3HUsd_O0RpHG2FROo070apW5Dt0nJ1kQfG7nQ@mail.gmail.com>
 <dc087e900618424e8e4804e97342728d@hyperstone.com>
In-Reply-To: <dc087e900618424e8e4804e97342728d@hyperstone.com>
From:   xc zhang <yujianxuechuan@gmail.com>
Date:   Mon, 9 May 2022 18:52:42 +0800
Message-ID: <CANugAwZmNz+ek2da7NHjqSjUe2r7gwsNAWnNEd11GQSi3BHFHA@mail.gmail.com>
Subject: Re: About "mmc: block: Check for errors after write on SPI"
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sorry for my mistake,  this is happen when dts changed to the upstream
kernel build, not with this patch.
maybe some hardware compatibility, when I set "max-frequency =3D
<150000000>;" in dts ,sbc boots normally , when missing this , It
failed to boot

thanks again!

Christian L=C3=B6hle <CLoehle@hyperstone.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=
=889=E6=97=A5=E5=91=A8=E4=B8=80 15:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Hey Xc Zhang,
> Are you sure you're only reverting the named commit 5d435933376962b107bd7=
6970912e7e80247dcc7
> I really do not see how my patch changed the behavior on a non-spi card a=
nd you are obviously using cqe with an eMMC.
> If you're sure about this particular commit, could you try this please:
>
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 506dc900f5c7..199fa97996b5 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1932,6 +1932,7 @@ static int mmc_blk_card_busy(struct mmc_card *card,=
 struct request *req)
>                 return 0;
>
>         if (mmc_host_is_spi(card->host)) {
> +               printk("CARD IS MARKED AS SPI\n");
>                 err =3D mmc_spi_err_check(card);
>                 if (err)
>                         mqrq->brq.data.bytes_xfered =3D 0;
>
>
>
> From: xc zhang <yujianxuechuan@gmail.com>
> Sent: Saturday, May 7, 2022 11:46 AM
> To: Andy Shevchenko
> Cc: Ulf Hansson; Christian L=C3=B6hle; linux-mmc@vger.kernel.org
> Subject: Re: About "mmc: block: Check for errors after write on SPI"
>
>
> 1. dts is rk3399-rock-pi-4b.dts
>
>
> 2. sbc has emmc port (using this , 32GB) and sdcard port (not using), and=
 an spi flash(4MB, but dts not include this spi flash) , sbc picture in att=
achment
>
>
> 3. dmesg for good boot is :
>
>
> zxc@rp4e:~$ dmesg
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version 5.15.37-00001-ge4161314ae45-dirty (zxc@zxc-Q=
iTianM425-N000) (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profil=
e Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolc=
hain for the A-profile Architecture  10.3-2021.07 (arm-10.29)) 2.36.1.20210=
621) #4 SMP PREEMPT Fri May 6 19:31:19 CST 2022
> [    0.000000] Machine model: Radxa ROCK Pi 4B
> [    0.000000] efi: UEFI not found.
> [    0.000000] earlycon: uart0 at MMIO32 0x00000000ff1a0000 (options '150=
0000n8')
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem 0x0000000000200000-0x000000007=
fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x7fb98c00-0x7fb9afff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000200000-0x000000007fffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000200000-0x000000007fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x000000007ff=
fffff]
> [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
> [    0.000000] cma: Reserved 32 MiB at 0x000000007b800000
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.0 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.0
> [    0.000000] percpu: Embedded 28 pages/cpu s74520 r8192 d31976 u114688
> [    0.000000] pcpu-alloc: s74520 r8192 d31976 u114688 alloc=3D28*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5
> [    0.000000] Detected VIPT I-cache on CPU0
> [    0.000000] CPU features: detected: GIC system register CPU interface
> [    0.000000] CPU features: detected: ARM erratum 845719
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 515=
592
> [    0.000000] Policy zone: DMA
> [    0.000000] Kernel command line: root=3DUUID=3D9e30106a-e841-4a98-8b1f=
-a54a4122c16e rootwait rootfstype=3Dext4 bootsplash.bootfile=3Dbootsplash.a=
rmbian earlycon console=3DttyS2,1500000  consoleblank=3D0 loglevel=3D8 uboo=
tpart=3D7f91284d-01 usb-storage.quirks=3D0x2537:0x1066:u,0x2537:0x1068:u   =
 cgroup_enable=3Dcpuset cgroup_memory=3D1 cgroup_enable=3Dmemory swapaccoun=
t=3D1
> [    0.000000] Unknown kernel command line parameters "ubootpart=3D7f9128=
4d-01 cgroup_enable=3Dmemory cgroup_memory=3D1", will be passed to user spa=
ce.
> [    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152=
 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 =
bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 1970144K/2095104K available (16512K kernel code, 3=
916K rwdata, 8924K rodata, 7168K init, 511K bss, 92192K reserved, 32768K cm=
a-reserved)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D6,=
 Nodes=3D1
> [    0.000000] trace event string verifier disabled
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu=
_ids=3D6.
> [    0.000000]  Trampoline variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is=
 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D6
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> [    0.000000] GICv3: 256 SPIs implemented
> [    0.000000] GICv3: 0 Extended SPIs implemented
> [    0.000000] GICv3: Distributor has no Range Selector support
> [    0.000000] Root IRQ handler: gic_handle_irq
> [    0.000000] GICv3: 16 PPIs implemented
> [    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000fef0=
0000
> [    0.000000] ITS [mem 0xfee20000-0xfee3ffff]
> [    0.000000] ITS@0x00000000fee20000: allocated 65536 Devices @500000 (f=
lat, esz 8, psz 64K, shr 0)
> [    0.000000] ITS: using cache flushing for cmd queue
> [    0.000000] GICv3: using LPI property table @0x00000000004d0000
> [    0.000000] GIC: using cache flushing for LPI property table
> [    0.000000] GICv3: CPU0: using allocated LPI pending table @0x00000000=
004e0000
> [    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] { /cpus=
/cpu@0[0] /cpus/cpu@1[1] /cpus/cpu@2[2] /cpus/cpu@3[3] }
> [    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] { /cpus=
/cpu@100[4] /cpus/cpu@101[5] }
> [    0.000000] random: get_random_bytes called from start_kernel+0x4d8/0x=
6c8 with crng_init=3D0
> [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_=
cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000000] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps ever=
y 4398046511097ns
> [    0.004984] Console: colour dummy device 80x25
> [    0.005525] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 48.00 BogoMIPS (lpj=3D96000)
> [    0.006509] pid_max: default: 32768 minimum: 301
> [    0.007067] LSM: Security Framework initializing
> [    0.007657] Mount-cache hash table entries: 4096 (order: 3, 32768 byte=
s, linear)
> [    0.008378] Mountpoint-cache hash table entries: 4096 (order: 3, 32768=
 bytes, linear)
> [    0.011742] rcu: Hierarchical SRCU implementation.
> [    0.012599] Platform MSI: interrupt-controller@fee20000 domain created
> [    0.013744] PCI/MSI: /interrupt-controller@fee00000/interrupt-controll=
er@fee20000 domain created
> [    0.014907] fsl-mc MSI: interrupt-controller@fee20000 domain created
> [    0.022246] EFI services will not be available.
> [    0.023190] smp: Bringing up secondary CPUs ...
> [    0.024427] Detected VIPT I-cache on CPU1
> [    0.024490] GICv3: CPU1: found redistributor 1 region 0:0x00000000fef2=
0000
> [    0.024514] GICv3: CPU1: using allocated LPI pending table @0x00000000=
004f0000
> [    0.024584] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
> [    0.025682] Detected VIPT I-cache on CPU2
> [    0.025745] GICv3: CPU2: found redistributor 2 region 0:0x00000000fef4=
0000
> [    0.025769] GICv3: CPU2: using allocated LPI pending table @0x00000000=
00580000
> [    0.025835] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
> [    0.026992] Detected VIPT I-cache on CPU3
> [    0.027054] GICv3: CPU3: found redistributor 3 region 0:0x00000000fef6=
0000
> [    0.027078] GICv3: CPU3: using allocated LPI pending table @0x00000000=
00590000
> [    0.027143] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
> [    0.028273] CPU features: detected: Spectre-v2
> [    0.028285] CPU features: detected: Spectre-v3a
> [    0.028292] CPU features: detected: Spectre-v4
> [    0.028296] CPU features: detected: Spectre-BHB
> [    0.028306] CPU features: detected: ARM errata 1165522, 1319367, or 15=
30923
> [    0.028312] Detected PIPT I-cache on CPU4
> [    0.028349] GICv3: CPU4: found redistributor 100 region 0:0x00000000fe=
f80000
> [    0.028367] GICv3: CPU4: using allocated LPI pending table @0x00000000=
005a0000
> [    0.028411] CPU4: Booted secondary processor 0x0000000100 [0x410fd082]
> [    0.029350] Detected PIPT I-cache on CPU5
> [    0.029395] GICv3: CPU5: found redistributor 101 region 0:0x00000000fe=
fa0000
> [    0.029414] GICv3: CPU5: using allocated LPI pending table @0x00000000=
005b0000
> [    0.029458] CPU5: Booted secondary processor 0x0000000101 [0x410fd082]
> [    0.029594] smp: Brought up 1 node, 6 CPUs
> [    0.044082] SMP: Total of 6 processors activated.
> [    0.044536] CPU features: detected: 32-bit EL0 Support
> [    0.045027] CPU features: detected: 32-bit EL1 Support
> [    0.045520] CPU features: detected: CRC32 instructions
> [    0.063825] CPU: All CPU(s) started at EL2
> [    0.064294] alternatives: patching kernel code
> [    0.067226] devtmpfs: initialized
> [    0.079491] KASLR disabled due to lack of seed
> [    0.080122] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
> [    0.081087] futex hash table entries: 2048 (order: 5, 131072 bytes, li=
near)
> [    0.082708] pinctrl core: initialized pinctrl subsystem
> [    0.084248] DMI not present or invalid.
> [    0.085130] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.087960] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic alloc=
ations
> [    0.088860] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atom=
ic allocations
> [    0.089859] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for at=
omic allocations
> [    0.090681] audit: initializing netlink subsys (disabled)
> [    0.091386] audit: type=3D2000 audit(0.088:1): state=3Dinitialized aud=
it_enabled=3D0 res=3D1
> [    0.092709] thermal_sys: Registered thermal governor 'step_wise'
> [    0.092718] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.093704] cpuidle: using governor menu
> [    0.094981] hw-breakpoint: found 6 breakpoint and 4 watchpoint registe=
rs.
> [    0.095835] ASID allocator initialised with 65536 entries
> [    0.098460] Serial: AMBA PL011 UART driver
> [    0.130258] platform ff770000.syscon:phy@f780: Fixing up cyclic depend=
ency with fe330000.mmc
> [    0.139248] platform ff940000.hdmi: Fixing up cyclic dependency with f=
f8f0000.vop
> [    0.140039] platform ff940000.hdmi: Fixing up cyclic dependency with f=
f900000.vop
> [    0.148649] rockchip-gpio ff720000.gpio0: probed /pinctrl/gpio0@ff7200=
00
> [    0.150037] rockchip-gpio ff730000.gpio1: probed /pinctrl/gpio1@ff7300=
00
> [    0.151337] rockchip-gpio ff780000.gpio2: probed /pinctrl/gpio2@ff7800=
00
> [    0.152628] rockchip-gpio ff788000.gpio3: probed /pinctrl/gpio3@ff7880=
00
> [    0.153940] rockchip-gpio ff790000.gpio4: probed /pinctrl/gpio4@ff7900=
00
> [    0.171775] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pag=
es
> [    0.172440] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pag=
es
> [    0.173097] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pag=
es
> [    0.173753] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pag=
es
> [    0.176190] cryptd: max_cpu_qlen set to 1000
> [    0.180174] ACPI: Interpreter disabled.
> [    0.184027] vcc5v0_sys: supplied by vcc12v_dcin
> [    0.184887] vcc3v3_pcie: supplied by vcc5v0_sys
> [    0.185606] vcc3v3_sys: supplied by vcc5v0_sys
> [    0.186409] vcc5v0_host: supplied by vcc5v0_sys
> [    0.187193] vcc5v0_typec: supplied by vcc5v0_sys
> [    0.188925] iommu: Default domain type: Translated
> [    0.189409] iommu: DMA domain TLB invalidation policy: strict mode
> [    0.192474] vgaarb: loaded
> [    0.193037] SCSI subsystem initialized
> [    0.193578] libata version 3.00 loaded.
> [    0.194168] usbcore: registered new interface driver usbfs
> [    0.194746] usbcore: registered new interface driver hub
> [    0.195298] usbcore: registered new device driver usb
> [    0.197319] pps_core: LinuxPPS API ver. 1 registered
> [    0.197807] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
> [    0.198706] PTP clock support registered
> [    0.199299] EDAC MC: Ver: 3.0.0
> [    0.202353] FPGA manager framework
> [    0.202777] Advanced Linux Sound Architecture Driver Initialized.
> [    0.204347] clocksource: Switched to clocksource arch_sys_counter
> [    0.248146] VFS: Disk quotas dquot_6.6.0
> [    0.248631] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
> [    0.249516] pnp: PnP ACPI: disabled
> [    0.258511] NET: Registered PF_INET protocol family
> [    0.259193] IP idents hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
> [    0.261801] tcp_listen_portaddr_hash hash table entries: 1024 (order: =
2, 16384 bytes, linear)
> [    0.262683] TCP established hash table entries: 16384 (order: 5, 13107=
2 bytes, linear)
> [    0.263628] TCP bind hash table entries: 16384 (order: 6, 262144 bytes=
, linear)
> [    0.264706] TCP: Hash tables configured (established 16384 bind 16384)
> [    0.265484] UDP hash table entries: 1024 (order: 3, 32768 bytes, linea=
r)
> [    0.266211] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, =
linear)
> [    0.267084] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.268208] RPC: Registered named UNIX socket transport module.
> [    0.268813] RPC: Registered udp transport module.
> [    0.269274] RPC: Registered tcp transport module.
> [    0.269735] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.270367] PCI: CLS 0 bytes, default 64
> [    0.271081] Unpacking initramfs...
> [    0.281029] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7=
 counters available
> [    0.282238] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7=
 counters available
> [    0.283595] kvm [1]: IPA Size Limit: 40 bits
> [    0.285663] kvm [1]: vgic-v2@fff20000
> [    0.286050] kvm [1]: GIC system register CPU interface enabled
> [    0.286857] kvm [1]: vgic interrupt IRQ18
> [    0.287510] kvm [1]: Hyp mode initialized successfully
> [    0.293669] Initialise system trusted keyrings
> [    0.294302] workingset: timestamp_bits=3D42 max_order=3D19 bucket_orde=
r=3D0
> [    0.301965] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.303330] NFS: Registering the id_resolver key type
> [    0.303851] Key type id_resolver registered
> [    0.304263] Key type id_legacy registered
> [    0.304769] nfs4filelayout_init: NFSv4 File Layout Driver Registering.=
..
> [    0.305427] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regi=
stering...
> [    0.306352] 9p: Installing v9fs 9p2000 file system support
> [    0.372967] Key type asymmetric registered
> [    0.373376] Asymmetric key parser 'x509' registered
> [    0.373915] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 245)
> [    0.374639] io scheduler mq-deadline registered
> [    0.375084] io scheduler kyber registered
> [    0.405475] EINJ: ACPI disabled.
> [    0.420637] dma-pl330 ff6d0000.dma-controller: Loaded driver for PL330=
 DMAC-241330
> [    0.421389] dma-pl330 ff6d0000.dma-controller:       DBUFF-32x8bytes N=
um_Chans-6 Num_Peri-12 Num_Events-12
> [    0.423482] dma-pl330 ff6e0000.dma-controller: Loaded driver for PL330=
 DMAC-241330
> [    0.424228] dma-pl330 ff6e0000.dma-controller:       DBUFF-128x8bytes =
Num_Chans-8 Num_Peri-20 Num_Events-16
> [    0.437100] vdd_log: supplied by regulator-dummy
> [    0.444129] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.447489] ff180000.serial: ttyS0 at MMIO 0xff180000 (irq =3D 42, bas=
e_baud =3D 1500000) is a 16550A
> [    0.448574] serial serial0: tty port ttyS0 registered
> [    0.449889] ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq =3D 43, bas=
e_baud =3D 1500000) is a 16550A
> [    0.450932] printk: console [ttyS2] enabled
> [    0.451712] printk: bootconsole [uart0] disabled
> [    0.455025] SuperH (H)SCI(F) driver initialized
> [    0.456516] msm_serial: driver initialized
> [    0.460079] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [    0.470204] loop: module loaded
> [    0.472862] megasas: 07.717.02.00-rc1
> [    0.488087] tun: Universal TUN/TAP device driver, 1.6
> [    0.490892] thunder_xcv, ver 1.0
> [    0.491245] thunder_bgx, ver 1.0
> [    0.491594] nicpf, ver 1.0
> [    0.495216] hclge is initializing
> [    0.495546] hns3: Hisilicon Ethernet Network Driver for Hip08 Family -=
 version
> [    0.496186] hns3: Copyright (c) 2017 Huawei Corporation.
> [    0.496773] e1000: Intel(R) PRO/1000 Network Driver
> [    0.497210] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    0.497777] e1000e: Intel(R) PRO/1000 Network Driver
> [    0.498218] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    0.498798] igb: Intel(R) Gigabit Ethernet Network Driver
> [    0.499277] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    0.499813] igbvf: Intel(R) Gigabit Virtual Function Network Driver
> [    0.500388] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> [    0.501807] sky2: driver version 1.30
> [    0.505131] VFIO - User Level meta-driver version: 0.3
> [    0.529444] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    0.530041] ehci-pci: EHCI PCI platform driver
> [    0.530490] ehci-platform: EHCI generic platform driver
> [    0.533478] ehci-platform fe380000.usb: EHCI Host Controller
> [    0.534012] ehci-platform fe380000.usb: new USB bus registered, assign=
ed bus number 1
> [    0.534855] ehci-platform fe380000.usb: irq 35, io mem 0xfe380000
> [    0.548384] ehci-platform fe380000.usb: USB 2.0 started, EHCI 1.00
> [    0.549860] hub 1-0:1.0: USB hub found
> [    0.550246] hub 1-0:1.0: 1 port detected
> [    0.553539] ehci-platform fe3c0000.usb: EHCI Host Controller
> [    0.554068] ehci-platform fe3c0000.usb: new USB bus registered, assign=
ed bus number 2
> [    0.554899] ehci-platform fe3c0000.usb: irq 37, io mem 0xfe3c0000
> [    0.568381] ehci-platform fe3c0000.usb: USB 2.0 started, EHCI 1.00
> [    0.569720] hub 2-0:1.0: USB hub found
> [    0.570095] hub 2-0:1.0: 1 port detected
> [    0.571305] ehci-orion: EHCI orion driver
> [    0.572095] ehci-exynos: EHCI Exynos driver
> [    0.572820] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    0.573394] ohci-pci: OHCI PCI platform driver
> [    0.573871] ohci-platform: OHCI generic platform driver
> [    0.574758] ohci-platform fe3a0000.usb: Generic Platform OHCI controll=
er
> [    0.575376] ohci-platform fe3a0000.usb: new USB bus registered, assign=
ed bus number 3
> [    0.576232] ohci-platform fe3a0000.usb: irq 36, io mem 0xfe3a0000
> [    0.641226] hub 3-0:1.0: USB hub found
> [    0.641613] hub 3-0:1.0: 1 port detected
> [    0.642732] ohci-platform fe3e0000.usb: Generic Platform OHCI controll=
er
> [    0.643349] ohci-platform fe3e0000.usb: new USB bus registered, assign=
ed bus number 4
> [    0.644186] ohci-platform fe3e0000.usb: irq 38, io mem 0xfe3e0000
> [    0.709158] hub 4-0:1.0: USB hub found
> [    0.709545] hub 4-0:1.0: 1 port detected
> [    0.710725] ohci-exynos: OHCI Exynos driver
> [    0.712521] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> [    0.713037] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned=
 bus number 5
> [    0.713887] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe64 hci versio=
n 0x110 quirks 0x0000000002010010
> [    0.714790] xhci-hcd xhci-hcd.0.auto: irq 77, io mem 0xfe800000
> [    0.716420] hub 5-0:1.0: USB hub found
> [    0.716805] hub 5-0:1.0: 1 port detected
> [    0.717580] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> [    0.718083] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned=
 bus number 6
> [    0.718774] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
> [    0.719436] usb usb6: We don't know the algorithms for LPM for this ho=
st, disabling LPM.
> [    0.720905] hub 6-0:1.0: USB hub found
> [    0.721284] hub 6-0:1.0: 1 port detected
> [    0.722327] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> [    0.722836] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned=
 bus number 7
> [    0.723675] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe64 hci versio=
n 0x110 quirks 0x0000000002010010
> [    0.724598] xhci-hcd xhci-hcd.1.auto: irq 78, io mem 0xfe900000
> [    0.726099] hub 7-0:1.0: USB hub found
> [    0.726476] hub 7-0:1.0: 1 port detected
> [    0.727230] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> [    0.727732] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned=
 bus number 8
> [    0.728455] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
> [    0.729122] usb usb8: We don't know the algorithms for LPM for this ho=
st, disabling LPM.
> [    0.730586] hub 8-0:1.0: USB hub found
> [    0.730962] hub 8-0:1.0: 1 port detected
> [    0.733054] usbcore: registered new interface driver usb-storage
> [    0.740922] i2c_dev: i2c /dev entries driver
> [    0.745037] i2c 1-0011: Fixing up cyclic dependency with ff880000.i2s
> [    0.750232] rk808 0-001b: chip id: 0x0
> [    0.755661] rk808-regulator rk808-regulator: there is no dvs0 gpio
> [    0.756256] rk808-regulator rk808-regulator: there is no dvs1 gpio
> [    0.757507] vdd_center: supplied by vcc5v0_sys
> [    0.758702] vdd_cpu_l: supplied by vcc5v0_sys
> [    0.759420] vcc_ddr: supplied by vcc5v0_sys
> [    0.760366] vcc_1v8: supplied by vcc5v0_sys
> [    0.761335] vcc1v8_codec: supplied by vcc5v0_sys
> [    0.762895] vcc1v8_hdmi: supplied by vcc5v0_sys
> [    0.764433] vcca_1v8: supplied by vcc5v0_sys
> [    0.765945] vcc_sdio: supplied by vcc5v0_sys
> [    0.767332] vcca3v0_codec: supplied by vcc5v0_sys
> [    0.768908] vcc_1v5: supplied by vcc5v0_sys
> [    0.770270] vcc0v9_hdmi: supplied by vcc5v0_sys
> [    0.771838] vcc_3v0: supplied by vcc5v0_sys
> [    0.773187] vcc_cam: supplied by vcc3v3_sys
> [    0.773864] vcc_mipi: supplied by vcc3v3_sys
> [    0.776902] fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detec=
ted!
> [    0.777989] vdd_cpu_b: supplied by vcc5v0_sys
> [    0.780669] fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1] Detec=
ted!
> [    0.781737] vdd_gpu: supplied by vcc5v0_sys
> [    0.794822] dw_wdt ff848000.watchdog: No valid TOPs array specified
> [    0.800593] cpu cpu0: EM: created perf domain
> [    0.802610] cpu cpu4: EM: created perf domain
> [    0.806479] sdhci: Secure Digital Host Controller Interface driver
> [    0.807035] sdhci: Copyright(c) Pierre Ossman
> [    0.808429] Synopsys Designware Multimedia Card Interface Driver
> [    0.810345] dwmmc_rockchip fe310000.mmc: IDMAC supports 32-bit address=
 mode.
> [    0.810445] dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit address=
 mode.
> [    0.810728] sdhci-pltfm: SDHCI platform and OF driver helper
> [    0.810996] dwmmc_rockchip fe310000.mmc: Using internal DMA controller=
.
> [    0.811603] dwmmc_rockchip fe320000.mmc: Using internal DMA controller=
.
> [    0.812091] dwmmc_rockchip fe310000.mmc: Version ID is 270a
> [    0.812613] mmc1: CQHCI version 5.10
> [    0.812689] dwmmc_rockchip fe320000.mmc: Version ID is 270a
> [    0.813313] dwmmc_rockchip fe310000.mmc: DW MMC controller at irq 32,3=
2 bit host data width,256 deep fifo
> [    0.813786] dwmmc_rockchip fe320000.mmc: DW MMC controller at irq 33,3=
2 bit host data width,256 deep fifo
> [    0.814394] dwmmc_rockchip fe310000.mmc: allocated mmc-pwrseq
> [    0.814694] dwmmc_rockchip fe320000.mmc: Got CD GPIO
> [    0.814776] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.815391] mmc_host mmc2: card is non-removable.
> [    0.817469] usbcore: registered new interface driver usbhid
> [    0.818595] usbhid: USB HID core driver
> [    0.826653] NET: Registered PF_PACKET protocol family
> [    0.827239] 9pnet: Installing 9P2000 support
> [    0.827661] Key type dns_resolver registered
> [    0.828763] mmc_host mmc2: Bus speed (slot 0) =3D 400000Hz (slot req 4=
00000Hz, actual 400000HZ div =3D 0)
> [    0.828763] mmc_host mmc0: Bus speed (slot 0) =3D 400000Hz (slot req 4=
00000Hz, actual 400000HZ div =3D 0)
> [    0.829075] Loading compiled-in X.509 certificates
> [    0.836574] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] usin=
g ADMA
> [    0.854687] Freeing initrd memory: 13904K
> [    0.854930] vcc_0v9: supplied by vcc3v3_sys
> [    0.868583] mmc_host mmc2: Bus speed (slot 0) =3D 300000Hz (slot req 3=
00000Hz, actual 300000HZ div =3D 0)
> [    0.893848] ALSA device list:
> [    0.894121]   No soundcards found.
> [    0.894559] dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
> [    0.897941] Freeing unused kernel memory: 7168K
> [    0.900009] random: fast init done
> [    0.908477] Run /init as init process
> [    0.908801]   with arguments:
> [    0.909061]     /init
> [    0.909261]   with environment:
> [    0.909536]     HOME=3D/
> [    0.909744]     TERM=3Dlinux
> [    0.909982]     ubootpart=3D7f91284d-01
> [    0.910302]     cgroup_enable=3Dmemory
> [    0.910614]     cgroup_memory=3D1
> [    0.915192] mmc_host mmc2: Bus speed (slot 0) =3D 200000Hz (slot req 2=
00000Hz, actual 200000HZ div =3D 0)
> [    0.934865] mmc1: Command Queue Engine enabled
> [    0.935290] mmc1: new HS400 Enhanced strobe MMC card at address 0001
> [    0.936519] mmcblk1: mmc1:0001 SLD32G 28.9 GiB
> [    0.964197]  mmcblk1: p1
> [    0.964498] mmc_host mmc2: Bus speed (slot 0) =3D 100000Hz (slot req 1=
00000Hz, actual 100000HZ div =3D 0)
> [    0.965082] mmcblk1boot0: mmc1:0001 SLD32G 4.00 MiB
> [    0.967152] mmcblk1boot1: mmc1:0001 SLD32G 4.00 MiB
> [    0.969097] mmcblk1rpmb: mmc1:0001 SLD32G 4.00 MiB, chardev (234:0)
> [    1.435599] EXT4-fs (mmcblk1p1): mounted filesystem with writeback dat=
a mode. Opts: (null). Quota mode: none.
> [    1.768203] systemd[1]: System time before build time, advancing clock=
.
> [    1.834509] NET: Registered PF_INET6 protocol family
> [    1.836843] Segment Routing with IPv6
> [    1.837216] In-situ OAM (IOAM) with IPv6
> [    1.861315] systemd[1]: systemd 245.4-4ubuntu3.16 running in system mo=
de. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSE=
TUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -ID=
N +PCRE2 default-hierarchy=3Dhybrid)
> [    1.864241] systemd[1]: Detected architecture arm64.
> [    1.905928] systemd[1]: Set hostname to <rp4e>.
> [    2.425171] random: systemd: uninitialized urandom read (16 bytes read=
)
> [    2.425865] systemd[1]: system-modprobe.slice: unit configures an IP f=
irewall, but the local system does not support BPF/cgroup firewalling.
> [    2.426965] systemd[1]: (This warning is only shown for the first unit=
 using IP firewalling.)
> [    2.429421] systemd[1]: Created slice system-modprobe.slice.
> [    2.430805] random: systemd: uninitialized urandom read (16 bytes read=
)
> [    2.432091] systemd[1]: Created slice system-serial\x2dgetty.slice.
> [    2.444524] random: systemd: uninitialized urandom read (16 bytes read=
)
> [    2.445880] systemd[1]: Created slice User and Session Slice.
> [    2.447517] systemd[1]: Started Forward Password Requests to Wall Dire=
ctory Watch.
> [    2.460793] systemd[1]: Condition check resulted in Arbitrary Executab=
le File Formats File System Automount Point being skipped.
> [    2.462037] systemd[1]: Reached target Remote File Systems.
> [    2.472529] systemd[1]: Reached target Slices.
> [    2.484865] systemd[1]: Reached target Swap.
> [    2.497393] systemd[1]: Reached target System Time Set.
> [    2.499447] systemd[1]: Listening on Syslog Socket.
> [    2.509378] systemd[1]: Listening on fsck to fsckd communication Socke=
t.
> [    2.521230] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [    2.534276] systemd[1]: Listening on Journal Audit Socket.
> [    2.545821] systemd[1]: Listening on Journal Socket (/dev/log).
> [    2.557815] systemd[1]: Listening on Journal Socket.
> [    2.570091] systemd[1]: Listening on udev Control Socket.
> [    2.582021] systemd[1]: Listening on udev Kernel Socket.
> [    2.592907] systemd[1]: Mounting Huge Pages File System...
> [    2.613589] systemd[1]: Mounting POSIX Message Queue File System...
> [    2.620449] systemd[1]: Mounting Kernel Debug File System...
> [    2.636768] systemd[1]: Mounting Kernel Trace File System...
> [    2.655690] systemd[1]: Starting Restore / save the current clock...
> [    2.666409] systemd[1]: Starting Set the console keyboard layout...
> [    2.673386] systemd[1]: Starting Create list of static device nodes fo=
r the current kernel...
> [    2.688709] systemd[1]: Starting Load Kernel Module drm...
> [    2.697876] systemd[1]: Started Nameserver information manager.
> [    2.709374] systemd[1]: Reached target Network (Pre).
> [    2.727342] systemd[1]: Condition check resulted in Set Up Additional =
Binary Formats being skipped.
> [    2.728322] systemd[1]: Condition check resulted in File System Check =
on Root Device being skipped.
> [    2.747490] systemd[1]: Starting Load Kernel Modules...
> [    2.766637] systemd[1]: Starting Remount Root and Kernel File Systems.=
..
> [    2.783214] systemd[1]: Starting udev Coldplug all Devices...
> [    2.791446] EXT4-fs (mmcblk1p1): re-mounted. Opts: commit=3D600,errors=
=3Dremount-ro. Quota mode: none.
> [    2.803741] systemd[1]: Mounted Huge Pages File System.
> [    2.805909] systemd[1]: Mounted POSIX Message Queue File System.
> [    2.817287] systemd[1]: Mounted Kernel Debug File System.
> [    2.819188] systemd[1]: Mounted Kernel Trace File System.
> [    2.833600] systemd[1]: Finished Restore / save the current clock.
> [    2.848479] systemd[1]: Finished Create list of static device nodes fo=
r the current kernel.
> [    2.862721] systemd[1]: modprobe@drm.service: Succeeded.
> [    2.866283] systemd[1]: Finished Load Kernel Module drm.
> [    2.875263] systemd[1]: Finished Set the console keyboard layout.
> [    2.879843] systemd[1]: Finished Load Kernel Modules.
> [    2.896650] systemd[1]: Finished Remount Root and Kernel File Systems.
> [    2.912825] systemd[1]: Condition check resulted in FUSE Control File =
System being skipped.
> [    2.922339] systemd[1]: Mounting Kernel Configuration File System...
> [    2.925364] systemd[1]: Condition check resulted in Rebuild Hardware D=
atabase being skipped.
> [    2.926529] systemd[1]: Condition check resulted in Platform Persisten=
t Storage Archival being skipped.
> [    2.933738] systemd[1]: Starting Load/Save Random Seed...
> [    2.939247] systemd[1]: Starting Apply Kernel Variables...
> [    2.945484] systemd[1]: Starting Create System Users...
> [    2.955255] systemd[1]: Mounted Kernel Configuration File System.
> [    2.973193] systemd[1]: Finished Create System Users.
> [    2.979174] systemd[1]: Starting Create Static Device Nodes in /dev...
> [    2.994700] systemd[1]: Finished Apply Kernel Variables.
> [    3.009498] systemd[1]: Finished Create Static Device Nodes in /dev.
> [    3.025501] systemd[1]: Reached target Local File Systems (Pre).
> [    3.047622] systemd[1]: Mounting /tmp...
> [    3.052931] systemd[1]: Starting udev Kernel Device Manager...
> [    3.059127] systemd[1]: Mounted /tmp.
> [    3.060404] systemd[1]: Reached target Local File Systems.
> [    3.081737] systemd[1]: Starting Armbian ZRAM config...
> [    3.087557] systemd[1]: Starting Set console font and keymap...
> [    3.094454] systemd[1]: Starting Tell Plymouth To Write Out Runtime Da=
ta...
> [    3.108649] systemd[1]: Condition check resulted in Commit a transient=
 machine-id on disk being skipped.
> [    3.110443] systemd[1]: Finished udev Coldplug all Devices.
> [    3.113439] systemd[1]: Finished Set console font and keymap.
> [    3.115730] systemd[1]: plymouth-read-write.service: Succeeded.
> [    3.117706] systemd[1]: Finished Tell Plymouth To Write Out Runtime Da=
ta.
> [    3.138742] systemd[1]: Starting Helper to synchronize boot up for ifu=
pdown...
> [    3.160698] systemd[1]: Finished Helper to synchronize boot up for ifu=
pdown.
> [    3.179394] systemd[1]: Starting Raise network interfaces...
> [    3.221992] systemd[1]: Started udev Kernel Device Manager.
> [    3.233187] systemd[1]: Condition check resulted in Show Plymouth Boot=
 Screen being skipped.
> [    3.233308] systemd[1]: Condition check resulted in Dispatch Password =
Requests to Console Directory Watch when bootsplash is active being skipped=
.
> [    3.233385] systemd[1]: Condition check resulted in Forward Password R=
equests to Plymouth Directory Watch being skipped.
> [    3.233493] systemd[1]: Reached target Local Encrypted Volumes.
> [    3.302811] systemd[1]: armbian-zram-config.service: Main process exit=
ed, code=3Dexited, status=3D1/FAILURE
> [    3.303053] systemd[1]: armbian-zram-config.service: Failed with resul=
t 'exit-code'.
> [    3.348651] systemd[1]: Failed to start Armbian ZRAM config.
> [    3.383174] systemd[1]: Starting Armbian memory supported logging...
> [    3.511171] systemd[1]: Finished Raise network interfaces.
> [    3.917193] rockchip-vop ff8f0000.vop: Adding to iommu group 2
> [    3.918002] rockchip-vop ff900000.vop: Adding to iommu group 3
> [    3.935387] systemd[1]: Found device /dev/ttyS2.
> [    3.965964] rockchip-drm display-subsystem: bound ff8f0000.vop (ops vo=
p_component_ops [rockchipdrm])
> [    3.966143] [drm] unsupported AFBC format[3231564e]
> [    3.967870] rockchip-drm display-subsystem: bound ff900000.vop (ops vo=
p_component_ops [rockchipdrm])
> [    3.968263] dwhdmi-rockchip ff940000.hdmi: Detected HDMI TX controller=
 v2.11a with HDCP (DWC HDMI 2.0 TX PHY)
> [    3.975907] rockchip-drm display-subsystem: bound ff940000.hdmi (ops d=
w_hdmi_rockchip_ops [rockchipdrm])
> [    3.982016] Bluetooth: Core ver 2.22
> [    3.982118] NET: Registered PF_BLUETOOTH protocol family
> [    3.982122] Bluetooth: HCI device and connection manager initialized
> [    3.982134] Bluetooth: HCI socket layer initialized
> [    3.982142] Bluetooth: L2CAP socket layer initialized
> [    3.982159] Bluetooth: SCO socket layer initialized
> [    3.984709] rockchip-drm display-subsystem: [drm] Cannot find any crtc=
 or sizes
> [    3.990266] rk_gmac-dwmac fe300000.ethernet: IRQ eth_wake_irq not foun=
d
> [    3.990289] rk_gmac-dwmac fe300000.ethernet: IRQ eth_lpi not found
> [    3.990414] rk_gmac-dwmac fe300000.ethernet: PTP uses main clock
> [    3.990618] rk_gmac-dwmac fe300000.ethernet: clock input or output? (i=
nput).
> [    3.990626] rk_gmac-dwmac fe300000.ethernet: TX delay(0x28).
> [    3.990633] rk_gmac-dwmac fe300000.ethernet: RX delay(0x11).
> [    3.990643] rk_gmac-dwmac fe300000.ethernet: integrated PHY? (no).
> [    3.990687] rk_gmac-dwmac fe300000.ethernet: cannot get clock clk_mac_=
speed
> [    3.990692] rk_gmac-dwmac fe300000.ethernet: clock input from PHY
> [    3.995710] rk_gmac-dwmac fe300000.ethernet: init for RGMII
> [    3.996025] rk_gmac-dwmac fe300000.ethernet: User ID: 0x10, Synopsys I=
D: 0x35
> [    3.996044] rk_gmac-dwmac fe300000.ethernet:         DWMAC1000
> [    3.996050] rk_gmac-dwmac fe300000.ethernet: DMA HW capability registe=
r supported
> [    3.996055] rk_gmac-dwmac fe300000.ethernet: RX Checksum Offload Engin=
e supported
> [    3.996060] rk_gmac-dwmac fe300000.ethernet: COE Type 2
> [    3.996064] rk_gmac-dwmac fe300000.ethernet: TX Checksum insertion sup=
ported
> [    3.996069] rk_gmac-dwmac fe300000.ethernet: Wake-Up On Lan supported
> [    3.997408] rk_gmac-dwmac fe300000.ethernet: Normal descriptors
> [    3.997424] rk_gmac-dwmac fe300000.ethernet: Ring mode enabled
> [    3.997429] rk_gmac-dwmac fe300000.ethernet: Enable RX Mitigation via =
HW Watchdog Timer
> [    4.003825] [drm] Initialized rockchip 1.0.0 20140818 for display-subs=
ystem on minor 0
> [    4.016908] Bluetooth: HCI UART driver ver 2.3
> [    4.016931] Bluetooth: HCI UART protocol H4 registered
> [    4.017010] Bluetooth: HCI UART protocol LL registered
> [    4.017793] hci_uart_bcm serial0-0: supply vbat not found, using dummy=
 regulator
> [    4.017933] hci_uart_bcm serial0-0: supply vddio not found, using dumm=
y regulator
> [    4.018084] Bluetooth: HCI UART protocol Broadcom registered
> [    4.018117] Bluetooth: HCI UART protocol QCA registered
> [    4.028892] rk808-rtc rk808-rtc: registered as rtc0
> [    4.029382] rk808-rtc rk808-rtc: setting system clock to 2022-05-07T02=
:43:19 UTC (1651891399)
> [    4.037174] mc: Linux media interface: v0.10
> [    4.136603] dw-apb-uart ff180000.serial: failed to request DMA
> [    4.138085] RTL8211F Gigabit Ethernet stmmac-0:00: attached PHY driver=
 (mii_bus:phy_addr=3Dstmmac-0:00, irq=3DPOLL)
> [    4.138108] RTL8211F Gigabit Ethernet stmmac-0:01: attached PHY driver=
 (mii_bus:phy_addr=3Dstmmac-0:01, irq=3DPOLL)
> [    4.204019] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ra=
nges:
> [    4.204065] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fb=
dfffff -> 0x00fa000000
> [    4.204093] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fb=
efffff -> 0x00fbe00000
> [    4.280388] panfrost ff9a0000.gpu: clock rate =3D 500000000
> [    4.284754] panfrost ff9a0000.gpu: [drm:panfrost_devfreq_init [panfros=
t]] Failed to register cooling device
> [    4.285161] panfrost ff9a0000.gpu: mali-t860 id 0x860 major 0x2 minor =
0x0 status 0x0
> [    4.285173] panfrost ff9a0000.gpu: features: 00000000,100e77bf, issues=
: 00000000,24040400
> [    4.285259] panfrost ff9a0000.gpu: Features: L2:0x07120206 Shader:0x00=
000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
> [    4.285269] panfrost ff9a0000.gpu: shader_present=3D0xf l2_present=3D0=
x1
> [    4.298295] videodev: Linux video capture interface: v2.00
> [    4.299818] [drm] Initialized panfrost 1.2.0 20180908 for ff9a0000.gpu=
 on minor 1
> [    4.375630] hantro-vpu ff650000.video-codec: Adding to iommu group 0
> [    4.382000] hantro-vpu ff650000.video-codec: registered rockchip,rk339=
9-vpu-enc as /dev/video0
> [    4.388509] hantro-vpu ff650000.video-codec: registered rockchip,rk339=
9-vpu-dec as /dev/video1
> [    4.575519] systemd[1]: Listening on Load/Save RF Kill Switch Status /=
dev/rfkill Watch.
> [    4.581923] systemd[1]: Starting Load/Save RF Kill Switch Status...
> [    4.620785] systemd[1]: Started Load/Save RF Kill Switch Status.
> [    4.636812] systemd[1]: Condition check resulted in Arbitrary Executab=
le File Formats File System Automount Point being skipped.
> [    4.637074] systemd[1]: Condition check resulted in FUSE Control File =
System being skipped.
> [    4.639689] systemd[1]: Starting Armbian ZRAM config...
> [    4.676164] systemd[1]: Starting Tell Plymouth To Write Out Runtime Da=
ta...
> [    4.688778] systemd[1]: Condition check resulted in Show Plymouth Boot=
 Screen being skipped.
> [    4.688918] systemd[1]: Condition check resulted in Dispatch Password =
Requests to Console Directory Watch when bootsplash is active being skipped=
.
> [    4.688984] systemd[1]: Condition check resulted in Forward Password R=
equests to Plymouth Directory Watch being skipped.
> [    4.689271] systemd[1]: Condition check resulted in Set Up Additional =
Binary Formats being skipped.
> [    4.689398] systemd[1]: Condition check resulted in Rebuild Hardware D=
atabase being skipped.
> [    4.689516] systemd[1]: Condition check resulted in Commit a transient=
 machine-id on disk being skipped.
> [    4.689597] systemd[1]: Condition check resulted in Platform Persisten=
t Storage Archival being skipped.
> [    4.695602] systemd[1]: plymouth-read-write.service: Succeeded.
> [    4.697187] systemd[1]: Finished Tell Plymouth To Write Out Runtime Da=
ta.
> [    4.742392] systemd[1]: armbian-zram-config.service: Main process exit=
ed, code=3Dexited, status=3D1/FAILURE
> [    4.742781] systemd[1]: armbian-zram-config.service: Failed with resul=
t 'exit-code'.
> [    4.744135] systemd[1]: Failed to start Armbian ZRAM config.
> [    4.760432] rockchip-pcie f8000000.pcie: PCIe link training gen1 timeo=
ut!
> [    4.760489] rockchip-pcie: probe of f8000000.pcie failed with error -1=
10
> [    4.783329] systemd[1]: Condition check resulted in Arbitrary Executab=
le File Formats File System Automount Point being skipped.
> [    4.783810] systemd[1]: Condition check resulted in FUSE Control File =
System being skipped.
> [    4.787680] systemd[1]: Starting Armbian ZRAM config...
> [    4.793763] systemd[1]: Starting Tell Plymouth To Write Out Runtime Da=
ta...
> [    4.808778] systemd[1]: Condition check resulted in Show Plymouth Boot=
 Screen being skipped.
> [    4.808912] systemd[1]: Condition check resulted in Dispatch Password =
Requests to Console Directory Watch when bootsplash is active being skipped=
.
> [    4.808975] systemd[1]: Condition check resulted in Forward Password R=
equests to Plymouth Directory Watch being skipped.
> [    4.809230] systemd[1]: Condition check resulted in Set Up Additional =
Binary Formats being skipped.
> [    4.809363] systemd[1]: Condition check resulted in Rebuild Hardware D=
atabase being skipped.
> [    4.809486] systemd[1]: Condition check resulted in Commit a transient=
 machine-id on disk being skipped.
> [    4.809579] systemd[1]: Condition check resulted in Platform Persisten=
t Storage Archival being skipped.
> [    4.810797] systemd[1]: plymouth-read-write.service: Succeeded.
> [    4.812818] systemd[1]: Finished Tell Plymouth To Write Out Runtime Da=
ta.
> [    4.907273] systemd[1]: armbian-zram-config.service: Main process exit=
ed, code=3Dexited, status=3D1/FAILURE
> [    4.907788] systemd[1]: armbian-zram-config.service: Failed with resul=
t 'exit-code'.
> [    4.909612] systemd[1]: Failed to start Armbian ZRAM config.
> [    4.992854] rockchip-drm display-subsystem: [drm] Cannot find any crtc=
 or sizes
> [    5.451010] systemd[1]: Finished Armbian memory supported logging.
> [    5.476708] systemd[1]: Starting Journal Service...
> [    5.580951] systemd[1]: Started Journal Service.
> [    5.625537] systemd-journald[536]: Received client request to flush ru=
ntime journal.
> [    5.841033] random: crng init done
> [    5.841061] random: 7 urandom warning(s) missed due to ratelimiting
> [    6.304351] Bluetooth: hci0: command 0x0c03 tx timeout
> [    9.712401] rk_gmac-dwmac fe300000.ethernet eth0: PHY [stmmac-0:00] dr=
iver [RTL8211F Gigabit Ethernet] (irq=3DPOLL)
> [    9.722108] rk_gmac-dwmac fe300000.ethernet eth0: Register MEM_TYPE_PA=
GE_POOL RxQ-0
> [    9.732431] rk_gmac-dwmac fe300000.ethernet eth0: No Safety Features s=
upport found
> [    9.732452] rk_gmac-dwmac fe300000.ethernet eth0: PTP not supported by=
 HW
> [    9.732734] rk_gmac-dwmac fe300000.ethernet eth0: configuring for phy/=
rgmii link mode
> [   12.383834] hdmi-audio-codec hdmi-audio-codec.5.auto: Only one simulta=
neous stream supported!
> [   12.383848] hdmi-audio-codec hdmi-audio-codec.5.auto: ASoC: error at s=
nd_soc_dai_startup on i2s-hifi: -22
> [   12.383859]  ff8a0000.i2s-i2s-hifi: soc_pcm_open() failed (-22)
> [   12.384103] hdmi-audio-codec hdmi-audio-codec.5.auto: Only one simulta=
neous stream supported!
> [   12.384111] hdmi-audio-codec hdmi-audio-codec.5.auto: ASoC: error at s=
nd_soc_dai_startup on i2s-hifi: -22
> [   12.384119]  ff8a0000.i2s-i2s-hifi: soc_pcm_open() failed (-22)
> [   12.385239] hdmi-audio-codec hdmi-audio-codec.5.auto: Only one simulta=
neous stream supported!
> [   12.385251] hdmi-audio-codec hdmi-audio-codec.5.auto: ASoC: error at s=
nd_soc_dai_startup on i2s-hifi: -22
> [   12.385262]  ff8a0000.i2s-i2s-hifi: soc_pcm_open() failed (-22)
> [   12.385531] hdmi-audio-codec hdmi-audio-codec.5.auto: Only one simulta=
neous stream supported!
> [   12.385539] hdmi-audio-codec hdmi-audio-codec.5.auto: ASoC: error at s=
nd_soc_dai_startup on i2s-hifi: -22
> [   12.385546]  ff8a0000.i2s-i2s-hifi: soc_pcm_open() failed (-22)
> [   12.833880] rk_gmac-dwmac fe300000.ethernet eth0: Link is Up - 1Gbps/F=
ull - flow control rx/tx
> [   12.833913] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [   14.304445] Bluetooth: hci0: BCM: Reset failed (-110)
> [   18.801873] hdmi-audio-codec hdmi-audio-codec.5.auto: Only one simulta=
neous stream supported!
> [   18.801888] hdmi-audio-codec hdmi-audio-codec.5.auto: ASoC: error at s=
nd_soc_dai_startup on i2s-hifi: -22
> [   18.801898]  ff8a0000.i2s-i2s-hifi: soc_pcm_open() failed (-22)
> [   18.802226] hdmi-audio-codec hdmi-audio-codec.5.auto: Only one simulta=
neous stream supported!
> [   18.802232] hdmi-audio-codec hdmi-audio-codec.5.auto: ASoC: error at s=
nd_soc_dai_startup on i2s-hifi: -22
> [   18.802240]  ff8a0000.i2s-i2s-hifi: soc_pcm_open() failed (-22)
> [   18.803208] hdmi-audio-codec hdmi-audio-codec.5.auto: Only one simulta=
neous stream supported!
> [   18.803220] hdmi-audio-codec hdmi-audio-codec.5.auto: ASoC: error at s=
nd_soc_dai_startup on i2s-hifi: -22
> [   18.803230]  ff8a0000.i2s-i2s-hifi: soc_pcm_open() failed (-22)
> [   18.803454] hdmi-audio-codec hdmi-audio-codec.5.auto: Only one simulta=
neous stream supported!
> [   18.803459] hdmi-audio-codec hdmi-audio-codec.5.auto: ASoC: error at s=
nd_soc_dai_startup on i2s-hifi: -22
> [   18.803465]  ff8a0000.i2s-i2s-hifi: soc_pcm_open() failed (-22)
> [ 3915.915140] perf: interrupt took too long (2510 > 2500), lowering kern=
el.perf_event_max_sample_rate to 79500
> [ 3915.935585] perf: interrupt took too long (3138 > 3137), lowering kern=
el.perf_event_max_sample_rate to 63500
> [ 3915.947972] perf: interrupt took too long (3947 > 3922), lowering kern=
el.perf_event_max_sample_rate to 50500
> [ 3915.956488] perf: interrupt took too long (4953 > 4933), lowering kern=
el.perf_event_max_sample_rate to 40250
> [ 3915.974638] perf: interrupt took too long (6200 > 6191), lowering kern=
el.perf_event_max_sample_rate to 32250
> [ 3916.877446] perf: interrupt took too long (7830 > 7750), lowering kern=
el.perf_event_max_sample_rate to 25500
> [ 3918.301719] perf: interrupt took too long (9848 > 9787), lowering kern=
el.perf_event_max_sample_rate to 20250
> [ 3927.453715] perf: interrupt took too long (12356 > 12310), lowering ke=
rnel.perf_event_max_sample_rate to 16000
>
>
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> ?2022?5?7??? 17:07??:
>   +Cc: ML and maintainer
>
> On Sat, May 07, 2022 at 10:16:43AM +0800, xc zhang wrote:
> > Hi Christian
> >
> > I am using a sbc named rock pi 4(based on rk3399,with emmc5.1 card), wi=
th
> > upstream linux kernel 5.15.37 , sbc cannot boot(5.15.32 is ok), and I
> > revert this patch , it boots normaly , I am not familier with mmc/sd,he=
re
> > is log , hope you can give some advice.
>
> Thank you for your report!
>
> Is there the dmesg for good boot available?
> Also, what DTS is used?
>
> Have you tried to boot with or without card in the SPI slot? (Interesting=
 to
> know how many SD/MMC slots you have and how they are being utilized).
>
> > Starting kernel ...
> >
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> > [    0.000000] Linux version 5.15.37-dirty (zxc@zxc-QiTianM425-N000)
> > (aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architectu=
re
> > 10.3-2021.07 (arm-10.29)) 10.3.1 20210621, GNU ld (GNU Toolchain for th=
e
> > A-profile Architecture 10.3-2021.07 (arm-10.29)) 2.36.1.20210621) #2 SM=
P
> > PREEMPT Fri May 6 14:30:45 CST 2022
> > [    0.000000] Machine model: Radxa ROCK Pi 4B
> > [    0.000000] efi: UEFI not found.
> > [    0.000000] earlycon: uart0 at MMIO32 0x00000000ff1a0000 (options
> > '1500000n8')
> > [    0.000000] printk: bootconsole [uart0] enabled
> > [    0.000000] NUMA: No NUMA configuration found
> > [    0.000000] NUMA: Faking a node at [mem
> > 0x0000000000200000-0x000000007fffffff]
> > [    0.000000] NUMA: NODE_DATA [mem 0x7fba7c00-0x7fba9fff]
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA      [mem 0x0000000000200000-0x000000007fffffff]
> > [    0.000000]   DMA32    empty
> > [    0.000000]   Normal   empty
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000000200000-0x000000007fffffff]
> > [    0.000000] Initmem setup node 0 [mem
> > 0x0000000000200000-0x000000007fffffff]
> > [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
> > [    0.000000] cma: Reserved 32 MiB at 0x000000007b800000
> > [    0.000000] psci: probing for conduit method from DT.
> > [    0.000000] psci: PSCIv1.0 detected in firmware.
> > [    0.000000] psci: Using standard PSCI v0.2 function IDs
> > [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> > [    0.000000] psci: SMC Calling Convention v1.0
> > [    0.000000] percpu: Embedded 28 pages/cpu s74520 r8192 d31976 u11468=
8
> > [    0.000000] pcpu-alloc: s74520 r8192 d31976 u114688 alloc=3D28*4096
> > [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5
> > [    0.000000] Detected VIPT I-cache on CPU0
> > [    0.000000] CPU features: detected: GIC system register CPU interfac=
e
> > [    0.000000] CPU features: detected: ARM erratum 845719
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 5=
15592
> > [    0.000000] Policy zone: DMA
> > [    0.000000] Kernel command line:
> > root=3DUUID=3D9e30106a-e841-4a98-8b1f-a54a4122c16e rootwait rootfstype=
=3Dext4
> > bootsplash.bootfile=3Dbootsplash.armbian earlycon console=3DttyS2,15000=
00
> >  consoleblank=3D0 loglevel=3D8 ubootpart=3D7f91284d-01
> > usb-storage.quirks=3D0x2537:0x1066:u,0x2537:0x1068:u   cgroup_enable=3D=
cpuset
> > cgroup_memory=3D1 cgroup_enable=3Dmemory swapaccount=3D1
> > [    0.000000] Unknown kernel command line parameters
> > "ubootpart=3D7f91284d-01 cgroup_enable=3Dmemory cgroup_memory=3D1", wil=
l be
> > passed to user space.
> > [    0.000000] Dentry cache hash table entries: 262144 (order: 9, 20971=
52
> > bytes, linear)
> > [    0.000000] Inode-cache hash table entries: 131072 (order: 8, 104857=
6
> > bytes, linear)
> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> > [    0.000000] Memory: 1970224K/2095104K available (16512K kernel code,
> > 3916K rwdata, 8920K rodata, 7168K init, 511K bss, 92112K reserved, 3276=
8K
> > cma-reserved)
> > [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
6, Nodes=3D1
> > [    0.000000] trace event string verifier disabled
> > [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> > [    0.000000] rcu: RCU event tracing is enabled.
> > [    0.000000] rcu: RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_i=
ds=3D6.
> > [    0.000000] Trampoline variant of Tasks RCU enabled.
> > [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay =
is
> > 25 jiffies.
> > [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu=
_ids=3D6
> > [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> > [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> > [    0.000000] GICv3: 256 SPIs implemented
> > [    0.000000] GICv3: 0 Extended SPIs implemented
> > [    0.000000] GICv3: Distributor has no Range Selector support
> > [    0.000000] Root IRQ handler: gic_handle_irq
> > [    0.000000] GICv3: 16 PPIs implemented
> > [    0.000000] GICv3: CPU0: found redistributor 0 region
> > 0:0x00000000fef00000
> > [    0.000000] ITS [mem 0xfee20000-0xfee3ffff]
> > [    0.000000] ITS@0x00000000fee20000: allocated 65536 Devices @500000
> > (flat, esz 8, psz 64K, shr 0)
> > [    0.000000] ITS: using cache flushing for cmd queue
> > [    0.000000] GICv3: using LPI property table @0x00000000004d0000
> > [    0.000000] GIC: using cache flushing for LPI property table
> > [    0.000000] GICv3: CPU0: using allocated LPI pending table
> > @0x00000000004e0000
> > [    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] {
> > /cpus/cpu@0[0] /cpus/cpu@1[1] /cpus/cpu@2[2] /cpus/cpu@3[3] }
> > [    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] {
> > /cpus/cpu@100[4] /cpus/cpu@101[5] }
> > [    0.000000] random: get_random_bytes called from
> > start_kernel+0x4d8/0x6c8 with crng_init=3D0
> > [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
> > [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> > max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> > [    0.000001] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps ev=
ery
> > 4398046511097ns
> > [    0.004409] Console: colour dummy device 80x25
> > [    0.004953] Calibrating delay loop (skipped), value calculated using
> > timer frequency.. 48.00 BogoMIPS (lpj=3D96000)
> > [    0.005939] pid_max: default: 32768 minimum: 301
> > [    0.006502] LSM: Security Framework initializing
> > [    0.007095] Mount-cache hash table entries: 4096 (order: 3, 32768 by=
tes,
> > linear)
> > [    0.007816] Mountpoint-cache hash table entries: 4096 (order: 3, 327=
68
> > bytes, linear)
> > [    0.011180] rcu: Hierarchical SRCU implementation.
> > [    0.012038] Platform MSI: interrupt-controller@fee20000 domain creat=
ed
> > [    0.013124] PCI/MSI: /interrupt-controller@fee00000
> > /interrupt-controller@fee20000 domain created
> > [    0.014231] fsl-mc MSI: interrupt-controller@fee20000 domain created
> > [    0.020632] EFI services will not be available.
> > [    0.021556] smp: Bringing up secondary CPUs ...
> > [    0.022857] Detected VIPT I-cache on CPU1
> > [    0.022920] GICv3: CPU1: found redistributor 1 region
> > 0:0x00000000fef20000
> > [    0.022942] GICv3: CPU1: using allocated LPI pending table
> > @0x00000000004f0000
> > [    0.023009] CPU1: Booted secondary processor 0x0000000001 [0x410fd03=
4]
> > [    0.024109] Detected VIPT I-cache on CPU2
> > [    0.024170] GICv3: CPU2: found redistributor 2 region
> > 0:0x00000000fef40000
> > [    0.024193] GICv3: CPU2: using allocated LPI pending table
> > @0x0000000000580000
> > [    0.024258] CPU2: Booted secondary processor 0x0000000002 [0x410fd03=
4]
> > [    0.025328] Detected VIPT I-cache on CPU3
> > [    0.025391] GICv3: CPU3: found redistributor 3 region
> > 0:0x00000000fef60000
> > [    0.025413] GICv3: CPU3: using allocated LPI pending table
> > @0x0000000000590000
> > [    0.025477] CPU3: Booted secondary processor 0x0000000003 [0x410fd03=
4]
> > [    0.026671] CPU features: detected: Spectre-v2
> > [    0.026683] CPU features: detected: Spectre-v3a
> > [    0.026689] CPU features: detected: Spectre-v4
> > [    0.026694] CPU features: detected: Spectre-BHB
> > [    0.026704] CPU features: detected: ARM errata 1165522, 1319367, or
> > 1530923
> > [    0.026709] Detected PIPT I-cache on CPU4
> > [    0.026746] GICv3: CPU4: found redistributor 100 region
> > 0:0x00000000fef80000
> > [    0.026764] GICv3: CPU4: using allocated LPI pending table
> > @0x00000000005a0000
> > [    0.026808] CPU4: Booted secondary processor 0x0000000100 [0x410fd08=
2]
> > [    0.027747] Detected PIPT I-cache on CPU5
> > [    0.027792] GICv3: CPU5: found redistributor 101 region
> > 0:0x00000000fefa0000
> > [    0.027812] GICv3: CPU5: using allocated LPI pending table
> > @0x00000000005b0000
> > [    0.027856] CPU5: Booted secondary processor 0x0000000101 [0x410fd08=
2]
> > [    0.027994] smp: Brought up 1 node, 6 CPUs
> > [    0.042468] SMP: Total of 6 processors activated.
> > [    0.042922] CPU features: detected: 32-bit EL0 Support
> > [    0.043411] CPU features: detected: 32-bit EL1 Support
> > [    0.043904] CPU features: detected: CRC32 instructions
> > [    0.062178] CPU: All CPU(s) started at EL2
> > [    0.062666] alternatives: patching kernel code
> > [    0.065599] devtmpfs: initialized
> > [    0.076690] KASLR disabled due to lack of seed
> > [    0.077317] clocksource: jiffies: mask: 0xffffffff max_cycles:
> > 0xffffffff, max_idle_ns: 7645041785100000 ns
> > [    0.078282] futex hash table entries: 2048 (order: 5, 131072 bytes,
> > linear)
> > [    0.079888] pinctrl core: initialized pinctrl subsystem
> > [    0.081448] DMI not present or invalid.
> > [    0.082336] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> > [    0.085186] DMA: preallocated 256 KiB GFP_KERNEL pool for atomic
> > allocations
> > [    0.086094] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for at=
omic
> > allocations
> > [    0.087082] DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for
> > atomic allocations
> > [    0.087904] audit: initializing netlink subsys (disabled)
> > [    0.088632] audit: type=3D2000 audit(0.084:1): state=3Dinitialized
> > audit_enabled=3D0 res=3D1
> > [    0.089935] thermal_sys: Registered thermal governor 'step_wise'
> > [    0.089944] thermal_sys: Registered thermal governor 'power_allocato=
r'
> > [    0.090962] cpuidle: using governor menu
> > [    0.092219] hw-breakpoint: found 6 breakpoint and 4 watchpoint regis=
ters.
> > [    0.093088] ASID allocator initialised with 65536 entries
> > [    0.095524] Serial: AMBA PL011 UART driver
> > [    0.126007] platform ff770000.syscon:phy@f780: Fixing up cyclic
> > dependency with fe330000.mmc
> > [    0.134846] platform ff940000.hdmi: Fixing up cyclic dependency with
> > ff8f0000.vop
> > [    0.135643] platform ff940000.hdmi: Fixing up cyclic dependency with
> > ff900000.vop
> > [    0.144052] rockchip-gpio ff720000.gpio0: probed /pinctrl/gpio0@ff72=
0000
> > [    0.145417] rockchip-gpio ff730000.gpio1: probed /pinctrl/gpio1@ff73=
0000
> > [    0.146711] rockchip-gpio ff780000.gpio2: probed /pinctrl/gpio2@ff78=
0000
> > [    0.148009] rockchip-gpio ff788000.gpio3: probed /pinctrl/gpio3@ff78=
8000
> > [    0.149307] rockchip-gpio ff790000.gpio4: probed /pinctrl/gpio4@ff79=
0000
> > [    0.166056] HugeTLB registered 1.00 GiB page size, pre-allocated 0 p=
ages
> > [    0.166721] HugeTLB registered 32.0 MiB page size, pre-allocated 0 p=
ages
> > [    0.167379] HugeTLB registered 2.00 MiB page size, pre-allocated 0 p=
ages
> > [    0.168034] HugeTLB registered 64.0 KiB page size, pre-allocated 0 p=
ages
> > [    0.170455] cryptd: max_cpu_qlen set to 1000
> > [    0.174457] ACPI: Interpreter disabled.
> > [    0.178235] vcc5v0_sys: supplied by vcc12v_dcin
> > [    0.179100] vcc3v3_pcie: supplied by vcc5v0_sys
> > [    0.179816] vcc3v3_sys: supplied by vcc5v0_sys
> > [    0.180619] vcc5v0_host: supplied by vcc5v0_sys
> > [    0.181425] vcc5v0_typec: supplied by vcc5v0_sys
> > [    0.183112] iommu: Default domain type: Translated
> > [    0.183596] iommu: DMA domain TLB invalidation policy: strict mode
> > [    0.186646] vgaarb: loaded
> > [    0.187203] SCSI subsystem initialized
> > [    0.187743] libata version 3.00 loaded.
> > [    0.188342] usbcore: registered new interface driver usbfs
> > [    0.188921] usbcore: registered new interface driver hub
> > [    0.189496] usbcore: registered new device driver usb
> > [    0.191452] pps_core: LinuxPPS API ver. 1 registered
> > [    0.191940] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodo=
lfo
> > Giometti <giometti@linux.it>
> > [    0.192838] PTP clock support registered
> > [    0.193427] EDAC MC: Ver: 3.0.0
> > [    0.196386] FPGA manager framework
> > [    0.196809] Advanced Linux Sound Architecture Driver Initialized.
> > [    0.198370] clocksource: Switched to clocksource arch_sys_counter
> > [    0.242478] VFS: Disk quotas dquot_6.6.0
> > [    0.242933] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
> > bytes)
> > [    0.243821] pnp: PnP ACPI: disabled
> > [    0.252914] NET: Registered PF_INET protocol family
> > [    0.253584] IP idents hash table entries: 32768 (order: 6, 262144 by=
tes,
> > linear)
> > [    0.256161] tcp_listen_portaddr_hash hash table entries: 1024 (order=
: 2,
> > 16384 bytes, linear)
> > [    0.257043] TCP established hash table entries: 16384 (order: 5, 131=
072
> > bytes, linear)
> > [    0.257989] TCP bind hash table entries: 16384 (order: 6, 262144 byt=
es,
> > linear)
> > [    0.259064] TCP: Hash tables configured (established 16384 bind 1638=
4)
> > [    0.259836] UDP hash table entries: 1024 (order: 3, 32768 bytes, lin=
ear)
> > [    0.260569] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes=
,
> > linear)
> > [    0.261452] NET: Registered PF_UNIX/PF_LOCAL protocol family
> > [    0.262629] RPC: Registered named UNIX socket transport module.
> > [    0.263213] RPC: Registered udp transport module.
> > [    0.263674] RPC: Registered tcp transport module.
> > [    0.264135] RPC: Registered tcp NFSv4.1 backchannel transport module=
.
> > [    0.264767] PCI: CLS 0 bytes, default 64
> > [    0.265431] Unpacking initramfs...
> > [    0.275287] hw perfevents: enabled with armv8_cortex_a53 PMU driver,=
 7
> > counters available
> > [    0.276498] hw perfevents: enabled with armv8_cortex_a72 PMU driver,=
 7
> > counters available
> > [    0.277828] kvm [1]: IPA Size Limit: 40 bits
> > [    0.279895] kvm [1]: vgic-v2@fff20000
> > [    0.280283] kvm [1]: GIC system register CPU interface enabled
> > [    0.281081] kvm [1]: vgic interrupt IRQ18
> > [    0.281734] kvm [1]: Hyp mode initialized successfully
> > [    0.287881] Initialise system trusted keyrings
> > [    0.288510] workingset: timestamp_bits=3D42 max_order=3D19 bucket_or=
der=3D0
> > [    0.296242] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> > [    0.297615] NFS: Registering the id_resolver key type
> > [    0.298139] Key type id_resolver registered
> > [    0.298601] Key type id_legacy registered
> > [    0.299094] nfs4filelayout_init: NFSv4 File Layout Driver Registerin=
g...
> > [    0.299747] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
> > Registering...
> > [    0.300731] 9p: Installing v9fs 9p2000 file system support
> > [    0.372956] Key type asymmetric registered
> > [    0.373363] Asymmetric key parser 'x509' registered
> > [    0.373967] Block layer SCSI generic (bsg) driver version 0.4 loaded
> > (major 245)
> > [    0.374702] io scheduler mq-deadline registered
> > [    0.375139] io scheduler kyber registered
> > [    0.415310] EINJ: ACPI disabled.
> > [    0.435288] dma-pl330 ff6d0000.dma-controller: Loaded driver for PL3=
30
> > DMAC-241330
> > [    0.436029] dma-pl330 ff6d0000.dma-controller: DBUFF-32x8bytes
> > Num_Chans-6 Num_Peri-12 Num_Events-12
> > [    0.438814] dma-pl330 ff6e0000.dma-controller: Loaded driver for PL3=
30
> > DMAC-241330
> > [    0.439544] dma-pl330 ff6e0000.dma-controller: DBUFF-128x8bytes
> > Num_Chans-8 Num_Peri-20 Num_Events-16
> > [    0.457157] vdd_log: supplied by regulator-dummy
> > [    0.466745] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > [    0.471093] ff180000.serial: ttyS0 at MMIO 0xff180000 (irq =3D 42,
> > base_baud =3D 1500000) is a 16550A
> > [    0.472158] serial serial0: tty port ttyS0 registered
> > [    0.473741] ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq =3D 43,
> > base_baud =3D 1500000) is a 16550A
> > [    0.474884] printk: console [ttyS2] enabled
> > [    0.474884] printk: console [ttyS2] enabled
> > [    0.475655] printk: bootconsole [uart0] disabled
> > [    0.475655] printk: bootconsole [uart0] disabled
> > [    0.480092] SuperH (H)SCI(F) driver initialized
> > [    0.482035] msm_serial: driver initialized
> > [    0.486876] cacheinfo: Unable to detect cache hierarchy for CPU 0
> > [    0.497074] loop: module loaded
> > [    0.499733] megasas: 07.717.02.00-rc1
> > [    0.514734] tun: Universal TUN/TAP device driver, 1.6
> > [    0.517453] thunder_xcv, ver 1.0
> > [    0.517807] thunder_bgx, ver 1.0
> > [    0.518149] nicpf, ver 1.0
> > [    0.521724] hclge is initializing
> > [    0.522057] hns3: Hisilicon Ethernet Network Driver for Hip08 Family=
 -
> > version
> > [    0.522723] hns3: Copyright (c) 2017 Huawei Corporation.
> > [    0.523283] e1000: Intel(R) PRO/1000 Network Driver
> > [    0.523718] e1000: Copyright (c) 1999-2006 Intel Corporation.
> > [    0.524291] e1000e: Intel(R) PRO/1000 Network Driver
> > [    0.524732] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> > [    0.525322] igb: Intel(R) Gigabit Ethernet Network Driver
> > [    0.525801] igb: Copyright (c) 2007-2014 Intel Corporation.
> > [    0.526338] igbvf: Intel(R) Gigabit Virtual Function Network Driver
> > [    0.526911] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> > [    0.528319] sky2: driver version 1.30
> > [    0.531604] VFIO - User Level meta-driver version: 0.3
> > [    0.555560] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
> > [    0.556158] ehci-pci: EHCI PCI platform driver
> > [    0.556618] ehci-platform: EHCI generic platform driver
> > [    0.559607] ehci-platform fe380000.usb: EHCI Host Controller
> > [    0.560141] ehci-platform fe380000.usb: new USB bus registered, assi=
gned
> > bus number 1
> > [    0.560992] ehci-platform fe380000.usb: irq 35, io mem 0xfe380000
> > [    0.574412] ehci-platform fe380000.usb: USB 2.0 started, EHCI 1.00
> > [    0.575881] hub 1-0:1.0: USB hub found
> > [    0.576261] hub 1-0:1.0: 1 port detected
> > [    0.579518] ehci-platform fe3c0000.usb: EHCI Host Controller
> > [    0.580045] ehci-platform fe3c0000.usb: new USB bus registered, assi=
gned
> > bus number 2
> > [    0.580865] ehci-platform fe3c0000.usb: irq 37, io mem 0xfe3c0000
> > [    0.594409] ehci-platform fe3c0000.usb: USB 2.0 started, EHCI 1.00
> > [    0.595752] hub 2-0:1.0: USB hub found
> > [    0.596126] hub 2-0:1.0: 1 port detected
> > [    0.597328] ehci-orion: EHCI orion driver
> > [    0.598116] ehci-exynos: EHCI Exynos driver
> > [    0.598826] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> > [    0.599400] ohci-pci: OHCI PCI platform driver
> > [    0.599876] ohci-platform: OHCI generic platform driver
> > [    0.600765] ohci-platform fe3a0000.usb: Generic Platform OHCI contro=
ller
> > [    0.601381] ohci-platform fe3a0000.usb: new USB bus registered, assi=
gned
> > bus number 3
> > [    0.602209] ohci-platform fe3a0000.usb: irq 36, io mem 0xfe3a0000
> > [    0.667242] hub 3-0:1.0: USB hub found
> > [    0.667627] hub 3-0:1.0: 1 port detected
> > [    0.668744] ohci-platform fe3e0000.usb: Generic Platform OHCI contro=
ller
> > [    0.669359] ohci-platform fe3e0000.usb: new USB bus registered, assi=
gned
> > bus number 4
> > [    0.670196] ohci-platform fe3e0000.usb: irq 38, io mem 0xfe3e0000
> > [    0.735195] hub 4-0:1.0: USB hub found
> > [    0.735571] hub 4-0:1.0: 1 port detected
> > [    0.736745] ohci-exynos: OHCI Exynos driver
> > [    0.738525] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> > [    0.739040] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assign=
ed
> > bus number 5
> > [    0.739878] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe64 hci vers=
ion
> > 0x110 quirks 0x0000000002010010
> > [    0.740780] xhci-hcd xhci-hcd.0.auto: irq 76, io mem 0xfe800000
> > [    0.742420] hub 5-0:1.0: USB hub found
> > [    0.742799] hub 5-0:1.0: 1 port detected
> > [    0.743593] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
> > [    0.744097] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assign=
ed
> > bus number 6
> > [    0.744788] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpe=
ed
> > [    0.745450] usb usb6: We don't know the algorithms for LPM for this
> > host, disabling LPM.
> > [    0.746939] hub 6-0:1.0: USB hub found
> > [    0.747315] hub 6-0:1.0: 1 port detected
> > [    0.748368] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> > [    0.748878] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assign=
ed
> > bus number 7
> > [    0.749721] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe64 hci vers=
ion
> > 0x110 quirks 0x0000000002010010
> > [    0.750651] xhci-hcd xhci-hcd.1.auto: irq 77, io mem 0xfe900000
> > [    0.752180] hub 7-0:1.0: USB hub found
> > [    0.752555] hub 7-0:1.0: 1 port detected
> > [    0.753333] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> > [    0.753835] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assign=
ed
> > bus number 8
> > [    0.754551] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpe=
ed
> > [    0.755215] usb usb8: We don't know the algorithms for LPM for this
> > host, disabling LPM.
> > [    0.756682] hub 8-0:1.0: USB hub found
> > [    0.757055] hub 8-0:1.0: 1 port detected
> > [    0.759120] usbcore: registered new interface driver usb-storage
> > [    0.766840] i2c_dev: i2c /dev entries driver
> > [    0.774467] rk808 0-001b: chip id: 0x0
> > [    0.780425] rk808-regulator rk808-regulator: there is no dvs0 gpio
> > [    0.781021] rk808-regulator rk808-regulator: there is no dvs1 gpio
> > [    0.782098] vdd_center: supplied by vcc5v0_sys
> > [    0.783321] vdd_cpu_l: supplied by vcc5v0_sys
> > [    0.784011] vcc_ddr: supplied by vcc5v0_sys
> > [    0.784991] vcc_1v8: supplied by vcc5v0_sys
> > [    0.785968] vcc1v8_codec: supplied by vcc5v0_sys
> > [    0.787526] vcc1v8_hdmi: supplied by vcc5v0_sys
> > [    0.789091] vcca_1v8: supplied by vcc5v0_sys
> > [    0.790604] vcc_sdio: supplied by vcc5v0_sys
> > [    0.791991] vcca3v0_codec: supplied by vcc5v0_sys
> > [    0.793568] vcc_1v5: supplied by vcc5v0_sys
> > [    0.794937] vcc0v9_hdmi: supplied by vcc5v0_sys
> > [    0.796476] vcc_3v0: supplied by vcc5v0_sys
> > [    0.797728] vcc_cam: supplied by vcc3v3_sys
> > [    0.798423] vcc_mipi: supplied by vcc3v3_sys
> > [    0.801316] fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1]
> > Detected!
> > [    0.802661] vdd_cpu_b: supplied by vcc5v0_sys
> > [    0.805416] fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1]
> > Detected!
> > [    0.806706] vdd_gpu: supplied by vcc5v0_sys
> > [    0.819985] dw_wdt ff848000.watchdog: No valid TOPs array specified
> > [    0.825784] cpu cpu0: EM: created perf domain
> > [    0.827910] cpu cpu4: EM: created perf domain
> > [    0.831873] sdhci: Secure Digital Host Controller Interface driver
> > [    0.832430] sdhci: Copyright(c) Pierre Ossman
> > [    0.833804] Synopsys Designware Multimedia Card Interface Driver
> > [    0.835668] dwmmc_rockchip fe310000.mmc: IDMAC supports 32-bit addre=
ss
> > mode.
> > [    0.835799] dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit addre=
ss
> > mode.
> > [    0.836088] sdhci-pltfm: SDHCI platform and OF driver helper
> > [    0.836316] dwmmc_rockchip fe310000.mmc: Using internal DMA controll=
er.
> > [    0.836923] dwmmc_rockchip fe320000.mmc: Using internal DMA controll=
er.
> > [    0.837411] dwmmc_rockchip fe310000.mmc: Version ID is 270a
> > [    0.837903] mmc1: CQHCI version 5.10
> > [    0.837987] dwmmc_rockchip fe320000.mmc: Version ID is 270a
> > [    0.838710] dwmmc_rockchip fe310000.mmc: DW MMC controller at irq 32=
,32
> > bit host data width,256 deep fifo
> > [    0.839122] dwmmc_rockchip fe320000.mmc: DW MMC controller at irq 33=
,32
> > bit host data width,256 deep fifo
> > [    0.839198] ledtrig-cpu: registered to indicate activity on CPUs
> > [    0.839659] dwmmc_rockchip fe310000.mmc: allocated mmc-pwrseq
> > [    0.839988] dwmmc_rockchip fe320000.mmc: Got CD GPIO
> > [    0.840702] mmc_host mmc2: card is non-removable.
> > [    0.841737] usbcore: registered new interface driver usbhid
> > [    0.843909] usbhid: USB HID core driver
> > [    0.851700] NET: Registered PF_PACKET protocol family
> > [    0.852284] 9pnet: Installing 9P2000 support
> > [    0.852709] Key type dns_resolver registered
> > [    0.854024] Loading compiled-in X.509 certificates
> > [    0.854585] mmc_host mmc0: Bus speed (slot 0) =3D 400000Hz (slot req
> > 400000Hz, actual 400000HZ div =3D 0)
> > [    0.854753] mmc_host mmc2: Bus speed (slot 0) =3D 400000Hz (slot req
> > 400000Hz, actual 400000HZ div =3D 0)
> > [    0.860237] Freeing initrd memory: 13904K
> > [    0.862502] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] us=
ing
> > ADMA
> > [    0.873812] vcc_0v9: supplied by vcc3v3_sys
> > [    0.874203] random: fast init done
> > [    0.898381] mmc_host mmc2: Bus speed (slot 0) =3D 300000Hz (slot req
> > 300000Hz, actual 300000HZ div =3D 0)
> > [    0.911007] ALSA device list:
> > [    0.911278]   No soundcards found.
> > [    0.911713] dw-apb-uart ff1a0000.serial: forbid DMA for kernel conso=
le
> > [    0.915111] Freeing unused kernel memory: 7168K
> > [    0.926547] Run /init as init process
> > [    0.926871]   with arguments:
> > [    0.927129]     /init
> > [    0.927330]   with environment:
> > [    0.927604]     HOME=3D/
> > [    0.927812]     TERM=3Dlinux
> > [    0.928050]     ubootpart=3D7f91284d-01
> > [    0.928370]     cgroup_enable=3Dmemory
> > [    0.928682]     cgroup_memory=3D1
> > [    0.946246] mmc_host mmc2: Bus speed (slot 0) =3D 200000Hz (slot req
> > 200000Hz, actual 200000HZ div =3D 0)
> > Loading, please wait...
> > [    0.958681] mmc1: Command Queue Engine enabled
> > [    0.959107] mmc1: new HS400 Enhanced strobe MMC card at address 0001
> > [    0.960404] mmcblk1: mmc1:0001 SLD32G 28.9 GiB
> > Starting version 245.4-4ubuntu3.16
> > [    0.987817]  mmcblk1: p1
> > [    0.988726] mmcblk1boot0: mmc1:0001 SLD32G 4.00 MiB
> > [    0.990645] mmcblk1boot1: mmc1:0001 SLD32G 4.00 MiB
> > [    0.995628] mmcblk1rpmb: mmc1:0001 SLD32G 4.00 MiB, chardev (234:0)
> > [    0.997067] mmc_host mmc2: Bus speed (slot 0) =3D 100000Hz (slot req
> > 100000Hz, actual 100000HZ div =3D 0)
> > [    1.241453] mmc1: running CQE recovery
> > [    1.242151] ------------[ cut here ]------------
> > [    1.242580] mmc1: cqhci: spurious TCN for tag 11
> > [    1.243048] WARNING: CPU: 0 PID: 186 at
> > drivers/mmc/host/cqhci-core.c:786 cqhci_irq+0x31c/0x640
> > [    1.243827] Modules linked in:
> > [    1.244105] CPU: 0 PID: 186 Comm: kworker/0:1H Not tainted 5.15.37-d=
irty
> > #2
> > [    1.244723] Hardware name: Radxa ROCK Pi 4B (DT)
> > [    1.245141] Workqueue: kblockd blk_mq_run_work_fn
> > [    1.245571] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS
> > BTYPE=3D--)
> > [    1.246182] pc : cqhci_irq+0x31c/0x640
> > [    1.246525] lr : cqhci_irq+0x31c/0x640
> > [    1.246862] sp : ffff800008003d80
> > [    1.247155] x29: ffff800008003d80 x28: ffff000006798000 x27:
> > ffff0000049b7580
> > [    1.247787] x26: 0000000000000001 x25: ffff8000097eb1d0 x24:
> > ffff0000049ed098
> > [    1.248420] x23: ffff80000a394974 x22: ffff0000049b7000 x21:
> > 0000000000000002
> > [    1.249051] x20: ffff0000049ed080 x19: 000000000000000b x18:
> > 0000000000000030
> > [    1.249682] x17: ffff80007609e000 x16: ffff800008004000 x15:
> > ffffffffffffffff
> > [    1.250312] x14: 0000000000000000 x13: ffff80000a01be10 x12:
> > 0000000000000459
> > [    1.250943] x11: 0000000000000173 x10: ffff80000a073e10 x9 :
> > 00000000fffff000
> > [    1.251573] x8 : ffff80000a01be10 x7 : ffff80000a073e10 x6 :
> > 0000000000000000
> > [    1.252204] x5 : 000000000000bff4 x4 : 0000000000000000 x3 :
> > 0000000000000000
> > [    1.252834] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
> > ffff000006798000
> > [    1.253465] Call trace:
> > [    1.253685]  cqhci_irq+0x31c/0x640
> > [    1.253998]  sdhci_arasan_cqhci_irq+0x54/0x84
> > [    1.254391]  sdhci_irq+0xb4/0xdc0
> > [    1.254693]  __handle_irq_event_percpu+0x64/0x25c
> > [    1.255117]  handle_irq_event+0x64/0x150
> > [    1.255468]  handle_fasteoi_irq+0xa8/0x19c
> > [    1.255834]  handle_domain_irq+0x64/0x94
> > [    1.256184]  gic_handle_irq+0xbc/0x140
> > [    1.256520]  call_on_irq_stack+0x2c/0x60
> > [    1.256871]  do_interrupt_handler+0x54/0x60
> > [    1.257245]  el1_interrupt+0x30/0x80
> > [    1.257569]  el1h_64_irq_handler+0x1c/0x30
> > [    1.257935]  el1h_64_irq+0x78/0x7c
> > [    1.258241]  sdhci_arasan_cqe_enable+0xac/0xf0
> > [    1.258640]  mmc_cqe_start_req+0x70/0x110
> > [    1.259000]  mmc_blk_mq_issue_rq+0x4d8/0xa60
> > [    1.259381]  mmc_mq_queue_rq+0x120/0x2bc
> > [    1.259731]  blk_mq_dispatch_rq_list+0x118/0x800
> > [    1.260143]  __blk_mq_sched_dispatch_requests+0xb4/0x160
> > [    1.260615]  blk_mq_sched_dispatch_requests+0x3c/0x80
> > [    1.261065]  __blk_mq_run_hw_queue+0x54/0x90
> > [    1.261449]  blk_mq_run_work_fn+0x24/0x30
> > [    1.261810]  process_one_work+0x1d4/0x480
> > [    1.262172]  worker_thread+0x13c/0x470
> > [    1.262509]  kthread+0x154/0x160
> > [    1.262803]  ret_from_fork+0x10/0x20
> > [    1.263127] ---[ end trace 1f38c121ed6ab84b ]---
> > [    1.264149] mmc1: running CQE recovery
> > [    1.265266] mmc1: running CQE recovery
> > [    1.265823] blk_update_request: I/O error, dev mmcblk1, sector 136 o=
p
> > 0x0:(READ) flags 0x80700 phys_seg 8 prio class 0
> > [    1.269914] mmc1: running CQE recovery
> > [    1.270856] mmc1: running CQE recovery
> > [    1.271768] mmc1: running CQE recovery
> > [    1.272325] blk_update_request: I/O error, dev mmcblk1, sector 216 o=
p
> > 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > [    1.273256] Buffer I/O error on dev mmcblk1, logical block 27, async
> > page read
> > [    1.274774] mmc1: running CQE recovery
> > [    1.275700] mmc1: running CQE recovery
> > [    1.276616] mmc1: running CQE recovery
> > [    1.277168] blk_update_request: I/O error, dev mmcblk1, sector 216 o=
p
> > 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > [    1.278096] Buffer I/O error on dev mmcblk1, logical block 27, async
> > page read
> > [    1.279322] mmc1: running CQE recovery
> > Begin: Loading essential drivers ... done.
> > Begin: Running /scripts/init-premount ... done.
> > Begin: Mounting root file system ... Begin: Running /scripts/local-top =
...
> > done.
> > Begin: Running /scripts/local-premount ... done.
> > Begin: Will now check root file system ... fsck from util-linux 2.34
> > [/usr/sbin/fsck.ext4 (1) -- /dev/mmcblk1p1] fsck.ext4 -a -C0 /dev/mmcbl=
k1p1
> > /dev/mmcblk1p1 contains a file system with errors, check forced.
> > [    1.436424] mmc1: running CQE recovery
> > [    1.439079] mmc1: running CQE recovery
> > [    1.440298] mmc1: running CQE recovery
> > [    1.440894] blk_update_request: I/O error, dev mmcblk1, sector 34760=
 op
> > 0x0:(READ) flags 0x80700 phys_seg 8 prio class 0
> > [    1.543306] mmc1: running CQE recovery
> > [    1.544544] mmc1: running CQE recovery
> > [    1.545336] mmc1: running CQE recovery
> > [    1.545837] blk_update_request: I/O error, dev mmcblk1, sector 35104=
 op
> > 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > [    1.546809] Buffer I/O error on dev mmcblk1p1, logical block 292, as=
ync
> > page read
> > [    1.548043] mmc1: running CQE recovery
> > [    1.548801] mmc1: running CQE recovery
> > [    1.549556] mmc1: running CQE recovery
> > [    1.550031] blk_update_request: I/O error, dev mmcblk1, sector 35104=
 op
> > 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > [    1.550961] Buffer I/O error on dev mmcblk1p1, logical block 292, as=
ync
> > page read
> > [    1.552051] mmc1: running CQE recovery
> > [    1.552811] mmc1: running CQE recovery
> > [    1.553565] mmc1: running CQE recovery
> > [    1.554051] blk_update_request: I/O error, dev mmcblk1, sector 35104=
 op
> > 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > [    1.555020] Buffer I/O error on dev mmcblk1p1, logical block 292, as=
ync
> > page read
> > [    1.556251] mmc1: running CQE recovery
> > [    1.557296] mmc1: running CQE recovery
> > [    1.558286] mmc1: running CQE recovery
> > [    1.558896] blk_update_request: I/O error, dev mmcblk1, sector 35104=
 op
> > 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > [    1.559846] Buffer I/O error on dev mmcblk1p1, logical block 292, as=
ync
> > page read
> > [    1.561036] mmc1: running CQE recovery
> > [    1.561982] mmc1: running CQE recovery
> > [    1.562957] mmc1: running CQE recovery
> > [    1.563531] blk_update_request: I/O error, dev mmcblk1, sector 35104=
 op
> > 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > [    1.564479] Buffer I/O error on dev mmcblk1p1, logical block 292, as=
ync
> > page read
> > [    1.565665] mmc1: running CQE recovery
> > [    1.566724] mmc1: running CQE recovery
> > [    1.567572] mmc1: running CQE recovery
> > [    1.568049] blk_update_request: I/O error, dev mmcblk1, sector 35104=
 op
> > 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> > [    1.568972] Buffer I/O error on dev mmcblk1p1, logical block 292, as=
ync
> > page read
> > Error reading block 292 (Input/output error) while getting next inode f=
rom
> > scan.
> >
> > /dev/mmcblk1p1: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
> > (i.e., without -a or -p options)
> > fsck exited with status code 4
> > done.
> > Failure: File system check of the root filesystem failed
> > The root filesystem on /dev/mmcblk1p1 requires a manual fsck
> >
> >
> > BusyBox v1.30.1 (Ubuntu 1:1.30.1-4ubuntu6.4) built-in shell (ash)
> > Enter 'help' for a list of built-in commands.
> >
> > (initramfs)
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>      =3D
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
