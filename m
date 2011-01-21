From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: delete clk gating code and FLAG since not correct
Date: Fri, 21 Jan 2011 11:22:04 -0800
Message-ID: <5817C3F1-F15D-4745-81A9-C667F389D7E2@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38821 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754788Ab1AUTYt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:24:49 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>

clock gating is using wrong registers for mmp2 SoC
sdhc-pxa.c is not generic for pxa family.

remove code -- future patch will add back support

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    1 -
 drivers/mmc/host/sdhci-pxa.c           |    9 ---------
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
index bae194a..bd6ac06 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -15,7 +15,6 @@
 
 /* pxa specific flag */
 /* Require clock free running */
-#define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
 
 #define PXA_FLAG_CARD_PERMANENT		(1<<1)
 /* Board design supports 8-bit data on SD/SDIO BUS */
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 5a61208..4713238 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -29,9 +29,6 @@
 
 #define DRIVER_NAME	"sdhci-pxa"
 
-#define SD_FIFO_PARAM		0x104
-#define DIS_PAD_SD_CLK_GATE	0x400
-
 struct sdhci_pxa {
 	struct sdhci_host		*host;
 	struct sdhci_pxa_platdata	*pdata;
@@ -49,7 +46,6 @@ struct sdhci_pxa {
 static void set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pxa *pxa = sdhci_priv(host);
-	u32 tmp = 0;
 
 	if (clock == 0) {
 		if (pxa->clk_enable) {
@@ -58,11 +54,6 @@ static void set_clock(struct sdhci_host *host, unsigned int clock)
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
-- 
1.7.0.4

