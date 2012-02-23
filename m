From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 4/7] mmc: omap_hsmmc: If probe fails, give our error messages
Date: Thu, 23 Feb 2012 17:10:44 +0530
Message-ID: <1329997247-27342-5-git-send-email-rnayak@ti.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35342 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab2BWLlG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Feb 2012 06:41:06 -0500
In-Reply-To: <1329997247-27342-1-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Giving our debug messages even in case of probe failure seems
not very useful. Make them error messages instead.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: <linux-mmc@vger.kernel.org>
---
 drivers/mmc/host/omap_hsmmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 21b8afa..653ffee 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2008,13 +2008,13 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	ret = request_irq(host->irq, omap_hsmmc_irq, 0,
 			mmc_hostname(mmc), host);
 	if (ret) {
-		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
+		dev_err(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n");
 		goto err_irq;
 	}
 
 	if (pdata->init != NULL) {
 		if (pdata->init(&pdev->dev) != 0) {
-			dev_dbg(mmc_dev(host->mmc),
+			dev_err(mmc_dev(host->mmc),
 				"Unable to configure MMC IRQs\n");
 			goto err_irq_cd_init;
 		}
@@ -2037,7 +2037,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 					   mmc_hostname(mmc), host);
 		if (ret) {
-			dev_dbg(mmc_dev(host->mmc),
+			dev_err(mmc_dev(host->mmc),
 				"Unable to grab MMC CD IRQ\n");
 			goto err_irq_cd;
 		}
-- 
1.7.1

