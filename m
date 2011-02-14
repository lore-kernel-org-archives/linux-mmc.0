From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 2/5] sdhci: sdhci-pxa.c ensure clocks are enabled on all SD
 controllers
Date: Sun, 13 Feb 2011 22:59:28 -0800
Message-ID: <99D274AD-18F8-4C30-836B-189C143FF21A@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39968 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751373Ab1BNHDh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:03:37 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


Do not rely on u-boot to do the right thing.  It does not.
Do not disable the system clock to the device as this may hang
the system if the register is touched

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 4713238..8c60d5c 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -35,7 +35,7 @@ struct sdhci_pxa {
 	struct clk			*clk;
 	struct resource			*res;
 
-	u8 clk_enable;
+	u8				clk_enable;
 };
 
 /*****************************************************************************\
@@ -43,25 +43,17 @@ struct sdhci_pxa {
  * SDHCI core callbacks                                                      *
  *                                                                           *
 \*****************************************************************************/
-static void set_clock(struct sdhci_host *host, unsigned int clock)
+static void enable_clock(struct sdhci_host *host)
 {
 	struct sdhci_pxa *pxa = sdhci_priv(host);
 
-	if (clock == 0) {
-		if (pxa->clk_enable) {
-			clk_disable(pxa->clk);
-			pxa->clk_enable = 0;
-		}
-	} else {
-		if (0 == pxa->clk_enable) {
-			clk_enable(pxa->clk);
-			pxa->clk_enable = 1;
-		}
+	if (pxa->clk_enable == 0) {
+		clk_enable(pxa->clk);
+		pxa->clk_enable = 1;
 	}
 }
 
 static struct sdhci_ops sdhci_pxa_ops = {
-	.set_clock = set_clock,
 };
 
 /*****************************************************************************\
@@ -136,6 +128,9 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+	/* do not rely on u-boot to enable the clocks */
+	enable_clock(host);
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
@@ -181,10 +176,6 @@ static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
 		if (pxa->res)
 			release_mem_region(pxa->res->start,
 					   resource_size(pxa->res));
-		if (pxa->clk_enable) {
-			clk_disable(pxa->clk);
-			pxa->clk_enable = 0;
-		}
 		clk_put(pxa->clk);
 
 		sdhci_free_host(host);
-- 
1.7.0.4


