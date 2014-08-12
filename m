From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/4] mmc: slot-gpio: add gpiod variant to get wp GPIO
Date: Tue, 12 Aug 2014 19:25:53 +0200
Message-ID: <1407864355-21545-2-git-send-email-linus.walleij@linaro.org>
References: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49243 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbaHLR0Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 13:26:24 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so6145176wib.5
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 10:26:23 -0700 (PDT)
In-Reply-To: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>

This makes it possible to get the write protect (read only)
GPIO line from a GPIO descriptor. Written to exactly mirror
the card detect function.

Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/slot-gpio.c  | 48 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/slot-gpio.h |  3 +++
 2 files changed, 51 insertions(+)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 908c2b29e79f..e3fce4493fab 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -326,6 +326,54 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 EXPORT_SYMBOL(mmc_gpiod_request_cd);
 
 /**
+ * mmc_gpiod_request_ro - request a gpio descriptor for write protection
+ * @host: mmc host
+ * @con_id: function within the GPIO consumer
+ * @idx: index of the GPIO to obtain in the consumer
+ * @override_active_level: ignore %GPIO_ACTIVE_LOW flag
+ * @debounce: debounce time in microseconds
+ *
+ * Use this function in place of mmc_gpio_request_ro() to use the GPIO
+ * descriptor API.  Note that it is paired with mmc_gpiod_free_ro() not
+ * mmc_gpio_free_ro().
+ *
+ * Returns zero on success, else an error.
+ */
+int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
+			 unsigned int idx, bool override_active_level,
+			 unsigned int debounce)
+{
+	struct mmc_gpio *ctx;
+	struct gpio_desc *desc;
+	int ret;
+
+	ret = mmc_gpio_alloc(host);
+	if (ret < 0)
+		return ret;
+
+	ctx = host->slot.handler_priv;
+
+	if (!con_id)
+		con_id = ctx->ro_label;
+
+	desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	if (debounce) {
+		ret = gpiod_set_debounce(desc, debounce);
+		if (ret < 0)
+			return ret;
+	}
+
+	ctx->override_ro_active_level = override_active_level;
+	ctx->ro_gpio = desc;
+
+	return 0;
+}
+EXPORT_SYMBOL(mmc_gpiod_request_ro);
+
+/**
  * mmc_gpiod_free_cd - free the card-detection gpio descriptor
  * @host: mmc host
  *
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index d2433381e828..a0d0442c15bf 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -25,6 +25,9 @@ void mmc_gpio_free_cd(struct mmc_host *host);
 int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, bool override_active_level,
 			 unsigned int debounce);
+int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
+			 unsigned int idx, bool override_active_level,
+			 unsigned int debounce);
 void mmc_gpiod_free_cd(struct mmc_host *host);
 void mmc_gpiod_request_cd_irq(struct mmc_host *host);
 
-- 
1.9.3

