From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 5/5] mmc: omap_hsmmc: convert critical failure reports to dev_err
Date: Tue, 6 Nov 2012 22:22:16 +0530
Message-ID: <1352220737-14071-6-git-send-email-svenkatr@ti.com>
References: <1352220737-14071-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50173 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598Ab2KFQwr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Nov 2012 11:52:47 -0500
In-Reply-To: <1352220737-14071-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

Fatal errors for the driver are not reported when just error
debug is enabled. Convert selected dev_dbg to dev_err for
accurate error reporting.

Reported-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d16ef0f..830c59b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -313,7 +313,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 	reg = regulator_get(host->dev, "vmmc");
 	if (IS_ERR(reg)) {
-		dev_dbg(host->dev, "vmmc regulator missing\n");
+		dev_err(host->dev, "vmmc regulator missing\n");
 		return PTR_ERR(reg);
 	} else {
 		mmc_slot(host).set_power = omap_hsmmc_set_power;
@@ -1136,7 +1136,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 
 	return 0;
 err:
-	dev_dbg(mmc_dev(host->mmc), "Unable to switch operating voltage\n");
+	dev_err(mmc_dev(host->mmc), "Unable to switch operating voltage\n");
 	return ret;
 }
 
@@ -1395,7 +1395,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 	if (host->use_dma) {
 		ret = omap_hsmmc_start_dma_transfer(host, req);
 		if (ret != 0) {
-			dev_dbg(mmc_dev(host->mmc), "MMC start dma failure\n");
+			dev_err(mmc_dev(host->mmc), "MMC start dma failure\n");
 			return ret;
 		}
 	}
@@ -1930,13 +1930,13 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
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
@@ -1959,7 +1959,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   mmc_hostname(mmc), host);
 		if (ret) {
-			dev_dbg(mmc_dev(host->mmc),
+			dev_err(mmc_dev(host->mmc),
 				"Unable to grab MMC CD IRQ\n");
 			goto err_irq_cd;
 		}
-- 
1.8.0

