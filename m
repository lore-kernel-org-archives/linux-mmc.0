From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 2/2] mmc: mxs-mmc: add non-removable property
Date: Fri,  5 Apr 2013 14:47:50 +0200
Message-ID: <1365166070-9370-3-git-send-email-mkl@pengutronix.de>
References: <1365166070-9370-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43054 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161586Ab3DEMr5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Apr 2013 08:47:57 -0400
In-Reply-To: <1365166070-9370-1-git-send-email-mkl@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kernel@pengutronix.de, cjb@laptop.org, aletes.xgr@gmail.com, Marc Kleine-Budde <mkl@pengutronix.de>

Some boards have non removable cards like eMMC. Handle such case.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
changes since v1:
- fix removeable typo

 drivers/mmc/host/mxs-mmc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 0cdf1f6..c231881 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -73,6 +73,7 @@ struct mxs_mmc_host {
 	int				wp_gpio;
 	bool				wp_inverted;
 	bool				cd_inverted;
+	bool				non_removable;
 };
 
 static int mxs_mmc_get_ro(struct mmc_host *mmc)
@@ -96,8 +97,9 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 	struct mxs_mmc_host *host = mmc_priv(mmc);
 	struct mxs_ssp *ssp = &host->ssp;
 
-	return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
-		 BM_SSP_STATUS_CARD_DETECT)) ^ host->cd_inverted;
+	return host->non_removable ||
+		!(readl(ssp->base + HW_SSP_STATUS(ssp)) &
+		  BM_SSP_STATUS_CARD_DETECT) ^ host->cd_inverted;
 }
 
 static void mxs_mmc_reset(struct mxs_mmc_host *host)
@@ -687,8 +689,10 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 	else if (bus_width == 8)
 		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+	host->non_removable = of_property_read_bool(np, "non-removable");
+	if (host->non_removable)
+		mmc->caps |= MMC_CAP_NONREMOVABLE;
 	host->wp_gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
-
 	if (flags & OF_GPIO_ACTIVE_LOW)
 		host->wp_inverted = 1;
 
-- 
1.8.2.rc2

