From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/7] mmc: core: Convert mmc_driver to device_driver
Date: Tue, 14 Oct 2014 13:45:17 +0200
Message-ID: <1413287120-10914-5-git-send-email-ulf.hansson@linaro.org>
References: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33999 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbaJNLpi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Oct 2014 07:45:38 -0400
Received: by mail-lb0-f179.google.com with SMTP id l4so8006983lbv.10
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2014 04:45:37 -0700 (PDT)
In-Reply-To: <1413287120-10914-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

The struct mmc_driver adds an extra layer on top of the struct
device_driver. That would be fine, if there were a good reason, but
that's not the case.

Let's simplify code by converting to the common struct device_driver
instead and thus also removing superfluous overhead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c    | 26 ++++++++++++++------------
 drivers/mmc/card/mmc_test.c | 18 +++++++++++-------
 drivers/mmc/core/bus.c      | 41 ++++++++---------------------------------
 include/linux/mmc/card.h    | 16 ++--------------
 4 files changed, 35 insertions(+), 66 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 67a37a7..53164e4 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2425,8 +2425,9 @@ static const struct mmc_fixup blk_fixups[] =
 	END_FIXUP
 };
 
-static int mmc_blk_probe(struct mmc_card *card)
+static int mmc_blk_probe(struct device *dev)
 {
+	struct mmc_card *card = mmc_dev_to_card(dev);
 	struct mmc_blk_data *md, *part_md;
 	char cap_str[10];
 
@@ -2481,8 +2482,9 @@ static int mmc_blk_probe(struct mmc_card *card)
 	return 0;
 }
 
-static void mmc_blk_remove(struct mmc_card *card)
+static int mmc_blk_remove(struct device *dev)
 {
+	struct mmc_card *card = mmc_dev_to_card(dev);
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	mmc_blk_remove_parts(card, md);
@@ -2495,11 +2497,14 @@ static void mmc_blk_remove(struct mmc_card *card)
 	pm_runtime_put_noidle(&card->dev);
 	mmc_blk_remove_req(md);
 	mmc_set_drvdata(card, NULL);
+
+	return 0;
 }
 
-static int _mmc_blk_suspend(struct mmc_card *card)
+static int _mmc_blk_suspend(struct device *dev)
 {
 	struct mmc_blk_data *part_md;
+	struct mmc_card *card = mmc_dev_to_card(dev);
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	if (md) {
@@ -2511,16 +2516,15 @@ static int _mmc_blk_suspend(struct mmc_card *card)
 	return 0;
 }
 
-static void mmc_blk_shutdown(struct mmc_card *card)
+static void mmc_blk_shutdown(struct device *dev)
 {
-	_mmc_blk_suspend(card);
+	_mmc_blk_suspend(dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
 static int mmc_blk_suspend(struct device *dev)
 {
-	struct mmc_card *card = mmc_dev_to_card(dev);
-	return _mmc_blk_suspend(card);
+	return _mmc_blk_suspend(dev);
 }
 
 static int mmc_blk_resume(struct device *dev)
@@ -2546,11 +2550,9 @@ static int mmc_blk_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(mmc_blk_pm_ops, mmc_blk_suspend, mmc_blk_resume);
 
-static struct mmc_driver mmc_driver = {
-	.drv		= {
-		.name	= "mmcblk",
-		.pm	= &mmc_blk_pm_ops,
-	},
+static struct device_driver mmc_driver = {
+	.name		= "mmcblk",
+	.pm		= &mmc_blk_pm_ops,
 	.probe		= mmc_blk_probe,
 	.remove		= mmc_blk_remove,
 	.shutdown	= mmc_blk_shutdown,
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 0c0fc52..b064343 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -14,6 +14,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/slab.h>
+#include <linux/device.h>
 
 #include <linux/scatterlist.h>
 #include <linux/swap.h>		/* For nr_free_buffer_pages() */
@@ -2997,8 +2998,9 @@ err:
 	return ret;
 }
 
-static int mmc_test_probe(struct mmc_card *card)
+static int mmc_test_probe(struct device *dev)
 {
+	struct mmc_card *card = mmc_dev_to_card(dev);
 	int ret;
 
 	if (!mmc_card_mmc(card) && !mmc_card_sd(card))
@@ -3013,20 +3015,22 @@ static int mmc_test_probe(struct mmc_card *card)
 	return 0;
 }
 
-static void mmc_test_remove(struct mmc_card *card)
+static int mmc_test_remove(struct device *dev)
 {
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
 	mmc_test_free_result(card);
 	mmc_test_free_dbgfs_file(card);
+
+	return 0;
 }
 
-static void mmc_test_shutdown(struct mmc_card *card)
+static void mmc_test_shutdown(struct device *dev)
 {
 }
 
-static struct mmc_driver mmc_driver = {
-	.drv		= {
-		.name	= "mmc_test",
-	},
+static struct device_driver mmc_driver = {
+	.name	= "mmc_test",
 	.probe		= mmc_test_probe,
 	.remove		= mmc_test_remove,
 	.shutdown	= mmc_test_shutdown,
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 2f37528..5ca562c 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -25,8 +25,6 @@
 #include "sdio_cis.h"
 #include "bus.h"
 
-#define to_mmc_driver(d)	container_of(d, struct mmc_driver, drv)
-
 static ssize_t type_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
@@ -106,33 +104,14 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return retval;
 }
 
-static int mmc_bus_probe(struct device *dev)
-{
-	struct mmc_driver *drv = to_mmc_driver(dev->driver);
-	struct mmc_card *card = mmc_dev_to_card(dev);
-
-	return drv->probe(card);
-}
-
-static int mmc_bus_remove(struct device *dev)
-{
-	struct mmc_driver *drv = to_mmc_driver(dev->driver);
-	struct mmc_card *card = mmc_dev_to_card(dev);
-
-	drv->remove(card);
-
-	return 0;
-}
-
 static void mmc_bus_shutdown(struct device *dev)
 {
-	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
 	struct mmc_host *host = card->host;
 	int ret;
 
-	if (dev->driver && drv->shutdown)
-		drv->shutdown(card);
+	if (dev->driver && dev->driver->shutdown)
+		dev->driver->shutdown(dev);
 
 	if (host->bus_ops->shutdown) {
 		ret = host->bus_ops->shutdown(host);
@@ -201,8 +180,6 @@ static struct bus_type mmc_bus_type = {
 	.dev_groups	= mmc_dev_groups,
 	.match		= mmc_bus_match,
 	.uevent		= mmc_bus_uevent,
-	.probe		= mmc_bus_probe,
-	.remove		= mmc_bus_remove,
 	.shutdown	= mmc_bus_shutdown,
 	.pm		= &mmc_bus_pm_ops,
 };
@@ -221,24 +198,22 @@ void mmc_unregister_bus(void)
  *	mmc_register_driver - register a media driver
  *	@drv: MMC media driver
  */
-int mmc_register_driver(struct mmc_driver *drv)
+int mmc_register_driver(struct device_driver *drv)
 {
-	drv->drv.bus = &mmc_bus_type;
-	return driver_register(&drv->drv);
+	drv->bus = &mmc_bus_type;
+	return driver_register(drv);
 }
-
 EXPORT_SYMBOL(mmc_register_driver);
 
 /**
  *	mmc_unregister_driver - unregister a media driver
  *	@drv: MMC media driver
  */
-void mmc_unregister_driver(struct mmc_driver *drv)
+void mmc_unregister_driver(struct device_driver *drv)
 {
-	drv->drv.bus = &mmc_bus_type;
-	driver_unregister(&drv->drv);
+	drv->bus = &mmc_bus_type;
+	driver_unregister(drv);
 }
-
 EXPORT_SYMBOL(mmc_unregister_driver);
 
 static void mmc_release_card(struct device *dev)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index b0692d2..cf54afe 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -513,20 +513,8 @@ static inline int mmc_card_broken_irq_polling(const struct mmc_card *c)
 #define mmc_get_drvdata(c)	dev_get_drvdata(&(c)->dev)
 #define mmc_set_drvdata(c,d)	dev_set_drvdata(&(c)->dev, d)
 
-/*
- * MMC device driver (e.g., Flash card, I/O card...)
- */
-struct mmc_driver {
-	struct device_driver drv;
-	int (*probe)(struct mmc_card *);
-	void (*remove)(struct mmc_card *);
-	int (*suspend)(struct mmc_card *);
-	int (*resume)(struct mmc_card *);
-	void (*shutdown)(struct mmc_card *);
-};
-
-extern int mmc_register_driver(struct mmc_driver *);
-extern void mmc_unregister_driver(struct mmc_driver *);
+extern int mmc_register_driver(struct device_driver *);
+extern void mmc_unregister_driver(struct device_driver *);
 
 extern void mmc_fixup_device(struct mmc_card *card,
 			     const struct mmc_fixup *table);
-- 
1.9.1

