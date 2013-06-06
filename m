From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 05/10] mmc: omap_hsmmc: remove use_reg
Date: Fri, 7 Jun 2013 00:44:14 +0530
Message-ID: <1370546059-24181-6-git-send-email-balajitk@ti.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41248 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab3FFTOw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jun 2013 15:14:52 -0400
In-Reply-To: <1370546059-24181-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org
Cc: Balaji T K <balajitk@ti.com>

Since regulator_put can handle NULL / IS_ERR(regulator)
use_reg can be removed, so that regulator_put in omap_hsmmc_reg_put
can be reused for vmmc_aux regulator error scenario.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 08f4ca7..533ced2 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -179,7 +179,6 @@ struct omap_hsmmc_host {
 	int			context_loss;
 	int			protect_card;
 	int			reqs_blocked;
-	int			use_reg;
 	int			req_in_progress;
 	struct omap_hsmmc_next	next_data;
 
@@ -1984,7 +1983,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		ret = omap_hsmmc_reg_get(host);
 		if (ret)
 			goto err_irq_cd;
-		host->use_reg = 1;
 	}
 
 	mmc->ocr_avail = mmc_slot(host).ocr_mask;
@@ -2038,8 +2036,7 @@ err_slot_name:
 	mmc_remove_host(mmc);
 	free_irq(mmc_slot(host).card_detect_irq, host);
 err_irq_cd:
-	if (host->use_reg)
-		omap_hsmmc_reg_put(host);
+	omap_hsmmc_reg_put(host);
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
 err_irq_cd_init:
@@ -2075,8 +2072,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 
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

