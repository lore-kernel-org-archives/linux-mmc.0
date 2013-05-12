From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] mmc: jz4740: Use clk_prepare_enable/clk_disable_unprepare
Date: Sun, 12 May 2013 20:12:38 +0200
Message-ID: <1368382358-4433-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-237.synserver.de ([212.40.185.237]:1042 "EHLO
	smtp-out-236.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750808Ab3ELSQs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 12 May 2013 14:16:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

In preparation to switching the jz4740 clk driver to the common clk framework
update the clk enable/disable calls to clk_prepare_enable/clk_disable_unprepare.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/mmc/host/jz4740_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 2391c6b..2bc147f 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -626,7 +626,7 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			gpio_set_value(host->pdata->gpio_power,
 					!host->pdata->power_active_low);
 		host->cmdat |= JZ_MMC_CMDAT_INIT;
-		clk_enable(host->clk);
+		clk_prepare_enable(host->clk);
 		break;
 	case MMC_POWER_ON:
 		break;
@@ -634,7 +634,7 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (gpio_is_valid(host->pdata->gpio_power))
 			gpio_set_value(host->pdata->gpio_power,
 					host->pdata->power_active_low);
-		clk_disable(host->clk);
+		clk_disable_unprepare(host->clk);
 		break;
 	}
 
-- 
1.8.2.1

