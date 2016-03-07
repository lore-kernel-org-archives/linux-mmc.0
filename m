From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESENT PATCH] mmc: block: fix ABI regression of mmc_blk_ioctl
Date: Mon,  7 Mar 2016 14:59:00 +0800
Message-ID: <1457333940-13076-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:37541 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbcCGHHf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2016 02:07:35 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Seshagiri Holi <sholi@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, stable@vger.kernel.org

We should return -EINVAL if cmd is not MMC_IOC_CMD or MMC_IOC_MULTI_CMD,
otherwise blkdev_roset will return -EPERM.

Android-adb calls make_block_device_writable with ioctl(BLKROSET), which
will return error, make remount failed:
remount of /system failed;
couldn't make block device writable: Operation not permitted

openat(AT_FDCWD, "/dev/block/platform/ff420000.dwmmc/by-name/system", O_RDONLY) = 3
ioctl(3, BLKROSET, 0)  = -1 EPERM (Operation not permitted)

Fixes: a5f5774c55a2 ("mmc: block: Add new ioctl to send multi commands")
Cc: stable@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/card/block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 47bc87d..170f099 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -688,6 +688,9 @@ cmd_err:
 static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
+	if (cmd != MMC_IOC_CMD && cmd != MMC_IOC_MULTI_CMD)
+		return -EINVAL;
+
 	/*
 	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
 	 * whole block device, not on a partition.  This prevents overspray
-- 
2.3.7


