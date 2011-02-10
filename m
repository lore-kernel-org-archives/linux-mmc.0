From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/11] tmio_mmc: use dmaengine helpers, drop submit check
Date: Thu, 10 Feb 2011 16:11:07 +0100
Message-ID: <1297350667-3652-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756531Ab1BJPtW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Linus Walleij <linus.walleij@linaro.org>

Use the new dmaengine helper functions, and drop the error check
on the returned cookier from the dmaengine - we recently
established that this is really not allowed to fail.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/tmio_mmc.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 708b3a1..f729aea 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -832,13 +832,8 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 	if (desc) {
 		desc->callback = tmio_dma_complete;
 		desc->callback_param = host;
-		cookie = desc->tx_submit(desc);
-		if (cookie < 0) {
-			desc = NULL;
-			ret = cookie;
-		} else {
-			chan->device->device_issue_pending(chan);
-		}
+		cookie = dmaengine_submit(desc);
+		dma_async_issue_pending(chan);
 	}
 	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
 		__func__, host->sg_len, ret, cookie, host->mrq);
@@ -911,11 +906,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 	if (desc) {
 		desc->callback = tmio_dma_complete;
 		desc->callback_param = host;
-		cookie = desc->tx_submit(desc);
-		if (cookie < 0) {
-			desc = NULL;
-			ret = cookie;
-		}
+		cookie = dmaengine_submit(desc);
 	}
 	dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
 		__func__, host->sg_len, ret, cookie, host->mrq);
@@ -959,7 +950,7 @@ static void tmio_issue_tasklet_fn(unsigned long priv)
 	struct tmio_mmc_host *host = (struct tmio_mmc_host *)priv;
 	struct dma_chan *chan = host->chan_tx;
 
-	chan->device->device_issue_pending(chan);
+	dma_async_issue_pending(chan);
 }
 
 static void tmio_tasklet_fn(unsigned long arg)
-- 
1.7.4

