From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 4/4 RESEND] mmc: sdhci-esdhc-imx: extend card_detect and write_protect support for mx5
Date: Fri, 17 Jun 2011 16:18:33 +0800
Message-ID: <1308298713-17562-1-git-send-email-shawn.guo@linaro.org>
References: <1308136522-3403-5-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43209 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261Ab1FQIJS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2011 04:09:18 -0400
Received: by iwn34 with SMTP id 34so1799962iwn.19
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jun 2011 01:09:18 -0700 (PDT)
In-Reply-To: <1308136522-3403-5-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, Pavel Machek <pma@sysgo.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The patch extends card_detect and write_protect support to get mx5
family and more scenarios supported.  The changes include:

 * Turn platform_data from optional to mandatory
 * Add cd_types and wp_types into platform_data to cover more use
   cases
 * Remove the use of flag ESDHC_FLAG_GPIO_FOR_CD
 * Adjust some machine codes to adopt the platform_data changes

With this patch, card_detect and write_protect gets supported on
mx5 based platforms.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
Changes for resend:
 * Fix the warning below:
  CC      drivers/mmc/host/sdhci-esdhc-imx.o
drivers/mmc/host/sdhci-esdhc-imx.c: In function 'esdhc_pltfm_get_ro':
drivers/mmc/host/sdhci-esdhc-imx.c:215:1: warning: control reaches end of non-void function

 * Add Wolfram's Acked-by

 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    3 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    3 +-
 arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +
 arch/arm/mach-imx/mach-pcm043.c                    |    2 +
 arch/arm/mach-mx5/board-mx51_babbage.c             |   14 ++-
 arch/arm/mach-mx5/board-mx53_loco.c                |    4 +
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   12 ++
 arch/arm/plat-mxc/include/mach/esdhc.h             |   25 ++++-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  123 ++++++++++++--------
 9 files changed, 126 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index 01ebcb3..66e8726 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -225,7 +225,8 @@ struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
 
 static struct esdhc_platform_data sd1_pdata = {
 	.cd_gpio = GPIO_SD1CD,
-	.wp_gpio = -EINVAL,
+	.cd_type = ESDHC_CD_GPIO,
+	.wp_type = ESDHC_WP_NONE,
 };
 
 /*
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 558eb52..0f0af02 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -236,7 +236,8 @@ struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
 
 static struct esdhc_platform_data sd1_pdata = {
 	.cd_gpio = GPIO_SD1CD,
-	.wp_gpio = -EINVAL,
+	.cd_type = ESDHC_CD_GPIO,
+	.wp_type = ESDHC_WP_NONE,
 };
 
 /*
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 01534bb..7f66a91 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -215,6 +215,8 @@ static const struct imxi2c_platform_data mx25_3ds_i2c0_data __initconst = {
 static const struct esdhc_platform_data mx25pdk_esdhc_pdata __initconst = {
 	.wp_gpio = SD1_GPIO_WP,
 	.cd_gpio = SD1_GPIO_CD,
+	.wp_type = ESDHC_WP_GPIO,
+	.cd_type = ESDHC_CD_GPIO,
 };
 
 static void __init mx25pdk_init(void)
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 163cc31..660ec3e 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -349,6 +349,8 @@ __setup("otg_mode=", pcm043_otg_mode);
 static struct esdhc_platform_data sd1_pdata = {
 	.wp_gpio = SD1_GPIO_WP,
 	.cd_gpio = SD1_GPIO_CD,
+	.wp_type = ESDHC_WP_GPIO,
+	.cd_type = ESDHC_CD_GPIO,
 };
 
 /*
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 15c6000..e400b09 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -41,8 +41,6 @@
 #define BABBAGE_POWER_KEY	IMX_GPIO_NR(2, 21)
 #define BABBAGE_ECSPI1_CS0	IMX_GPIO_NR(4, 24)
 #define BABBAGE_ECSPI1_CS1	IMX_GPIO_NR(4, 25)
-#define BABBAGE_SD1_CD		IMX_GPIO_NR(1, 0)
-#define BABBAGE_SD1_WP		IMX_GPIO_NR(1, 1)
 #define BABBAGE_SD2_CD		IMX_GPIO_NR(1, 6)
 #define BABBAGE_SD2_WP		IMX_GPIO_NR(1, 5)
 
@@ -146,8 +144,9 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	MX51_PAD_SD1_DATA1__SD1_DATA1,
 	MX51_PAD_SD1_DATA2__SD1_DATA2,
 	MX51_PAD_SD1_DATA3__SD1_DATA3,
-	MX51_PAD_GPIO1_0__GPIO1_0,
-	MX51_PAD_GPIO1_1__GPIO1_1,
+	/* CD/WP from controller */
+	MX51_PAD_GPIO1_0__SD1_CD,
+	MX51_PAD_GPIO1_1__SD1_WP,
 
 	/* SD 2 */
 	MX51_PAD_SD2_CMD__SD2_CMD,
@@ -156,6 +155,7 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	MX51_PAD_SD2_DATA1__SD2_DATA1,
 	MX51_PAD_SD2_DATA2__SD2_DATA2,
 	MX51_PAD_SD2_DATA3__SD2_DATA3,
+	/* CD/WP gpio */
 	MX51_PAD_GPIO1_6__GPIO1_6,
 	MX51_PAD_GPIO1_5__GPIO1_5,
 
@@ -340,13 +340,15 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 };
 
 static const struct esdhc_platform_data mx51_babbage_sd1_data __initconst = {
-	.cd_gpio = BABBAGE_SD1_CD,
-	.wp_gpio = BABBAGE_SD1_WP,
+	.cd_type = ESDHC_CD_CONTROLLER,
+	.wp_type = ESDHC_WP_CONTROLLER,
 };
 
 static const struct esdhc_platform_data mx51_babbage_sd2_data __initconst = {
 	.cd_gpio = BABBAGE_SD2_CD,
 	.wp_gpio = BABBAGE_SD2_WP,
+	.cd_type = ESDHC_CD_GPIO,
+	.wp_type = ESDHC_WP_GPIO,
 };
 
 /*
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 54be525..4e1d51d 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -210,11 +210,15 @@ static const struct gpio_keys_platform_data loco_button_data __initconst = {
 
 static const struct esdhc_platform_data mx53_loco_sd1_data __initconst = {
 	.cd_gpio = LOCO_SD1_CD,
+	.cd_type = ESDHC_CD_GPIO,
+	.wp_type = ESDHC_WP_NONE,
 };
 
 static const struct esdhc_platform_data mx53_loco_sd3_data __initconst = {
 	.cd_gpio = LOCO_SD3_CD,
 	.wp_gpio = LOCO_SD3_WP,
+	.cd_type = ESDHC_CD_GPIO,
+	.wp_type = ESDHC_WP_GPIO,
 };
 
 static inline void mx53_loco_fec_reset(void)
diff --git a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
index 6b2940b..79d6d71 100644
--- a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
+++ b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
@@ -65,6 +65,11 @@ imx53_sdhci_esdhc_imx_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX53 */
 
+static const struct esdhc_platform_data default_esdhc_pdata __initconst = {
+	.wp_type = ESDHC_WP_NONE,
+	.cd_type = ESDHC_CD_NONE,
+};
+
 struct platform_device *__init imx_add_sdhci_esdhc_imx(
 		const struct imx_sdhci_esdhc_imx_data *data,
 		const struct esdhc_platform_data *pdata)
@@ -81,6 +86,13 @@ struct platform_device *__init imx_add_sdhci_esdhc_imx(
 		},
 	};
 
+	/*
+	 * If machine does not provide pdata, use the default one
+	 * which means no WP/CD support
+	 */
+	if (!pdata)
+		pdata = &default_esdhc_pdata;
+
 	return imx_add_platform_device("sdhci-esdhc-imx", data->id, res,
 			ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
index 86003f4..aaf9748 100644
--- a/arch/arm/plat-mxc/include/mach/esdhc.h
+++ b/arch/arm/plat-mxc/include/mach/esdhc.h
@@ -10,17 +10,34 @@
 #ifndef __ASM_ARCH_IMX_ESDHC_H
 #define __ASM_ARCH_IMX_ESDHC_H
 
+enum wp_types {
+	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
+	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
+	ESDHC_WP_GPIO,		/* external gpio pin for WP */
+};
+
+enum cd_types {
+	ESDHC_CD_NONE,		/* no CD, neither controller nor gpio */
+	ESDHC_CD_CONTROLLER,	/* mmc controller internal CD */
+	ESDHC_CD_GPIO,		/* external gpio pin for CD */
+	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
+};
+
 /**
- * struct esdhc_platform_data - optional platform data for esdhc on i.MX
+ * struct esdhc_platform_data - platform data for esdhc on i.MX
  *
- * strongly recommended for i.MX25/35, not needed for other variants
+ * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
  *
- * @wp_gpio:	gpio for write_protect (-EINVAL if unused)
- * @cd_gpio:	gpio for card_detect interrupt (-EINVAL if unused)
+ * @wp_gpio:	gpio for write_protect
+ * @cd_gpio:	gpio for card_detect interrupt
+ * @wp_type:	type of write_protect method (see wp_types enum above)
+ * @cd_type:	type of card_detect method (see cd_types enum above)
  */
 
 struct esdhc_platform_data {
 	unsigned int wp_gpio;
 	unsigned int cd_gpio;
+	enum wp_types wp_type;
+	enum cd_types cd_type;
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 79b7a9a..91d9579 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -29,7 +29,6 @@
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
 
-#define ESDHC_FLAG_GPIO_FOR_CD		(1 << 0)
 /*
  * The CMDTYPE of the CMD register (offset 0xE) should be set to
  * "11" when the STOP CMD12 is issued on imx53 to abort one
@@ -70,19 +69,15 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
 
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct esdhc_platform_data *boarddata =
+			host->mmc->parent->platform_data;
 
-	/* fake CARD_PRESENT flag on mx25/35 */
+	/* fake CARD_PRESENT flag */
 	u32 val = readl(host->ioaddr + reg);
 
 	if (unlikely((reg == SDHCI_PRESENT_STATE)
-			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD))) {
-		struct esdhc_platform_data *boarddata =
-				host->mmc->parent->platform_data;
-
-		if (boarddata && gpio_is_valid(boarddata->cd_gpio)
-				&& gpio_get_value(boarddata->cd_gpio))
+			&& gpio_is_valid(boarddata->cd_gpio))) {
+		if (gpio_get_value(boarddata->cd_gpio))
 			/* no card, if a valid gpio says so... */
 			val &= ~SDHCI_CARD_PRESENT;
 		else
@@ -97,12 +92,13 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct esdhc_platform_data *boarddata =
+			host->mmc->parent->platform_data;
 
 	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
-			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD)))
+			&& (boarddata->cd_type == ESDHC_CD_GPIO)))
 		/*
 		 * these interrupts won't work with a custom card_detect gpio
-		 * (only applied to mx25/35)
 		 */
 		val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
 
@@ -201,6 +197,25 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk) / 256 / 16;
 }
 
+static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
+{
+	struct esdhc_platform_data *boarddata =
+			host->mmc->parent->platform_data;
+
+	switch (boarddata->wp_type) {
+	case ESDHC_WP_GPIO:
+		if (gpio_is_valid(boarddata->wp_gpio))
+			return gpio_get_value(boarddata->wp_gpio);
+	case ESDHC_WP_CONTROLLER:
+		return !(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
+			       SDHCI_WRITE_PROTECT);
+	case ESDHC_WP_NONE:
+		break;
+	}
+
+	return -ENOSYS;
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -212,6 +227,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_max_blk_size = esdhc_pltfm_get_max_blk_size,
 	.get_max_blk_count = esdhc_pltfm_get_max_blk_count,
+	.get_ro = esdhc_pltfm_get_ro,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
@@ -221,17 +237,6 @@ static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 	.ops = &sdhci_esdhc_ops,
 };
 
-static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
-{
-	struct esdhc_platform_data *boarddata =
-			host->mmc->parent->platform_data;
-
-	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
-		return gpio_get_value(boarddata->wp_gpio);
-	else
-		return -ENOSYS;
-}
-
 static irqreturn_t cd_irq(int irq, void *data)
 {
 	struct sdhci_host *sdhost = (struct sdhci_host *)data;
@@ -272,23 +277,34 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (!cpu_is_mx25())
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	if (cpu_is_mx25() || cpu_is_mx35()) {
-		/* write_protect can't be routed to controller, use gpio */
-		sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
-	}
-
 	if (!(cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51()))
 		imx_data->flags |= ESDHC_FLAG_MULTIBLK_NO_INT;
 
 	boarddata = host->mmc->parent->platform_data;
-	if (boarddata) {
+	if (!boarddata) {
+		dev_err(mmc_dev(host->mmc), "no board data!\n");
+		err = -EINVAL;
+		goto no_board_data;
+	}
+
+	/* write_protect */
+	if (boarddata->wp_type == ESDHC_WP_GPIO) {
 		err = gpio_request_one(boarddata->wp_gpio, GPIOF_IN, "ESDHC_WP");
 		if (err) {
 			dev_warn(mmc_dev(host->mmc),
-				"no write-protect pin available!\n");
-			boarddata->wp_gpio = err;
+				 "no write-protect pin available!\n");
+			boarddata->wp_gpio = -EINVAL;
 		}
+	} else {
+		boarddata->wp_gpio = -EINVAL;
+	}
 
+	/* card_detect */
+	if (boarddata->cd_type != ESDHC_CD_GPIO)
+		boarddata->cd_gpio = -EINVAL;
+
+	switch (boarddata->cd_type) {
+	case ESDHC_CD_GPIO:
 		err = gpio_request_one(boarddata->cd_gpio, GPIOF_IN, "ESDHC_CD");
 		if (err) {
 			dev_warn(mmc_dev(host->mmc),
@@ -296,10 +312,6 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			goto no_card_detect_pin;
 		}
 
-		/* i.MX5x has issues to be researched */
-		if (!cpu_is_mx25() && !cpu_is_mx35())
-			goto not_supported;
-
 		err = request_irq(gpio_to_irq(boarddata->cd_gpio), cd_irq,
 				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 				 mmc_hostname(host->mmc), host);
@@ -307,10 +319,19 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			dev_warn(mmc_dev(host->mmc), "request irq error\n");
 			goto no_card_detect_irq;
 		}
+		/* fall through */
 
-		imx_data->flags |= ESDHC_FLAG_GPIO_FOR_CD;
-		/* Now we have a working card_detect again */
+	case ESDHC_CD_CONTROLLER:
+		/* we have a working card_detect back */
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		break;
+
+	case ESDHC_CD_PERMANENT:
+		host->mmc->caps = MMC_CAP_NONREMOVABLE;
+		break;
+
+	case ESDHC_CD_NONE:
+		break;
 	}
 
 	err = sdhci_add_host(host);
@@ -319,16 +340,20 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	return 0;
 
- no_card_detect_irq:
-	gpio_free(boarddata->cd_gpio);
- no_card_detect_pin:
-	boarddata->cd_gpio = err;
- not_supported:
-	kfree(imx_data);
- err_add_host:
+err_add_host:
+	if (gpio_is_valid(boarddata->cd_gpio))
+		free_irq(gpio_to_irq(boarddata->cd_gpio), host);
+no_card_detect_irq:
+	if (gpio_is_valid(boarddata->cd_gpio))
+		gpio_free(boarddata->cd_gpio);
+	if (gpio_is_valid(boarddata->wp_gpio))
+		gpio_free(boarddata->wp_gpio);
+no_card_detect_pin:
+no_board_data:
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
- err_clk_get:
+err_clk_get:
+	kfree(imx_data);
 	sdhci_pltfm_free(pdev);
 	return err;
 }
@@ -343,14 +368,12 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
-	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
+	if (gpio_is_valid(boarddata->wp_gpio))
 		gpio_free(boarddata->wp_gpio);
 
-	if (boarddata && gpio_is_valid(boarddata->cd_gpio)) {
+	if (gpio_is_valid(boarddata->cd_gpio)) {
+		free_irq(gpio_to_irq(boarddata->cd_gpio), host);
 		gpio_free(boarddata->cd_gpio);
-
-		if (!(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION))
-			free_irq(gpio_to_irq(boarddata->cd_gpio), host);
 	}
 
 	clk_disable(pltfm_host->clk);
-- 
1.7.4.1

