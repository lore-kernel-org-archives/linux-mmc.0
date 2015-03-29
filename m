From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: [PATCH] mmc: block: use block layer pm helpers for pm of card device
Date: Sun, 29 Mar 2015 17:11:25 +0300
Message-ID: <5518080D.6070803@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090004030905050407080004"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59222 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbbC2OLa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Mar 2015 10:11:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090004030905050407080004
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

--------------090004030905050407080004
Content-Type: text/x-patch;
 name="0001-mmc-block-use-block-layer-pm-helpers-for-pm-of-card-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-mmc-block-use-block-layer-pm-helpers-for-pm-of-card-.pa";
 filename*1="tch"

>From a429c2c9357c26862a45fd01fff3ed7ec5d69fd7 Mon Sep 17 00:00:00 2001
From: Konstantin Dorfman <kdorfman@codeaurora.org>
Date: Wed, 25 Mar 2015 14:43:01 +0200
Subject: [PATCH] mmc: block: use block layer pm helpers for pm of card device

Use of block layer runtime PM helpers, implementing the block layer's
request-based mechanism, simplifies data path of mmc core layer. It
enables to remove synchronous call pm_runtime_get_sync() from mmc core
data path.

The idea and API is designed by Alan Stern and described here:
    http://marc.info/?l=linux-scsi&m=133727953625963&w=2

Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
---
 drivers/mmc/card/block.c |  4 ++--
 drivers/mmc/card/queue.c |  5 +++++
 drivers/mmc/core/mmc.c   | 13 ++++++++++++-
 include/linux/mmc/card.h |  1 +
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1fa4c80..de5f85d 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2017,7 +2017,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	if (req && !mq->mqrq_prev->req)
 		/* claim host only for the first request */
-		mmc_get_card(card);
+		mmc_claim_host(card->host);
 
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
@@ -2060,7 +2060,7 @@ out:
 		 * In case sepecial request, there is no reentry to
 		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
 		 */
-		mmc_put_card(card);
+		mmc_release_host(card->host);
 	return ret;
 }
 
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index feea926..e12c828 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -213,6 +213,11 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
+	if (!subname) {
+		blk_pm_runtime_init(mq->queue, &card->dev);
+		card->q = mq->queue;
+	}
+
 #ifdef CONFIG_MMC_BLOCK_BOUNCE
 	if (host->max_segs == 1) {
 		unsigned int bouncesz;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a301a78..bf3f919 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/pm_runtime.h>
+#include <linux/blkdev.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -1814,11 +1815,17 @@ static int mmc_runtime_suspend(struct mmc_host *host)
 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
 		return 0;
 
+	err = blk_pre_runtime_suspend(host->card->q);
+	if (err)
+		return err;
+
 	err = _mmc_suspend(host, true);
 	if (err)
 		pr_err("%s: error %d doing aggessive suspend\n",
 			mmc_hostname(host), err);
 
+	blk_post_runtime_suspend(host->card->q, err);
+
 	return err;
 }
 
@@ -1832,12 +1839,16 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	if (!(host->caps & (MMC_CAP_AGGRESSIVE_PM | MMC_CAP_RUNTIME_RESUME)))
 		return 0;
 
+	blk_pre_runtime_resume(host->card->q);
+
 	err = _mmc_resume(host);
 	if (err)
 		pr_err("%s: error %d doing aggessive resume\n",
 			mmc_hostname(host), err);
 
-	return 0;
+	blk_post_runtime_resume(host->card->q, err);
+
+	return err;
 }
 
 static int mmc_power_restore(struct mmc_host *host)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index b0692d2..1f4810b 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -244,6 +244,7 @@ struct mmc_part {
 struct mmc_card {
 	struct mmc_host		*host;		/* the host this device belongs to */
 	struct device		dev;		/* the device */
+	struct request_queue    *q;
 	u32			ocr;		/* the current OCR setting */
 	unsigned int		rca;		/* relative card address of device */
 	unsigned int		type;		/* card type */
-- 
1.8.5.2
-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

--------------090004030905050407080004--
