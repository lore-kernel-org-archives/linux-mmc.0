From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 3/3] mmc: mxs-mmc: add broken-cd property
Date: Wed, 10 Apr 2013 11:13:45 +0200
Message-ID: <1365585225-11360-4-git-send-email-mkl@pengutronix.de>
References: <1365585225-11360-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59340 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936046Ab3DJJNx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Apr 2013 05:13:53 -0400
In-Reply-To: <1365585225-11360-1-git-send-email-mkl@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kernel@pengutronix.de, cjb@laptop.org, Hector Palacios <hector.palacios@digi.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Hector Palacios <hector.palacios@digi.com>

According to bindings documentation for mmc, the property 'broken-cd'
can be used to indicate card-detection is not available and polling
must be used instead. This patch retrieves this property
and sets a custom flag. On the get_cd() hook, it returns 1 if
the flag is set, to always assume the card is present.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/mmc/host/mxs-mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index c231881..146a53b 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -73,6 +73,7 @@ struct mxs_mmc_host {
 	int				wp_gpio;
 	bool				wp_inverted;
 	bool				cd_inverted;
+	bool				broken_cd;
 	bool				non_removable;
 };
 
@@ -97,7 +98,7 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 	struct mxs_mmc_host *host = mmc_priv(mmc);
 	struct mxs_ssp *ssp = &host->ssp;
 
-	return host->non_removable ||
+	return host->non_removable || host->broken_cd ||
 		!(readl(ssp->base + HW_SSP_STATUS(ssp)) &
 		  BM_SSP_STATUS_CARD_DETECT) ^ host->cd_inverted;
 }
@@ -689,6 +690,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 	else if (bus_width == 8)
 		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+	host->broken_cd = of_property_read_bool(np, "broken-cd");
 	host->non_removable = of_property_read_bool(np, "non-removable");
 	if (host->non_removable)
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
-- 
1.8.2.rc2

