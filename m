From: Sebastian Rasmussen <sebras@gmail.com>
Subject: [PATCH 2/3] MMC: Fix checkpatch warnings
Date: Sat, 18 Jun 2011 19:50:32 +0200
Message-ID: <1308419432-18273-1-git-send-email-sebras@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:53545 "EHLO mail.df.lth.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795Ab1FRRuf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2011 13:50:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sebastian Rasmussen <sebras@gmail.com>

Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
---
 drivers/mmc/card/block.c     |   10 +++++-----
 drivers/mmc/card/queue.c     |   15 +++++----------
 drivers/mmc/card/sdio_uart.c |    2 +-
 drivers/mmc/core/bus.c       |    5 +----
 drivers/mmc/core/bus.h       |    2 +-
 drivers/mmc/core/core.c      |    7 -------
 drivers/mmc/core/debugfs.c   |    2 +-
 drivers/mmc/core/host.c      |    4 ----
 drivers/mmc/core/sd_ops.c    |    1 -
 drivers/mmc/core/sdio_bus.c  |    9 ++++-----
 drivers/mmc/core/sdio_irq.c  |   10 +++++-----
 11 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1c7049a..48cf063 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <linux/capability.h>
 #include <linux/compat.h>
+#include <linux/uaccess.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -42,7 +43,6 @@
 #include <linux/mmc/sd.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
 
 #include "queue.h"
 
@@ -169,11 +169,11 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
 	int ret;
 	char *end;
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
-	unsigned long set = simple_strtoul(buf, &end, 0);
-	if (end == buf) {
-		ret = -EINVAL;
+	unsigned long set
+
+	ret = kstrtoul(buf, 10, &set)
+	if (ret < 0)
 		goto out;
-	}
 
 	set_disk_ro(dev_to_disk(dev), set || md->read_only);
 	ret = count;
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 185314c..2c10e61 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -219,15 +219,12 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock
 
 	return 0;
  free_bounce_sg:
-	if (mq->bounce_sg)
-		kfree(mq->bounce_sg);
+	kfree(mq->bounce_sg);
 	mq->bounce_sg = NULL;
  cleanup_queue:
-	if (mq->sg)
-		kfree(mq->sg);
+	kfree(mq->sg);
 	mq->sg = NULL;
-	if (mq->bounce_buf)
-		kfree(mq->bounce_buf);
+	kfree(mq->bounce_buf);
 	mq->bounce_buf = NULL;
 	blk_cleanup_queue(mq->queue);
 	return ret;
@@ -250,15 +247,13 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	blk_start_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
-	if (mq->bounce_sg)
-		kfree(mq->bounce_sg);
+	kfree(mq->bounce_sg);
 	mq->bounce_sg = NULL;
 
 	kfree(mq->sg);
 	mq->sg = NULL;
 
-	if (mq->bounce_buf)
-		kfree(mq->bounce_buf);
+	kfree(mq->bounce_buf);
 	mq->bounce_buf = NULL;
 
 	mq->card = NULL;
diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
index c8c9edb..c7f8229 100644
--- a/drivers/mmc/card/sdio_uart.c
+++ b/drivers/mmc/card/sdio_uart.c
@@ -1102,7 +1102,7 @@ static int sdio_uart_probe(struct sdio_func *func,
 		}
 		if (!tpl) {
 			printk(KERN_WARNING
-       "%s: can't find tuple 0x91 subtuple 0 (SUBTPL_SIOREG) for GPS class\n",
+	"%s: can't find tuple 0x91 subtuple 0 (SUBTPL_SIOREG) for GPS class\n",
 			       sdio_func_id(func));
 			kfree(port);
 			return -EINVAL;
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 393d817..a7245b7 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -208,7 +208,6 @@ int mmc_register_driver(struct mmc_driver *drv)
 	drv->drv.bus = &mmc_bus_type;
 	return driver_register(&drv->drv);
 }
-
 EXPORT_SYMBOL(mmc_register_driver);
 
 /**
@@ -220,7 +219,6 @@ void mmc_unregister_driver(struct mmc_driver *drv)
 	drv->drv.bus = &mmc_bus_type;
 	driver_unregister(&drv->drv);
 }
-
 EXPORT_SYMBOL(mmc_unregister_driver);
 
 static void mmc_release_card(struct device *dev)
@@ -229,8 +227,7 @@ static void mmc_release_card(struct device *dev)
 
 	sdio_free_common_cis(card);
 
-	if (card->info)
-		kfree(card->info);
+	kfree(card->info);
 
 	kfree(card);
 }
diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
index 00a1971..8b4d1cc 100644
--- a/drivers/mmc/core/bus.h
+++ b/drivers/mmc/core/bus.h
@@ -12,7 +12,7 @@
 #define _MMC_CORE_BUS_H
 
 #define MMC_DEV_ATTR(name, fmt, args...)					\
-static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *attr, char *buf)	\
+static ssize_t mmc_##name##_show(struct device *dev, struct device_attribute *attr, char *buf)	\
 {										\
 	struct mmc_card *card = mmc_dev_to_card(dev);				\
 	return sprintf(buf, fmt, args);						\
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 25a9aeb..b03ae56 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -135,7 +135,6 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 		mmc_host_clk_gate(host);
 	}
 }
-
 EXPORT_SYMBOL(mmc_request_done);
 
 static void
@@ -221,7 +220,6 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 
 	wait_for_completion(&complete);
 }
-
 EXPORT_SYMBOL(mmc_wait_for_req);
 
 /**
@@ -250,7 +248,6 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries
 
 	return cmd->error;
 }
-
 EXPORT_SYMBOL(mmc_wait_for_cmd);
 
 /**
@@ -499,7 +496,6 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
 		mmc_host_enable(host);
 	return stop;
 }
-
 EXPORT_SYMBOL(__mmc_claim_host);
 
 /**
@@ -607,7 +603,6 @@ void mmc_release_host(struct mmc_host *host)
 
 	mmc_do_release_host(host);
 }
-
 EXPORT_SYMBOL(mmc_release_host);
 
 /*
@@ -1164,7 +1159,6 @@ void mmc_detect_change(struct mmc_host *host, unsigned long delay)
 
 	mmc_schedule_delayed_work(&host->detect, delay);
 }
-
 EXPORT_SYMBOL(mmc_detect_change);
 
 void mmc_init_erase(struct mmc_card *card)
@@ -1781,7 +1775,6 @@ int mmc_suspend_host(struct mmc_host *host)
 
 	return err;
 }
-
 EXPORT_SYMBOL(mmc_suspend_host);
 
 /**
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 998797e..7826f23 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -22,7 +22,7 @@
 /* The debugfs functions are optimized away when CONFIG_DEBUG_FS isn't set. */
 static int mmc_ios_show(struct seq_file *s, void *data)
 {
-	static const char *vdd_str[] = {
+	static const char * const vdd_str[] = {
 		[8]	= "2.0",
 		[9]	= "2.1",
 		[10]	= "2.2",
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b29d3e8..9e46ca3 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -307,7 +307,6 @@ free:
 	kfree(host);
 	return NULL;
 }
-
 EXPORT_SYMBOL(mmc_alloc_host);
 
 /**
@@ -340,7 +339,6 @@ int mmc_add_host(struct mmc_host *host)
 
 	return 0;
 }
-
 EXPORT_SYMBOL(mmc_add_host);
 
 /**
@@ -366,7 +364,6 @@ void mmc_remove_host(struct mmc_host *host)
 
 	mmc_host_clk_exit(host);
 }
-
 EXPORT_SYMBOL(mmc_remove_host);
 
 /**
@@ -383,5 +380,4 @@ void mmc_free_host(struct mmc_host *host)
 
 	put_device(&host->class_dev);
 }
-
 EXPORT_SYMBOL(mmc_free_host);
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 6b0dc37..3f83b9c 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -114,7 +114,6 @@ int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
 
 	return err;
 }
-
 EXPORT_SYMBOL(mmc_wait_for_app_cmd);
 
 int mmc_app_set_bus_width(struct mmc_card *card, int width)
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index e43e9d0..b1a4484 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -30,8 +30,8 @@ field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
 {									\
 	struct sdio_func *func;						\
 									\
-	func = dev_to_sdio_func (dev);					\
-	return sprintf (buf, format_string, func->field);		\
+	func = dev_to_sdio_func(dev);					\
+	return sprintf(buf, format_string, func->field);		\
 }
 
 sdio_config_attr(class, "0x%02x\n");
@@ -40,7 +40,7 @@ sdio_config_attr(device, "0x%04x\n");
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct sdio_func *func = dev_to_sdio_func (dev);
+	struct sdio_func *func = dev_to_sdio_func(dev);
 
 	return sprintf(buf, "sdio:c%02Xv%04Xd%04X\n",
 			func->class, func->vendor, func->device);
@@ -262,8 +262,7 @@ static void sdio_release_func(struct device *dev)
 
 	sdio_free_func_cis(func);
 
-	if (func->info)
-		kfree(func->info);
+	kfree(func->info);
 
 	kfree(func);
 }
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 03ead02..45bd33c 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -205,12 +205,12 @@ static void sdio_single_irq_set(struct mmc_card *card)
 
 	card->sdio_single_irq = NULL;
 	if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
-	    card->host->sdio_irqs == 1)
+	     card->host->sdio_irqs == 1)
 		for (i = 0; i < card->sdio_funcs; i++) {
-		       func = card->sdio_func[i];
-		       if (func && func->irq_handler) {
-			       card->sdio_single_irq = func;
-			       break;
+			func = card->sdio_func[i];
+			if (func && func->irq_handler) {
+				card->sdio_single_irq = func;
+				break;
 		       }
 	       }
 }
-- 
1.7.4.1

