From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: Delete bounce buffer handling
Date: Wed, 20 Sep 2017 10:56:14 +0200
Message-ID: <20170920085614.22697-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:50614 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdITI4X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Sep 2017 04:56:23 -0400
Received: by mail-lf0-f51.google.com with SMTP id d4so2017160lfj.7
        for <linux-mmc@vger.kernel.org>; Wed, 20 Sep 2017 01:56:22 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Pierre Ossman <pierre@ossman.eu>, Juha Yrjola <juha.yrjola@solidboot.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>

In may, Steven sent a patch deleting the bounce buffer handling
and the CONFIG_MMC_BLOCK_BOUNCE option.

I chose the less invasive path of making it a runtime config
option, and we merged that successfully for kernel v4.12.

The code is however just standing in the way and taking up
space for seemingly no gain on any systems in wide use today.

Pierre says the code was there to improve speed on TI SDHCI
controllers on certain HP laptops and possibly some Ricoh
controllers as well. Early SDHCI controllers lacked the
scatter-gather feature, which made software bounce buffers
a significant speed boost.

We are clearly talking about the list of SDHCI PCI-based
MMC/SD card readers found in the pci_ids[] list in
drivers/mmc/host/sdhci-pci-core.c.

The TI SDHCI derivative is not supported by the upstream
kernel. This leaves the Ricoh.

What we can however notice is that the x86 defconfigs in the
kernel did not enable CONFIG_MMC_BLOCK_BOUNCE option, which
means that any such laptop would have to have a custom
configured kernel to actually take advantage of this
bounce buffer speed-up. It simply seems like there was
a speed optimization for the Ricoh controllers that noone
was using. (I have not checked the distro defconfigs but
I am pretty sure the situation is the same there.)

Bounce buffers increased performance on the OMAP HSMMC
at one point, and was part of the original submission in
commit a45c6cb81647 ("[ARM] 5369/1: omap mmc: Add new
   omap hsmmc controller for 2430 and 34xx, v3")

This optimization was removed in
commit 0ccd76d4c236 ("omap_hsmmc: Implement scatter-gather
   emulation")
which found that scatter-gather emulation provided even
better performance.

The same was introduced for SDHCI in
commit 2134a922c6e7 ("sdhci: scatter-gather (ADMA) support")

I am pretty positively convinced that software
scatter-gather emulation will do for any host controller what
the bounce buffers were doing. Essentially, the bounce buffer
was a reimplementation of software scatter-gather-emulation in
the MMC subsystem, and it should be done away with.

Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>
Cc: Steven J. Hill <Steven.Hill@cavium.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Suggested-by: Steven J. Hill <Steven.Hill@cavium.com>
Suggested-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c  |   3 --
 drivers/mmc/core/queue.c  | 120 ++++------------------------------------------
 drivers/mmc/core/queue.h  |   6 ---
 drivers/mmc/host/cavium.c |   2 +-
 drivers/mmc/host/pxamci.c |   6 +--
 include/linux/mmc/host.h  |   2 +-
 6 files changed, 12 insertions(+), 127 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 48521376b17e..ab9c780df750 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1675,8 +1675,6 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
 	}
 
 	mqrq->areq.mrq = &brq->mrq;
-
-	mmc_queue_bounce_pre(mqrq);
 }
 
 static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
@@ -1870,7 +1868,6 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
 		brq = &mq_rq->brq;
 		old_req = mmc_queue_req_to_req(mq_rq);
 		type = rq_data_dir(old_req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
-		mmc_queue_bounce_post(mq_rq);
 
 		switch (status) {
 		case MMC_BLK_SUCCESS:
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 3baccbf16f3d..f74f9ef460cc 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -23,8 +23,6 @@
 #include "core.h"
 #include "card.h"
 
-#define MMC_QUEUE_BOUNCESZ	65536
-
 /*
  * Prepare a MMC request. This just filters out odd stuff.
  */
@@ -150,26 +148,6 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
 }
 
-static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
-{
-	unsigned int bouncesz = MMC_QUEUE_BOUNCESZ;
-
-	if (host->max_segs != 1 || (host->caps & MMC_CAP_NO_BOUNCE_BUFF))
-		return 0;
-
-	if (bouncesz > host->max_req_size)
-		bouncesz = host->max_req_size;
-	if (bouncesz > host->max_seg_size)
-		bouncesz = host->max_seg_size;
-	if (bouncesz > host->max_blk_count * 512)
-		bouncesz = host->max_blk_count * 512;
-
-	if (bouncesz <= 512)
-		return 0;
-
-	return bouncesz;
-}
-
 /**
  * mmc_init_request() - initialize the MMC-specific per-request data
  * @q: the request queue
@@ -184,26 +162,9 @@ static int mmc_init_request(struct request_queue *q, struct request *req,
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 
-	if (card->bouncesz) {
-		mq_rq->bounce_buf = kmalloc(card->bouncesz, gfp);
-		if (!mq_rq->bounce_buf)
-			return -ENOMEM;
-		if (card->bouncesz > 512) {
-			mq_rq->sg = mmc_alloc_sg(1, gfp);
-			if (!mq_rq->sg)
-				return -ENOMEM;
-			mq_rq->bounce_sg = mmc_alloc_sg(card->bouncesz / 512,
-							gfp);
-			if (!mq_rq->bounce_sg)
-				return -ENOMEM;
-		}
-	} else {
-		mq_rq->bounce_buf = NULL;
-		mq_rq->bounce_sg = NULL;
-		mq_rq->sg = mmc_alloc_sg(host->max_segs, gfp);
-		if (!mq_rq->sg)
-			return -ENOMEM;
-	}
+	mq_rq->sg = mmc_alloc_sg(host->max_segs, gfp);
+	if (!mq_rq->sg)
+		return -ENOMEM;
 
 	return 0;
 }
@@ -212,13 +173,6 @@ static void mmc_exit_request(struct request_queue *q, struct request *req)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
 
-	/* It is OK to kfree(NULL) so this will be smooth */
-	kfree(mq_rq->bounce_sg);
-	mq_rq->bounce_sg = NULL;
-
-	kfree(mq_rq->bounce_buf);
-	mq_rq->bounce_buf = NULL;
-
 	kfree(mq_rq->sg);
 	mq_rq->sg = NULL;
 }
@@ -265,18 +219,11 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
-	card->bouncesz = mmc_queue_calc_bouncesz(host);
-	if (card->bouncesz) {
-		blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
-		blk_queue_max_segments(mq->queue, card->bouncesz / 512);
-		blk_queue_max_segment_size(mq->queue, card->bouncesz);
-	} else {
-		blk_queue_bounce_limit(mq->queue, limit);
-		blk_queue_max_hw_sectors(mq->queue,
-			min(host->max_blk_count, host->max_req_size / 512));
-		blk_queue_max_segments(mq->queue, host->max_segs);
-		blk_queue_max_segment_size(mq->queue, host->max_seg_size);
-	}
+	blk_queue_bounce_limit(mq->queue, limit);
+	blk_queue_max_hw_sectors(mq->queue,
+		min(host->max_blk_count, host->max_req_size / 512));
+	blk_queue_max_segments(mq->queue, host->max_segs);
+	blk_queue_max_segment_size(mq->queue, host->max_seg_size);
 
 	sema_init(&mq->thread_sem, 1);
 
@@ -365,56 +312,7 @@ void mmc_queue_resume(struct mmc_queue *mq)
  */
 unsigned int mmc_queue_map_sg(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
 {
-	unsigned int sg_len;
-	size_t buflen;
-	struct scatterlist *sg;
 	struct request *req = mmc_queue_req_to_req(mqrq);
-	int i;
-
-	if (!mqrq->bounce_buf)
-		return blk_rq_map_sg(mq->queue, req, mqrq->sg);
-
-	sg_len = blk_rq_map_sg(mq->queue, req, mqrq->bounce_sg);
-
-	mqrq->bounce_sg_len = sg_len;
-
-	buflen = 0;
-	for_each_sg(mqrq->bounce_sg, sg, sg_len, i)
-		buflen += sg->length;
-
-	sg_init_one(mqrq->sg, mqrq->bounce_buf, buflen);
-
-	return 1;
-}
-
-/*
- * If writing, bounce the data to the buffer before the request
- * is sent to the host driver
- */
-void mmc_queue_bounce_pre(struct mmc_queue_req *mqrq)
-{
-	if (!mqrq->bounce_buf)
-		return;
-
-	if (rq_data_dir(mmc_queue_req_to_req(mqrq)) != WRITE)
-		return;
-
-	sg_copy_to_buffer(mqrq->bounce_sg, mqrq->bounce_sg_len,
-		mqrq->bounce_buf, mqrq->sg[0].length);
-}
-
-/*
- * If reading, bounce the data from the buffer after the request
- * has been handled by the host driver
- */
-void mmc_queue_bounce_post(struct mmc_queue_req *mqrq)
-{
-	if (!mqrq->bounce_buf)
-		return;
-
-	if (rq_data_dir(mmc_queue_req_to_req(mqrq)) != READ)
-		return;
 
-	sg_copy_from_buffer(mqrq->bounce_sg, mqrq->bounce_sg_len,
-		mqrq->bounce_buf, mqrq->sg[0].length);
+	return blk_rq_map_sg(mq->queue, req, mqrq->sg);
 }
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 7649ed6cbef7..68f68ecd94ea 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -51,9 +51,6 @@ enum mmc_drv_op {
 struct mmc_queue_req {
 	struct mmc_blk_request	brq;
 	struct scatterlist	*sg;
-	char			*bounce_buf;
-	struct scatterlist	*bounce_sg;
-	unsigned int		bounce_sg_len;
 	struct mmc_async_req	areq;
 	enum mmc_drv_op		drv_op;
 	int			drv_op_result;
@@ -83,10 +80,7 @@ extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
 extern void mmc_cleanup_queue(struct mmc_queue *);
 extern void mmc_queue_suspend(struct mmc_queue *);
 extern void mmc_queue_resume(struct mmc_queue *);
-
 extern unsigned int mmc_queue_map_sg(struct mmc_queue *,
 				     struct mmc_queue_req *);
-extern void mmc_queue_bounce_pre(struct mmc_queue_req *);
-extern void mmc_queue_bounce_post(struct mmc_queue_req *);
 
 #endif
diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index 27fb625cbcf3..fbd29f00fca0 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -1038,7 +1038,7 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
 	 */
 	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_POWER_OFF_CARD |
-		     MMC_CAP_3_3V_DDR | MMC_CAP_NO_BOUNCE_BUFF;
+		     MMC_CAP_3_3V_DDR;
 
 	if (host->use_sg)
 		mmc->max_segs = 16;
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 59ab194cb009..c763b404510f 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -702,11 +702,7 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	pxamci_init_ocr(host);
 
-	/*
-	 * This architecture used to disable bounce buffers through its
-	 * defconfig, now it is done at runtime as a host property.
-	 */
-	mmc->caps = MMC_CAP_NO_BOUNCE_BUFF;
+	mmc->caps = 0;
 	host->cmdat = 0;
 	if (!cpu_is_pxa25x()) {
 		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f3f2d07feb2a..9a43763a68ad 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -316,7 +316,7 @@ struct mmc_host {
 #define MMC_CAP_UHS_SDR50	(1 << 18)	/* Host supports UHS SDR50 mode */
 #define MMC_CAP_UHS_SDR104	(1 << 19)	/* Host supports UHS SDR104 mode */
 #define MMC_CAP_UHS_DDR50	(1 << 20)	/* Host supports UHS DDR50 mode */
-#define MMC_CAP_NO_BOUNCE_BUFF	(1 << 21)	/* Disable bounce buffers on host */
+/* (1 << 21) is free for reuse */
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
-- 
2.13.5

