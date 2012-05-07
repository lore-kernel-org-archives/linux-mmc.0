From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 01/10] mmc: mxs-mmc: use global stmp_device functionality
Date: Mon,  7 May 2012 22:43:03 +0800
Message-ID: <1336401793-13753-2-git-send-email-shawn.guo@linaro.org>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46809 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab2EGOnK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 10:43:10 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1335513dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 07 May 2012 07:43:10 -0700 (PDT)
In-Reply-To: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>

Use global stmp_device functionality to reduce mach-dependency.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxs-mmc.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index bb03ddd..2ea5361 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -40,9 +40,9 @@
 #include <linux/module.h>
 #include <linux/fsl/mxs-dma.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/stmp_device.h>
 
 #include <mach/mxs.h>
-#include <mach/common.h>
 #include <mach/mmc.h>
 
 #define DRIVER_NAME	"mxs-mmc"
@@ -191,7 +191,7 @@ static void mxs_mmc_reset(struct mxs_mmc_host *host)
 {
 	u32 ctrl0, ctrl1;
 
-	mxs_reset_block(host->base);
+	stmp_reset_block(host->base);
 
 	ctrl0 = BM_SSP_CTRL0_IGNORE_CRC;
 	ctrl1 = BF_SSP(0x3, CTRL1_SSP_MODE) |
@@ -279,7 +279,7 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, void *dev_id)
 
 	stat = readl(host->base + HW_SSP_CTRL1);
 	writel(stat & MXS_MMC_IRQ_BITS,
-	       host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);
+	       host->base + HW_SSP_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	if ((stat & BM_SSP_CTRL1_SDIO_IRQ) && (stat & BM_SSP_CTRL1_SDIO_IRQ_EN))
 		mmc_signal_sdio_irq(host->mmc);
@@ -637,18 +637,18 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 	if (enable) {
 		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
-		       host->base + HW_SSP_CTRL0 + MXS_SET_ADDR);
+		       host->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 		writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
-		       host->base + HW_SSP_CTRL1 + MXS_SET_ADDR);
+		       host->base + HW_SSP_CTRL1 + STMP_OFFSET_REG_SET);
 
 		if (readl(host->base + HW_SSP_STATUS) & BM_SSP_STATUS_SDIO_IRQ)
 			mmc_signal_sdio_irq(host->mmc);
 
 	} else {
 		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
-		       host->base + HW_SSP_CTRL0 + MXS_CLR_ADDR);
+		       host->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
 		writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
-		       host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);
+		       host->base + HW_SSP_CTRL1 + STMP_OFFSET_REG_CLR);
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
-- 
1.7.5.4

