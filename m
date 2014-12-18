From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/7] mmc: slot-gpio: Rework how to handle allocation of slot-gpio data
Date: Thu, 18 Dec 2014 15:44:36 +0100
Message-ID: <1418913876-13937-8-git-send-email-ulf.hansson@linaro.org>
References: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:55778 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbaLROo5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 09:44:57 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so2019634wiv.6
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 06:44:56 -0800 (PST)
In-Reply-To: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

By moving the allocation of the slot-gpio data into mmc_alloc_host(),
we can remove the slot-gpio internal calls to mmc_gpio_alloc().

This means mmc_gpio_alloc() has now only one caller left, which
consequence allow us to simplify and remove some of the slot-gpio code.

Additionally, this makes the slot-gpio mutex redundant, so let's remove
it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/host.c      | 20 +++++++-------
 drivers/mmc/core/slot-gpio.c | 62 ++++++++++----------------------------------
 include/linux/mmc/host.h     |  2 --
 3 files changed, 23 insertions(+), 61 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index fcb7f06..0763644 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -29,6 +29,7 @@
 
 #include "core.h"
 #include "host.h"
+#include "slot-gpio.h"
 
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
@@ -38,7 +39,6 @@ static DEFINE_SPINLOCK(mmc_host_lock);
 static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
-	mutex_destroy(&host->slot.lock);
 	spin_lock(&mmc_host_lock);
 	idr_remove(&mmc_host_idr, host->index);
 	spin_unlock(&mmc_host_lock);
@@ -478,8 +478,10 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 		host->index = err;
 	spin_unlock(&mmc_host_lock);
 	idr_preload_end();
-	if (err < 0)
-		goto free;
+	if (err < 0) {
+		kfree(host);
+		return NULL;
+	}
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
 
@@ -488,10 +490,12 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
 
-	mmc_host_clk_init(host);
+	if (mmc_gpio_alloc(host)) {
+		put_device(&host->class_dev);
+		return NULL;
+	}
 
-	mutex_init(&host->slot.lock);
-	host->slot.cd_irq = -EINVAL;
+	mmc_host_clk_init(host);
 
 	spin_lock_init(&host->lock);
 	init_waitqueue_head(&host->wq);
@@ -512,10 +516,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->max_blk_count = PAGE_CACHE_SIZE / 512;
 
 	return host;
-
-free:
-	kfree(host);
-	return NULL;
 }
 
 EXPORT_SYMBOL(mmc_alloc_host);
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index ec918c2..1a3edbd 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -43,29 +43,17 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
 int mmc_gpio_alloc(struct mmc_host *host)
 {
 	size_t len = strlen(dev_name(host->parent)) + 4;
-	struct mmc_gpio *ctx;
-
-	mutex_lock(&host->slot.lock);
-
-	ctx = host->slot.handler_priv;
-	if (!ctx) {
-		/*
-		 * devm_kzalloc() can be called after device_initialize(), even
-		 * before device_add(), i.e., between mmc_alloc_host() and
-		 * mmc_add_host()
-		 */
-		ctx = devm_kzalloc(host->parent, sizeof(*ctx) + 2 * len,
-				   GFP_KERNEL);
-		if (ctx) {
-			ctx->ro_label = ctx->cd_label + len;
-			snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
-			snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
-			host->slot.handler_priv = ctx;
-		}
+	struct mmc_gpio *ctx = devm_kzalloc(host->parent,
+				sizeof(*ctx) + 2 * len,	GFP_KERNEL);
+
+	if (ctx) {
+		ctx->ro_label = ctx->cd_label + len;
+		snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
+		snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
+		host->slot.handler_priv = ctx;
+		host->slot.cd_irq = -EINVAL;
 	}
 
-	mutex_unlock(&host->slot.lock);
-
 	return ctx ? 0 : -ENOMEM;
 }
 
@@ -111,18 +99,12 @@ EXPORT_SYMBOL(mmc_gpio_get_cd);
  */
 int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
 {
-	struct mmc_gpio *ctx;
+	struct mmc_gpio *ctx = host->slot.handler_priv;
 	int ret;
 
 	if (!gpio_is_valid(gpio))
 		return -EINVAL;
 
-	ret = mmc_gpio_alloc(host);
-	if (ret < 0)
-		return ret;
-
-	ctx = host->slot.handler_priv;
-
 	ret = devm_gpio_request_one(host->parent, gpio, GPIOF_DIR_IN,
 				    ctx->ro_label);
 	if (ret < 0)
@@ -187,15 +169,9 @@ EXPORT_SYMBOL(mmc_gpiod_request_cd_irq);
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
 			unsigned int debounce)
 {
-	struct mmc_gpio *ctx;
+	struct mmc_gpio *ctx = host->slot.handler_priv;
 	int ret;
 
-	ret = mmc_gpio_alloc(host);
-	if (ret < 0)
-		return ret;
-
-	ctx = host->slot.handler_priv;
-
 	ret = devm_gpio_request_one(host->parent, gpio, GPIOF_DIR_IN,
 				    ctx->cd_label);
 	if (ret < 0)
@@ -239,16 +215,10 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, bool override_active_level,
 			 unsigned int debounce, bool *gpio_invert)
 {
-	struct mmc_gpio *ctx;
+	struct mmc_gpio *ctx = host->slot.handler_priv;
 	struct gpio_desc *desc;
 	int ret;
 
-	ret = mmc_gpio_alloc(host);
-	if (ret < 0)
-		return ret;
-
-	ctx = host->slot.handler_priv;
-
 	if (!con_id)
 		con_id = ctx->cd_label;
 
@@ -291,16 +261,10 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, bool override_active_level,
 			 unsigned int debounce, bool *gpio_invert)
 {
-	struct mmc_gpio *ctx;
+	struct mmc_gpio *ctx = host->slot.handler_priv;
 	struct gpio_desc *desc;
 	int ret;
 
-	ret = mmc_gpio_alloc(host);
-	if (ret < 0)
-		return ret;
-
-	ctx = host->slot.handler_priv;
-
 	if (!con_id)
 		con_id = ctx->ro_label;
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9f32270..b6bf718 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -166,7 +166,6 @@ struct mmc_async_req {
  * struct mmc_slot - MMC slot functions
  *
  * @cd_irq:		MMC/SD-card slot hotplug detection IRQ or -EINVAL
- * @lock:		protect the @handler_priv pointer
  * @handler_priv:	MMC/SD-card slot context
  *
  * Some MMC/SD host controllers implement slot-functions like card and
@@ -176,7 +175,6 @@ struct mmc_async_req {
  */
 struct mmc_slot {
 	int cd_irq;
-	struct mutex lock;
 	void *handler_priv;
 };
 
-- 
1.9.1

