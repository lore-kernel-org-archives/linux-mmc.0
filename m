From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 158/258] mmc: jz4740: Get CD/WP GPIOs from descriptors
Date: Mon, 28 Jan 2019 10:57:44 -0500
Message-ID: <20190128155924.51521-158-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Paul Cercueil <paul@crapouillou.net>, linux-mips@linux-mips.org, Ulf Hansson <ulf.hansson@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 0c901c0566fb4edc2631c3786e5085a037be91f8 ]

Modifty the JZ4740 driver to retrieve card detect and write
protect GPIO pins from GPIO descriptors instead of hard-coded
global numbers. Augment the only board file using this in the
process and cut down on passed in platform data.

Preserve the code setting the caps2 flags for CD and WP
as active low or high since the slot GPIO code currently
ignores the gpiolib polarity inversion semantice and uses
the raw accessors to read the GPIO lines, but set the right
polarity flags in the descriptor table for jz4740.

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mips/include/asm/mach-jz4740/jz4740_mmc.h |  2 --
 arch/mips/jz4740/board-qi_lb60.c              | 12 ++++++++---
 drivers/mmc/host/jz4740_mmc.c                 | 20 +++++++++----------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
index e9cc62cfac99..ff50aeb1a933 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
@@ -4,8 +4,6 @@
 
 struct jz4740_mmc_platform_data {
 	int gpio_power;
-	int gpio_card_detect;
-	int gpio_read_only;
 	unsigned card_detect_active_low:1;
 	unsigned read_only_active_low:1;
 	unsigned power_active_low:1;
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index af0c8ace0141..705593d40d12 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -43,7 +43,6 @@
 #include "clock.h"
 
 /* GPIOs */
-#define QI_LB60_GPIO_SD_CD		JZ_GPIO_PORTD(0)
 #define QI_LB60_GPIO_SD_VCC_EN_N	JZ_GPIO_PORTD(2)
 
 #define QI_LB60_GPIO_KEYOUT(x)		(JZ_GPIO_PORTC(10) + (x))
@@ -386,12 +385,18 @@ static struct platform_device qi_lb60_gpio_keys = {
 };
 
 static struct jz4740_mmc_platform_data qi_lb60_mmc_pdata = {
-	.gpio_card_detect	= QI_LB60_GPIO_SD_CD,
-	.gpio_read_only		= -1,
 	.gpio_power		= QI_LB60_GPIO_SD_VCC_EN_N,
 	.power_active_low	= 1,
 };
 
+static struct gpiod_lookup_table qi_lb60_mmc_gpio_table = {
+	.dev_id = "jz4740-mmc.0",
+	.table = {
+		GPIO_LOOKUP("GPIOD", 0, "cd", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /* beeper */
 static struct pwm_lookup qi_lb60_pwm_lookup[] = {
 	PWM_LOOKUP("jz4740-pwm", 4, "pwm-beeper", NULL, 0,
@@ -500,6 +505,7 @@ static int __init qi_lb60_init_platform_devices(void)
 	gpiod_add_lookup_table(&qi_lb60_audio_gpio_table);
 	gpiod_add_lookup_table(&qi_lb60_nand_gpio_table);
 	gpiod_add_lookup_table(&qi_lb60_spigpio_gpio_table);
+	gpiod_add_lookup_table(&qi_lb60_mmc_gpio_table);
 
 	spi_register_board_info(qi_lb60_spi_board_info,
 				ARRAY_SIZE(qi_lb60_spi_board_info));
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 993386c9ea50..864338e308e2 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -983,17 +983,17 @@ static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 	if (!pdata->read_only_active_low)
 		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
-	if (gpio_is_valid(pdata->gpio_card_detect)) {
-		ret = mmc_gpio_request_cd(mmc, pdata->gpio_card_detect, 0);
-		if (ret)
-			return ret;
-	}
+	/*
+	 * Get optional card detect and write protect GPIOs,
+	 * only back out on probe deferral.
+	 */
+	ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0, NULL);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
-	if (gpio_is_valid(pdata->gpio_read_only)) {
-		ret = mmc_gpio_request_ro(mmc, pdata->gpio_read_only);
-		if (ret)
-			return ret;
-	}
+	ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0, NULL);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
 	return jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_power,
 			"MMC read only", true, pdata->power_active_low);
-- 
2.19.1
