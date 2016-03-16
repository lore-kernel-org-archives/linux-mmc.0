From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] mmc: block: fix ABI regression of mmc_blk_ioctl
Date: Wed, 16 Mar 2016 18:15:47 +0800
Message-ID: <1458123347-32392-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:49006 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966308AbcCPKQQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 06:16:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, sholi@nvidia.com, John Stultz <john.stultz@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, stable@vger.kernel.org

If mmc_blk_ioctl returns -EINVAL, blkdev_ioctl continues to
work without returning err to user-space. But now we check
CAP_SYS_RAWIO firstly, so we return -EPERM to blkdev_ioctl,
which make blkdev_ioctl return -EPERM to user-space directly.
So this will break all the ioctl with BLKROSET. Now we find
Android-adb suffer it for the following log:

remount of /system failed;
couldn't make block device writable: Operation not permitted
openat(AT_FDCWD, "/dev/block/platform/ff420000.dwmmc/by-name/system", O_RDONLY) = 3
ioctl(3, BLKROSET, 0)  = -1 EPERM (Operation not permitted)

Fixes: a5f5774c55a2 ("mmc: block: Add new ioctl to send multi commands")
Cc: stable@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- move checking CAP_SYS_RAWIO inside the mmc_blk_ioctl_cmd and
  mmc_blk_ioctl_multi_cmd

 drivers/mmc/card/block.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 47bc87d..3bdbe50 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -589,6 +589,14 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	struct mmc_card *card;
 	int err = 0, ioc_err = 0;
 
+	/*
+	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
+	 * whole block device, not on a partition.  This prevents overspray
+	 * between sibling partitions.
+	 */
+	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
+		return -EPERM;
+
 	idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
 	if (IS_ERR(idata))
 		return PTR_ERR(idata);
@@ -631,6 +639,14 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
 	int i, err = 0, ioc_err = 0;
 	__u64 num_of_cmds;
 
+	/*
+	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
+	 * whole block device, not on a partition.  This prevents overspray
+	 * between sibling partitions.
+	 */
+	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
+		return -EPERM;
+
 	if (copy_from_user(&num_of_cmds, &user->num_of_cmds,
 			   sizeof(num_of_cmds)))
 		return -EFAULT;
@@ -688,14 +704,6 @@ cmd_err:
 static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
-	/*
-	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
-	 * whole block device, not on a partition.  This prevents overspray
-	 * between sibling partitions.
-	 */
-	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
-		return -EPERM;
-
 	switch (cmd) {
 	case MMC_IOC_CMD:
 		return mmc_blk_ioctl_cmd(bdev,
-- 
2.3.7


