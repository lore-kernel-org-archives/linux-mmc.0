From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 6/9 v4] mmc: add WP pin handler to slot functions
Date: Fri, 22 Jun 2012 15:23:19 +0200
Message-ID: <1340371402-4801-7-git-send-email-g.liakhovetski@gmx.de>
References: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Card Write-Protect pin is often implemented, using a GPIO, which makes it
simple to provide a generic handler for it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v4:

1. gpio variables are now signed
2. take care to mark gpio variables as invalid in hotplug context
3. MMC_CAP2_*_ACTIVE_HIGH inverted compared to v3

 drivers/mmc/core/slot-gpio.c  |   52 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/mmc/slot-gpio.h |    4 +++
 2 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 41689da..0582429 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -18,7 +18,9 @@
 #include <linux/slab.h>
 
 struct mmc_gpio {
+	int ro_gpio;
 	int cd_gpio;
+	char *ro_label;
 	char cd_label[0];
 };
 
@@ -43,11 +45,14 @@ static int mmc_gpio_alloc(struct mmc_host *host)
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
 			ctx->cd_gpio = -EINVAL;
+			ctx->ro_gpio = -EINVAL;
 			host->slot.handler_priv = ctx;
 		}
 	}
@@ -57,6 +62,18 @@ static int mmc_gpio_alloc(struct mmc_host *host)
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
+		!!(host->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
+}
+EXPORT_SYMBOL(mmc_gpio_get_ro);
+
 int mmc_gpio_get_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
@@ -69,6 +86,24 @@ int mmc_gpio_get_cd(struct mmc_host *host)
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
+	return gpio_request_one(gpio, GPIOF_DIR_IN, ctx->ro_label);
+}
+EXPORT_SYMBOL(mmc_gpio_request_ro);
+
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 {
 	struct mmc_gpio *ctx;
@@ -117,6 +152,21 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 }
 EXPORT_SYMBOL(mmc_gpio_request_cd);
 
+void mmc_gpio_free_ro(struct mmc_host *host)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+	int gpio;
+
+	if (!ctx || !gpio_is_valid(ctx->ro_gpio))
+		return;
+
+	gpio = ctx->ro_gpio;
+	ctx->ro_gpio = -EINVAL;
+
+	gpio_free(gpio);
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

