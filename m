From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: block: Fix bug when removing RPMB chardev
Date: Mon,  2 Oct 2017 13:59:18 +0200
Message-ID: <20171002115918.11035-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:44669 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdJBL7Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 07:59:25 -0400
Received: by mail-lf0-f52.google.com with SMTP id l196so5756262lfl.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2017 04:59:25 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

I forgot to account for the fact that the device core holds a
reference to a device added with device_initialize() that need
to be released with a corresponding put_device() to reach a 0
refcount at the end of the lifecycle.

This led to a NULL pointer reference when freeing the device
when e.g. unbidning the host device in sysfs.

Fix this and use the device .release() callback to free the
IDA and free:ing the memory used by the RPMB device.

Before this patch:

/sys/bus/amba/drivers/mmci-pl18x$ echo 80114000.sdi4_per2 > unbind
[   29.797332] mmc3: card 0001 removed
[   29.810791] Unable to handle kernel NULL pointer dereference at
               virtual address 00000050
[   29.818878] pgd = de70c000
[   29.821624] [00000050] *pgd=1e70a831, *pte=00000000, *ppte=00000000
[   29.827911] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[   29.833282] Modules linked in:
[   29.836334] CPU: 1 PID: 154 Comm: sh Not tainted
               4.14.0-rc3-00039-g83318e309566-dirty #736
[   29.844604] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
[   29.851562] task: de572700 task.stack: de742000
[   29.856079] PC is at kernfs_find_ns+0x8/0x100
[   29.860443] LR is at kernfs_find_and_get_ns+0x30/0x48

After this patch:

/sys/bus/amba/drivers/mmci-pl18x$ echo 80005000.sdi4_per2 > unbind
[   20.623382] mmc3: card 0001 removed
[   20.627288] mmc_rpmb mmcblk3rpmb: removed

Fixes: 0ab0c7c0e65a ("mmc: block: Convert RPMB to a character device")
Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/block.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c29dbcec7c61..2033a71bacc3 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2329,6 +2329,14 @@ static const struct file_operations mmc_rpmb_fileops = {
 #endif
 };
 
+static void mmc_blk_rpmb_device_release(struct device *dev)
+{
+	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
+
+	dev_info(dev, "removed\n");
+	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
+	kfree(rpmb);
+}
 
 static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 				   struct mmc_blk_data *md,
@@ -2371,6 +2379,8 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 		goto out_remove_ida;
 	}
 
+	/* From this point, the .release() function cleans up the device */
+	rpmb->dev.release = mmc_blk_rpmb_device_release;
 	list_add(&rpmb->node, &md->rpmbs);
 
 	string_get_size((u64)size, 512, STRING_UNITS_2,
@@ -2384,17 +2394,22 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 	return 0;
 
 out_remove_ida:
+	put_device(&rpmb->dev);
 	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
 	kfree(rpmb);
 	return ret;
 }
 
 static void mmc_blk_remove_rpmb_part(struct mmc_rpmb_data *rpmb)
+
 {
 	cdev_device_del(&rpmb->chrdev, &rpmb->dev);
-	device_del(&rpmb->dev);
-	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
-	kfree(rpmb);
+	/*
+	 * Unless something is holding a reference to the device, this
+	 * drops the last reference and triggers the device to cleanup
+	 * and calls the .remove() callback.
+	 */
+	put_device(&rpmb->dev);
 }
 
 /* MMC Physical partitions consist of two boot partitions and
-- 
2.13.5

