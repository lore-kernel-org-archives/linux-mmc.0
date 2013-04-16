From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V3 3/4] mmc: block: Enable runtime pm for mmc blkdevice
Date: Tue, 16 Apr 2013 12:00:36 +0200
Message-ID: <1366106437-18004-4-git-send-email-ulf.hansson@stericsson.com>
References: <1366106437-18004-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:49809 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935469Ab3DPKBU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Apr 2013 06:01:20 -0400
In-Reply-To: <1366106437-18004-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

From: Ulf Hansson <ulf.hansson@linaro.org>

Once the mmc blkdevice is being probed, runtime pm will be enabled.
By using runtime autosuspend, the power save operations can be done
when request inactivity occurs for a certain time. Right now the
selected timeout value is set to 3 s. Obviously this value will likely
need to be configurable somehow since it needs to be trimmed depending
on the power save algorithm.

For SD-combo cards, we are still leaving the enablement of runtime PM
to the SDIO init sequence since it depends on the capabilities of the
SDIO func driver.

Moreover, when the blk device is being suspended, we make sure the device
will be runtime resumed. The reason for doing this is that we want the
host suspend sequence to be unaware of any runtime power save operations
done for the card in this phase. Thus it can just handle the suspend as
the card is fully powered from a runtime perspective.

Finally, this patch prepares to make it possible to move BKOPS handling
into the runtime callbacks for the mmc bus_ops. Thus IDLE BKOPS can be
accomplished.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maya Erez <merez@codeaurora.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Liu <kliu5@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Drake <dsd@laptop.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/card/block.c   |   32 ++++++++++++++++++++++++++------
 drivers/mmc/core/core.c    |   23 +++++++++++++++++++++++
 drivers/mmc/core/debugfs.c |    8 ++++----
 drivers/mmc/core/mmc.c     |    4 ++--
 drivers/mmc/core/sd.c      |    4 ++--
 include/linux/mmc/core.h   |    3 +++
 6 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e12a03c..360a41a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <linux/capability.h>
 #include <linux/compat.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -222,7 +223,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 	md = mmc_blk_get(dev_to_disk(dev));
 	card = md->queue.card;
 
-	mmc_claim_host(card->host);
+	mmc_get_card(card);
 
 	ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
 				card->ext_csd.boot_ro_lock |
@@ -233,7 +234,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
 	else
 		card->ext_csd.boot_ro_lock |= EXT_CSD_BOOT_WP_B_PWR_WP_EN;
 
-	mmc_release_host(card->host);
+	mmc_put_card(card);
 
 	if (!ret) {
 		pr_info("%s: Locking boot partition ro until next power on\n",
@@ -492,7 +493,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 
 	mrq.cmd = &cmd;
 
-	mmc_claim_host(card->host);
+	mmc_get_card(card);
 
 	err = mmc_blk_part_switch(card, md);
 	if (err)
@@ -559,7 +560,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	}
 
 cmd_rel_host:
-	mmc_release_host(card->host);
+	mmc_put_card(card);
 
 cmd_done:
 	mmc_blk_put(md);
@@ -1896,7 +1897,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 	if (req && !mq->mqrq_prev->req)
 		/* claim host only for the first request */
-		mmc_claim_host(card->host);
+		mmc_get_card(card);
 
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
@@ -1940,7 +1941,7 @@ out:
 		 * In case sepecial request, there is no reentry to
 		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
 		 */
-		mmc_release_host(card->host);
+		mmc_put_card(card);
 	return ret;
 }
 
@@ -2337,6 +2338,19 @@ static int mmc_blk_probe(struct mmc_card *card)
 		if (mmc_add_disk(part_md))
 			goto out;
 	}
+
+	pm_runtime_set_autosuspend_delay(&card->dev, 3000);
+	pm_runtime_use_autosuspend(&card->dev);
+
+	/*
+	 * Don't enable runtime PM for SD-combo cards here. Leave that
+	 * decision to be taken during the SDIO init sequence instead.
+	 */
+	if (card->type != MMC_TYPE_SD_COMBO) {
+		pm_runtime_set_active(&card->dev);
+		pm_runtime_enable(&card->dev);
+	}
+
 	return 0;
 
  out:
@@ -2350,9 +2364,13 @@ static void mmc_blk_remove(struct mmc_card *card)
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	mmc_blk_remove_parts(card, md);
+	pm_runtime_get_sync(&card->dev);
 	mmc_claim_host(card->host);
 	mmc_blk_part_switch(card, md);
 	mmc_release_host(card->host);
+	if (card->type != MMC_TYPE_SD_COMBO)
+		pm_runtime_disable(&card->dev);
+	pm_runtime_put_noidle(&card->dev);
 	mmc_blk_remove_req(md);
 	mmc_set_drvdata(card, NULL);
 }
@@ -2364,6 +2382,7 @@ static int mmc_blk_suspend(struct mmc_card *card)
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	if (md) {
+		pm_runtime_get_sync(&card->dev);
 		mmc_queue_suspend(&md->queue);
 		list_for_each_entry(part_md, &md->part, part) {
 			mmc_queue_suspend(&part_md->queue);
@@ -2387,6 +2406,7 @@ static int mmc_blk_resume(struct mmc_card *card)
 		list_for_each_entry(part_md, &md->part, part) {
 			mmc_queue_resume(&part_md->queue);
 		}
+		pm_runtime_put(&card->dev);
 	}
 	return 0;
 }
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b16b64a..602db00 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -952,6 +952,29 @@ void mmc_release_host(struct mmc_host *host)
 EXPORT_SYMBOL(mmc_release_host);
 
 /*
+ * This is a helper function, which fetches a runtime pm reference for the
+ * card device and also claims the host.
+ */
+void mmc_get_card(struct mmc_card *card)
+{
+	pm_runtime_get_sync(&card->dev);
+	mmc_claim_host(card->host);
+}
+EXPORT_SYMBOL(mmc_get_card);
+
+/*
+ * This is a helper function, which releases the host and drops the runtime
+ * pm reference for the card device.
+ */
+void mmc_put_card(struct mmc_card *card)
+{
+	mmc_release_host(card->host);
+	pm_runtime_mark_last_busy(&card->dev);
+	pm_runtime_put_autosuspend(&card->dev);
+}
+EXPORT_SYMBOL(mmc_put_card);
+
+/*
  * Internal function that does the actual ios call to the host driver,
  * optionally printing some debug output.
  */
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 35c2f85..54829c0 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -258,13 +258,13 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
 	u32		status;
 	int		ret;
 
-	mmc_claim_host(card->host);
+	mmc_get_card(card);
 
 	ret = mmc_send_status(data, &status);
 	if (!ret)
 		*val = status;
 
-	mmc_release_host(card->host);
+	mmc_put_card(card);
 
 	return ret;
 }
@@ -291,9 +291,9 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
 		goto out_free;
 	}
 
-	mmc_claim_host(card->host);
+	mmc_get_card(card);
 	err = mmc_send_ext_csd(card, ext_csd);
-	mmc_release_host(card->host);
+	mmc_put_card(card);
 	if (err)
 		goto out_free;
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 66a530e..bf19058 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1380,14 +1380,14 @@ static void mmc_detect(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
-	mmc_claim_host(host);
+	mmc_get_card(host->card);
 
 	/*
 	 * Just check if our card has been removed.
 	 */
 	err = _mmc_detect_card_removed(host);
 
-	mmc_release_host(host);
+	mmc_put_card(host->card);
 
 	if (err) {
 		mmc_remove(host);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 9e645e1..30387d6 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1037,14 +1037,14 @@ static void mmc_sd_detect(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
-	mmc_claim_host(host);
+	mmc_get_card(host->card);
 
 	/*
 	 * Just check if our card has been removed.
 	 */
 	err = _mmc_detect_card_removed(host);
 
-	mmc_release_host(host);
+	mmc_put_card(host->card);
 
 	if (err) {
 		mmc_sd_remove(host);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 39613b9..49fb132 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -188,6 +188,9 @@ extern int __mmc_claim_host(struct mmc_host *host, atomic_t *abort);
 extern void mmc_release_host(struct mmc_host *host);
 extern int mmc_try_claim_host(struct mmc_host *host);
 
+extern void mmc_get_card(struct mmc_card *card);
+extern void mmc_put_card(struct mmc_card *card);
+
 extern int mmc_flush_cache(struct mmc_card *);
 
 extern int mmc_detect_card_removed(struct mmc_host *host);
-- 
1.7.10

