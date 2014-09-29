From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v2 1/9] omap_hsmmc: use separate platform data for ompa3 and omap 1/2 driver
Date: Mon, 29 Sep 2014 11:32:51 +0200
Message-ID: <1411983179-28677-2-git-send-email-afenkart@gmail.com>
References: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:43189 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaI2JdG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 05:33:06 -0400
In-Reply-To: <1411983179-28677-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

- mmci driver supports multiple slots, omap_hsmmc only one
this leads to one of the major confusions in the omap_hsmmc driver

- platform data should be read-only for the driver
most callbacks are not set by the omap3 platform init code while being
required by the driver, leading to the fact that they are set by the
driver during it's probe function
typical example are card detect / read only detect callbacks

un-bundling by searching for driver name \"omap_hsmmc in the
arch/arm folder. omap_hsmmc_platform_data is not initialized directly,
but from omap2_hsmmc_info, which is defined in a separate header file
not touched by this patch

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 07d4c7b..e3555f2 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -47,7 +47,7 @@ static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 				  int power_on, int vdd)
 {
 	u32 reg, prog_io;
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
 
 	if (mmc->slots[0].remux)
 		mmc->slots[0].remux(dev, slot, power_on);
@@ -120,7 +120,7 @@ static void omap_hsmmc1_after_set_reg(struct device *dev, int slot,
 	}
 }
 
-static void hsmmc2_select_input_clk_src(struct omap_mmc_platform_data *mmc)
+static void hsmmc2_select_input_clk_src(struct omap_hsmmc_platform_data *mmc)
 {
 	u32 reg;
 
@@ -135,7 +135,7 @@ static void hsmmc2_select_input_clk_src(struct omap_mmc_platform_data *mmc)
 static void hsmmc2_before_set_reg(struct device *dev, int slot,
 				   int power_on, int vdd)
 {
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
 
 	if (mmc->slots[0].remux)
 		mmc->slots[0].remux(dev, slot, power_on);
@@ -147,7 +147,7 @@ static void hsmmc2_before_set_reg(struct device *dev, int slot,
 static int am35x_hsmmc2_set_power(struct device *dev, int slot,
 				  int power_on, int vdd)
 {
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	struct omap_hsmmc_platform_data *mmc = dev->platform_data;
 
 	if (power_on)
 		hsmmc2_select_input_clk_src(mmc);
@@ -161,8 +161,8 @@ static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
 	return 0;
 }
 
-static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
-			int controller_nr)
+static inline void omap_hsmmc_mux(struct omap_hsmmc_platform_data
+				  *mmc_controller, int controller_nr)
 {
 	if (gpio_is_valid(mmc_controller->slots[0].switch_pin) &&
 		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
@@ -243,7 +243,7 @@ static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
 }
 
 static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
-					struct omap_mmc_platform_data *mmc)
+					struct omap_hsmmc_platform_data *mmc)
 {
 	char *hc_name;
 
@@ -368,7 +368,7 @@ static int omap_hsmmc_done;
 void omap_hsmmc_late_init(struct omap2_hsmmc_info *c)
 {
 	struct platform_device *pdev;
-	struct omap_mmc_platform_data *mmc_pdata;
+	struct omap_hsmmc_platform_data *mmc_pdata;
 	int res;
 
 	if (omap_hsmmc_done != 1)
@@ -408,12 +408,12 @@ static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 	struct omap_device *od;
 	struct platform_device *pdev;
 	char oh_name[MAX_OMAP_MMC_HWMOD_NAME_LEN];
-	struct omap_mmc_platform_data *mmc_data;
-	struct omap_mmc_dev_attr *mmc_dev_attr;
+	struct omap_hsmmc_platform_data *mmc_data;
+	struct omap_hsmmc_dev_attr *mmc_dev_attr;
 	char *name;
 	int res;
 
-	mmc_data = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
+	mmc_data = kzalloc(sizeof(*mmc_data), GFP_KERNEL);
 	if (!mmc_data) {
 		pr_err("Cannot allocate memory for mmc device!\n");
 		return;
@@ -463,7 +463,7 @@ static void __init omap_hsmmc_init_one(struct omap2_hsmmc_info *hsmmcinfo,
 	}
 
 	res = platform_device_add_data(pdev, mmc_data,
-			      sizeof(struct omap_mmc_platform_data));
+			      sizeof(struct omap_hsmmc_platform_data));
 	if (res) {
 		pr_err("Could not add pdata for %s\n", name);
 		goto put_pdev;
diff --git a/arch/arm/mach-omap2/mmc.h b/arch/arm/mach-omap2/mmc.h
index 0cd4b08..db28c14 100644
--- a/arch/arm/mach-omap2/mmc.h
+++ b/arch/arm/mach-omap2/mmc.h
@@ -1,5 +1,5 @@
 #include <linux/mmc/host.h>
-#include <linux/platform_data/mmc-omap.h>
+#include <linux/platform_data/hsmmc-omap.h>
 
 #define OMAP24XX_NR_MMC		2
 #define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
@@ -8,9 +8,9 @@
 #define OMAP4_MMC_REG_OFFSET	0x100
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
-void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data);
+void omap242x_init_mmc(struct omap_hsmmc_platform_data **mmc_data);
 #else
-static inline void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
+static inline void omap242x_init_mmc(struct omap_hsmmc_platform_data **mmc_data)
 {
 }
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index a579b89..7a85958 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -836,7 +836,7 @@ static struct omap_hwmod_class am33xx_mmc_hwmod_class = {
 };
 
 /* mmc0 */
-static struct omap_mmc_dev_attr am33xx_mmc0_dev_attr = {
+static struct omap_hsmmc_dev_attr am33xx_mmc0_dev_attr = {
 	.flags		= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
 };
 
@@ -854,7 +854,7 @@ struct omap_hwmod am33xx_mmc0_hwmod = {
 };
 
 /* mmc1 */
-static struct omap_mmc_dev_attr am33xx_mmc1_dev_attr = {
+static struct omap_hsmmc_dev_attr am33xx_mmc1_dev_attr = {
 	.flags		= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
 };
 
@@ -872,7 +872,7 @@ struct omap_hwmod am33xx_mmc1_hwmod = {
 };
 
 /* mmc2 */
-static struct omap_mmc_dev_attr am33xx_mmc2_dev_attr = {
+static struct omap_hsmmc_dev_attr am33xx_mmc2_dev_attr = {
 	.flags		= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
 };
 struct omap_hwmod am33xx_mmc2_hwmod = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 1cd0cfd..20a2b88 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1786,12 +1786,12 @@ static struct omap_hwmod_opt_clk omap34xx_mmc1_opt_clks[] = {
 	{ .role = "dbck", .clk = "omap_32k_fck", },
 };
 
-static struct omap_mmc_dev_attr mmc1_dev_attr = {
+static struct omap_hsmmc_dev_attr mmc1_dev_attr = {
 	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
 };
 
 /* See 35xx errata 2.1.1.128 in SPRZ278F */
-static struct omap_mmc_dev_attr mmc1_pre_es3_dev_attr = {
+static struct omap_hsmmc_dev_attr mmc1_pre_es3_dev_attr = {
 	.flags = (OMAP_HSMMC_SUPPORTS_DUAL_VOLT |
 		  OMAP_HSMMC_BROKEN_MULTIBLOCK_READ),
 };
@@ -1854,7 +1854,7 @@ static struct omap_hwmod_opt_clk omap34xx_mmc2_opt_clks[] = {
 };
 
 /* See 35xx errata 2.1.1.128 in SPRZ278F */
-static struct omap_mmc_dev_attr mmc2_pre_es3_dev_attr = {
+static struct omap_hsmmc_dev_attr mmc2_pre_es3_dev_attr = {
 	.flags = OMAP_HSMMC_BROKEN_MULTIBLOCK_READ,
 };
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 35ac2e4..5f2b5b7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -42,7 +42,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
-#include <linux/platform_data/mmc-omap.h>
+#include <linux/platform_data/hsmmc-omap.h>
 
 /* OMAP HSMMC Host Controller Registers */
 #define OMAP_HSMMC_SYSSTATUS	0x0014
@@ -220,7 +220,7 @@ struct omap_hsmmc_host {
 #define HSMMC_SDIO_IRQ_ENABLED	(1 << 1)        /* SDIO irq enabled */
 #define HSMMC_WAKE_IRQ_ENABLED	(1 << 2)
 	struct omap_hsmmc_next	next_data;
-	struct	omap_mmc_platform_data	*pdata;
+	struct	omap_hsmmc_platform_data	*pdata;
 };
 
 struct omap_mmc_of_data {
@@ -233,7 +233,7 @@ static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host);
 static int omap_hsmmc_card_detect(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-	struct omap_mmc_platform_data *mmc = host->pdata;
+	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
 	/* NOTE: assumes card detect signal is active-low */
 	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
@@ -242,7 +242,7 @@ static int omap_hsmmc_card_detect(struct device *dev, int slot)
 static int omap_hsmmc_get_wp(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-	struct omap_mmc_platform_data *mmc = host->pdata;
+	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
 	/* NOTE: assumes write protect signal is active-high */
 	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
@@ -251,7 +251,7 @@ static int omap_hsmmc_get_wp(struct device *dev, int slot)
 static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-	struct omap_mmc_platform_data *mmc = host->pdata;
+	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
 	/* NOTE: assumes card detect signal is active-low */
 	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
@@ -262,7 +262,7 @@ static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
 static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-	struct omap_mmc_platform_data *mmc = host->pdata;
+	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
 	disable_irq(mmc->slots[0].card_detect_irq);
 	return 0;
@@ -271,7 +271,7 @@ static int omap_hsmmc_suspend_cdirq(struct device *dev, int slot)
 static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-	struct omap_mmc_platform_data *mmc = host->pdata;
+	struct omap_hsmmc_platform_data *mmc = host->pdata;
 
 	enable_irq(mmc->slots[0].card_detect_irq);
 	return 0;
@@ -449,7 +449,7 @@ static inline int omap_hsmmc_have_reg(void)
 
 #endif
 
-static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
+static int omap_hsmmc_gpio_init(struct omap_hsmmc_platform_data *pdata)
 {
 	int ret;
 
@@ -492,7 +492,7 @@ err_free_sp:
 	return ret;
 }
 
-static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
+static void omap_hsmmc_gpio_free(struct omap_hsmmc_platform_data *pdata)
 {
 	if (gpio_is_valid(pdata->slots[0].gpio_wp))
 		gpio_free(pdata->slots[0].gpio_wp);
@@ -1286,7 +1286,7 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
 static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
 {
 	struct omap_hsmmc_host *host = dev_id;
-	struct omap_mmc_slot_data *slot = &mmc_slot(host);
+	struct omap_hsmmc_slot_data *slot = &mmc_slot(host);
 	int carddetect;
 
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
@@ -1947,9 +1947,9 @@ static const struct of_device_id omap_mmc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
 
-static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
+static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 {
-	struct omap_mmc_platform_data *pdata;
+	struct omap_hsmmc_platform_data *pdata;
 	struct device_node *np = dev->of_node;
 	u32 bus_width, max_freq;
 	int cd_gpio, wp_gpio;
@@ -1999,7 +1999,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	return pdata;
 }
 #else
-static inline struct omap_mmc_platform_data
+static inline struct omap_hsmmc_platform_data
 			*of_get_hsmmc_pdata(struct device *dev)
 {
 	return ERR_PTR(-EINVAL);
@@ -2008,7 +2008,7 @@ static inline struct omap_mmc_platform_data
 
 static int omap_hsmmc_probe(struct platform_device *pdev)
 {
-	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct omap_hsmmc_platform_data *pdata = pdev->dev.platform_data;
 	struct mmc_host *mmc;
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
new file mode 100644
index 0000000..cb91db4
--- /dev/null
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -0,0 +1,152 @@
+/*
+ * MMC definitions for OMAP2
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define OMAP_MMC_MAX_SLOTS	1
+
+/*
+ * struct omap_hsmmc_dev_attr.flags possibilities
+ *
+ * OMAP_HSMMC_SUPPORTS_DUAL_VOLT: Some HSMMC controller instances can
+ *    operate with either 1.8Vdc or 3.0Vdc card voltages; this flag
+ *    should be set if this is the case.  See for example Section 22.5.3
+ *    "MMC/SD/SDIO1 Bus Voltage Selection" of the OMAP34xx Multimedia
+ *    Device Silicon Revision 3.1.x Revision ZR (July 2011) (SWPU223R).
+ *
+ * OMAP_HSMMC_BROKEN_MULTIBLOCK_READ: Multiple-block read transfers
+ *    don't work correctly on some MMC controller instances on some
+ *    OMAP3 SoCs; this flag should be set if this is the case.  See
+ *    for example Advisory 2.1.1.128 "MMC: Multiple Block Read
+ *    Operation Issue" in _OMAP3530/3525/3515/3503 Silicon Errata_
+ *    Revision F (October 2010) (SPRZ278F).
+ */
+#define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
+#define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
+#define OMAP_HSMMC_SWAKEUP_MISSING		BIT(2)
+
+struct mmc_card;
+
+struct omap_hsmmc_dev_attr {
+	u8 flags;
+};
+
+struct omap_hsmmc_platform_data {
+	/* back-link to device */
+	struct device *dev;
+
+	/* number of slots per controller */
+	unsigned nr_slots:2;
+
+	/* set if your board has components or wiring that limits the
+	 * maximum frequency on the MMC bus */
+	unsigned int max_freq;
+
+	/* switch the bus to a new slot */
+	int (*switch_slot)(struct device *dev, int slot);
+	/* initialize board-specific MMC functionality, can be NULL if
+	 * not supported */
+	int (*init)(struct device *dev);
+	void (*cleanup)(struct device *dev);
+	void (*shutdown)(struct device *dev);
+
+	/* To handle board related suspend/resume functionality for MMC */
+	int (*suspend)(struct device *dev, int slot);
+	int (*resume)(struct device *dev, int slot);
+
+	/* Return context loss count due to PM states changing */
+	int (*get_context_loss_count)(struct device *dev);
+
+	/* Integrating attributes from the omap_hwmod layer */
+	u8 controller_flags;
+
+	/* Register offset deviation */
+	u16 reg_offset;
+
+	struct omap_hsmmc_slot_data {
+		/*
+		 * 4/8 wires and any additional host capabilities
+		 * need to OR'd all capabilities (ref. linux/mmc/host.h)
+		 */
+		u8  wires;	/* Used for the MMC driver on omap1 and 2420 */
+		u32 caps;	/* Used for the MMC driver on 2430 and later */
+		u32 pm_caps;	/* PM capabilities of the mmc */
+
+		/*
+		 * nomux means "standard" muxing is wrong on this board, and
+		 * that board-specific code handled it before common init logic.
+		 */
+		unsigned nomux:1;
+
+		/* switch pin can be for card detect (default) or card cover */
+		unsigned cover:1;
+
+		/* use the internal clock */
+		unsigned internal_clock:1;
+
+		/* nonremovable e.g. eMMC */
+		unsigned nonremovable:1;
+
+		/* Try to sleep or power off when possible */
+		unsigned power_saving:1;
+
+		/* If using power_saving and the MMC power is not to go off */
+		unsigned no_off:1;
+
+		/* eMMC does not handle power off when not in sleep state */
+		unsigned no_regulator_off_init:1;
+
+		/* Regulator off remapped to sleep */
+		unsigned vcc_aux_disable_is_sleep:1;
+
+		/* we can put the features above into this variable */
+#define HSMMC_HAS_PBIAS		(1 << 0)
+#define HSMMC_HAS_UPDATED_RESET	(1 << 1)
+#define HSMMC_HAS_HSPE_SUPPORT	(1 << 2)
+#define MMC_OMAP7XX		(1 << 3)
+#define MMC_OMAP15XX		(1 << 4)
+#define MMC_OMAP16XX		(1 << 5)
+		unsigned features;
+
+		int switch_pin;			/* gpio (card detect) */
+		int gpio_wp;			/* gpio (write protect) */
+
+		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
+		int (*set_power)(struct device *dev, int slot,
+				 int power_on, int vdd);
+		int (*get_ro)(struct device *dev, int slot);
+		void (*remux)(struct device *dev, int slot, int power_on);
+		/* Call back before enabling / disabling regulators */
+		void (*before_set_reg)(struct device *dev, int slot,
+				       int power_on, int vdd);
+		/* Call back after enabling / disabling regulators */
+		void (*after_set_reg)(struct device *dev, int slot,
+				      int power_on, int vdd);
+		/* if we have special card, init it using this callback */
+		void (*init_card)(struct mmc_card *card);
+
+		/* return MMC cover switch state, can be NULL if not supported.
+		 *
+		 * possible return values:
+		 *   0 - closed
+		 *   1 - open
+		 */
+		int (*get_cover_state)(struct device *dev, int slot);
+
+		const char *name;
+		u32 ocr_mask;
+
+		/* Card detection IRQs */
+		int card_detect_irq;
+
+		int (*card_detect)(struct device *dev, int slot);
+
+		unsigned int ban_openended:1;
+
+	} slots[OMAP_MMC_MAX_SLOTS];
+};
-- 
2.1.0

