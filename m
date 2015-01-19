From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO pin
Date: Mon, 19 Jan 2015 10:13:04 +0100
Message-ID: <1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421658784-11980-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The need for reset GPIOs has several times been pointed out from
erlier posted patchsets. Especially some WLAN chips which are
attached to an SDIO interface may use a GPIO reset.

The reset GPIO is asserted at initialization and prior we start the
power up procedure. The GPIO will be de-asserted right after the power
has been provided to the card, from the ->post_power_on() callback.

Note, the reset GPIO is optional. Thus we don't return an error even if
we can't find a GPIO for the consumer.

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

Changes in v4:
	- Fixed call to kfree().

---
 drivers/mmc/core/pwrseq_simple.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 61c991e..0958c69 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/gpio/consumer.h>
 
 #include <linux/mmc/host.h>
 
@@ -18,31 +19,68 @@
 
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
+	struct gpio_desc *reset_gpio;
 };
 
+static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
+					struct mmc_pwrseq_simple, pwrseq);
+
+	if (!IS_ERR(pwrseq->reset_gpio))
+		gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
+}
+
+static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
+					struct mmc_pwrseq_simple, pwrseq);
+
+	if (!IS_ERR(pwrseq->reset_gpio))
+		gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
+}
+
 static void mmc_pwrseq_simple_free(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
 
+	if (!IS_ERR(pwrseq->reset_gpio))
+		gpiod_put(pwrseq->reset_gpio);
+
 	kfree(pwrseq);
 	host->pwrseq = NULL;
 }
 
 static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
+	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
+	.post_power_on = mmc_pwrseq_simple_post_power_on,
+	.power_off = mmc_pwrseq_simple_pre_power_on,
 	.free = mmc_pwrseq_simple_free,
 };
 
 int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
 {
 	struct mmc_pwrseq_simple *pwrseq;
+	int ret = 0;
 
 	pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
 	if (!pwrseq)
 		return -ENOMEM;
 
+	pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_HIGH);
+	if (IS_ERR(pwrseq->reset_gpio) &&
+		PTR_ERR(pwrseq->reset_gpio) != -ENOENT &&
+		PTR_ERR(pwrseq->reset_gpio) != -ENOSYS) {
+		ret = PTR_ERR(pwrseq->reset_gpio);
+		goto free;
+	}
+
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 	host->pwrseq = &pwrseq->pwrseq;
 
 	return 0;
+free:
+	kfree(pwrseq);
+	return ret;
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
