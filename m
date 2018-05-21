From: Evan Green <evgreen@chromium.org>
Subject: [PATCH] mmc: Allow non-sleeping GPIO cd
Date: Mon, 21 May 2018 15:35:03 -0700
Message-ID: <20180521223503.152131-1-evgreen@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, dianders@chromium.org
Cc: Evan Green <evgreen@chromium.org>
List-Id: linux-mmc@vger.kernel.org

This change uses the appropriate _cansleep or non-sleeping API for
reading GPIO card detect state. This allows users with GPIOs that
never sleep to avoid a warning when certain quirks are present.

The sdhci controller has an SDHCI_QUIRK_NO_CARD_NO_RESET, which
indicates that a controller will not reset properly if no card is
inserted. With this quirk enabled, mmc_get_cd_gpio is called in
several places with a spinlock held and interrupts disabled.
gpiod_get_raw_value_cansleep is not happy with this situation,
and throws out a warning.

For boards that a) use controllers that have this quirk, and b) wire
card detect up to a GPIO that doesn't sleep, this is a spurious warning.
This change silences that warning, at the cost of pushing this problem
down to users that have sleeping GPIOs and controllers with this quirk.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
This is my initial solution to the warning I was trying to face down
in my previous RFC [1]. Upsides of this solution is it manages to
avoid the warning in places where the warning doesn't apply, and is
low-risk. Other approaches I considered:

1. Changing sdhci_get_cd to reach through mmc and get the GPIO value
directly (without sleeping) rather than calling mmc_gpio_get_cd,
which uses the cansleep functions. I didn't love this because a) it
seemed ugly to be reaching into mmc_host like that and b) I'd have to
duplicate the logic in mmc_gpio_get_cd, which seemed brittle.

2. Using mmc_gpio_set_cd_isr to record when the card detect pin
changes, and then in sdhci_do_reset we wouldn't actually need to
get CD state, just look at the cached value. This seemed risky to me
since it would affect all sdhci controllers, and I don't know that
everybody using gpio-cd can do interrupts on their pins.

3. Adding mmc_gpio_get_cd_nosleep(). That one's still doable if
preferred, but I'd have to give some thought to when sdhci wires
up to which one.

I'm up for other suggestions. This one most just seemed like the
best first stab of minimally addressing the warning without rocking
the boat otherwise.

[1] https://patchwork.kernel.org/patch/10374633/
---
 drivers/mmc/core/slot-gpio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 31f7dbb15668..0f497b69f4b8 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -75,16 +75,22 @@ EXPORT_SYMBOL(mmc_gpio_get_ro);
 
 int mmc_gpio_get_cd(struct mmc_host *host)
 {
+	int can_sleep;
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 
 	if (!ctx || !ctx->cd_gpio)
 		return -ENOSYS;
 
-	if (ctx->override_cd_active_level)
-		return !gpiod_get_raw_value_cansleep(ctx->cd_gpio) ^
-			!!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
+	can_sleep = gpiod_cansleep(ctx->cd_gpio);
+	if (ctx->override_cd_active_level) {
+		int value = can_sleep ?
+				gpiod_get_raw_value_cansleep(ctx->cd_gpio) :
+				gpiod_get_raw_value(ctx->cd_gpio);
+		return !value ^ !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
+	}
 
-	return gpiod_get_value_cansleep(ctx->cd_gpio);
+	return can_sleep ? gpiod_get_value_cansleep(ctx->cd_gpio) :
+			gpiod_get_value(ctx->cd_gpio);
 }
 EXPORT_SYMBOL(mmc_gpio_get_cd);
 
-- 
2.13.5
