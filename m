From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 3/6] mmc: omap_hsmmc: use devm_request_threaded_irq
Date: Fri, 9 May 2014 22:16:50 +0530
Message-ID: <1399654013-28262-4-git-send-email-balajitk@ti.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1399654013-28262-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

With devm_request_threaded_irq conversion free_irq can be removed
in clean up path

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ef7e48a..6179fe3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2043,9 +2043,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	/* Request IRQ for card detect */
 	if ((mmc_slot(host).card_detect_irq)) {
-		ret = request_threaded_irq(mmc_slot(host).card_detect_irq,
-					   NULL,
-					   omap_hsmmc_detect,
+		ret = devm_request_threaded_irq(&pdev->dev,
+						mmc_slot(host).card_detect_irq,
+						NULL, omap_hsmmc_detect,
 					   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   mmc_hostname(mmc), host);
 		if (ret) {
@@ -2088,7 +2088,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
-	free_irq(mmc_slot(host).card_detect_irq, host);
 err_irq_cd:
 	if (host->use_reg)
 		omap_hsmmc_reg_put(host);
@@ -2127,8 +2126,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 		omap_hsmmc_reg_put(host);
 	if (host->pdata->cleanup)
 		host->pdata->cleanup(&pdev->dev);
-	if (mmc_slot(host).card_detect_irq)
-		free_irq(mmc_slot(host).card_detect_irq, host);
 
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
-- 
1.7.5.4

