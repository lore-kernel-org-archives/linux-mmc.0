From: Peter Chen <peter.chen@freescale.com>
Subject: [PATCH 1/1] mmc: sdhci: Clear all possible pending status bits
Date: Mon, 18 Mar 2013 14:27:12 +0800
Message-ID: <1363588032-26913-1-git-send-email-peter.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:28361
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750813Ab3CRG1W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Mar 2013 02:27:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: guo.shawn@linaro.org, linux-mmc@vger.kernel.org

Clear all possible pending status bits before request_irq

I meet below oops error occasionally at my Freescale
mx6q SabreSD board, it seems SDHCI_INT_CARD_INT
is triggered but the sdio task is still not created.

-------------------------------DUMP---------------------------------------------
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: no vqmmc regulator found
mmc0: no vmmc regulator found
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = 80004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.9.0-rc2+ #2)
PC is at wake_up_process+0xc/0x44
LR is at sdhci_irq+0x408/0xa10
pc : [<8004f66c>]    lr : [<8040a28c>]    psr: 60000193
sp : bf857b90  ip : bf857ba8  fp : bf857ba4
r10: bf808a24  r9 : bf8089c0  r8 : 00000037
r7 : 00000100  r6 : 00000001  r5 : 00000001  r4 : bfb49000
r3 : 00000001  r2 : 00000002  r1 : 20000193  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 1000404a  DAC: 00000017
Process swapper/0 (pid: 1, stack limit = 0xbf856238)
Stack: (0xbf857b90 to 0xbf858000)
7b80:                                     bfb49000 00000001 bf857c0c bf857ba8
7ba0: 8040a28c 8004f66c bf857be4 00df7000 bfb49370 bfb49374 bfb49388 bfb49384
7bc0: bfb493c8 00000001 bf857c14 bf857bd8 8007b31c 00000000 bfb49328 00000000
7be0: bf857be0 bfb47bc0 8072ab38 00000000 00000000 00000037 bf8089c0 bf808a24
7c00: bf857c44 bf857c10 8007349c 80409e90 80029d70 80029adc 800142d4 bf8089c0
7c20: 8072ab38 8071fba0 00000037 00000000 8071e404 bf8089f0 bf857c5c bf857c48
7c40: 80073634 80073454 bf8089c0 8072ab38 bf857c74 bf857c60 800763bc 800735f4
7c60: 00000037 8072ab38 bf857c8c bf857c78 8007342c 8007632c bf856000 8072ab38
7c80: bf857cb4 bf857c90 8000f660 80073408 f400010c 8072ac98 bf857cd8 f4000110
7ca0: 60000113 8071e404 bf857cd4 bf857cb8 80008614 8000f618 80542674 60000113
7cc0: ffffffff bf857d0c bf857d2c bf857cd8 8000e7c0 800085ec bf808a10 60000113
7ce0: 00000007 00000000 bf8089c0 bfb47bc0 00000037 bf808a10 60000113 8071e404
7d00: bf8089f0 bf857d2c bf857d30 bf857d20 80074870 80542674 60000113 ffffffff
7d20: bf857d6c bf857d30 80074870 80542654 157f513f 80074d30 00002c0d 0000000f
7d40: bfb49240 bfb49240 80409e84 bf8089c0 bfb47bc0 00000037 8071e404 80711e6c
7d60: bf857d9c bf857d70 80074d7c 8007470c 00000080 00000000 00000000 bfb49240
7d80: bfb49000 04000000 bfb49370 bfb49384 bf857dcc bf857da0 80409a10 80074c9c
7da0: bfb47800 bfb49240 bfb47910 bfb47910 bfb49240 00000000 bf98fa00 00000000
7dc0: bf857dfc bf857dd0 8040bce0 804092d0 bf857dec bf857de0 8011f494 807bc088
7de0: 80762700 bf98fa10 00000000 80762700 bf857e0c bf857e00 802ee5e8 8040ba68
7e00: bf857e34 bf857e10 802ed108 802ee5d4 bf98fa10 80762700 bf98fa44 00000000
7e20: 000000a7 8071e404 bf857e54 bf857e38 802ed31c 802ed084 80762700 802ed288
7e40: bf857e58 00000000 bf857e7c bf857e58 802eb8a8 802ed294 bf83a458 bf931b34
7e60: 80762700 80752af0 bfb25b00 00000000 bf857e8c bf857e80 802ecf58 802eb838
7e80: bf857eb4 bf857e90 802ec1f0 802ecf44 80692164 bf857ea0 bf856000 80762700
7ea0: 8076cdc0 00000000 bf857edc bf857eb8 802ed94c 802ec054 bf856000 00000007
7ec0: 8076cdc0 00000000 000000a7 8071e404 bf857eec bf857ee0 802ee8f0 802ed8d8
7ee0: bf857efc bf857ef0 806fed50 802ee8b0 bf857f54 bf857f00 800086fc 806fed48
7f00: bf857f54 bf857f10 806fed3c 00000000 00000000 00000006 00000006 806d2790
7f20: 806886a8 60000113 bf857f54 80711e64 00000007 8076cdc0 806d544c 000000a7
7f40: 8071e404 80711e6c bf857f94 bf857f58 806d5380 800086c8 00000006 00000006
7f60: 806d544c 845a9090 a01e93d0 00000000 8053a958 00000000 00000000 00000000
7f80: 00000000 00000000 bf857fac bf857f98 8053a968 806d5290 00000000 8053a958
7fa0: 00000000 bf857fb0 8000ecd8 8053a964 00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 02012091 82205cc0
Backtrace:
[<8004f660>] (wake_up_process+0x0/0x44) from [<8040a28c>] (sdhci_irq+0x408/0xa10)
 r5:00000001 r4:bfb>] (generic_handle_irq+0x30/0x38)
 r5:8072ab38 r4:00000037
[<800733fc>] (generic_handle_irq+0x0/0x38) from [<8000f660>] (handle_IRQ+0x54/0xb4)
 r5:8072ab38 r4:bf856000
[<8000f60c>] (handle_IRQ+0x0/0xb4) from [<80008614>] (gic_handle_irq+0x34/0x68)
 r9:8071e404 r8:60000113 r7:f4000110 r6:bf857cd8 r5:8072ac98
r4:f400010c
[<800085e0>] (gic_handle_irq+0x0/0x68) from [<8000e7c0>] (__irq_svc+0x40/0x54)
Exception stack(0xbf857cd8 to 0xbf857d20)
7cc0:                                                       bf808a10 60000113
7ce0: 00000007 00000000 bf8089c0 bfb47bc0 00000037 bf808a10 60000113 8071e404
7d00: bf8089f0 bf857d2c bf857d30 bf857d20 80074870 80542674 60000113 ffffffff
 r7:bf857d0c r6:ffffffff r5:60000113 r4:80542674
[<80542648>] (_raw_spin_unlock_irqrestore+0x0/0x30) from [<80074870>] (__setup_irq+0x170/0x414)
[<80074700>] (__setup_irq+0x0/0x414) from [<80074d7c>] (request_threaded_irq+0xec/0x164)
[<80074c90>] (request_threaded_irq+0x0/0x164) from [<80409a10>] (sdhci_add_host+0x74c/0xbc0)
 r8:bfb49384 r7:bfb49370 r6:04000000 r5:bfb49000 r4:bfb49240
[<804092c4>] (sdhci_add_host+0x0/0xbc0) from [<8040bce0>] (sdhci_esdhc_imx_probe+0x284/0x504)
 r8:00000000 r7:bf98fa00 r6:00000000 r5:bfb49240 r4:bfb47910
[<8040ba5c>] (sdhci_esdhc_imx_probe+0x0/0x504) from [<802ee5e8>] (platform_drv_probe+0x20/0x24)
 r8:80762700 r7:00000000 r6:bf98fa10 r5:80762700 r4:807bc088
[<802ee5c8>] (platform_drv_probe+0x0/0x24) from [<802ed108>] (driver_probe_device+0x90/0x210)
[<802ed078>] (driver_probe_device+0x0/0x210) from [<802ed31c>] (__driver_attach+0x94/0x98)
 r9:8071e404 r8:000000a7 r7:00000000 r6:bf98fa44 r5:80762700
r4:bf98fa10
[<802ed288>] (__driver_attach+0x0/0x98) from [<802eb8a8>] (bus_for_each_dev+0x7c/0xa0)
 r7:00000000 r6:bf857e58 r5:802ed288 r4:80762700
[<802eb82c>] (bus_for_each_dev+0x0/0xa0) from [<802ecf58>] (driver_attach+0x20/0x28)
 r7:00000000 r6:bfb25b00 r5:80752af0 r4:80762700
[<802ecf38>] (driver_attach+0x0/0x28) from [<802ec1f0>] (bus_add_driver+0x1a8/0x244)
[<802ec048>] (bus_add_driver+0x0/0x244) from [<802ed94c>] (driver_register+0x80/0x148)
 r7:00000000 r6:8076cdc0 r5:80762700 r4:bf856000
[<802ed8cc>] (driver_register+0x0/0x148) from [<802ee8f0>] (platform_driver_register+0x4c/0x60)
 r9:8071e404 r8:000000a7 r7:00000000 r6:8076cdc0 r5:00000007
r4:bf856000
[<802ee8a4>] (platform_driver_register+0x0/0x60) from [<806fed50>] (sdhci_esdhc_imx_driver_init+0x14/0x1c)
[<806fed3c>] (sdhci_esdhc_imx_driver_init+0x0/0x1c) from [<800086fc>] (do_one_initcall+0x40/0x194)
[<800086bc>] (do_one_initcall+0x0/0x194) from [<806d5380>] (kernel_init_freeable+0xfc/0x1c8)
[<806d5284>] (kernel_init_freeable+0x0/0x1c8) from [<8053a968>] (kernel_init+0x10/0xec)
[<8053a958>] (kernel_init+0x0/0xec) from [<8000ecd8>] (ret_from_fork+0x14/0x3c)
 r5:8053a958 r4:00000000
Code: e89da800 e1a0c00d e92dd830 e24cb004 (e5903000)
---[ end trace e0e66d7e1108b3cb ]---
Kernel panic - not syncing: Fatal exception in interrupt
CPU1: stopping
Backtrace:
[<800122f0>] (dump_backtrace+0x0/0x10c) from [<8053f760>] (dump_stack+0x18/0x1c)
 r7:00000000 r6:8071fba0 r5:8072ab38 r4:8076d11c
[<8053f748>] (dump_stack+0x0/0x1c) from [<800139d8>] (handle_IPI+0x114/0x150)
[<800138c4>] (handle_IPI+0x0/0x150) from [<80008640>] (gic_handle_irq+0x60/0x68)
 r9:412fc09a r8:8076ce88 r7:f4000110 r6:bf89ff70 r5:8072ac98
r4:f400010c
[<800085e0>] (gic_handle_irq+0x0/0x68) from [<8000e7c0>] (__irq_svc+0x40/0x54)
Exception stack(0xbf89ff70 to 0xbf89ffb8)
ff60:                                     00000000 00000000 0000000f 80019440
ff80: bf89e000 8076ce88 80544e0c 00000000 8076ce88 412fc09a 8072a850 bf89ffdc
ffa0: bf89ff78 bf89ffb8 8000fcb0 8000fc8c 60000113 ffffffff
 r7:bf89ffa4 r6:ffffffff r5:60000113 r4:8000fc8c
[<8000fbc8>] (cpu_idle+0x0/0x10c) from [<8053cd54>] (secondary_start_kernel+0x150/0x178)
[<8053cc04>] (secondary_start_kernel+0x0/0x178) from [<1053c544>] (0x1053c544)
 r5:0000001f r4:4f87c06a
CPU3: stopping
Backtrace:
[<800122f0>] (dump_backtrace+0x0/0x10c) from [<8053f760>] (dump_stack+0x18/0x1c)
 r7:00000000 r6:8071fba0 r5:8072ab38 r4:8076d11c
[<8053f748>] (dump_stack+0x0/0x1c) from [<800139d8>] (handle_IPI+0x114/0x150)
[<800138c4>] (handle_IPI+0x0/0x150) from [<80008640>] (gic_handle_irq+0x60/0x68)
 r9:412fc09a r8:8076ce88 r7:f4000110 r6:bf8a3f70 r5:8072ac98
r4:f400010c
[<800085e0>] (gic_handle_irq+0x0/0x68) from [<8000e7c0>] (__irq_svc+0x40/0x54)
Exception stack(0xbf8a3f70 to 0xbf8a3fb8)
3f60:                                     00000000 00000000 0000000f 80019440
3f80: bf8a2000 8076ce88 80544e0c 00000000 8076ce88 412fc09a 8072a850 bf8a3fdc
3fa0: bf8a3f78 bf8a3fb8 8000fcb0 8000fc8c 60000113 ffffffff
 r7:bf8a3fa4 r6:ffffffff r5:60000113 r4:8000fc8c
[<8000fbc8>] (cpu_idle+0x0/0x10c) from [<8053cd54>] (secondary_start_kernel+0x150/0x178)
[<8053cc04>] (secondary_start_kernel+0x0/0x178) from [<1053c544>] (0x1053c544)
 r5:0000001f r4:4f87c06a
CPU2: stopping
Backtrace:
[<800122f0>] (dump_backtrace+0x0/0x10c) from [<8053f760>] (dump_stack+0x18/0x1c)
 r7:00000000 r6:8071fba0 r5:8072ab38 r4:8076d11c
[<8053f748>] (dump_stack+0x0/0x1c) from [<800139d8>] (handle_IPI+0x114/0x150)
[<800138c4>] (handle_IPI+0x0/0x150) from [<80008640>] (gic_handle_irq+0x60/0x68)
 r9:412fc09a r8:8076ce88 r7:f4000110 r6:bf8a1f70 r5:8072ac98
r4:f400010c
[<800085e0>] (gic_handle_irq+0x0/0x68) from [<8000e7c0>] (__irq_svc+0x40/0x54)
Exception stack(0xbf8a1f70 to 0xbf8a1fb8)
1f60:                                     00000000 00000000 0000000f 80019440
1f80: bf8a0000 8076ce88 80544e0c 00000000 8076ce88 412fc09a 8072a850 bf8a1fdc
1fa0: bf8a1f78 bf8a1fb8 8000fcb0 8000fc8c 60000113 ffffffff
 r7:bf8a1fa4 r6:ffffffff r5:60000113 r4:8000fc8c
[<8000fbc8>] (cpu_idle+0x0/0x10c) from [<8053cd54>] (secondary_start_kernel+0x150/0x178)
[<8053cc04>] (secondary_start_kernel+0x0/0x178) from [<1053c544>] (0x1053c544)
 r5:0000001f r4:4f87c06a
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/mmc/host/sdhci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 51bbba4..59cd6c0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3137,6 +3137,9 @@ int sdhci_add_host(struct sdhci_host *host)
 		host->tuning_timer.function = sdhci_tuning_timer;
 	}
 
+	/* Clear all possible pending status bits */
+	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
+
 	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
 		mmc_hostname(mmc), host);
 	if (ret) {
-- 
1.7.0.4


