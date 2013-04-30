From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 05/13] mmc: omap_hsmmc: remove use_reg
Date: Tue, 30 Apr 2013 19:33:45 +0530
Message-ID: <1367330633-5941-6-git-send-email-balajitk@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58086 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760713Ab3D3OEG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Apr 2013 10:04:06 -0400
In-Reply-To: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>

Since regulator_put can handle NULL / IS_ERR(regulator)
use_reg can be removed, so that regulator_put in omap_hsmmc_reg_put
can be reused for vmmc_aux regulator error scenario.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5fd78b2..6616621 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -178,7 +178,6 @@ struct omap_hsmmc_host {
 	int			context_loss;
 	int			protect_card;
 	int			reqs_blocked;
-	int			use_reg;
 	int			req_in_progress;
 	struct omap_hsmmc_next	next_data;
 
@@ -1961,7 +1960,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		ret = omap_hsmmc_reg_get(host);
 		if (ret)
 			goto err_irq_cd;
-		host->use_reg = 1;
 	}
 
 	mmc->ocr_avail = mmc_slot(host).ocr_mask;
@@ -2015,8 +2013,7 @@ err_slot_name:
 	mmc_remove_host(mmc);
 	free_irq(mmc_slot(host).card_detect_irq, host);
 err_irq_cd:
-	if (host->use_reg)
-		omap_hsmmc_reg_put(host);
+	omap_hsmmc_reg_put(host);
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
 err_irq_cd_init:
@@ -2053,8 +2050,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(host->dev);
 	mmc_remove_host(host->mmc);
-	if (host->use_reg)
-		omap_hsmmc_reg_put(host);
+	omap_hsmmc_reg_put(host);
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
 	free_irq(host->irq, host);
-- 
1.7.5.4

