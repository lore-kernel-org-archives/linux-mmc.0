From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mmc: sh_mmcif: Silence DMA slave ID compile warnings on 64-bit
Date: Tue, 11 Aug 2015 14:48:34 +0200
Message-ID: <1439297314-29118-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:40277 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964918AbbHKMsh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Aug 2015 08:48:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On arm64:

    drivers/mmc/host/sh_mmcif.c: In function 'sh_mmcif_request_dma_one':
    drivers/mmc/host/sh_mmcif.c:417:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
	(void *)pdata->slave_id_tx :
	^
    drivers/mmc/host/sh_mmcif.c:418:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
	(void *)pdata->slave_id_rx;
	^

Add an intermediate cast to "uintptr_t" to kill the compile warning.

While we're at it, replace "void *slave_data" by "unsigned int slave_id"
to avoid having to cast in two places, and because it's a DMA slave ID,
not a platform data pointer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/sh_mmcif.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5a1fdd405b1af14f..51ac09b8a5770df2 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -403,7 +403,7 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 {
 	struct dma_slave_config cfg = { 0, };
 	struct dma_chan *chan;
-	void *slave_data = NULL;
+	unsigned int slave_id = 0;
 	struct resource *res;
 	struct device *dev = sh_mmcif_host_to_dev(host);
 	dma_cap_mask_t mask;
@@ -413,12 +413,11 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 	dma_cap_set(DMA_SLAVE, mask);
 
 	if (pdata)
-		slave_data = direction == DMA_MEM_TO_DEV ?
-			(void *)pdata->slave_id_tx :
-			(void *)pdata->slave_id_rx;
+		slave_id = direction == DMA_MEM_TO_DEV ?
+			pdata->slave_id_tx : pdata->slave_id_rx;
 
 	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
-				slave_data, dev,
+				(void *)(uintptr_t)slave_id, dev,
 				direction == DMA_MEM_TO_DEV ? "tx" : "rx");
 
 	dev_dbg(dev, "%s: %s: got channel %p\n", __func__,
-- 
1.9.1

