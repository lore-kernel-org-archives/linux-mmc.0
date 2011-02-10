From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/11] sh_mmcif: use dmaengine helpers, drop submit check
Date: Thu, 10 Feb 2011 16:10:00 +0100
Message-ID: <1297350600-2613-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53476 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756531Ab1BJPtY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 10:49:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Paul Mundt <lethal@linux-sh.org>, Linus Walleij <linus.walleij@linaro.org>

Use the new dmaengine helper functions, and drop the error check
on the returned cookier from the dmaengine - we recently
established that this is really not allowed to fail.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index e247031..aea8626 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -224,14 +224,9 @@ static void sh_mmcif_start_dma_rx(struct sh_mmcif_host *host)
 	if (desc) {
 		desc->callback = mmcif_dma_complete;
 		desc->callback_param = host;
-		cookie = desc->tx_submit(desc);
-		if (cookie < 0) {
-			desc = NULL;
-			ret = cookie;
-		} else {
-			sh_mmcif_bitset(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAREN);
-			chan->device->device_issue_pending(chan);
-		}
+		cookie = dmaengine_submit(desc);
+		sh_mmcif_bitset(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAREN);
+		dma_async_issue_pending(chan);
 	}
 	dev_dbg(&host->pd->dev, "%s(): mapped %d -> %d, cookie %d\n",
 		__func__, host->data->sg_len, ret, cookie);
@@ -277,14 +272,9 @@ static void sh_mmcif_start_dma_tx(struct sh_mmcif_host *host)
 	if (desc) {
 		desc->callback = mmcif_dma_complete;
 		desc->callback_param = host;
-		cookie = desc->tx_submit(desc);
-		if (cookie < 0) {
-			desc = NULL;
-			ret = cookie;
-		} else {
-			sh_mmcif_bitset(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAWEN);
-			chan->device->device_issue_pending(chan);
-		}
+		cookie = dmaengine_submit(desc);
+		sh_mmcif_bitset(host, MMCIF_CE_BUF_ACC, BUF_ACC_DMAWEN);
+		dma_async_issue_pending(chan);
 	}
 	dev_dbg(&host->pd->dev, "%s(): mapped %d -> %d, cookie %d\n",
 		__func__, host->data->sg_len, ret, cookie);
-- 
1.7.4

