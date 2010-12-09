From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V4  4/4] mmc: add support for H/W clock gating of SD
 controller
Date: Wed, 8 Dec 2010 16:18:32 -0800
Message-ID: <CA3BCC53-F6AC-4F13-A2AD-C2E1F533AFB5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34153 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755307Ab0LIAUw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Dec 2010 19:20:52 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>

This patch is different from the previous patch due to changes in the latest mmp2 silicon.

reverified under Marvell MMP2 linux on brownstone using SDIO/SD, MMC/Plus and eMMC.
Clock gating verified using scope for external cards SD, MMC/Plus and SDIO.
debug log used to verify eMMC

>From f7b98789396dd59d4abf5f34e4ccca138944e294 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Wed, 8 Dec 2010 15:23:23 -0800
Subject: [PATCH] sdhci: add support for H/W clock gating of SD controller

MMP2 controller allows clock gating for SD/eMMC/SDIO cards
by extending the definition for SDCTRL_2_ASYNC_INT_EN in the
host control register 2. The SD Host Controller spec
defines this bit (14) for use with SDIO.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   42 +++++++++++++++++++++++++++++++++---------
 1 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 5a61208..125cda8 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -25,13 +25,11 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <plat/sdhci.h>
+#include <mach/cputype.h>
 #include "sdhci.h"
 
 #define DRIVER_NAME	"sdhci-pxa"
 
-#define SD_FIFO_PARAM		0x104
-#define DIS_PAD_SD_CLK_GATE	0x400
-
 struct sdhci_pxa {
 	struct sdhci_host		*host;
 	struct sdhci_pxa_platdata	*pdata;
@@ -46,10 +44,33 @@ struct sdhci_pxa {
  * SDHCI core callbacks                                                      *
  *                                                                           *
 \*****************************************************************************/
+#ifdef CONFIG_MMC_CLKGATE
+static void hardware_clk_gating(struct sdhci_host *host)
+{
+	unsigned short tmp;
+	int enable;
+
+	/*
+	 * MMP2 controller allows clock gating for SD/eMMC/SDIO cards
+	 * by extending the definition for SDCTRL_2_ASYNC_INT_EN in the
+	 * host control register 2. The SD Host Controller spec
+	 * defines this bit for use with SDIO.
+	 */
+	enable = host->mmc->clk_gated;
+	tmp = readw(host->ioaddr + HOST_CTRL_2);
+
+	if (enable)
+		tmp |= SDCTRL_2_ASYNC_INT_EN;
+	else
+		tmp &= ~SDCTRL_2_ASYNC_INT_EN;
+
+	writew(tmp, host->ioaddr + HOST_CTRL_2);
+}
+#endif
+
 static void set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pxa *pxa = sdhci_priv(host);
-	u32 tmp = 0;
 
 	if (clock == 0) {
 		if (pxa->clk_enable) {
@@ -58,11 +79,6 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
 		}
 	} else {
 		if (0 == pxa->clk_enable) {
-			if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
-				tmp = readl(host->ioaddr + SD_FIFO_PARAM);
-				tmp |= DIS_PAD_SD_CLK_GATE;
-				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
-			}
 			clk_enable(pxa->clk);
 			pxa->clk_enable = 1;
 		}
@@ -71,6 +87,9 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
 
 static struct sdhci_ops sdhci_pxa_ops = {
 	.set_clock = set_clock,
+#ifdef CONFIG_MMC_CLKGATE
+	.platform_hw_clk_gate =  hardware_clk_gating,
+#endif
 };
 
 /*****************************************************************************\
@@ -145,6 +164,11 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+#ifdef CONFIG_MMC_CLKGATE
+	if (cpu_is_mmp2())
+		host->mmc->caps |= MMC_CAP_HW_CLOCK_GATING;
+#endif
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
-- 
1.6.0.4

