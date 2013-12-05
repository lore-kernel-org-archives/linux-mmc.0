From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/6] mmc: mxs: use standard flag for cd inverted
Date: Thu,  5 Dec 2013 14:34:49 +0100
Message-ID: <1386250491-4708-5-git-send-email-s.hauer@pengutronix.de>
References: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49765 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198Ab3LENey (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 08:34:54 -0500
In-Reply-To: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

We have a MMC_CAP2_CD_ACTIVE_HIGH flag, so use it rather than a custom
driver specific flag.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/mxs-mmc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 02210ce..3dd2f4c 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -71,7 +71,6 @@ struct mxs_mmc_host {
 	int				sdio_irq_en;
 	int				wp_gpio;
 	bool				wp_inverted;
-	bool				cd_inverted;
 };
 
 static int mxs_mmc_get_ro(struct mmc_host *mmc)
@@ -94,9 +93,15 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 {
 	struct mxs_mmc_host *host = mmc_priv(mmc);
 	struct mxs_ssp *ssp = &host->ssp;
+	int present;
 
-	return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
-		  BM_SSP_STATUS_CARD_DETECT) ^ host->cd_inverted;
+	present = !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
+			BM_SSP_STATUS_CARD_DETECT);
+
+	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
+		present = !present;
+
+	return present;
 }
 
 static int mxs_mmc_reset(struct mxs_mmc_host *host)
@@ -658,7 +663,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	if (flags & OF_GPIO_ACTIVE_LOW)
 		host->wp_inverted = 1;
 
-	host->cd_inverted = of_property_read_bool(np, "cd-inverted");
+	if (of_property_read_bool(np, "cd-inverted"))
+		mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
 
 	mmc->f_min = 400000;
 	mmc->f_max = 288000000;
-- 
1.8.4.3

