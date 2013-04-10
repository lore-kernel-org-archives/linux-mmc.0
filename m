From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 1/3] mmc: mxs-mmc: add cd-inverted property
Date: Wed, 10 Apr 2013 11:13:43 +0200
Message-ID: <1365585225-11360-2-git-send-email-mkl@pengutronix.de>
References: <1365585225-11360-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59346 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936027Ab3DJJOA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Apr 2013 05:14:00 -0400
In-Reply-To: <1365585225-11360-1-git-send-email-mkl@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kernel@pengutronix.de, cjb@laptop.org, Marc Kleine-Budde <mkl@pengutronix.de>

The card-detect GPIO is inverted on some boards. Handle such case.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/mmc/host/mxs-mmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 4efe302..0cdf1f6 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -72,6 +72,7 @@ struct mxs_mmc_host {
 	int				sdio_irq_en;
 	int				wp_gpio;
 	bool				wp_inverted;
+	bool				cd_inverted;
 };
 
 static int mxs_mmc_get_ro(struct mmc_host *mmc)
@@ -96,7 +97,7 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 	struct mxs_ssp *ssp = &host->ssp;
 
 	return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
-		 BM_SSP_STATUS_CARD_DETECT);
+		 BM_SSP_STATUS_CARD_DETECT)) ^ host->cd_inverted;
 }
 
 static void mxs_mmc_reset(struct mxs_mmc_host *host)
@@ -691,6 +692,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	if (flags & OF_GPIO_ACTIVE_LOW)
 		host->wp_inverted = 1;
 
+	host->cd_inverted = of_property_read_bool(np, "cd-inverted");
+
 	mmc->f_min = 400000;
 	mmc->f_max = 288000000;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-- 
1.8.2.rc2

