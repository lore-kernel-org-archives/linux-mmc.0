From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mmc: atmel-mci: allow DMA transfers for AVR32
Date: Mon, 27 Jul 2015 14:53:30 +0300
Message-ID: <1437998010-12036-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24044 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbbG0Lxd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Jul 2015 07:53:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The commit ecb89f2f5f3e (mmc: atmel-mci: remove compat for non DT board when
requesting dma chan) removes compat transfer which breaks DMA
support for ATNGW100. This patch returns back that functionality.

Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/atmel-mci.c | 49 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 9a39e0b..70865be 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2277,12 +2277,55 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 	mmc_free_host(slot->mmc);
 }
 
-static int atmci_configure_dma(struct atmel_mci *host)
+static bool atmci_filter(struct dma_chan *chan, void *pdata)
 {
+	struct mci_platform_data *sl_pdata = pdata;
+	struct mci_dma_data *sl;
+
+	if (!sl_pdata)
+		return false;
+
+	sl = sl_pdata->dma_slave;
+	if (sl && find_slave_dev(sl) == chan->device->dev) {
+		chan->private = slave_data_ptr(sl);
+		return true;
+	} else {
+		return false;
+	}
+}
+
+static int atmci_dma_request_channel(struct atmel_mci *host)
+{
+	struct mci_platform_data	*pdata;
+	dma_cap_mask_t mask;
+
 	host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev,
 							"rxtx");
-	if (IS_ERR(host->dma.chan))
-		return PTR_ERR(host->dma.chan);
+	if (!IS_ERR(host->dma.chan))
+		return 0;
+
+	if (PTR_ERR(host->dma.chan) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	pdata = host->pdev->dev.platform_data;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	host->dma.chan = dma_request_channel(mask, atmci_filter, pdata);
+	if (!host->dma.chan)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int atmci_configure_dma(struct atmel_mci *host)
+{
+	int ret;
+
+	ret = atmci_dma_request_channel(host);
+	if (ret)
+		return ret;
 
 	dev_info(&host->pdev->dev, "using %s for DMA transfers\n",
 		 dma_chan_name(host->dma.chan));
-- 
2.4.6

