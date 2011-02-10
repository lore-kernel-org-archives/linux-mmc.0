From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 03/11] atmel-mci: use dmaengine helper functions
Date: Thu, 10 Feb 2011 16:08:26 +0100
Message-ID: <1297350506-1522-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756424Ab1BJPtP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:15 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>

Use the new dmaengine helpers to make the code more readable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/atmel-mci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index df5a135..80bc9a5 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -589,7 +589,7 @@ static void atmci_stop_dma(struct atmel_mci *host)
 	struct dma_chan *chan = host->data_chan;
 
 	if (chan) {
-	  chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+		dmaengine_terminate_all(chan);
 		atmci_dma_cleanup(host);
 	} else {
 		/* Data transfer was stopped by the interrupt handler */
@@ -710,8 +710,8 @@ static void atmci_submit_data(struct atmel_mci *host)
 	struct dma_async_tx_descriptor	*desc = host->dma.data_desc;
 
 	if (chan) {
-		desc->tx_submit(desc);
-		chan->device->device_issue_pending(chan);
+		dmaengine_submit(desc);
+		dma_async_issue_pending(chan);
 	}
 }
 
-- 
1.7.4

