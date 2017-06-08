From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/6 v3] mmc: debugfs: Move block debugfs into block module
Date: Thu,  8 Jun 2017 10:54:03 +0200
Message-ID: <20170608085403.11795-7-linus.walleij@linaro.org>
References: <20170608085403.11795-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33850 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdFHIya (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 04:54:30 -0400
Received: by mail-lf0-f50.google.com with SMTP id v20so15274532lfa.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 01:54:29 -0700 (PDT)
In-Reply-To: <20170608085403.11795-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

The if #IS_ENABLED() clauses inside the debugfs code isn't
very nice.

And alternative is to move the block layer debugfs file
handling into the block module, so they live and die with
the block initialization of the card.

This makes the code smaller since we do not need cross-calls
between debugfs.c and block.c.

On the other hand it moves some debugfs code from debugfs.c
and into block.c.

So both approaches have their merits.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- New patch after discussion with Ulf, numbering v3 to keep
  the series together.

Ulf: I leave it to you to decide if you prefer to centralize
debugfs code in debugfs.c or to localize the block debugfs
code inside block.c.
---
 drivers/mmc/core/block.c   | 170 +++++++++++++++++++++++++++++++++++----------
 drivers/mmc/core/block.h   |   2 -
 drivers/mmc/core/debugfs.c |  96 -------------------------
 3 files changed, 132 insertions(+), 136 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4708f95ebdd0..1ce6012ce3c1 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -36,6 +36,7 @@
 #include <linux/compat.h>
 #include <linux/pm_runtime.h>
 #include <linux/idr.h>
+#include <linux/debugfs.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -1965,44 +1966,6 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		mmc_put_card(card);
 }
 
-/* Called from debugfs for MMC/SD cards */
-int mmc_blk_card_status_get(struct mmc_card *card, u64 *val)
-{
-	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
-	struct mmc_queue *mq = &md->queue;
-	struct request *req;
-	int ret;
-
-	/* Ask the block layer about the card status */
-	req = blk_get_request(mq->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
-	blk_execute_rq(mq->queue, NULL, req, 0);
-	ret = req_to_mmc_queue_req(req)->drv_op_result;
-	if (ret >= 0) {
-		*val = ret;
-		ret = 0;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(mmc_blk_card_status_get);
-
-/* Called from debugfs for MMC cards */
-int mmc_blk_get_ext_csd(struct mmc_card *card, u8 **ext_csd)
-{
-	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
-	struct mmc_queue *mq = &md->queue;
-	struct request *req;
-
-	/* Ask the block layer about the EXT CSD */
-	req = blk_get_request(mq->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
-	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
-	req_to_mmc_queue_req(req)->drv_op_data = ext_csd;
-	blk_execute_rq(mq->queue, NULL, req, 0);
-	return req_to_mmc_queue_req(req)->drv_op_result;
-}
-EXPORT_SYMBOL(mmc_blk_get_ext_csd);
-
 static inline int mmc_blk_readonly(struct mmc_card *card)
 {
 	return mmc_card_readonly(card) ||
@@ -2275,6 +2238,134 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	return ret;
 }
 
+#ifdef CONFIG_DEBUG_FS
+
+static int mmc_dbg_card_status_get(void *data, u64 *val)
+{
+	struct mmc_card *card = data;
+	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
+	struct mmc_queue *mq = &md->queue;
+	struct request *req;
+	int ret;
+
+	/* Ask the block layer about the card status */
+	req = blk_get_request(mq->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
+	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
+	blk_execute_rq(mq->queue, NULL, req, 0);
+	ret = req_to_mmc_queue_req(req)->drv_op_result;
+	if (ret >= 0) {
+		*val = ret;
+		ret = 0;
+	}
+
+	return ret;
+}
+DEFINE_SIMPLE_ATTRIBUTE(mmc_dbg_card_status_fops, mmc_dbg_card_status_get,
+		NULL, "%08llx\n");
+
+/* That is two digits * 512 + 1 for newline */
+#define EXT_CSD_STR_LEN 1025
+
+static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
+{
+	struct mmc_card *card = inode->i_private;
+	struct mmc_blk_data *md = dev_get_drvdata(&card->dev);
+	struct mmc_queue *mq = &md->queue;
+	struct request *req;
+	char *buf;
+	ssize_t n = 0;
+	u8 *ext_csd;
+	int err, i;
+
+	buf = kmalloc(EXT_CSD_STR_LEN + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Ask the block layer for the EXT CSD */
+	req = blk_get_request(mq->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
+	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
+	req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
+	blk_execute_rq(mq->queue, NULL, req, 0);
+	err = req_to_mmc_queue_req(req)->drv_op_result;
+	if (err) {
+		pr_err("FAILED %d\n", err);
+		goto out_free;
+	}
+
+	for (i = 0; i < 512; i++)
+		n += sprintf(buf + n, "%02x", ext_csd[i]);
+	n += sprintf(buf + n, "\n");
+
+	if (n != EXT_CSD_STR_LEN) {
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	filp->private_data = buf;
+	kfree(ext_csd);
+	return 0;
+
+out_free:
+	kfree(buf);
+	return err;
+}
+
+static ssize_t mmc_ext_csd_read(struct file *filp, char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	char *buf = filp->private_data;
+
+	return simple_read_from_buffer(ubuf, cnt, ppos,
+				       buf, EXT_CSD_STR_LEN);
+}
+
+static int mmc_ext_csd_release(struct inode *inode, struct file *file)
+{
+	kfree(file->private_data);
+	return 0;
+}
+
+static const struct file_operations mmc_dbg_ext_csd_fops = {
+	.open		= mmc_ext_csd_open,
+	.read		= mmc_ext_csd_read,
+	.release	= mmc_ext_csd_release,
+	.llseek		= default_llseek,
+};
+
+static int mmc_blk_add_debugfs(struct mmc_card *card)
+{
+	struct dentry *root;
+
+	if (!card->debugfs_root)
+		return 0;
+
+	root = card->debugfs_root;
+
+	if (mmc_card_mmc(card) || mmc_card_sd(card)) {
+		if (!debugfs_create_file("status", S_IRUSR, root, card,
+					 &mmc_dbg_card_status_fops))
+			return -EIO;
+	}
+
+	if (mmc_card_mmc(card)) {
+		if (!debugfs_create_file("ext_csd", S_IRUSR, root, card,
+					 &mmc_dbg_ext_csd_fops))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+
+#else
+
+static int mmc_blk_add_debugfs(struct mmc_card *card)
+{
+	return 0;
+}
+
+#endif /* CONFIG_DEBUG_FS */
+
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
@@ -2311,6 +2402,9 @@ static int mmc_blk_probe(struct mmc_card *card)
 			goto out;
 	}
 
+	/* Add two debugfs entries */
+	mmc_blk_add_debugfs(card);
+
 	pm_runtime_set_autosuspend_delay(&card->dev, 3000);
 	pm_runtime_use_autosuspend(&card->dev);
 
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 377ebbf6a978..860ca7c8df86 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -5,7 +5,5 @@ struct mmc_queue;
 struct request;
 
 void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req);
-int mmc_blk_card_status_get(struct mmc_card *card, u64 *val);
-int mmc_blk_get_ext_csd(struct mmc_card *card, u8 **ext_csd);
 
 #endif
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index cc1f7085111c..8583c2dc879e 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -282,99 +282,6 @@ void mmc_remove_host_debugfs(struct mmc_host *host)
 	debugfs_remove_recursive(host->debugfs_root);
 }
 
-#if IS_ENABLED(CONFIG_MMC_BLOCK)
-
-static int mmc_dbg_card_status_get(void *data, u64 *val)
-{
-	return mmc_blk_card_status_get(data, val);
-}
-DEFINE_SIMPLE_ATTRIBUTE(mmc_dbg_card_status_fops, mmc_dbg_card_status_get,
-		NULL, "%08llx\n");
-
-#define EXT_CSD_STR_LEN 1025
-
-static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
-{
-	struct mmc_card *card = inode->i_private;
-	char *buf;
-	ssize_t n = 0;
-	u8 *ext_csd;
-	int err, i;
-
-	buf = kmalloc(EXT_CSD_STR_LEN + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	err = mmc_blk_get_ext_csd(card, &ext_csd);
-	if (err)
-		goto out_free;
-
-	for (i = 0; i < 512; i++)
-		n += sprintf(buf + n, "%02x", ext_csd[i]);
-	n += sprintf(buf + n, "\n");
-
-	if (n != EXT_CSD_STR_LEN) {
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	filp->private_data = buf;
-	kfree(ext_csd);
-	return 0;
-
-out_free:
-	kfree(buf);
-	return err;
-}
-
-static ssize_t mmc_ext_csd_read(struct file *filp, char __user *ubuf,
-				size_t cnt, loff_t *ppos)
-{
-	char *buf = filp->private_data;
-
-	return simple_read_from_buffer(ubuf, cnt, ppos,
-				       buf, EXT_CSD_STR_LEN);
-}
-
-static int mmc_ext_csd_release(struct inode *inode, struct file *file)
-{
-	kfree(file->private_data);
-	return 0;
-}
-
-static const struct file_operations mmc_dbg_ext_csd_fops = {
-	.open		= mmc_ext_csd_open,
-	.read		= mmc_ext_csd_read,
-	.release	= mmc_ext_csd_release,
-	.llseek		= default_llseek,
-};
-
-static int mmc_add_block_debugfs(struct mmc_card *card, struct dentry *root)
-{
-	if (mmc_card_mmc(card) || mmc_card_sd(card)) {
-		if (!debugfs_create_file("status", S_IRUSR, root, card,
-					 &mmc_dbg_card_status_fops))
-			return -EIO;
-	}
-
-	if (mmc_card_mmc(card)) {
-		if (!debugfs_create_file("ext_csd", S_IRUSR, root, card,
-					 &mmc_dbg_ext_csd_fops))
-			return -EIO;
-	}
-
-	return 0;
-}
-
-#else /* !IS_ENABLED(CONFIG_MMC_BLOCK) */
-
-static int mmc_add_block_debugfs(struct mmc_card *card, struct dentry *root)
-{
-	return 0;
-}
-
-#endif
-
 void mmc_add_card_debugfs(struct mmc_card *card)
 {
 	struct mmc_host	*host = card->host;
@@ -397,9 +304,6 @@ void mmc_add_card_debugfs(struct mmc_card *card)
 	if (!debugfs_create_x32("state", S_IRUSR, root, &card->state))
 		goto err;
 
-	if (mmc_add_block_debugfs(card, root))
-		goto err;
-
 	return;
 
 err:
-- 
2.9.4

