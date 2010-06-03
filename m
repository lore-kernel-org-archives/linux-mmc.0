From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 1/4] block: Allow drivers to implement BLKDISCARD and add
 BLKSECDISCARD
Date: Fri, 04 Jun 2010 00:13:16 +0300
Message-ID: <4C081AEC.7010302@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
List-Id: linux-mmc@vger.kernel.org

>From 328a858c01be1e0d08f4a4b1f43d9fd117a295e5 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Thu, 3 Jun 2010 10:46:04 +0300
Subject: [PATCH 1/4] block: Allow drivers to implement BLKDISCARD and add BLKSECDISCARD

SD/MMC cards provide an erase operation that is too inefficient to
allow file systems to use it, however it is still useful for
userspace tools because it is still 10 - 100 times faster than
writing zeroes.  Allow the MMC block driver to provide its own
BLKDISCARD implementation for this purpose.

In addition, eMMC v4.4 cards can provide a secure erase operation
which guarantees that all copies of the discarded sectors (for
example created by garbage collection) will also be erased.  For
this a new ioctl BLKSECDISCARD is added.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 block/compat_ioctl.c |    1 +
 block/ioctl.c        |    9 +++++++++
 include/linux/fs.h   |    1 +
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index f26051f..24a146d 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -753,6 +753,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	case BLKFLSBUF:
 	case BLKROSET:
 	case BLKDISCARD:
+	case BLKSECDISCARD:
 	/*
 	 * the ones below are implemented in blkdev_locked_ioctl,
 	 * but we call blkdev_ioctl, which gets the lock for us
diff --git a/block/ioctl.c b/block/ioctl.c
index e8eb679..985aa88 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -232,12 +232,21 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		if (!(mode & FMODE_WRITE))
 			return -EBADF;
 
+		ret = __blkdev_driver_ioctl(bdev, mode, cmd, arg);
+		if (ret != -ENOTTY)
+			return ret;
+
 		if (copy_from_user(range, (void __user *)arg, sizeof(range)))
 			return -EFAULT;
 
 		return blk_ioctl_discard(bdev, range[0], range[1]);
 	}
 
+	case BLKSECDISCARD:
+		if (!(mode & FMODE_WRITE))
+			return -EBADF;
+		return __blkdev_driver_ioctl(bdev, mode, cmd, arg);
+
 	case HDIO_GETGEO: {
 		struct hd_geometry geo;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3428393..25a6058 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -309,6 +309,7 @@ struct inodes_stat_t {
 #define BLKALIGNOFF _IO(0x12,122)
 #define BLKPBSZGET _IO(0x12,123)
 #define BLKDISCARDZEROES _IO(0x12,124)
+#define BLKSECDISCARD _IO(0x12,125)
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
-- 
1.6.3.3
