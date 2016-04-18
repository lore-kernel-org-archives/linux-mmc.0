From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] mmc: block: Convert to IDA for partition device indexes
Date: Mon, 18 Apr 2016 13:43:54 +0200
Message-ID: <1460979834-24582-3-git-send-email-ulf.hansson@linaro.org>
References: <1460979834-24582-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35146 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbcDRLoN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2016 07:44:13 -0400
Received: by mail-lf0-f46.google.com with SMTP id c126so213239470lfb.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2016 04:44:12 -0700 (PDT)
In-Reply-To: <1460979834-24582-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Instead of using an mmc specific implementation to deal with indexes
through a BITMAP, let's convert to use the IDA library.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9aaf22e..9ce6792 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -35,6 +35,7 @@
 #include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/pm_runtime.h>
+#include <linux/idr.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -78,14 +79,14 @@ static int perdev_minors = CONFIG_MMC_BLOCK_MINORS;
 /*
  * We've only got one major, so number of mmcblk devices is
  * limited to (1 << 20) / number of minors per device.  It is also
- * currently limited by the size of the static bitmaps below.
+ * limited by the MAX_DEVICES below.
  */
 static int max_devices;
 
 #define MAX_DEVICES 256
 
-/* TODO: Replace these with struct ida */
-static DECLARE_BITMAP(dev_use, MAX_DEVICES);
+static DEFINE_IDA(mmc_blk_ida);
+static DEFINE_SPINLOCK(mmc_blk_lock);
 
 /*
  * There is one mmc_blk_data per slot.
@@ -178,7 +179,9 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 		int devidx = mmc_get_devidx(md->disk);
 		blk_cleanup_queue(md->queue.queue);
 
-		__clear_bit(devidx, dev_use);
+		spin_lock(&mmc_blk_lock);
+		ida_remove(&mmc_blk_ida, devidx);
+		spin_unlock(&mmc_blk_lock);
 
 		put_disk(md->disk);
 		kfree(md);
@@ -2189,10 +2192,23 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	struct mmc_blk_data *md;
 	int devidx, ret;
 
-	devidx = find_first_zero_bit(dev_use, max_devices);
-	if (devidx >= max_devices)
-		return ERR_PTR(-ENOSPC);
-	__set_bit(devidx, dev_use);
+again:
+	if (!ida_pre_get(&mmc_blk_ida, GFP_KERNEL))
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock(&mmc_blk_lock);
+	ret = ida_get_new(&mmc_blk_ida, &devidx);
+	spin_unlock(&mmc_blk_lock);
+
+	if (ret == -EAGAIN)
+		goto again;
+	else if (ret)
+		return ERR_PTR(ret);
+
+	if (devidx >= max_devices) {
+		ret = -ENOSPC;
+		goto out;
+	}
 
 	md = kzalloc(sizeof(struct mmc_blk_data), GFP_KERNEL);
 	if (!md) {
@@ -2289,7 +2305,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
  err_kfree:
 	kfree(md);
  out:
-	__clear_bit(devidx, dev_use);
+	spin_lock(&mmc_blk_lock);
+	ida_remove(&mmc_blk_ida, devidx);
+	spin_unlock(&mmc_blk_lock);
 	return ERR_PTR(ret);
 }
 
-- 
1.9.1

