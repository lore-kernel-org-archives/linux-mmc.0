From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/8 v5] mmc: block: Move duplicate check
Date: Sun, 20 Aug 2017 23:39:09 +0200
Message-ID: <20170820213913.9737-5-linus.walleij@linaro.org>
References: <20170820213913.9737-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35545 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753351AbdHTVj3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Aug 2017 17:39:29 -0400
Received: by mail-lf0-f54.google.com with SMTP id k186so4087512lfe.2
        for <linux-mmc@vger.kernel.org>; Sun, 20 Aug 2017 14:39:29 -0700 (PDT)
In-Reply-To: <20170820213913.9737-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

mmc_blk_ioctl() calls either mmc_blk_ioctl_cmd() or
mmc_blk_ioctl_multi_cmd() and each of these make the same
check. Factor it into a new helper function, call it on
both branches of the switch() statement and save a chunk
of duplicate code.

Cc: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v5:
- Rebase, put on top of the other cleanups.
- Number v5 to keep together with the rest of the series.
ChangeLog v1->v2:
- We need to check the block device only if an actual
  well-known ioctl() is coming in, on the path of the
  switch() statments, only those branches that handle
  actual ioctl()s. Create a new helper function to check
  the block device and call that.
---
 drivers/mmc/core/block.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 6c91e125ab72..b0585f7971f1 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -564,14 +564,6 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	int err = 0, ioc_err = 0;
 	struct request *req;
 
-	/*
-	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
-	 * whole block device, not on a partition.  This prevents overspray
-	 * between sibling partitions.
-	 */
-	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
-		return -EPERM;
-
 	idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
 	if (IS_ERR(idata))
 		return PTR_ERR(idata);
@@ -624,14 +616,6 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 	__u64 num_of_cmds;
 	struct request *req;
 
-	/*
-	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
-	 * whole block device, not on a partition.  This prevents overspray
-	 * between sibling partitions.
-	 */
-	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
-		return -EPERM;
-
 	if (copy_from_user(&num_of_cmds, &user->num_of_cmds,
 			   sizeof(num_of_cmds)))
 		return -EFAULT;
@@ -698,14 +682,34 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 	return ioc_err ? ioc_err : err;
 }
 
+static int mmc_blk_check_blkdev(struct block_device *bdev)
+{
+	/*
+	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
+	 * whole block device, not on a partition.  This prevents overspray
+	 * between sibling partitions.
+	 */
+	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
+		return -EPERM;
+	return 0;
+}
+
 static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
+	int ret;
+
 	switch (cmd) {
 	case MMC_IOC_CMD:
+		ret = mmc_blk_check_blkdev(bdev);
+		if (ret)
+			return ret;
 		return mmc_blk_ioctl_cmd(bdev,
 				(struct mmc_ioc_cmd __user *)arg);
 	case MMC_IOC_MULTI_CMD:
+		ret = mmc_blk_check_blkdev(bdev);
+		if (ret)
+			return ret;
 		return mmc_blk_ioctl_multi_cmd(bdev,
 				(struct mmc_ioc_multi_cmd __user *)arg);
 	default:
-- 
2.13.5

