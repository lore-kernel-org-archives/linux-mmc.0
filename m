From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 4/4] mmc: sdhci-esdhc-imx: extend card_detect and write_protect support for mx5
Date: Tue, 14 Jun 2011 14:47:39 +0800
Message-ID: <1308034059-4014-1-git-send-email-shawn.guo@linaro.org>
References: <1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48545 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab1FNGjT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 02:39:19 -0400
Received: by pwi15 with SMTP id 15so2465854pwi.19
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 23:39:18 -0700 (PDT)
In-Reply-To: <1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The patch extends card_detect and write_protect support to get mx5
family and more scenarios supported.  The changes include:

 * Turn platform_data from optional to mandatory
 * Add cd_types and wp_types into platform_data to cover more use
   cases
 * Remove the use of flag ESDHC_FLAG_GPIO_FOR_CD
 * Adjust some machine codes to adopt the platform_data changes

With this patch, card_detect and write_protect gets supported on
mx51_babbage, and other mx5 machines can easily get there with the
least board level configuration added.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Changes since v1:
 * Took the suggestion from Arnaud Patard to add default pdata
   in imx_add_sdhci_esdhc_imx(), to avoid touching every single
   board file for the platform_data changes

 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    3 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    3 +-
 arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +
 arch/arm/mach-imx/mach-pcm043.c                    |    2 +
 arch/arm/mach-mx5/board-mx51_babbage.c             |   27 +++++-
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   12 ++
 arch/arm/plat-mxc/include/mach/esdhc.h             |   25 ++++-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  115 +++++++++++---------
 8 files changed, 130 insertions(+), 59 deletions(-)

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
index e54e4bf..4db6cf9 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -34,6 +34,8 @@
 #include "devices.h"
 #include "cpu_op-mx51.h"
 
+#define BABBAGE_ESDHC2_WP	IMX_GPIO_NR(1, 5)
+#define BABBAGE_ESDHC2_CD	IMX_GPIO_NR(1, 6)
 #define BABBAGE_USB_HUB_RESET	IMX_GPIO_NR(1, 7)
 #define BABBAGE_USBH1_STP	IMX_GPIO_NR(1, 27)
 #define BABBAGE_USB_PHY_RESET	IMX_GPIO_NR(2, 5)
@@ -142,6 +144,10 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	MX51_PAD_SD1_DATA1__SD1_DATA1,
 	MX51_PAD_SD1_DATA2__SD1_DATA2,
 	MX51_PAD_SD1_DATA3__SD1_DATA3,
+	/* CD signal */
+	MX51_PAD_GPIO1_0__SD1_CD,
+	/* WP signal */
+	MX51_PAD_GPIO1_1__SD1_WP,
 
 	/* SD 2 */
 	MX51_PAD_SD2_CMD__SD2_CMD,
@@ -150,6 +156,11 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	MX51_PAD_SD2_DATA1__SD2_DATA1,
 	MX51_PAD_SD2_DATA2__SD2_DATA2,
 	MX51_PAD_SD2_DATA3__SD2_DATA3,
+	/* WP gpio */
+	MX51_PAD_GPIO1_5__GPIO1_5,
+	/* CD gpio */
+	MX51_PAD_GPIO1_6__GPIO1_6,
+
 
 	/* eCSPI1 */
 	MX51_PAD_CSPI1_MISO__ECSPI1_MISO,
@@ -331,6 +342,18 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
 };
 
+static const struct esdhc_platform_data esdhc1_pdata __initconst = {
+	.wp_type = ESDHC_WP_SIGNAL,
+	.cd_type = ESDHC_CD_SIGNAL,
+};
+
+static const struct esdhc_platform_data esdhc2_pdata __initconst = {
+	.wp_gpio = BABBAGE_ESDHC2_WP,
+	.cd_gpio = BABBAGE_ESDHC2_CD,
+	.wp_type = ESDHC_WP_GPIO,
+	.cd_type = ESDHC_CD_GPIO,
+};
+
 /*
  * Board specific initialization.
  */
@@ -376,8 +399,8 @@ static void __init mx51_babbage_init(void)
 	mxc_iomux_v3_setup_pad(usbh1stp);
 	babbage_usbhub_reset();
 
-	imx51_add_sdhci_esdhc_imx(0, NULL);
-	imx51_add_sdhci_esdhc_imx(1, NULL);
+	imx51_add_sdhci_esdhc_imx(0, &esdhc1_pdata);
+	imx51_add_sdhci_esdhc_imx(1, &esdhc2_pdata);
 
 	spi_register_board_info(mx51_babbage_spi_board_info,
 		ARRAY_SIZE(mx51_babbage_spi_board_info));
diff --git a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
index 6b2940b..a880f73 100644
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
+	 * If machine does not provide a pdata, use the default one
+	 * which means none WP/CD support
+	 */
+	if (!pdata)
+		pdata = &default_esdhc_pdata;
+
 	return imx_add_platform_device("sdhci-esdhc-imx", data->id, res,
 			ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
index 86003f4..fced348 100644
--- a/arch/arm/plat-mxc/include/mach/esdhc.h
+++ b/arch/arm/plat-mxc/include/mach/esdhc.h
@@ -10,17 +10,32 @@
 #ifndef __ASM_ARCH_IMX_ESDHC_H
 #define __ASM_ARCH_IMX_ESDHC_H
 
+enum wp_types {
+	ESDHC_WP_NONE,		/* no WP, neither signal nor gpio */
+	ESDHC_WP_SIGNAL,	/* mmc internal WP signal */
+	ESDHC_WP_GPIO,		/* external gpio pin for WP */
+};
+
+enum cd_types {
+	ESDHC_CD_NONE,		/* no CD, neither signal nor gpio */
+	ESDHC_CD_SIGNAL,	/* mmc internal CD signal */
+	ESDHC_CD_GPIO,		/* external gpio pin for CD */
+	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
+};
+
 /**
- * struct esdhc_platform_data - optional platform data for esdhc on i.MX
- *
- * strongly recommended for i.MX25/35, not needed for other variants
+ * struct esdhc_platform_data - platform data for esdhc on i.MX
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
index 79b7a9a..9cba6eb 100644
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
 
@@ -201,6 +197,18 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk) / 256 / 16;
 }
 
+static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
+{
+	struct esdhc_platform_data *boarddata =
+			host->mmc->parent->platform_data;
+
+	if (gpio_is_valid(boarddata->wp_gpio))
+		return gpio_get_value(boarddata->wp_gpio);
+	else
+		return !(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
+				SDHCI_WRITE_PROTECT);
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -212,6 +220,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_max_blk_size = esdhc_pltfm_get_max_blk_size,
 	.get_max_blk_count = esdhc_pltfm_get_max_blk_count,
+	.get_ro = esdhc_pltfm_get_ro,
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
@@ -221,17 +230,6 @@ static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
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
@@ -272,23 +270,33 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
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
+	} else
+		boarddata->wp_gpio = -EINVAL;
 
+	/* card_detect */
+	if (boarddata->cd_type != ESDHC_CD_GPIO)
+		boarddata->cd_gpio = -EINVAL;
+
+	switch (boarddata->cd_type) {
+	case ESDHC_CD_GPIO:
 		err = gpio_request_one(boarddata->cd_gpio, GPIOF_IN, "ESDHC_CD");
 		if (err) {
 			dev_warn(mmc_dev(host->mmc),
@@ -296,10 +304,6 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			goto no_card_detect_pin;
 		}
 
-		/* i.MX5x has issues to be researched */
-		if (!cpu_is_mx25() && !cpu_is_mx35())
-			goto not_supported;
-
 		err = request_irq(gpio_to_irq(boarddata->cd_gpio), cd_irq,
 				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 				 mmc_hostname(host->mmc), host);
@@ -307,10 +311,19 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			dev_warn(mmc_dev(host->mmc), "request irq error\n");
 			goto no_card_detect_irq;
 		}
+		/* fall through */
 
-		imx_data->flags |= ESDHC_FLAG_GPIO_FOR_CD;
-		/* Now we have a working card_detect again */
+	case ESDHC_CD_SIGNAL:
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
@@ -319,16 +332,20 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
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
@@ -343,14 +360,12 @@ static int __devexit sdhci_esdhc_imx_remove(struct platform_device *pdev)
 
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

