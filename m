From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: block: Move duplicate check
Date: Wed, 14 Jun 2017 13:48:51 +0200
Message-ID: <20170614114851.17146-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34760 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbdFNLs6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2017 07:48:58 -0400
Received: by mail-lf0-f47.google.com with SMTP id v20so90173101lfa.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2017 04:48:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

mmc_blk_ioctl() calls either mmc_blk_ioctl_cmd() or
mmc_blk_ioctl_multi_cmd() and each of these make the same
check. Factor it into the first call and save one chunk
of duplicate code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1ce6012ce3c1..c80bee4a9cff 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -566,14 +566,6 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
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
@@ -626,14 +618,6 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
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
@@ -700,6 +684,14 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
+	/*
+	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
+	 * whole block device, not on a partition.  This prevents overspray
+	 * between sibling partitions.
+	 */
+	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
+		return -EPERM;
+
 	switch (cmd) {
 	case MMC_IOC_CMD:
 		return mmc_blk_ioctl_cmd(bdev,
-- 
2.9.4

