From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2 2/2] mmc: block: Enable runtime pm for mmc blkdevice
Date: Mon, 8 Apr 2013 13:44:57 +0200
Message-ID: <1365421497-4661-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:42204 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934359Ab3DHLpM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Apr 2013 07:45:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Once the mmc blkdevice is being probed, runtime pm will be enabled.
By using runtime autosuspend, the power save operations can be done
when request inactivity occurs for a certain time. Right now the
selected timeout value is set to 3 s.

Moreover, when the blk device is being suspended, we make sure the device
will be runtime resumed. The reason for doing this is that we want the
host suspend sequence to be unaware of any runtime power save operations,
so it can just handle the suspend as the device is fully powered from a
runtime perspective.

This patch is preparing to make it possible to move BKOPS handling into
the runtime callbacks for the mmc bus_ops. Thus IDLE BKOPS can be
accomplished.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Maya Erez <merez@codeaurora.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e12a03c..536331a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <linux/capability.h>
 #include <linux/compat.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -222,6 +223,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 	md = mmc_blk_get(dev_to_disk(dev));
 	card = md->queue.card;
 
+	pm_runtime_get_sync(&card->dev);
 	mmc_claim_host(card->host);
 
 	ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
@@ -234,6 +236,8 @@ static ssize_t power_ro_lock_store(struct device *dev,
 		card->ext_csd.boot_ro_lock |= EXT_CSD_BOOT_WP_B_PWR_WP_EN;
 
 	mmc_release_host(card->host);
+	pm_runtime_mark_last_busy(&card->dev);
+	pm_runtime_put_autosuspend(&card->dev);
 
 	if (!ret) {
 		pr_info("%s: Locking boot partition ro until next power on\n",
@@ -492,6 +496,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 
 	mrq.cmd = &cmd;
 
+	pm_runtime_get_sync(&card->dev);
 	mmc_claim_host(card->host);
 
 	err = mmc_blk_part_switch(card, md);
@@ -560,6 +565,8 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 
 cmd_rel_host:
 	mmc_release_host(card->host);
+	pm_runtime_mark_last_busy(&card->dev);
+	pm_runtime_put_autosuspend(&card->dev);
 
 cmd_done:
 	mmc_blk_put(md);
@@ -1894,9 +1901,11 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_host *host = card->host;
 	unsigned long flags;
 
-	if (req && !mq->mqrq_prev->req)
+	if (req && !mq->mqrq_prev->req) {
+		pm_runtime_get_sync(&card->dev);
 		/* claim host only for the first request */
 		mmc_claim_host(card->host);
+	}
 
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
@@ -1933,7 +1942,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 out:
 	if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
-	     (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK)))
+	     (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK))) {
 		/*
 		 * Release host when there are no more requests
 		 * and after special request(discard, flush) is done.
@@ -1941,6 +1950,10 @@ out:
 		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
 		 */
 		mmc_release_host(card->host);
+		pm_runtime_mark_last_busy(&card->dev);
+		pm_runtime_put_autosuspend(&card->dev);
+	}
+
 	return ret;
 }
 
@@ -2337,6 +2350,12 @@ static int mmc_blk_probe(struct mmc_card *card)
 		if (mmc_add_disk(part_md))
 			goto out;
 	}
+
+	pm_runtime_set_active(&card->dev);
+	pm_runtime_set_autosuspend_delay(&card->dev, 3000);
+	pm_runtime_use_autosuspend(&card->dev);
+	pm_runtime_enable(&card->dev);
+
 	return 0;
 
  out:
@@ -2350,9 +2369,12 @@ static void mmc_blk_remove(struct mmc_card *card)
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	mmc_blk_remove_parts(card, md);
+	pm_runtime_get_sync(&card->dev);
 	mmc_claim_host(card->host);
 	mmc_blk_part_switch(card, md);
 	mmc_release_host(card->host);
+	pm_runtime_disable(&card->dev);
+	pm_runtime_put_noidle(&card->dev);
 	mmc_blk_remove_req(md);
 	mmc_set_drvdata(card, NULL);
 }
@@ -2364,6 +2386,7 @@ static int mmc_blk_suspend(struct mmc_card *card)
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	if (md) {
+		pm_runtime_get_sync(&card->dev);
 		mmc_queue_suspend(&md->queue);
 		list_for_each_entry(part_md, &md->part, part) {
 			mmc_queue_suspend(&part_md->queue);
@@ -2387,6 +2410,7 @@ static int mmc_blk_resume(struct mmc_card *card)
 		list_for_each_entry(part_md, &md->part, part) {
 			mmc_queue_resume(&part_md->queue);
 		}
+		pm_runtime_put(&card->dev);
 	}
 	return 0;
 }
-- 
1.7.10

