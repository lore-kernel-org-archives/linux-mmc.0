From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2] mmc: atmel-mci: use probe deferring if dma controller is not ready yet
Date: Wed, 19 Nov 2014 15:51:07 +0100
Message-ID: <1416408667-4666-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:45135 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644AbaKSOvL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 09:51:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Return probe defer if requesting a dma channel without a dma controller
probed. Using late_initcall is no more needing.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

patch based on
mmc: atmel-mci: remove compat for non DT board when requesting dma chan

v2 changes:
- use module_platform_driver
- remove warning message when asking for probe deferring

 drivers/mmc/host/atmel-mci.c | 61 ++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index ba38f94..72f6501 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2265,37 +2265,39 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 	mmc_free_host(slot->mmc);
 }
 
-static bool atmci_configure_dma(struct atmel_mci *host)
+static int atmci_configure_dma(struct atmel_mci *host)
 {
 	struct mci_platform_data	*pdata;
 	dma_cap_mask_t mask;
+	int ret = 0;
 
 	if (host == NULL)
-		return false;
+		return -EINVAL;
 
 	pdata = host->pdev->dev.platform_data;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	host->dma.chan = dma_request_slave_channel(&host->pdev->dev, "rxtx");
-	if (!host->dma.chan) {
-		dev_warn(&host->pdev->dev, "no DMA channel available\n");
-		return false;
-	} else {
-		dev_info(&host->pdev->dev,
-					"using %s for DMA transfers\n",
-					dma_chan_name(host->dma.chan));
-
-		host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
-		host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		host->dma_conf.src_maxburst = 1;
-		host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
-		host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		host->dma_conf.dst_maxburst = 1;
-		host->dma_conf.device_fc = false;
-		return true;
+	host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev, "rxtx");
+	if (IS_ERR(host->dma.chan)) {
+		ret = PTR_ERR(host->dma.chan);
+		host->dma.chan = NULL;
+		return ret;
 	}
+
+	dev_info(&host->pdev->dev,
+			"using %s for DMA transfers\n",
+			dma_chan_name(host->dma.chan));
+
+	host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
+	host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	host->dma_conf.src_maxburst = 1;
+	host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
+	host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	host->dma_conf.dst_maxburst = 1;
+	host->dma_conf.device_fc = false;
+	return ret;
 }
 
 /*
@@ -2411,7 +2413,10 @@ static int __init atmci_probe(struct platform_device *pdev)
 
 	/* Get MCI capabilities and set operations according to it */
 	atmci_get_cap(host);
-	if (atmci_configure_dma(host)) {
+	ret = atmci_configure_dma(host);
+	if (ret == -EPROBE_DEFER)
+		goto err_dma_probe_defer;
+	if (ret == 0) {
 		host->prepare_data = &atmci_prepare_data_dma;
 		host->submit_data = &atmci_submit_data_dma;
 		host->stop_transfer = &atmci_stop_transfer_dma;
@@ -2484,6 +2489,7 @@ err_init_slot:
 	del_timer_sync(&host->timer);
 	if (host->dma.chan)
 		dma_release_channel(host->dma.chan);
+err_dma_probe_defer:
 	free_irq(irq, host);
 	return ret;
 }
@@ -2518,25 +2524,14 @@ static int __exit atmci_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver atmci_driver = {
+	.probe		= atmci_probe,
 	.remove		= __exit_p(atmci_remove),
 	.driver		= {
 		.name		= "atmel_mci",
 		.of_match_table	= of_match_ptr(atmci_dt_ids),
 	},
 };
-
-static int __init atmci_init(void)
-{
-	return platform_driver_probe(&atmci_driver, atmci_probe);
-}
-
-static void __exit atmci_exit(void)
-{
-	platform_driver_unregister(&atmci_driver);
-}
-
-late_initcall(atmci_init); /* try to load after dma driver when built-in */
-module_exit(atmci_exit);
+module_platform_driver(atmci_driver);
 
 MODULE_DESCRIPTION("Atmel Multimedia Card Interface driver");
 MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
-- 
2.0.3

