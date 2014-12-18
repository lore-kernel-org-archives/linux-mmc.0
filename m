From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/7] mmc: slot-gpio: Remove option to explicitly free requested CD/WP GPIOs
Date: Thu, 18 Dec 2014 15:44:32 +0100
Message-ID: <1418913876-13937-4-git-send-email-ulf.hansson@linaro.org>
References: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:40588 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbaLROou (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 09:44:50 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so2005712wib.10
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 06:44:49 -0800 (PST)
In-Reply-To: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

The slot-gpio uses the devm*_ managed functions. Still it provide APIs
to explicitly free requested CD/WP GPIOs, but these API isn't being
used.

Therefore let's simplify slot-gpio by removing these unused APIs. If it
later turns out we need some of them, we can always consider to restore
the code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/slot-gpio.c  | 92 ++-----------------------------------------
 include/linux/mmc/slot-gpio.h |  3 --
 2 files changed, 4 insertions(+), 91 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 69bbf2a..a428f10 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -103,11 +103,7 @@ EXPORT_SYMBOL(mmc_gpio_get_cd);
  * @gpio: gpio number requested
  *
  * As devm_* managed functions are used in mmc_gpio_request_ro(), client
- * drivers do not need to explicitly call mmc_gpio_free_ro() for freeing up,
- * if the requesting and freeing are only needed at probing and unbinding time
- * for once.  However, if client drivers do something special like runtime
- * switching for write-protection, they are responsible for calling
- * mmc_gpio_request_ro() and mmc_gpio_free_ro() as a pair on their own.
+ * drivers do not need to worry about freeing up memory.
  *
  * Returns zero on success, else an error.
  */
@@ -178,11 +174,7 @@ EXPORT_SYMBOL(mmc_gpiod_request_cd_irq);
  * @debounce: debounce time in microseconds
  *
  * As devm_* managed functions are used in mmc_gpio_request_cd(), client
- * drivers do not need to explicitly call mmc_gpio_free_cd() for freeing up,
- * if the requesting and freeing are only needed at probing and unbinding time
- * for once.  However, if client drivers do something special like runtime
- * switching for card-detection, they are responsible for calling
- * mmc_gpio_request_cd() and mmc_gpio_free_cd() as a pair on their own.
+ * drivers do not need to worry about freeing up memory.
  *
  * If GPIO debouncing is desired, set the debounce parameter to a non-zero
  * value. The caller is responsible for ensuring that the GPIO driver associated
@@ -226,55 +218,6 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
 EXPORT_SYMBOL(mmc_gpio_request_cd);
 
 /**
- * mmc_gpio_free_ro - free the write-protection gpio
- * @host: mmc host
- *
- * It's provided only for cases that client drivers need to manually free
- * up the write-protection gpio requested by mmc_gpio_request_ro().
- */
-void mmc_gpio_free_ro(struct mmc_host *host)
-{
-	struct mmc_gpio *ctx = host->slot.handler_priv;
-	int gpio;
-
-	if (!ctx || !ctx->ro_gpio)
-		return;
-
-	gpio = desc_to_gpio(ctx->ro_gpio);
-	ctx->ro_gpio = NULL;
-
-	devm_gpio_free(&host->class_dev, gpio);
-}
-EXPORT_SYMBOL(mmc_gpio_free_ro);
-
-/**
- * mmc_gpio_free_cd - free the card-detection gpio
- * @host: mmc host
- *
- * It's provided only for cases that client drivers need to manually free
- * up the card-detection gpio requested by mmc_gpio_request_cd().
- */
-void mmc_gpio_free_cd(struct mmc_host *host)
-{
-	struct mmc_gpio *ctx = host->slot.handler_priv;
-	int gpio;
-
-	if (!ctx || !ctx->cd_gpio)
-		return;
-
-	if (host->slot.cd_irq >= 0) {
-		devm_free_irq(&host->class_dev, host->slot.cd_irq, host);
-		host->slot.cd_irq = -EINVAL;
-	}
-
-	gpio = desc_to_gpio(ctx->cd_gpio);
-	ctx->cd_gpio = NULL;
-
-	devm_gpio_free(&host->class_dev, gpio);
-}
-EXPORT_SYMBOL(mmc_gpio_free_cd);
-
-/**
  * mmc_gpiod_request_cd - request a gpio descriptor for card-detection
  * @host: mmc host
  * @con_id: function within the GPIO consumer
@@ -285,8 +228,7 @@ EXPORT_SYMBOL(mmc_gpio_free_cd);
  * to NULL to ignore
  *
  * Use this function in place of mmc_gpio_request_cd() to use the GPIO
- * descriptor API.  Note that it is paired with mmc_gpiod_free_cd() not
- * mmc_gpio_free_cd().  Note also that it must be called prior to mmc_add_host()
+ * descriptor API.  Note that it must be called prior to mmc_add_host()
  * otherwise the caller must also call mmc_gpiod_request_cd_irq().
  *
  * Returns zero on success, else an error.
@@ -339,8 +281,7 @@ EXPORT_SYMBOL(mmc_gpiod_request_cd);
  * set to NULL to ignore
  *
  * Use this function in place of mmc_gpio_request_ro() to use the GPIO
- * descriptor API.  Note that it is paired with mmc_gpiod_free_ro() not
- * mmc_gpio_free_ro().
+ * descriptor API.
  *
  * Returns zero on success, else an error.
  */
@@ -380,28 +321,3 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 	return 0;
 }
 EXPORT_SYMBOL(mmc_gpiod_request_ro);
-
-/**
- * mmc_gpiod_free_cd - free the card-detection gpio descriptor
- * @host: mmc host
- *
- * It's provided only for cases that client drivers need to manually free
- * up the card-detection gpio requested by mmc_gpiod_request_cd().
- */
-void mmc_gpiod_free_cd(struct mmc_host *host)
-{
-	struct mmc_gpio *ctx = host->slot.handler_priv;
-
-	if (!ctx || !ctx->cd_gpio)
-		return;
-
-	if (host->slot.cd_irq >= 0) {
-		devm_free_irq(&host->class_dev, host->slot.cd_irq, host);
-		host->slot.cd_irq = -EINVAL;
-	}
-
-	devm_gpiod_put(host->parent, ctx->cd_gpio);
-
-	ctx->cd_gpio = NULL;
-}
-EXPORT_SYMBOL(mmc_gpiod_free_cd);
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index e56fa24..4a36d69 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -15,12 +15,10 @@ struct mmc_host;
 
 int mmc_gpio_get_ro(struct mmc_host *host);
 int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio);
-void mmc_gpio_free_ro(struct mmc_host *host);
 
 int mmc_gpio_get_cd(struct mmc_host *host);
 int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
 			unsigned int debounce);
-void mmc_gpio_free_cd(struct mmc_host *host);
 
 int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, bool override_active_level,
@@ -28,7 +26,6 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, bool override_active_level,
 			 unsigned int debounce, bool *gpio_invert);
-void mmc_gpiod_free_cd(struct mmc_host *host);
 void mmc_gpiod_request_cd_irq(struct mmc_host *host);
 
 #endif
-- 
1.9.1

