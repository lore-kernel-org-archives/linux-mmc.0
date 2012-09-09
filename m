From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: slot-gpio: Add support for power gpios
Date: Sat, 08 Sep 2012 23:01:35 -0400
Message-ID: <87oblfzypc.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39890 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab2IIDBj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 8 Sep 2012 23:01:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

A power gpio is a sideband output gpio that controls card power.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
Hi Guennadi, what do you think of this patch?  I'm hoping to use it
first to de-duplicate power-gpio handling between sdhci-pxa and
sdhci-tegra, and then to create a generic DT parser for MMC.

The zero-length array trick might be becoming unmaintainable as we add
more labels to the struct like this.  Do you think we should keep it
as-is, or change to individual allocations?  Thanks!

 drivers/mmc/core/slot-gpio.c  | 65 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/host.h      |  1 +
 include/linux/mmc/slot-gpio.h |  3 ++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 4f9b366..6c785dd 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -20,6 +20,8 @@
 struct mmc_gpio {
 	int ro_gpio;
 	int cd_gpio;
+	int pwr_gpio;
+	char *pwr_label;
 	char *ro_label;
 	char cd_label[0];
 };
@@ -33,6 +35,9 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
 
 static int mmc_gpio_alloc(struct mmc_host *host)
 {
+	/* The "+ 4" is to leave room for a space, two-char identifier
+	 * and \0 after each label in the mmc_gpio struct.
+	 */
 	size_t len = strlen(dev_name(host->parent)) + 4;
 	struct mmc_gpio *ctx;
 
@@ -45,14 +50,19 @@ static int mmc_gpio_alloc(struct mmc_host *host)
 		 * before device_add(), i.e., between mmc_alloc_host() and
 		 * mmc_add_host()
 		 */
-		ctx = devm_kzalloc(&host->class_dev, sizeof(*ctx) + 2 * len,
+
+		/* len*3 because we have three strings to allocate on the end. */
+		ctx = devm_kzalloc(&host->class_dev, sizeof(*ctx) + len*3,
 				   GFP_KERNEL);
 		if (ctx) {
 			ctx->ro_label = ctx->cd_label + len;
+			ctx->pwr_label = ctx->cd_label + len*2;
 			snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
 			snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
+			snprintf(ctx->pwr_label, len, "%s pw", dev_name(host->parent));
 			ctx->cd_gpio = -EINVAL;
 			ctx->ro_gpio = -EINVAL;
+			ctx->pwr_gpio = -EINVAL;
 			host->slot.handler_priv = ctx;
 		}
 	}
@@ -74,6 +84,18 @@ int mmc_gpio_get_ro(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_gpio_get_ro);
 
+int mmc_gpio_get_pwr(struct mmc_host *host)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	if (!ctx || !gpio_is_valid(ctx->pwr_gpio))
+		return -ENOSYS;
+
+	return !gpio_get_value_cansleep(ctx->pwr_gpio) ^
+		!!(host->caps2 & MMC_CAP2_PWR_ACTIVE_HIGH);
+}
+EXPORT_SYMBOL(mmc_gpio_get_pwr);
+
 int mmc_gpio_get_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
@@ -105,6 +127,32 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
 }
 EXPORT_SYMBOL(mmc_gpio_request_ro);
 
+int mmc_gpio_request_pwr(struct mmc_host *host, unsigned int gpio)
+{
+	struct mmc_gpio *ctx;
+	int ret;
+	unsigned long gpio_flags;
+
+	if (!gpio_is_valid(gpio))
+		return -EINVAL;
+
+	ret = mmc_gpio_alloc(host);
+	if (ret < 0)
+		return ret;
+
+	ctx = host->slot.handler_priv;
+	ctx->pwr_gpio = gpio;
+
+	gpio_flags = GPIOF_DIR_OUT;
+	if (host->caps2 & MMC_CAP2_PWR_ACTIVE_HIGH)
+		gpio_flags |= GPIOF_INIT_HIGH;
+	else
+		gpio_flags |= GPIOF_INIT_LOW;
+
+	return gpio_request_one(gpio, gpio_flags, ctx->pwr_label);
+}
+EXPORT_SYMBOL(mmc_gpio_request_pwr);
+
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 {
 	struct mmc_gpio *ctx;
@@ -168,6 +216,21 @@ void mmc_gpio_free_ro(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_gpio_free_ro);
 
+void mmc_gpio_free_pwr(struct mmc_host *host)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+	int gpio;
+
+	if (!ctx || !gpio_is_valid(ctx->pwr_gpio))
+		return;
+
+	gpio = ctx->pwr_gpio;
+	ctx->pwr_gpio = -EINVAL;
+
+	gpio_free(gpio);
+}
+EXPORT_SYMBOL(mmc_gpio_free_pwr);
+
 void mmc_gpio_free_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d5d9bd4..5a00cc1 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -257,6 +257,7 @@ struct mmc_host {
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
+#define MMC_CAP2_PWR_ACTIVE_HIGH (1 << 12)	/* Card power signal active high */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 7d88d27..d083dfa 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -21,4 +21,7 @@ int mmc_gpio_get_cd(struct mmc_host *host);
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio);
 void mmc_gpio_free_cd(struct mmc_host *host);
 
+int mmc_gpio_get_pwr(struct mmc_host *host);
+int mmc_gpio_request_pwr(struct mmc_host *host, unsigned int gpio);
+void mmc_gpio_free_pwr(struct mmc_host *host);
 #endif
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
