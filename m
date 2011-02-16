From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] msm_sdcc: remove needless cache flush after dma_unmap_sg()
Date: Wed, 16 Feb 2011 23:28:53 +0100
Message-ID: <1297895333-5551-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:54798 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752211Ab1BPW3N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Feb 2011 17:29:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sahitya Tummala <stummala@codeaurora.org>, San Mehat <san@google.com>, Linus Walleij <linus.walleij@linaro.org>

dma_unmap_sg() already flushes the cache, I don't get what this
code is doing here.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/msm_sdcc.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 153ab97..67b0881 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -266,14 +266,6 @@ msmsdcc_dma_complete_tlet(unsigned long data)
 	dma_unmap_sg(mmc_dev(host->mmc), host->dma.sg, host->dma.num_ents,
 		     host->dma.dir);
 
-	if (host->curr.user_pages) {
-		struct scatterlist *sg = host->dma.sg;
-		int i;
-
-		for (i = 0; i < host->dma.num_ents; i++)
-			flush_dcache_page(sg_page(sg++));
-	}
-
 	host->dma.sg = NULL;
 	host->dma.busy = 0;
 
-- 
1.7.4

