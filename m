From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] mmc: core: Fix struct mmc_gpio corruption
Date: Tue,  3 Jul 2018 15:11:14 +0100
Message-ID: <20180703141114.11609-1-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linus.walleij@linaro.org, shawn.lin@rock-chips.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

I recently realised that something was amiss with /proc/interrupts
on my cubietruck:

 51:          0          0     GICv2  41 Level     mv64xxx_i2c
 59:       1047          0     GICv2 117 Level     eth0
 66:          2          0  sunxi_pio_edge   1 Edge   XXXXX

where XXXXX has some non-ASCII characters, while I was expecting:

 66:          0          0  sunxi_pio_edge   1 Edge      1c0f000.mmc cd

It turns out that the cd_debounce_delay_ms field was recently to
struct mmc_gpio, and carefully placed at the one spot where it could
cause damage: right *after* the zero-sized array that contains the
associated label. This label ends up being passed to the IRQ
subsystem, and then overwritten by the cd_debounce_delay_ms field.

Funky!

Let's move that field to a less crowded location.

Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card after card is inserted")
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/mmc/core/slot-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index ef05e0039378..1ccf9dc07395 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,8 +27,8 @@ struct mmc_gpio {
 	bool override_cd_active_level;
 	irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
 	char *ro_label;
-	char cd_label[0];
 	u32 cd_debounce_delay_ms;
+	char cd_label[0];
 };
 
 static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
-- 
2.17.1
