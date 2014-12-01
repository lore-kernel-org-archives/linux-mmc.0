From: Rickard Gustafsson <rickard.gustafsson@hostmobility.com>
Subject: sdhci-esdhc-imx kernel panic on resume from suspend
Date: Mon, 1 Dec 2014 13:51:39 +0100
Message-ID: <CAF1WMs5YJyTi9EX-0iCPFy-7Zydppxkx5bct6_Fe49NrsDK6+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:65085 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbaLAMvk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Dec 2014 07:51:40 -0500
Received: by mail-wg0-f51.google.com with SMTP id k14so13828892wgh.24
        for <linux-mmc@vger.kernel.org>; Mon, 01 Dec 2014 04:51:39 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

When resuming from suspend the sdhci-esdhc-imx driver causes a kernel
panic if no card is inserted into card reader. Works fine when card is
inserted.

The problem is resolved when  pm_runtime_set_active(&pdev->dev); is
removed from sdhci_esdhc_imx_probe(struct platform_device *pdev).
Should this fuction be called here or is it handled via mmc core?

Attaching kernel log.

[   93.177424] PM: Syncing filesystems ... done.
[   93.304719] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   93.313460] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   93.327760] PM: suspend of devices complete after 4.607 msecs
[   93.333751] PM: suspend devices took 0.010 seconds
[   93.339878] PM: late suspend of devices complete after 1.099 msecs
[   93.347499] PM: noirq suspend of devices complete after 1.198 msecs
[   93.354814] PM: noirq resume of devices complete after 0.780 msecs
[   93.362390] PM: early resume of devices complete after 0.761 msecs
[   93.369431] Unhandled fault: external abort on non-linefetch
(0x1008) at 0x9086a02c
[   93.377391] Internal error: : 1008 [#1] ARM
[   93.381738] Modules linked in:
[   93.384953] CPU: 0 PID: 384 Comm: sh Not tainted
3.18.0-rc5-104485-g4d2a9b2-dirty #30
[   93.393067] task: 8e046400 ti: 8ca26000 task.ti: 8ca26000
[   93.398689] PC is at esdhc_writeb_le+0x58/0x150
[   93.403400] LR is at esdhc_writeb_le+0x58/0x150
[   93.408102] pc : [<803f4d48>]    lr : [<803f4d48>]    psr: a00f0013
[   93.408102] sp : 8ca27cc0  ip : 8ca27cc0  fp : 8ca27cec
[   93.419974] r10: 00000018  r9 : 8079a044  r8 : 8ea1be10
[   93.425387] r7 : 9086a02c  r6 : 00000001  r5 : 8ea35ac0  r4 : 0000002f
[   93.432147] r3 : 90808730  r2 : 90808000  r1 : 00000000  r0 : 8ea35ac0
[   93.438910] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   93.446296] Control: 10c5387d  Table: 8ca28059  DAC: 00000015
[   93.452246] Process sh (pid: 384, stack limit = 0x8ca26238)
[   93.458022] Stack: (0x8ca27cc0 to 0x8ca28000)
[   93.462551] 7cc0: 803f4cf0 8ea35ac0 8ea35ac0 00000001 802dac54
8e8b7410 807a237c 00000010
[   93.471024] 7ce0: 8ca27d0c 8ca27cf0 803f4448 803f4cfc 8ea35ac0
00000001 8e8b7444 802dac54
[   93.488700] 7d00: 8ca27d24 8ca27d10 803f54a0 803f433c 8ea35ac0
00000001 8ca27d3c 8ca27d28
[   93.506426] 7d20: 803ef480 803f5498 8ea35ac0 00000000 8ca27d5c
8ca27d40 803f0b8c 803ef434
[   93.524440] 7d40: 8ea35800 8ea35ac0 00000000 8e8b7444 8ca27d7c
8ca27d60 803f1a60 803f0b78
[   93.542705] 7d60: 8ea58400 8ea35ac0 00000000 00000000 8ca27d8c
8ca27d80 803f446c 803f1994
[   93.561399] 7d80: 8ca27d9c 8ca27d90 802dac88 803f4464 8ca27dd4
8ca27da0 802e1dd0 802dac60
[   93.580206] 7da0: 800403a8 800402cc 00000000 00000000 8ca27dd4
8e8b7410 00000001 8e8b7444
[   93.599344] 7dc0: 00000010 00000000 8ca27dfc 8ca27dd8 802e1ebc
802e1da8 000000cc 8e8b7468
[   93.618555] 7de0: 8e8b7410 807b4d28 807b4d4c 8082e2a8 8ca27e44
8ca27e00 802e31e0 802e1e14
[   93.638150] 7e00: 8ca27e5c 8ca27e10 bcd565db 00000015 bcd565db
00000015 bc66d969 00000010
[   93.658112] 7e20: 807dcab0 00000003 8079abd6 00000000 8cb0380c
00000000 8ca27e5c 8ca27e48
[   93.678426] 7e40: 802e34b4 802e30fc 807dcad0 00000000 8ca27e9c
8ca27e60 80043bd8 802e34ac
[   93.699024] 7e60: 8ca27e8c 8ca27e70 8058ca40 80045f28 806bbfc0
8ca27e94 00000000 00000003
[   93.719764] 7e80: 807dcabc 00000003 8cb031c0 00000004 8ca27ebc
8ca27ea0 80043fec 8004397c
[   93.740736] 7ea0: 0000006d 00000003 806ba6d4 807dcac0 8ca27ee4
8ca27ec0 800429f0 80043d88
[   93.761722] 7ec0: 8e83fa50 8cb031c0 8ca27f78 8cb031c0 8cb03800
00000004 8ca27ef4 8ca27ee8
[   93.782715] 7ee0: 80269b84 80042988 8ca27f0c 8ca27ef8 8010e1cc
80269b74 00000000 00000000
[   93.803707] 7f00: 8ca27f44 8ca27f10 8010d848 8010e18c 00000000
00000000 8ca27f44 8ca1f900
[   93.824698] 7f20: 00000004 014f0408 8ca27f78 00000004 8ca26000
014f0408 8ca27f74 8ca27f48
[   93.845683] 7f40: 800b4dd4 8010d78c 800cca10 800cc990 00000000
00000000 8ca1f900 8ca1f900
[   93.866671] 7f60: 00000004 014f0408 8ca27fa4 8ca27f78 800b50fc
800b4d38 00000000 00000000
[   93.887660] 7f80: 00000004 014f0408 76f9ab58 00000004 8000e9e4
00000000 00000000 8ca27fa8
[   93.908647] 7fa0: 8000e840 800b50c4 00000004 014f0408 00000001
014f0408 00000004 00000000
[   93.929638] 7fc0: 00000004 014f0408 76f9ab58 00000004 00000004
014f0408 00000004 00000000
[   93.950622] 7fe0: 00000000 7eca0944 76ed26bc 76f2707c 60010010
00000001 00000000 00000000
[   93.971591] Backtrace:
[   93.980302] [<803f4cf0>] (esdhc_writeb_le) from [<803f4448>]
(sdhci_reset+0x118/0x128)
[   94.000698]  r10:00000010 r9:807a237c r8:8e8b7410 r7:802dac54
r6:00000001 r5:8ea35ac0
[   94.021142]  r4:8ea35ac0 r3:803f4cf0
[   94.030915] [<803f4330>] (sdhci_reset) from [<803f54a0>]
(esdhc_reset+0x14/0xac)
[   94.050517]  r7:802dac54 r6:8e8b7444 r5:00000001 r4:8ea35ac0
[   94.062434] [<803f548c>] (esdhc_reset) from [<803ef480>]
(sdhci_do_reset+0x58/0x9c)
[   94.082174]  r5:00000001 r4:8ea35ac0
[   94.091764] [<803ef428>] (sdhci_do_reset) from [<803f0b8c>]
(sdhci_init+0x20/0xe0)
[   94.111152]  r5:00000000 r4:8ea35ac0
[   94.120613] [<803f0b6c>] (sdhci_init) from [<803f1a60>]
(sdhci_resume_host+0xd8/0x190)
[   94.140105]  r6:8e8b7444 r5:00000000 r4:8ea35ac0 r3:8ea35800
[   94.151695] [<803f1988>] (sdhci_resume_host) from [<803f446c>]
(sdhci_pltfm_resume+0x14/0x18)
[   94.171684]  r5:00000000 r4:00000000
[   94.180953] [<803f4458>] (sdhci_pltfm_resume) from [<802dac88>]
(platform_pm_resume+0x34/0x54)
[   94.200817] [<802dac54>] (platform_pm_resume) from [<802e1dd0>]
(dpm_run_callback.isra.9+0x34/0x6c)
[   94.221127] [<802e1d9c>] (dpm_run_callback.isra.9) from
[<802e1ebc>] (device_resume+0xb4/0x188)
[   94.241065]  r8:00000000 r7:00000010 r6:8e8b7444 r5:00000001 r4:8e8b7410
[   94.253610] [<802e1e08>] (device_resume) from [<802e31e0>]
(dpm_resume+0xf0/0x214)
[   94.272460]  r8:8082e2a8 r7:807b4d4c r6:807b4d28 r5:8e8b7410
r4:8e8b7468 r3:000000cc
[   94.291831] [<802e30f0>] (dpm_resume) from [<802e34b4>]
(dpm_resume_end+0x14/0x20)
[   94.310866]  r10:00000000 r9:8cb0380c r8:00000000 r7:8079abd6
r6:00000003 r5:807dcab0
[   94.330555]  r4:00000010
[   94.338836] [<802e34a0>] (dpm_resume_end) from [<80043bd8>]
(suspend_devices_and_enter+0x268/0x40c)
[   94.359437]  r4:00000000 r3:807dcad0
[   94.368757] [<80043970>] (suspend_devices_and_enter) from
[<80043fec>] (pm_suspend+0x270/0x2a4)
[   94.389001]  r10:00000004 r8:8cb031c0 r7:00000003 r6:807dcabc
r5:00000003 r4:00000000
[   94.408641] [<80043d7c>] (pm_suspend) from [<800429f0>]
(state_store+0x74/0xc4)
[   94.427733]  r6:807dcac0 r5:806ba6d4 r4:00000003 r3:0000006d
[   94.439487] [<8004297c>] (state_store) from [<80269b84>]
(kobj_attr_store+0x1c/0x28)
[   94.459020]  r10:00000004 r8:8cb03800 r7:8cb031c0 r6:8ca27f78
r5:8cb031c0 r4:8e83fa50
[   94.479044] [<80269b68>] (kobj_attr_store) from [<8010e1cc>]
(sysfs_kf_write+0x4c/0x50)
[   94.499111] [<8010e180>] (sysfs_kf_write) from [<8010d848>]
(kernfs_fop_write+0xc8/0x184)
[   94.519335]  r5:00000000 r4:00000000
[   94.528910] [<8010d780>] (kernfs_fop_write) from [<800b4dd4>]
(vfs_write+0xa8/0x1b0)
[   94.548477]  r10:014f0408 r9:8ca26000 r8:00000004 r7:8ca27f78
r6:014f0408 r5:00000004
[   94.568290]  r4:8ca1f900
[   94.576618] [<800b4d2c>] (vfs_write) from [<800b50fc>] (SyS_write+0x44/0x90)
[   94.589539]  r10:014f0408 r8:00000004 r7:8ca1f900 r6:8ca1f900
r5:00000000 r4:00000000
[   94.609023] [<800b50b8>] (SyS_write) from [<8000e840>]
(ret_fast_syscall+0x0/0x30)
[   94.628209]  r10:00000000 r8:8000e9e4 r7:00000004 r6:76f9ab58
r5:014f0408 r4:00000004
[   94.648005] Code: e5993014 e3530000 0a000000 e12fff33 (e5973000)
[   94.660150] ---[ end trace 7d827e90462ff80c ]---
