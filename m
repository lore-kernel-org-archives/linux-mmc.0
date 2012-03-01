From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] mmc: omap_hsmmc: Simplify init for twl6030 MMC card
 detect
Date: Thu, 01 Mar 2012 10:55:35 -0800
Message-ID: <20120301185535.29210.71546.stgit@kaulin.local>
References: <20120301185044.29210.44521.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20555 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab2CASzh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Mar 2012 13:55:37 -0500
In-Reply-To: <20120301185044.29210.44521.stgit@kaulin.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linuxkernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Rajendra Nayak <rnayak@ti.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

There's no need to use callbacks for this, we can
do it directly between MMC driver and twl6030.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |   45 +---------------------------
 arch/arm/mach-omap2/board-omap4panda.c |   52 +-------------------------------
 drivers/mfd/twl6030-irq.c              |   33 +++++++++-----------
 drivers/mmc/host/omap_hsmmc.c          |   31 +++++++++++++++++++
 4 files changed, 48 insertions(+), 113 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 09ae257..c31efa4 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -455,49 +455,6 @@ static struct platform_device omap_vwlan_device = {
 	},
 };
 
-static int omap4_twl6030_hsmmc_late_init(struct device *dev)
-{
-	int ret = 0;
-	struct platform_device *pdev = container_of(dev,
-				struct platform_device, dev);
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
-
-	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0) {
-		ret = twl6030_mmc_card_detect_config();
-		if (ret)
-			pr_err("Failed configuring MMC1 card detect\n");
-		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
-						MMCDETECT_INTR_OFFSET;
-		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
-	}
-	return ret;
-}
-
-static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
-{
-	struct omap_mmc_platform_data *pdata;
-
-	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
-	if (!dev) {
-		pr_err("Failed %s\n", __func__);
-		return;
-	}
-	pdata = dev->platform_data;
-	pdata->init =	omap4_twl6030_hsmmc_late_init;
-}
-
-static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
-{
-	struct omap2_hsmmc_info *c;
-
-	omap_hsmmc_init(controllers);
-	for (c = controllers; c->mmc; c++)
-		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
-
-	return 0;
-}
-
 static struct regulator_init_data sdp4430_vaux1 = {
 	.constraints = {
 		.min_uV			= 1000000,
@@ -906,7 +863,7 @@ static void __init omap_4430sdp_init(void)
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	omap4_sdp4430_wifi_init();
-	omap4_twl6030_hsmmc_init(mmc);
+	omap_hsmmc_init(mmc);
 
 	usb_musb_init(&musb_board_data);
 
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 7ca7a5c..8cf4e54 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -153,8 +153,8 @@ static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
-		.gpio_wp	= -EINVAL,
 		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
 	},
 	{
 		.name		= "wl1271",
@@ -204,54 +204,6 @@ struct wl12xx_platform_data omap_panda_wlan_data  __initdata = {
 	.board_ref_clock = 2,
 };
 
-static int omap4_twl6030_hsmmc_late_init(struct device *dev)
-{
-	int ret = 0;
-	struct platform_device *pdev = container_of(dev,
-				struct platform_device, dev);
-	struct omap_mmc_platform_data *pdata = dev->platform_data;
-
-	if (!pdata) {
-		dev_err(dev, "%s: NULL platform data\n", __func__);
-		return -EINVAL;
-	}
-	/* Setting MMC1 Card detect Irq */
-	if (pdev->id == 0) {
-		ret = twl6030_mmc_card_detect_config();
-		 if (ret)
-			dev_err(dev, "%s: Error card detect config(%d)\n",
-				__func__, ret);
-		 else
-			pdata->slots[0].card_detect = twl6030_mmc_card_detect;
-	}
-	return ret;
-}
-
-static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
-{
-	struct omap_mmc_platform_data *pdata;
-
-	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
-	if (!dev) {
-		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");
-		return;
-	}
-	pdata = dev->platform_data;
-
-	pdata->init =	omap4_twl6030_hsmmc_late_init;
-}
-
-static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
-{
-	struct omap2_hsmmc_info *c;
-
-	omap_hsmmc_init(controllers);
-	for (c = controllers; c->mmc; c++)
-		omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
-
-	return 0;
-}
-
 /* Panda board uses the common PMIC configuration */
 static struct twl4030_platform_data omap4_panda_twldata;
 
@@ -503,7 +455,7 @@ static void __init omap4_panda_init(void)
 	platform_device_register(&omap_vwlan_device);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-	omap4_twl6030_hsmmc_init(mmc);
+	omap_hsmmc_init(mmc);
 	omap4_ehci_init();
 	usb_musb_init(&musb_board_data);
 	omap4_panda_display_init();
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index c6b456a..ce0002b 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -283,35 +283,30 @@ int twl6030_mmc_card_detect_config(void)
 	 * Card status on TWL6030 for MMC1
 	 */
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, TWL6030_MMCCTRL);
-	if (ret < 0) {
-		pr_err("twl6030: Failed to read MMCCTRL, error %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		goto err;
 	reg_val &= ~VMMC_AUTO_OFF;
 	reg_val |= SW_FC;
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCCTRL);
-	if (ret < 0) {
-		pr_err("twl6030: Failed to write MMCCTRL, error %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		goto err;
 
 	/* Configuring PullUp-PullDown register */
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
 						TWL6030_CFG_INPUT_PUPD3);
-	if (ret < 0) {
-		pr_err("twl6030: Failed to read CFG_INPUT_PUPD3, error %d\n",
-									ret);
-		return ret;
-	}
+	if (ret < 0)
+		goto err;
 	reg_val &= ~(MMC_PU | MMC_PD);
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
 						TWL6030_CFG_INPUT_PUPD3);
-	if (ret < 0) {
-		pr_err("twl6030: Failed to write CFG_INPUT_PUPD3, error %d\n",
-									ret);
-		return ret;
-	}
-	return 0;
+	if (ret < 0)
+		goto err;
+
+	return twl6030_irq_base + MMCDETECT_INTR_OFFSET;
+
+err:
+	pr_err("twl6030: Failed to initialize MMC card detect: %d\n", ret);
+	return -ENODEV;
 }
 EXPORT_SYMBOL(twl6030_mmc_card_detect_config);
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1aa2420..7f483b7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -34,6 +34,7 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/i2c/twl.h>
 #include <plat/dma.h>
 #include <mach/hardware.h>
 #include <plat/board.h>
@@ -578,6 +579,32 @@ static void omap_hsmmc_gpio_free(struct omap_hsmmc_host *host)
 		gpio_free(host->gpio_cd);
 }
 
+#ifdef CONFIG_TWL4030_CORE
+static int omap_hsmmc_init_twl6030(struct omap_hsmmc_host *host)
+{
+	struct omap_mmc_platform_data *pdata = host->pdata;
+	struct omap_mmc_slot_data *slot = &pdata->slots[0];
+	int irq;
+
+	if (gpio_is_valid(host->gpio_cd) || host->id)
+		return 0;
+
+	irq = twl6030_mmc_card_detect_config();
+	if (irq <= 0)
+		return irq;
+
+	slot->card_detect_irq = irq;
+	slot->card_detect = twl6030_mmc_card_detect;
+
+	return 0;
+}
+#else
+static inline int omap_hsmmc_init_twl6030(struct omap_hsmmc_host *host)
+{
+	return -ENODEV;
+}
+#endif
+
 /*
  * Start clock to the card
  */
@@ -1933,6 +1960,10 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err1;
 
+	ret = omap_hsmmc_init_twl6030(host);
+	if (ret)
+		goto err1;
+
 	mmc->ops	= &omap_hsmmc_ops;
 
 	/*

