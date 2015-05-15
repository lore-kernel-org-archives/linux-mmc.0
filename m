From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Fri, 15 May 2015 14:29:09 +0800
Message-ID: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:34182 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbbEOG3a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2015 02:29:30 -0400
Received: by yhom41 with SMTP id m41so29280977yho.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2015 23:29:29 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>, linux-mmc@vger.kernel.org

This reverts commit 459fe0cfda71835eacc0b24571e8425cea975688.
It causes kernel panic due to a null pointer reference to .set_bus_width
on fsl p2020rdb board.
  Unable to handle kernel paging request for instruction fetch
  Faulting instruction address: 0x00000000
  Oops: Kernel access of bad area, sig: 11 [#1]
  SMP NR_CPUS=8 P2020 RDB
  Modules linked in:
  CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.1.0-rc3-next-20150514-00001-g76c7a15bee83 #103
  task: ea858000 ti: ea846000 task.ti: ea846000
  NIP: 00000000 LR: c048036c CTR: 00000000
  REGS: ea847c70 TRAP: 0400   Not tainted  (4.1.0-rc3-next-20150514-00001-g76c7a15bee83)
  MSR: 00021000 <CE,ME>  CR: 22010022  XER: 00000000

  GPR00: c04802c4 ea847d20 ea858000 eaa3ab00 00000000 00000f20 00000002 00000000
  GPR08: 00000000 00000000 00000000 90000000 22010022 00000000 c0002a68 00000000
  GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 c08a64e0 000000e9
  GPR24: c080f398 c08a0000 00000000 0000000e 00029000 eaa3ab28 eaa3a9f0 eaa3ab00
  NIP [00000000]   (null)
  LR [c048036c] sdhci_do_set_ios+0x164/0x824
  Call Trace:
  [ea847d20] [c04802c4] sdhci_do_set_ios+0xbc/0x824 (unreliable)
  [ea847d40] [c0480a60] sdhci_set_ios+0x34/0x4c
  [ea847d50] [c046c96c] mmc_power_up.part.16+0x3c/0x120
  [ea847d70] [c046da10] mmc_start_host+0x50/0xa4
  [ea847d80] [c046ee28] mmc_add_host+0x50/0x78
  [ea847d90] [c0481438] sdhci_add_host+0x8c4/0xcc0
  [ea847db0] [c0485824] sdhci_esdhc_probe+0xa8/0xc8
  [ea847dd0] [c032ed28] platform_drv_probe+0x3c/0xa4
  [ea847df0] [c032d170] driver_probe_device+0x1f0/0x2c4
  [ea847e10] [c032d370] __driver_attach+0xbc/0xc0
  [ea847e30] [c032b178] bus_for_each_dev+0x6c/0xb8
  [ea847e60] [c032c6b8] bus_add_driver+0x168/0x220
  [ea847e80] [c032da70] driver_register+0x88/0x130
  [ea847e90] [c000234c] do_one_initcall+0x8c/0x1e0
  [ea847f00] [c0815b08] kernel_init_freeable+0x138/0x1d4
  [ea847f30] [c0002a7c] kernel_init+0x14/0x100
  [ea847f40] [c000e838] ret_from_kernel_thread+0x5c/0x64

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7a98a2207976..1804bdbdb145 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -82,10 +82,6 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
 		/* fixup the result */
 		ret &= ~SDHCI_CTRL_DMA_MASK;
 		ret |= dma_bits;
-
-		/* 8BIT is bit 29 in Control register */
-		ret |= ((ret << 3) & SDHCI_CTRL_8BITBUS);
-		ret &= ~(SDHCI_CTRL_8BITBUS >> 3);
 	}
 
 	return ret;
@@ -138,10 +134,6 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 			dma_bits);
 		val &= ~SDHCI_CTRL_DMA_MASK;
 		val |= in_be32(host->ioaddr + reg) & SDHCI_CTRL_DMA_MASK;
-
-		/* 8BIT is bit 29 in Control register */
-		val |= ((val & SDHCI_CTRL_8BITBUS) >> 3);
-		val = (val & ~SDHCI_CTRL_8BITBUS);
 	}
 
 	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
@@ -262,6 +254,28 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 }
 
+static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
+{
+	u32 ctrl;
+
+	switch (width) {
+	case MMC_BUS_WIDTH_8:
+		ctrl = ESDHC_CTRL_8BITBUS;
+		break;
+
+	case MMC_BUS_WIDTH_4:
+		ctrl = ESDHC_CTRL_4BITBUS;
+		break;
+
+	default:
+		ctrl = 0;
+		break;
+	}
+
+	clrsetbits_be32(host->ioaddr + SDHCI_HOST_CONTROL,
+			ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
+}
+
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
 	sdhci_reset(host, mask);
@@ -283,6 +297,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.get_min_clock = esdhc_of_get_min_clock,
 	.platform_init = esdhc_of_platform_init,
 	.adma_workaround = esdhci_of_adma_workaround,
+	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.reset = esdhc_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
-- 
2.1.0

