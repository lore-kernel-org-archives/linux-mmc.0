From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC] mmc: tmio: maximize power saving
Date: Fri, 27 May 2011 16:56:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105271654080.29270@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This patch uses runtime PM to allow the system to power down the MMC
controller, when the MMC closk is switched off.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index ad6347b..a36535e 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -771,33 +771,30 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	if (ios->clock)
-		tmio_mmc_set_clock(host, ios->clock);
-
-	/* Power sequence - OFF -> UP -> ON */
-	if (ios->power_mode == MMC_POWER_UP) {
-		if ((pdata->flags & TMIO_MMC_HAS_COLD_CD) && !pdata->power) {
+	/*
+	 * pdata->power == false only if COLD_CD is available, otherwise only
+	 * in short time intervals during probing or resuming
+	 */
+	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
+		if (!pdata->power) {
 			pm_runtime_get_sync(&host->pdev->dev);
 			pdata->power = true;
 		}
+		tmio_mmc_set_clock(host, ios->clock);
 		/* power up SD bus */
 		if (host->set_pwr)
 			host->set_pwr(host->pdev, 1);
-	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
-		/* power down SD bus */
-		if (ios->power_mode == MMC_POWER_OFF) {
-			if (host->set_pwr)
-				host->set_pwr(host->pdev, 0);
-			if ((pdata->flags & TMIO_MMC_HAS_COLD_CD) &&
-			    pdata->power) {
-				pdata->power = false;
-				pm_runtime_put(&host->pdev->dev);
-			}
-		}
-		tmio_mmc_clk_stop(host);
-	} else {
 		/* start bus clock */
 		tmio_mmc_clk_start(host);
+	} else if (ios->power_mode != MMC_POWER_UP) {
+		if (host->set_pwr)
+			host->set_pwr(host->pdev, 0);
+		if ((pdata->flags & TMIO_MMC_HAS_COLD_CD) &&
+		    pdata->power) {
+			pdata->power = false;
+			pm_runtime_put(&host->pdev->dev);
+		}
+		tmio_mmc_clk_stop(host);
 	}
 
 	switch (ios->bus_width) {
@@ -921,8 +918,10 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	tmio_mmc_request_dma(_host, pdata);
 
 	/* We have to keep the device powered for its card detection to work */
-	if (!(pdata->flags & TMIO_MMC_HAS_COLD_CD))
+	if (!(pdata->flags & TMIO_MMC_HAS_COLD_CD)) {
+		pdata->power = true;
 		pm_runtime_get_noresume(&pdev->dev);
+	}
 
 	mmc_add_host(mmc);
 
-- 
1.7.2.5

