From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] mmc: mxs-mmc: add cd-inverted property
Date: Mon, 25 Mar 2013 16:02:30 +0100
Message-ID: <1364223751-28253-2-git-send-email-mkl@pengutronix.de>
References: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51530 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101Ab3CYPCl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Mar 2013 11:02:41 -0400
In-Reply-To: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Marc Kleine-Budde <mkl@pengutronix.de>

The card-detect GPIO is inverted on some boards. Handle such case.

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

