From: NeilBrown <neilb@suse.de>
Subject: [PATCH 1/3] mmc: core: Allow host driver to provide isr for
 card-detect interrupts.
Date: Tue, 13 Jan 2015 08:23:18 +1300
Message-ID: <20150112192318.2895.10673.stgit@notabene.brown>
References: <20150112191702.2895.75815.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150112191702.2895.75815.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

One of the reasons omap_hsmmc doesn't use the slot-gpio library
is that it has some non-standard functionality in the card-detect
interrupt service routine.

To make it possible for omap_hsmmc (and maybe others) to be converted
to use slot-gpio, add 'mmc_gpio_request_cd_isr' which provide an
alternate isr to be register by the slot-gpio code.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/mmc/core/slot-gpio.c  |   18 +++++++++++++++++-
 include/linux/mmc/slot-gpio.h |    2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 1a3edbd47719..27117ba47073 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -25,6 +25,7 @@ struct mmc_gpio {
 	struct gpio_desc *cd_gpio;
 	bool override_ro_active_level;
 	bool override_cd_active_level;
+	irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
 	char *ro_label;
 	char cd_label[0];
 };
@@ -136,8 +137,10 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
 		irq = -EINVAL;
 
 	if (irq >= 0) {
+		if (!ctx->cd_gpio_isr)
+			ctx->cd_gpio_isr = mmc_gpio_cd_irqt;
 		ret = devm_request_threaded_irq(host->parent, irq,
-			NULL, mmc_gpio_cd_irqt,
+			NULL, ctx->cd_gpio_isr,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			ctx->cd_label, host);
 		if (ret < 0)
@@ -151,6 +154,19 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_gpiod_request_cd_irq);
 
+/* Register an alternate interrupt service routine for
+ * the card-detect GPIO.
+ */
+void mmc_gpio_set_cd_isr(struct mmc_host *host,
+			 irqreturn_t (*isr)(int irq, void *dev_id))
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	WARN_ON(ctx->cd_gpio_isr);
+	ctx->cd_gpio_isr = isr;
+}
+EXPORT_SYMBOL(mmc_gpio_set_cd_isr);
+
 /**
  * mmc_gpio_request_cd - request a gpio for card-detection
  * @host: mmc host
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 4a36d6954631..3945a8c9d3cb 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -26,6 +26,8 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, bool override_active_level,
 			 unsigned int debounce, bool *gpio_invert);
+void mmc_gpio_set_cd_isr(struct mmc_host *host,
+			 irqreturn_t (*isr)(int irq, void *dev_id));
 void mmc_gpiod_request_cd_irq(struct mmc_host *host);
 
 #endif
