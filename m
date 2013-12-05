From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/6] mmc: mxs: use standard flag for broken card detection
Date: Thu,  5 Dec 2013 14:34:48 +0100
Message-ID: <1386250491-4708-4-git-send-email-s.hauer@pengutronix.de>
References: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49797 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218Ab3LENf0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 08:35:26 -0500
In-Reply-To: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

Use the standard MMC_CAP_NEEDS_POLL flag rather than a custom broken_cd
flag. The original code used to just return true in the card detection
function for broken card detection. The MMC_CAP_NEEDS_POLL works different,
but was introduced for the same purpose, so assume the code works correct
now.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/mxs-mmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 374fca7..02210ce 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -72,7 +72,6 @@ struct mxs_mmc_host {
 	int				wp_gpio;
 	bool				wp_inverted;
 	bool				cd_inverted;
-	bool				broken_cd;
 };
 
 static int mxs_mmc_get_ro(struct mmc_host *mmc)
@@ -96,8 +95,7 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
 	struct mxs_mmc_host *host = mmc_priv(mmc);
 	struct mxs_ssp *ssp = &host->ssp;
 
-	return host->broken_cd ||
-		!(readl(ssp->base + HW_SSP_STATUS(ssp)) &
+	return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
 		  BM_SSP_STATUS_CARD_DETECT) ^ host->cd_inverted;
 }
 
@@ -652,7 +650,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 	else if (bus_width == 8)
 		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
-	host->broken_cd = of_property_read_bool(np, "broken-cd");
+	if (of_property_read_bool(np, "broken-cd"))
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
 	if (of_property_read_bool(np, "non-removable"))
 		mmc->caps |= MMC_CAP_NONREMOVABLE;
 	host->wp_gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
-- 
1.8.4.3

