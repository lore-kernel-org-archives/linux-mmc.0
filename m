From: Takao Orito <orito.takao@socionext.com>
Subject: [PATCH v1 2/2] mmc: sdhci_f_sdh30: Add support for Milbeaut M10V host controller
Date: Tue, 26 Mar 2019 14:53:46 +0900
Message-ID: <1553579626-6177-1-git-send-email-orito.takao@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com, orito.takao@socionext.com
List-Id: linux-mmc@vger.kernel.org

SD Host controller on Milbeaut is consist of two controller parts.
One is core controller F_SDH30, this is similar to sdhci-fujitsu
controller.
Another is bridge controller.
This bridge controller is not compatible with sdhci-fujitsu controller.
This is special for Milbeaut series. This has some functions.
For example, reset control, clock enable/select for SDR50/25/12, set
property of SD physical pins, retuning control, set capabilityies.

This bridge controller requires special procedures at reset or clock
enablement or change for further tuning of clock.

This new driver uses GPIO descriptor from platform data to switch
the power.

Signed-off-by: Takao Orito <orito.takao@socionext.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 324 +++++++++++++++++++++++++++++++++++----
 1 file changed, 296 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 485f759..994bafd 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -11,12 +11,15 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/err.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/bits.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/property.h>
-#include <linux/clk.h>
 
 #include "sdhci-pltfm.h"
 
@@ -43,14 +46,55 @@
 
 #define F_SDH30_CMD_DAT_DELAY		0x200
 
+/* milbeaut bridge controller register */
+#define MLB_SOFT_RESET		0x0200
+#define  MLB_SOFT_RESET_RSTX		BIT(0)
+
+#define MLB_WP_CD_LED_SET	0x0210
+#define  MLB_WP_CD_LED_SET_LED_INV  BIT(2)
+
+#define MLB_CR_SET			0x0220
+#define  MLB_CR_SET_CR_TOCLKUNIT       BIT(24)
+#define  MLB_CR_SET_CR_TOCLKFREQ_SFT   (16)
+#define  MLB_CR_SET_CR_TOCLKFREQ_MASK  (0x3F << MLB_CR_SET_CR_TOCLKFREQ_SFT)
+#define  MLB_CR_SET_CR_BCLKFREQ_SFT    (8)
+#define  MLB_CR_SET_CR_BCLKFREQ_MASK   (0xFF << MLB_CR_SET_CR_BCLKFREQ_SFT)
+#define  MLB_CR_SET_CR_RTUNTIMER_SFT   (4)
+#define  MLB_CR_SET_CR_RTUNTIMER_MASK  (0xF << MLB_CR_SET_CR_RTUNTIMER_SFT)
+
+#define MLB_SD_TOCLK_I_DIV	16
+#define MLB_TOCLKFREQ_UNIT_THRES	16000000
+#define MLB_CAL_TOCLKFREQ_MHZ(rate)	(rate / MLB_SD_TOCLK_I_DIV / 1000000)
+#define MLB_CAL_TOCLKFREQ_KHZ(rate)	(rate / MLB_SD_TOCLK_I_DIV / 1000)
+#define MLB_TOCLKFREQ_MAX	63
+#define MLB_TOCLKFREQ_MIN	 1
+
+#define MLB_SD_BCLK_I_DIV	4
+#define MLB_CAL_BCLKFREQ(rate)	(rate / MLB_SD_BCLK_I_DIV / 1000000)
+#define MLB_BCLKFREQ_MAX		255
+#define MLB_BCLKFREQ_MIN		  1
+
+#define MLB_CDR_SET			0x0230
+#define MLB_CDR_SET_CLK2POW16	3
+
 #define F_SDH30_MIN_CLOCK		400000
 
+struct f_sdh30_config {
+	void (*reset)(struct sdhci_host *host, u8 mask);
+	void (*init)(struct sdhci_host *host);
+	void (*quirk_init)(struct sdhci_host *host);
+	void (*prepare_power)(struct sdhci_host *host, unsigned char mode,
+					 unsigned short vdd);
+};
+
 struct f_sdhost_priv {
 	struct clk *clk_iface;
 	struct clk *clk;
 	u32 vendor_hs200;
 	struct device *dev;
 	bool enable_cmd_dat_delay;
+	struct gpio_desc *power_gpio;
+	struct f_sdh30_config *config;
 };
 
 static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
@@ -86,7 +130,46 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
 	return F_SDH30_MIN_CLOCK;
 }
 
-static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
+static void sdhci_milbeaut_reset(struct sdhci_host *host, u8 mask)
+{
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+	u16 clk;
+	u32 ctl;
+	ktime_t timeout;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk = (clk & ~SDHCI_CLOCK_CARD_EN) | SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	sdhci_reset(host, mask);
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	timeout = ktime_add_ms(ktime_get(), 10);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
+			pr_err("%s: Internal clock never stabilised.\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return;
+		}
+		udelay(10);
+	}
+
+	if (priv->enable_cmd_dat_delay) {
+		ctl = sdhci_readl(host, F_SDH30_ESD_CONTROL);
+		ctl |= F_SDH30_CMD_DAT_DELAY;
+		sdhci_writel(host, ctl, F_SDH30_ESD_CONTROL);
+	}
+}
+
+static void sdhci_mb86s70_reset(struct sdhci_host *host, u8 mask)
 {
 	struct f_sdhost_priv *priv = sdhci_priv(host);
 	u32 ctl;
@@ -103,6 +186,51 @@ static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
+{
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+
+	priv->config->reset(host, mask);
+}
+
+static void sdhci_milbeaut_power_off(struct f_sdhost_priv *priv)
+{
+	gpiod_set_value(priv->power_gpio, 0);
+	udelay(1000);
+}
+
+static void sdhci_milbeaut_power_on(struct f_sdhost_priv *priv)
+{
+	gpiod_set_value(priv->power_gpio, 1);
+}
+
+static void sdhci_milbeaut_prepare_power(struct sdhci_host *host,
+			unsigned char mode, unsigned short vdd)
+{
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+
+	if (!IS_ERR(priv->power_gpio))
+		switch (mode) {
+		case MMC_POWER_UP:
+			sdhci_milbeaut_power_on(priv);
+			break;
+		case MMC_POWER_OFF:
+			sdhci_milbeaut_power_off(priv);
+			return;
+		}
+}
+
+static void sdhci_f_sdh30_set_power(struct sdhci_host *host,
+				unsigned char mode, unsigned short vdd)
+{
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+
+	if (priv->config->prepare_power)
+		priv->config->prepare_power(host, mode, vdd);
+
+	sdhci_set_power(host, mode, vdd);
+}
+
 static const struct sdhci_ops sdhci_f_sdh30_ops = {
 	.voltage_switch = sdhci_f_sdh30_soft_voltage_switch,
 	.get_min_clock = sdhci_f_sdh30_get_min_clock,
@@ -110,6 +238,156 @@ static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_power = sdhci_f_sdh30_set_power,
+};
+
+static void sdhci_milbeaut_bridge_reset(struct sdhci_host *host, int reset_flag)
+{
+	if (reset_flag)
+		sdhci_writel(host, 0, MLB_SOFT_RESET);
+	else
+		sdhci_writel(host, MLB_SOFT_RESET_RSTX, MLB_SOFT_RESET);
+}
+
+static void sdhci_milbeaut_bridge_init(struct sdhci_host *host, int rate)
+{
+	u32 val, clk;
+
+	/* IO_SDIO_CR_SET should be set while reset */
+	val = sdhci_readl(host, MLB_CR_SET);
+	val &= ~(MLB_CR_SET_CR_TOCLKFREQ_MASK | MLB_CR_SET_CR_TOCLKUNIT |
+				MLB_CR_SET_CR_BCLKFREQ_MASK);
+	if (rate >= MLB_TOCLKFREQ_UNIT_THRES) {
+		clk = MLB_CAL_TOCLKFREQ_MHZ(rate);
+		clk = min_t(u32, MLB_TOCLKFREQ_MAX, clk);
+		val |= MLB_CR_SET_CR_TOCLKUNIT |
+			(clk << MLB_CR_SET_CR_TOCLKFREQ_SFT);
+	} else {
+		clk = MLB_CAL_TOCLKFREQ_KHZ(rate);
+		clk = min_t(u32, MLB_TOCLKFREQ_MAX, clk);
+		clk = max_t(u32, MLB_TOCLKFREQ_MIN, clk);
+		val |= clk << MLB_CR_SET_CR_TOCLKFREQ_SFT;
+	}
+
+	clk = MLB_CAL_BCLKFREQ(rate);
+	clk = min_t(u32, MLB_BCLKFREQ_MAX, clk);
+	clk = max_t(u32, MLB_BCLKFREQ_MIN, clk);
+	val |=  clk << MLB_CR_SET_CR_BCLKFREQ_SFT;
+
+	val &= ~MLB_CR_SET_CR_RTUNTIMER_MASK;
+
+	sdhci_writel(host, val, MLB_CR_SET);
+
+	sdhci_writel(host, MLB_CDR_SET_CLK2POW16, MLB_CDR_SET);
+
+	sdhci_writel(host, MLB_WP_CD_LED_SET_LED_INV, MLB_WP_CD_LED_SET);
+}
+
+static void sdhci_milbeaut_vendor_init(struct sdhci_host *host)
+{
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+	u32 ctl;
+
+	ctl = sdhci_readl(host, F_SDH30_IO_CONTROL2);
+	ctl |= F_SDH30_CRES_O_DN;
+	sdhci_writel(host, ctl, F_SDH30_IO_CONTROL2);
+	ctl &= ~F_SDH30_MSEL_O_1_8;
+	sdhci_writel(host, ctl, F_SDH30_IO_CONTROL2);
+	ctl &= ~F_SDH30_CRES_O_DN;
+	sdhci_writel(host, ctl, F_SDH30_IO_CONTROL2);
+
+	ctl = sdhci_readw(host, F_SDH30_AHB_CONFIG);
+	ctl |= F_SDH30_SIN | F_SDH30_AHB_INCR_16 | F_SDH30_AHB_INCR_8 |
+		   F_SDH30_AHB_INCR_4;
+	ctl &= ~(F_SDH30_AHB_BIGED | F_SDH30_BUSLOCK_EN);
+	sdhci_writew(host, ctl, F_SDH30_AHB_CONFIG);
+
+	if (priv->enable_cmd_dat_delay) {
+		ctl = sdhci_readl(host, F_SDH30_ESD_CONTROL);
+		ctl |= F_SDH30_CMD_DAT_DELAY;
+		sdhci_writel(host, ctl, F_SDH30_ESD_CONTROL);
+	}
+}
+
+static void sdhci_milbeaut_init(struct sdhci_host *host)
+{
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+	int rate = clk_get_rate(priv->clk);
+	u16 ctl;
+
+	sdhci_milbeaut_bridge_reset(host, 0);
+
+	ctl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	ctl &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN);
+	sdhci_writew(host, ctl, SDHCI_CLOCK_CONTROL);
+
+	sdhci_milbeaut_bridge_reset(host, 1);
+
+	priv->power_gpio = devm_gpiod_get_optional(priv->dev,
+			 "sni,mmc-power", GPIOD_OUT_LOW);
+	if (!IS_ERR(priv->power_gpio)) {
+		sdhci_milbeaut_power_off(priv);
+		msleep(20); /* need for card power off duration */
+	}
+
+	sdhci_milbeaut_bridge_init(host, rate);
+	sdhci_milbeaut_bridge_reset(host, 0);
+
+	sdhci_milbeaut_vendor_init(host);
+}
+
+static void sdhci_mb86s70_init(struct sdhci_host *host)
+{
+	struct f_sdhost_priv *priv = sdhci_priv(host);
+	u32 ctrl, reg;
+
+	/* init vendor specific regs */
+	ctrl = sdhci_readw(host, F_SDH30_AHB_CONFIG);
+	ctrl |= F_SDH30_SIN | F_SDH30_AHB_INCR_16 | F_SDH30_AHB_INCR_8 |
+		F_SDH30_AHB_INCR_4;
+	ctrl &= ~(F_SDH30_AHB_BIGED | F_SDH30_BUSLOCK_EN);
+	sdhci_writew(host, ctrl, F_SDH30_AHB_CONFIG);
+
+	reg = sdhci_readl(host, F_SDH30_ESD_CONTROL);
+	sdhci_writel(host, reg & ~F_SDH30_EMMC_RST, F_SDH30_ESD_CONTROL);
+	msleep(20);
+	sdhci_writel(host, reg | F_SDH30_EMMC_RST, F_SDH30_ESD_CONTROL);
+
+	reg = sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (reg & SDHCI_CAN_DO_8BIT)
+		priv->vendor_hs200 = F_SDH30_EMMC_HS200;
+}
+
+static void sdhci_milbeaut_quirk_init(struct sdhci_host *host)
+{
+	host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+			   SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
+			   SDHCI_QUIRK_CLOCK_BEFORE_RESET |
+			   SDHCI_QUIRK_DELAY_AFTER_POWER;
+	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
+			SDHCI_QUIRK2_TUNING_WORK_AROUND |
+			SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+}
+
+static void sdhci_mb86s70_quirk_init(struct sdhci_host *host)
+{
+	host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
+			   SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
+	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
+			SDHCI_QUIRK2_TUNING_WORK_AROUND;
+}
+
+struct f_sdh30_config mb86s70_config = {
+	.reset = sdhci_mb86s70_reset,
+	.quirk_init = sdhci_mb86s70_quirk_init,
+	.init = sdhci_mb86s70_init,
+};
+
+struct f_sdh30_config milbeaut_config = {
+	.reset = sdhci_milbeaut_reset,
+	.prepare_power = sdhci_milbeaut_prepare_power,
+	.quirk_init = sdhci_milbeaut_quirk_init,
+	.init = sdhci_milbeaut_init,
 };
 
 static int sdhci_f_sdh30_probe(struct platform_device *pdev)
@@ -117,9 +395,8 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	int irq, ctrl = 0, ret = 0;
+	int irq, ret = 0;
 	struct f_sdhost_priv *priv;
-	u32 reg = 0;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -133,14 +410,12 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 
 	priv = sdhci_priv(host);
 	priv->dev = dev;
+	priv->config = (struct f_sdh30_config *)of_device_get_match_data(dev);
+	if (!priv->config)
+		/* this must be matched by ACPI, fall down to mb86s70 compat */
+		priv->config = &mb86s70_config;
 
-	host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
-		       SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
-	host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
-			SDHCI_QUIRK2_TUNING_WORK_AROUND;
-
-	priv->enable_cmd_dat_delay = device_property_read_bool(dev,
-						"fujitsu,cmd-dat-delay-select");
+	priv->config->quirk_init(host);
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
@@ -183,21 +458,7 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 			goto err_clk;
 	}
 
-	/* init vendor specific regs */
-	ctrl = sdhci_readw(host, F_SDH30_AHB_CONFIG);
-	ctrl |= F_SDH30_SIN | F_SDH30_AHB_INCR_16 | F_SDH30_AHB_INCR_8 |
-		F_SDH30_AHB_INCR_4;
-	ctrl &= ~(F_SDH30_AHB_BIGED | F_SDH30_BUSLOCK_EN);
-	sdhci_writew(host, ctrl, F_SDH30_AHB_CONFIG);
-
-	reg = sdhci_readl(host, F_SDH30_ESD_CONTROL);
-	sdhci_writel(host, reg & ~F_SDH30_EMMC_RST, F_SDH30_ESD_CONTROL);
-	msleep(20);
-	sdhci_writel(host, reg | F_SDH30_EMMC_RST, F_SDH30_ESD_CONTROL);
-
-	reg = sdhci_readl(host, SDHCI_CAPABILITIES);
-	if (reg & SDHCI_CAN_DO_8BIT)
-		priv->vendor_hs200 = F_SDH30_EMMC_HS200;
+	priv->config->init(host);
 
 	ret = sdhci_add_host(host);
 	if (ret)
@@ -233,7 +494,14 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id f_sdh30_dt_ids[] = {
-	{ .compatible = "fujitsu,mb86s70-sdhci-3.0" },
+	{
+		.compatible = "fujitsu,mb86s70-sdhci-3.0",
+		.data = &mb86s70_config,
+	},
+	{
+		.compatible = "socionext,milbeaut-m10v-sdhci-3.0",
+		.data = &milbeaut_config,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, f_sdh30_dt_ids);
-- 
1.9.1
