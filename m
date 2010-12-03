From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 3/3 ] mmc: add support for h/w clock gating of sd controller
Date: Fri, 3 Dec 2010 11:29:35 -0800
Message-ID: <4840F7B2-1DB1-4047-A5F4-F490B712E38D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:60082 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752659Ab0LCTdX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Dec 2010 14:33:23 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Linus Walleij <linus.Walleij@stericsson.com>

code is based on sdhci-pxa in mmc-next on Dec 2, 2010.

if cpu_is_mmp2 enable mmc caps MMC_CAP_CLOCK_GATING_HW

code will need changing based on the work of the ongoing
work on sdhci-pxa but since that code is NOT in mmc-next
better to have something that can work.

code tested on marvell linux

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 5a61208..e2cc851 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <plat/sdhci.h>
+#include <mach/cputype.h>
 #include "sdhci.h"
 
 #define DRIVER_NAME	"sdhci-pxa"
@@ -46,10 +47,27 @@ struct sdhci_pxa {
  * SDHCI core callbacks                                                      *
  *                                                                           *
 \*****************************************************************************/
+#ifdef CONFIG_MMC_CLKGATE
+static void hardware_clk_gating (struct sdhci_host *host)
+{
+	unsigned short tmp;
+	int enable;
+
+	enable = host->mmc->clk_gated;
+	tmp = readw(host->ioaddr + SD_FIFO_PARAM);
+
+	if (enable)
+		tmp &= ~DIS_PAD_SD_CLK_GATE;
+	else
+		tmp |= DIS_PAD_SD_CLK_GATE;
+
+	writew(tmp, host->ioaddr + SD_FIFO_PARAM);
+}
+#endif
+
 static void set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pxa *pxa = sdhci_priv(host);
-	u32 tmp = 0;
 
 	if (clock == 0) {
 		if (pxa->clk_enable) {
@@ -58,11 +76,6 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
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
@@ -71,6 +84,9 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
 
 static struct sdhci_ops sdhci_pxa_ops = {
 	.set_clock = set_clock,
+#ifdef CONFIG_MMC_CLKGATE
+	.platform_hw_clk_gate =  hardware_clk_gating,
+#endif
 };
 
 /*****************************************************************************\
@@ -145,6 +161,11 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+#ifdef CONFIG_MMC_CLKGATE
+	if (cpu_is_mmp2())
+		host->mmc->caps |= MMC_CAP_CLOCK_GATING_HW;
+#endif
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
-- 
1.6.0.4

