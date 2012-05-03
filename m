From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 22/29] mmc: add WP pin handler to slot functions
Date: Thu,  3 May 2012 17:05:51 +0200
Message-ID: <1336057558-11031-23-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Card Write-Protect pin is often implemented, using a GPIO, which makes it
simple to provide a generic handler for it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/core/slot-gpio.c  |   51 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/slot-gpio.h |    4 +++
 2 files changed, 54 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 7e16a50..eb04c06 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -18,7 +18,9 @@
 #include <linux/slab.h>
 
 struct mmc_gpio {
+	unsigned int ro_gpio;
 	unsigned int cd_gpio;
+	char *ro_label;
 	char cd_label[0];
 };
 
@@ -43,10 +45,12 @@ static int mmc_gpio_alloc(struct mmc_host *host)
 		 * before device_add(), i.e., between mmc_alloc_host() and
 		 * mmc_add_host()
 		 */
-		ctx = devm_kzalloc(&host->class_dev, sizeof(*ctx) + len,
+		ctx = devm_kzalloc(&host->class_dev, sizeof(*ctx) + 2 * len,
 				   GFP_KERNEL);
 		if (ctx) {
+			ctx->ro_label = ctx->cd_label + len;
 			snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
+			snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
 			host->slot.handler_priv = ctx;
 		}
 	}
@@ -56,6 +60,18 @@ static int mmc_gpio_alloc(struct mmc_host *host)
 	return ctx ? 0 : -ENOMEM;
 }
 
+int mmc_gpio_get_ro(struct mmc_host *host)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	if (!ctx || !gpio_is_valid(ctx->ro_gpio))
+		return -ENOSYS;
+
+	return !gpio_get_value_cansleep(ctx->ro_gpio) ^
+		!(host->caps2 & MMC_CAP2_INVERTED_RO);
+}
+EXPORT_SYMBOL(mmc_gpio_get_ro);
+
 int mmc_gpio_get_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
@@ -68,6 +84,28 @@ int mmc_gpio_get_cd(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_gpio_get_cd);
 
+int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
+{
+	struct mmc_gpio *ctx;
+	int ret;
+
+	if (!gpio_is_valid(gpio))
+		return -EINVAL;
+
+	ret = mmc_gpio_alloc(host);
+	if (ret < 0)
+		return ret;
+
+	ctx = host->slot.handler_priv;
+
+	ret = gpio_request_one(gpio, GPIOF_DIR_IN, ctx->ro_label);
+	if (ret < 0)
+		return ret;;
+
+	return 0;
+}
+EXPORT_SYMBOL(mmc_gpio_request_ro);
+
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 {
 	struct mmc_gpio *ctx;
@@ -110,6 +148,17 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 }
 EXPORT_SYMBOL(mmc_gpio_request_cd);
 
+void mmc_gpio_free_ro(struct mmc_host *host)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	if (!ctx || !gpio_is_valid(ctx->ro_gpio))
+		return;
+
+	gpio_free(ctx->ro_gpio);
+}
+EXPORT_SYMBOL(mmc_gpio_free_ro);
+
 void mmc_gpio_free_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 1a977d7..7d88d27 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -13,6 +13,10 @@
 
 struct mmc_host;
 
+int mmc_gpio_get_ro(struct mmc_host *host);
+int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio);
+void mmc_gpio_free_ro(struct mmc_host *host);
+
 int mmc_gpio_get_cd(struct mmc_host *host);
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio);
 void mmc_gpio_free_cd(struct mmc_host *host);
-- 
1.7.2.5

