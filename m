From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 05/10 v3] mmc: convert slot functions to managed allocation
Date: Fri, 25 May 2012 17:16:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251359200.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251321020.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56277 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab2EYPQJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:16:09 -0400
In-Reply-To: <Pine.LNX.4.64.1205251321020.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

This prepares for the addition of further slot functions.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/core/host.c      |    2 +
 drivers/mmc/core/slot-gpio.c |   49 +++++++++++++++++++++++++++++++----------
 include/linux/mmc/host.h     |    3 ++
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b8c5290..74cf29a5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -32,6 +32,7 @@
 static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	mutex_destroy(&host->slot.lock);
 	kfree(host);
 }
 
@@ -327,6 +328,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	mmc_host_clk_init(host);
 
+	mutex_init(&host->slot.lock);
 	host->slot.cd_irq = -EINVAL;
 
 	spin_lock_init(&host->lock);
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index d70b790..f14c8a1 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -29,6 +29,33 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int mmc_gpio_alloc(struct mmc_host *host)
+{
+	size_t len = strlen(dev_name(host->parent)) + 4;
+	struct mmc_gpio *ctx;
+
+	mutex_lock(&host->slot.lock);
+
+	ctx = host->slot.handler_priv;
+	if (!ctx) {
+		/*
+		 * devm_kzalloc() can be called after device_initialize(), even
+		 * before device_add(), i.e., between mmc_alloc_host() and
+		 * mmc_add_host()
+		 */
+		ctx = devm_kzalloc(&host->class_dev, sizeof(*ctx) + len,
+				   GFP_KERNEL);
+		if (ctx) {
+			snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
+			host->slot.handler_priv = ctx;
+		}
+	}
+
+	mutex_unlock(&host->slot.lock);
+
+	return ctx ? 0 : -ENOMEM;
+}
+
 int mmc_gpio_get_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
@@ -43,20 +70,24 @@ EXPORT_SYMBOL(mmc_gpio_get_cd);
 
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 {
-	size_t len = strlen(dev_name(host->parent)) + 4;
 	struct mmc_gpio *ctx;
 	int irq = gpio_to_irq(gpio);
 	int ret;
 
-	ctx = kmalloc(sizeof(*ctx) + len, GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ret = mmc_gpio_alloc(host);
+	if (ret < 0)
+		return ret;
 
-	snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
+	ctx = host->slot.handler_priv;
 
 	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->cd_label);
 	if (ret < 0)
-		goto egpioreq;
+		/*
+		 * don't bother freeing gpio. It might still get used by other
+		 * slot functions, in any case it will be freed, when the device
+		 * is destroyed.
+		 */
+		return ret;
 
 	/*
 	 * Even if gpio_to_irq() returns a valid IRQ number, the platform might
@@ -83,10 +114,6 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 	host->slot.handler_priv = ctx;
 
 	return 0;
-
-egpioreq:
-	kfree(ctx);
-	return ret;
 }
 EXPORT_SYMBOL(mmc_gpio_request_cd);
 
@@ -102,7 +129,5 @@ void mmc_gpio_free_cd(struct mmc_host *host)
 		host->slot.cd_irq = -EINVAL;
 	}
 	gpio_free(ctx->cd_gpio);
-	host->slot.handler_priv = NULL;
-	kfree(ctx);
 }
 EXPORT_SYMBOL(mmc_gpio_free_cd);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1b3a917..3f3c8c9 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -11,6 +11,7 @@
 #define LINUX_MMC_HOST_H
 
 #include <linux/leds.h>
+#include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/fault-inject.h>
@@ -154,6 +155,7 @@ struct mmc_async_req {
  * struct mmc_slot - MMC slot functions
  *
  * @cd_irq:		MMC/SD-card slot hotplug detection IRQ or -EINVAL
+ * @lock:		protect the @handler_priv pointer
  * @handler_priv:	MMC/SD-card slot context
  *
  * Some MMC/SD host controllers implement slot-functions like card and
@@ -163,6 +165,7 @@ struct mmc_async_req {
  */
 struct mmc_slot {
 	int cd_irq;
+	struct mutex lock;
 	void *handler_priv;
 };
 
-- 
1.7.2.5

