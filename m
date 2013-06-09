From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] mmc: jz4740: Use clk_prepare_enable/clk_disable_unprepare
Date: Sun,  9 Jun 2013 21:10:00 +0200
Message-ID: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-250.synserver.de ([212.40.185.250]:1062 "EHLO
	smtp-out-250.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab3FITGz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jun 2013 15:06:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Maarten ter Huurne <maarten@treewalker.org>, linux-mmc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

In preparation to switching the jz4740 clk driver to the common clk framework
update the clk enable/disable calls to clk_prepare_enable/clk_disable_unprepare.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/mmc/host/jz4740_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 1c47b34..c4f3872 100644
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

