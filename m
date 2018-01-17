From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 05/16] mmc: slot-gpio: add a helper to check capability of GPIO WP detection
Date: Thu, 18 Jan 2018 01:28:05 +0900
Message-ID: <1516206496-16612-6-git-send-email-yamada.masahiro@socionext.com>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Like mmc_can_gpio_cd(), mmc_can_gpio_ro() will also be useful for host
drivers to know whether GPIO write-protect detection is supported.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - newly added

Changes in v2: None

 drivers/mmc/core/slot-gpio.c  | 8 ++++++++
 include/linux/mmc/slot-gpio.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index f7c6e05..3698b05 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -305,3 +305,11 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 	return 0;
 }
 EXPORT_SYMBOL(mmc_gpiod_request_ro);
+
+bool mmc_can_gpio_ro(struct mmc_host *host)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	return ctx->ro_gpio ? true : false;
+}
+EXPORT_SYMBOL(mmc_can_gpio_ro);
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 82f0d28..91f1ba0 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -33,5 +33,6 @@ void mmc_gpio_set_cd_isr(struct mmc_host *host,
 			 irqreturn_t (*isr)(int irq, void *dev_id));
 void mmc_gpiod_request_cd_irq(struct mmc_host *host);
 bool mmc_can_gpio_cd(struct mmc_host *host);
+bool mmc_can_gpio_ro(struct mmc_host *host);
 
 #endif
-- 
2.7.4
