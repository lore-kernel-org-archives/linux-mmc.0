From: Qiang Liu <b32616@freescale.com>
Subject: [PATCH 2/2] SD/MMC: add support of adjust bounce size at run-time
Date: Thu, 24 Nov 2011 11:06:17 +0800
Message-ID: <1322103977-7155-2-git-send-email-b32616@freescale.com>
References: <1322103977-7155-1-git-send-email-b32616@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:57378 "EHLO
	TX2EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab1KXDiN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2011 22:38:13 -0500
In-Reply-To: <1322103977-7155-1-git-send-email-b32616@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: leoli@freescale.com, Qiang Liu <b32616@freescale.com>

Add bounce_size under /sys/block/mmcblk0/bouncesz.
Support dynamic adjustment of bounce buffer in run-time (include mounted or
unmounted filesystem).

/sys/block/mmcblk0/bouncesz should be integer multiple of 512, the
value should be range from 4096 to 4194304.

Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
---
 drivers/mmc/card/block.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a1cb21f..649bfed 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -59,6 +59,9 @@ MODULE_ALIAS("mmc:block");
 #define INAND_CMD38_ARG_SECTRIM1 0x81
 #define INAND_CMD38_ARG_SECTRIM2 0x88

+#define MMC_MIN_QUEUE_BOUNCESZ 4096
+#define MMC_MAX_QUEUE_BOUNCESZ 4194304
+
 static DEFINE_MUTEX(block_mutex);

 /*
@@ -107,6 +110,7 @@ struct mmc_blk_data {
 	 */
 	unsigned int	part_curr;
 	struct device_attribute force_ro;
+	struct device_attribute bouncesz;
 };

 static DEFINE_MUTEX(open_lock);
@@ -1547,6 +1551,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
 			del_gendisk(md->disk);
 		}

+		device_remove_file(disk_to_dev(md->disk), &md->bouncesz);
 		/* Then flush out any already in there */
 		mmc_cleanup_queue(&md->queue);
 		mmc_blk_put(md);
@@ -1609,6 +1614,33 @@ static const struct mmc_fixup blk_fixups[] =
 	END_FIXUP
 };

+#ifdef CONFIG_MMC_BLOCK_BOUNCE
+static ssize_t mmc_bouncesz_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	 return sprintf(buf, "%u\n", mmc_queue_bouncesz);
+}
+
+static ssize_t mmc_bouncesz_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	unsigned int bouncesz;
+	struct mmc_blk_data *md;
+
+	if ((sscanf(buf, "%d", &bouncesz) != 1) ||
+			(bouncesz < MMC_MIN_QUEUE_BOUNCESZ) ||
+			(bouncesz > MMC_MAX_QUEUE_BOUNCESZ) ||
+			(bouncesz % 512 != 0))
+		return -EINVAL;
+
+	md = mmc_blk_get(dev_to_disk(dev));
+	mmc_reinit_bounce_queue(&md->queue, md->queue.card, bouncesz);
+	mmc_blk_put(md);
+	return mmc_queue_bouncesz;
+}
+#endif
+
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
@@ -1648,6 +1680,18 @@ static int mmc_blk_probe(struct mmc_card *card)
 		if (mmc_add_disk(part_md))
 			goto out;
 	}
+
+#ifdef CONFIG_MMC_BLOCK_BOUNCE
+	md->bouncesz.show = mmc_bouncesz_show;
+	md->bouncesz.store = mmc_bouncesz_store;
+	sysfs_attr_init(&md->bouncesz.attr);
+	md->bouncesz.attr.name = "bouncesz";
+	md->bouncesz.attr.mode = S_IRUGO | S_IWUSR;
+	err = device_create_file(disk_to_dev(md->disk), &md->bouncesz);
+	if (err)
+		goto out;
+#endif
+
 	return 0;

  out:
--
1.6.4


