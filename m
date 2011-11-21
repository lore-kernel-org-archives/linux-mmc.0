From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: [PATCH v2 3/4] mmc: sdhci-pxa: Add SDHCI driver for PXA16x
Date: Mon, 21 Nov 2011 09:56:49 +0530
Message-ID: <1321849609-3013-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <87r51fwxgt.fsf@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ahm.einfochips.com ([203.76.128.206]:59370 "EHLO
	ahm.einfochips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab1KUE1A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Nov 2011 23:27:00 -0500
In-Reply-To: <87r51fwxgt.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei.gao@marvell.com, dwang4@marvell.com, njun@marvell.com, wuqm@marvell.com, prakity@marvell.com
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>

PXA16x devices uses SDHCI controller v1. As it's not much different
than v2 controller, v1 driver is merged with sdhci-pxav2 driver

v2 - instead of having separate file sdhci-pxav1, merge code with
     sdhci-pxav2 driver code as suggested by Chris Ball

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 drivers/mmc/host/Kconfig                |    7 ++++---
 drivers/mmc/host/sdhci-pxav2.c          |   30 +++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c                |    3 +++
 drivers/mmc/host/sdhci.h                |    1 +
 include/linux/platform_data/pxa_sdhci.h |    2 ++
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 21b4149..77541f5 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -195,14 +195,15 @@ config MMC_SDHCI_PXAV3
 	  If unsure, say N.
 
 config MMC_SDHCI_PXAV2
-	tristate "Marvell PXA9XX SD Host Controller support (PXAV2)"
+	tristate "Marvell PXA16X/PXA9XX SD Host Controller support (PXAV1/V2)"
 	depends on CLKDEV_LOOKUP
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
 	default y if CPU_PXA910
+	default y if CPU_PXA168
 	help
-	  This selects the Marvell(R) PXAV2 SD Host Controller.
-	  If you have a PXA9XX platform with SD Host Controller
+	  This selects the Marvell(R) PXAV1/V2 SD Host Controller.
+	  If you have a PXA16X or PXA9XX platform with SD Host Controller
 	  and a card slot, say Y or M here.
 
 	  If unsure, say N.
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index d4bf6d3..633cc77 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -28,6 +28,7 @@
 #include <linux/mmc/host.h>
 #include <linux/platform_data/pxa_sdhci.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 
@@ -72,7 +73,13 @@ static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
 			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
 		}
 
-		if (pdata && (pdata->flags & PXA_FLAG_ENABLE_CLOCK_GATING)) {
+		if (pdata && pdata->pxav1_controller) {
+			/* no clock gating */
+			tmp = readw(host->ioaddr + SD_FIFO_PARAM);
+			tmp |= DIS_PAD_SD_CLK_GATE;
+			writew(tmp, host->ioaddr + SD_FIFO_PARAM);
+		} else if (pdata && (pdata->flags
+				& PXA_FLAG_ENABLE_CLOCK_GATING)) {
 			tmp = readw(host->ioaddr + SD_FIFO_PARAM);
 			tmp &= ~CLK_GATE_SETTING_BITS;
 			writew(tmp, host->ioaddr + SD_FIFO_PARAM);
@@ -115,6 +122,20 @@ static u32 pxav2_get_max_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk);
 }
 
+/*
+ * we cannot talk to controller for 8 bus cycles according to sdio spec
+ * at lowest speed this is 100,000 HZ per cycle or 800,000 cycles
+ * which is quite a LONG TIME on a fast cpu -- so delay if needed
+ */
+static void platform_specific_completion(struct sdhci_host *host)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+
+	if (host->clock < 3200000 && pdata && pdata->delay_in_ms)
+		mdelay(pdata->delay_in_ms);
+}
+
 static struct sdhci_ops pxav2_sdhci_ops = {
 	.get_max_clock = pxav2_get_max_clock,
 	.platform_reset_exit = pxav2_set_private_registers,
@@ -167,6 +188,13 @@ static int __devinit sdhci_pxav2_probe(struct platform_device *pdev)
 		if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 			host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+		if (pdata->pxav1_controller) {
+			host->quirks |=	SDHCI_QUIRK_NO_BUSY_IRQ
+					| SDHCI_QUIRK_32BIT_DMA_SIZE;
+			pxav2_sdhci_ops.platform_specific_completion
+				= platform_specific_completion;
+		}
+
 		if (pdata->quirks)
 			host->quirks |= pdata->quirks;
 		if (pdata->host_caps)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6d8eea3..c6b52b8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -983,6 +983,9 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
+	if (host->ops->platform_specific_completion)
+		host->ops->platform_specific_completion(host);
+
 	mod_timer(&host->timer, jiffies + 10 * HZ);
 
 	host->cmd = cmd;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a5b654..4ba3244 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -274,6 +274,7 @@ struct sdhci_ops {
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
+	void	(*platform_specific_completion)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
index 51ad099..99bf54d 100644
--- a/include/linux/platform_data/pxa_sdhci.h
+++ b/include/linux/platform_data/pxa_sdhci.h
@@ -51,6 +51,8 @@ struct sdhci_pxa_platdata {
 	unsigned int	host_caps;
 	unsigned int	quirks;
 	unsigned int	pm_caps;
+	bool		pxav1_controller;  /* set if pxa168 */
+	unsigned int	delay_in_ms;
 };
 
 struct sdhci_pxa {
-- 
1.7.0.4

