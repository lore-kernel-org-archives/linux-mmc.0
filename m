From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/8 v5] mmc: block: Reparametrize mmc_blk_ioctl_[multi]_cmd()
Date: Sun, 20 Aug 2017 23:39:11 +0200
Message-ID: <20170820213913.9737-7-linus.walleij@linaro.org>
References: <20170820213913.9737-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:38474 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753351AbdHTVjd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Aug 2017 17:39:33 -0400
Received: by mail-lf0-f41.google.com with SMTP id y15so59683459lfd.5
        for <linux-mmc@vger.kernel.org>; Sun, 20 Aug 2017 14:39:32 -0700 (PDT)
In-Reply-To: <20170820213913.9737-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

Instead of passing a block device to
mmc_blk_ioctl[_multi]_cmd(), let's pass struct mmc_blk_data()
so we operate ioctl()s on the MMC block device representation
rather than the vanilla block device.

This saves a little duplicated code and makes it possible to
issue ioctl()s not targeted for a specific block device but
rather for a specific partition/area.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v5:
- Rebase.
- Renumber v5 to keep together with the rest of the series.
---
 drivers/mmc/core/block.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 3abdbab401ad..502068b155b9 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -553,12 +553,11 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	return err;
 }
 
-static int mmc_blk_ioctl_cmd(struct block_device *bdev,
+static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 			     struct mmc_ioc_cmd __user *ic_ptr)
 {
 	struct mmc_blk_ioc_data *idata;
 	struct mmc_blk_ioc_data *idatas[1];
-	struct mmc_blk_data *md;
 	struct mmc_queue *mq;
 	struct mmc_card *card;
 	int err = 0, ioc_err = 0;
@@ -568,12 +567,6 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	if (IS_ERR(idata))
 		return PTR_ERR(idata);
 
-	md = mmc_blk_get(bdev->bd_disk);
-	if (!md) {
-		err = -EINVAL;
-		goto cmd_err;
-	}
-
 	card = md->queue.card;
 	if (IS_ERR(card)) {
 		err = PTR_ERR(card);
@@ -597,20 +590,17 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	blk_put_request(req);
 
 cmd_done:
-	mmc_blk_put(md);
-cmd_err:
 	kfree(idata->buf);
 	kfree(idata);
 	return ioc_err ? ioc_err : err;
 }
 
-static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
+static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 				   struct mmc_ioc_multi_cmd __user *user)
 {
 	struct mmc_blk_ioc_data **idata = NULL;
 	struct mmc_ioc_cmd __user *cmds = user->cmds;
 	struct mmc_card *card;
-	struct mmc_blk_data *md;
 	struct mmc_queue *mq;
 	int i, err = 0, ioc_err = 0;
 	__u64 num_of_cmds;
@@ -639,16 +629,10 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 		}
 	}
 
-	md = mmc_blk_get(bdev->bd_disk);
-	if (!md) {
-		err = -EINVAL;
-		goto cmd_err;
-	}
-
 	card = md->queue.card;
 	if (IS_ERR(card)) {
 		err = PTR_ERR(card);
-		goto cmd_done;
+		goto cmd_err;
 	}
 
 
@@ -671,8 +655,6 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 
 	blk_put_request(req);
 
-cmd_done:
-	mmc_blk_put(md);
 cmd_err:
 	for (i = 0; i < num_of_cmds; i++) {
 		kfree(idata[i]->buf);
@@ -697,6 +679,7 @@ static int mmc_blk_check_blkdev(struct block_device *bdev)
 static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
+	struct mmc_blk_data *md;
 	int ret;
 
 	switch (cmd) {
@@ -704,14 +687,24 @@ static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 		ret = mmc_blk_check_blkdev(bdev);
 		if (ret)
 			return ret;
-		return mmc_blk_ioctl_cmd(bdev,
-				(struct mmc_ioc_cmd __user *)arg);
+		md = mmc_blk_get(bdev->bd_disk);
+		if (!md)
+			return -EINVAL;
+		ret = mmc_blk_ioctl_cmd(md,
+					(struct mmc_ioc_cmd __user *)arg);
+		mmc_blk_put(md);
+		return ret;
 	case MMC_IOC_MULTI_CMD:
 		ret = mmc_blk_check_blkdev(bdev);
 		if (ret)
 			return ret;
-		return mmc_blk_ioctl_multi_cmd(bdev,
-				(struct mmc_ioc_multi_cmd __user *)arg);
+		md = mmc_blk_get(bdev->bd_disk);
+		if (!md)
+			return -EINVAL;
+		ret = mmc_blk_ioctl_multi_cmd(md,
+					(struct mmc_ioc_multi_cmd __user *)arg);
+		mmc_blk_put(md);
+		return ret;
 	default:
 		return -EINVAL;
 	}
-- 
2.13.5

