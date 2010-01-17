From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 3/10] omap: Rename hsmmc symbols to reflect independence from twl4030
Date: Sun, 17 Jan 2010 03:33:13 +0200
Message-ID: <20100117013313.17308.77430.sendpatchset@ahunter-work.research.nokia.com>
References: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

>From 189a7b728445f49557bfd3d08af8ec5341632dae Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sun, 17 Jan 2010 02:41:07 +0200
Subject: [PATCH] omap: Rename hsmmc symbols to reflect independence from twl4030

hsmmc.[ch] no longer has any dependency on twl4030
and variable names should be renamed to reflect that.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    4 ++--
 arch/arm/mach-omap2/board-3430sdp.c          |    4 ++--
 arch/arm/mach-omap2/board-cm-t35.c           |    4 ++--
 arch/arm/mach-omap2/board-igep0020.c         |    4 ++--
 arch/arm/mach-omap2/board-ldp.c              |    4 ++--
 arch/arm/mach-omap2/board-omap3beagle.c      |    4 ++--
 arch/arm/mach-omap2/board-omap3evm.c         |    4 ++--
 arch/arm/mach-omap2/board-omap3pandora.c     |    4 ++--
 arch/arm/mach-omap2/board-omap3touchbook.c   |    4 ++--
 arch/arm/mach-omap2/board-overo.c            |    4 ++--
 arch/arm/mach-omap2/board-rx51-peripherals.c |   18 ++++++++----------
 arch/arm/mach-omap2/board-zoom-peripherals.c |    4 ++--
 arch/arm/mach-omap2/hsmmc.c                  |   24 ++++++++++++------------
 arch/arm/mach-omap2/hsmmc.h                  |    6 +++---
 14 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index e42848d..a3d21a6 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -182,7 +182,7 @@ static int __init omap2430_i2c_init(void)
 	return 0;
 }
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
+static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -201,7 +201,7 @@ static void __init omap_2430sdp_init(void)
 
 	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
 	omap_serial_init();
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 	usb_musb_init();
 	board_smc91x_init();
 
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a0cf00f..a77b25e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -326,7 +326,7 @@ static struct twl4030_bci_platform_data sdp3430_bci_data = {
 	.tblsize		= ARRAY_SIZE(sdp3430_batt_table),
 };
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		/* 8 bits (default) requires S6.3 == ON,
@@ -363,7 +363,7 @@ static int sdp3430_twl_gpio_setup(struct device *dev,
 	 */
 	mmc[0].gpio_cd = gpio + 0;
 	mmc[1].gpio_cd = gpio + 1;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 214a2a8..e2b1885 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -364,7 +364,7 @@ static struct twl4030_keypad_data cm_t35_kp_data = {
 	.rep		= 1,
 };
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -413,7 +413,7 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters */
 	cm_t35_vmmc1_supply.dev = mmc[0].dev;
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 9db061f..754bcc0 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -121,7 +121,7 @@ static struct regulator_init_data igep2_vmmc1 = {
 	.consumer_supplies      = &igep2_vmmc1_supply,
 };
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -142,7 +142,7 @@ static int igep2_twl_gpio_setup(struct device *dev,
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 635f54d..e3b0fcd 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -359,7 +359,7 @@ static int __init omap_i2c_init(void)
 	return 0;
 }
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
+static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -396,7 +396,7 @@ static void __init omap_ldp_init(void)
 	omap_serial_init();
 	usb_musb_init();
 
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 	/* link regulators to MMC adapters */
 	ldp_vmmc1_supply.dev = mmc[0].dev;
 }
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index aaa9760..518fde6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -108,7 +108,7 @@ static struct platform_device omap3beagle_nand_device = {
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 8,
@@ -147,7 +147,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	}
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters */
 	beagle_vmmc1_supply.dev = mmc[0].dev;
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 2dd52ad..7916faa 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -185,7 +185,7 @@ static struct regulator_init_data omap3evm_vsim = {
 	.consumer_supplies	= &omap3evm_vsim_supply,
 };
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -225,7 +225,7 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters */
 	omap3evm_vmmc1_supply.dev = mmc[0].dev;
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 3a11506..148be6d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -192,7 +192,7 @@ static struct twl4030_keypad_data pandora_kp_data = {
 	.rep		= 1,
 };
 
-static struct twl4030_hsmmc_info omap3pandora_mmc[] = {
+static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -231,7 +231,7 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	/* gpio + {0,1} is "mmc{0,1}_cd" (input/IRQ) */
 	omap3pandora_mmc[0].gpio_cd = gpio + 0;
 	omap3pandora_mmc[1].gpio_cd = gpio + 1;
-	twl4030_mmc_init(omap3pandora_mmc);
+	omap2_hsmmc_init(omap3pandora_mmc);
 
 	/* link regulators to MMC adapters */
 	pandora_vmmc1_supply.dev = omap3pandora_mmc[0].dev;
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 8efef51..f4987a1 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -122,7 +122,7 @@ static struct platform_device omap3touchbook_nand_device = {
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 8,
@@ -161,7 +161,7 @@ static int touchbook_twl_gpio_setup(struct device *dev,
 	}
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters */
 	touchbook_vmmc1_supply.dev = mmc[0].dev;
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 8a9d439..0597245 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -272,7 +272,7 @@ static void __init overo_flash_init(void)
 	}
 }
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 4,
@@ -297,7 +297,7 @@ static struct regulator_consumer_supply overo_vmmc1_supply = {
 static int overo_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	overo_vmmc1_supply.dev = mmc[0].dev;
 
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index b2de206..ab07ca2 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -209,7 +209,7 @@ static struct twl4030_madc_platform_data rx51_madc_data = {
 	.irq_line		= 1,
 };
 
-static struct twl4030_hsmmc_info mmc[] = {
+static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
 		.mmc		= 1,
@@ -232,15 +232,18 @@ static struct twl4030_hsmmc_info mmc[] = {
 };
 
 static struct regulator_consumer_supply rx51_vmmc1_supply = {
-	.supply			= "vmmc",
+	.supply   = "vmmc",
+	.dev_name = "mmci-omap-hs.0",
 };
 
 static struct regulator_consumer_supply rx51_vmmc2_supply = {
-	.supply			= "vmmc",
+	.supply   = "vmmc",
+	.dev_name = "mmci-omap-hs.1",
 };
 
 static struct regulator_consumer_supply rx51_vsim_supply = {
-	.supply			= "vmmc_aux",
+	.supply   = "vmmc_aux",
+	.dev_name = "mmci-omap-hs.1",
 };
 
 static struct regulator_init_data rx51_vaux1 = {
@@ -375,12 +378,6 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
 	gpio_request(gpio + 7, "speaker_en");
 	gpio_direction_output(gpio + 7, 1);
 
-	/* set up MMC adapters, linking their regulators to them */
-	twl4030_mmc_init(mmc);
-	rx51_vmmc1_supply.dev = mmc[0].dev;
-	rx51_vmmc2_supply.dev = mmc[1].dev;
-	rx51_vsim_supply.dev = mmc[1].dev;
-
 	return 0;
 }
 
@@ -751,5 +748,6 @@ void __init rx51_peripherals_init(void)
 	rx51_init_wl1251();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
+	omap2_hsmmc_init(mmc);
 }
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 671dd06..9a0821f 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -151,7 +151,7 @@ static struct regulator_init_data zoom_vsim = {
 	.consumer_supplies      = &zoom_vsim_supply,
 };
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
+static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
 		.mmc		= 1,
@@ -176,7 +176,7 @@ static int zoom_twl_gpio_setup(struct device *dev,
 {
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
-	twl4030_mmc_init(mmc);
+	omap2_hsmmc_init(mmc);
 
 	/* link regulators to MMC adapters ... we "know" the
 	 * regulators will be set up only *after* we return.
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b88c538..90bf8ce 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -26,20 +26,20 @@ static u16 control_devconf1_offset;
 
 #define HSMMC_NAME_LEN	9
 
-static struct twl_mmc_controller {
+static struct hsmmc_controller {
 	char				name[HSMMC_NAME_LEN + 1];
 } hsmmc[OMAP34XX_NR_MMC];
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 
-static int twl4030_mmc_get_context_loss(struct device *dev)
+static int hsmmc_get_context_loss(struct device *dev)
 {
 	/* FIXME: PM DPS not implemented yet */
 	return 0;
 }
 
 #else
-#define twl4030_mmc_get_context_loss NULL
+#define hsmmc_get_context_loss NULL
 #endif
 
 static void hsmmc1_before_set_reg(struct device *dev, int slot,
@@ -135,9 +135,9 @@ static void hsmmc23_before_set_reg(struct device *dev, int slot,
 
 static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
 
-void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
+void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
-	struct twl4030_hsmmc_info *c;
+	struct omap2_hsmmc_info *c;
 	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
 
 	if (cpu_is_omap2430()) {
@@ -149,7 +149,7 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 	}
 
 	for (c = controllers; c->mmc; c++) {
-		struct twl_mmc_controller *twl = hsmmc + c->mmc - 1;
+		struct hsmmc_controller *hc = hsmmc + c->mmc - 1;
 		struct omap_mmc_platform_data *mmc = hsmmc_data[c->mmc - 1];
 
 		if (!c->mmc || c->mmc > nr_hsmmc) {
@@ -161,25 +161,25 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 			continue;
 		}
 
-		mmc = kzalloc(sizeof(struct omap_mmc_platform_data), GFP_KERNEL);
+		mmc = kzalloc(sizeof(struct omap_mmc_platform_data),
+			      GFP_KERNEL);
 		if (!mmc) {
 			pr_err("Cannot allocate memory for mmc device!\n");
 			return;
 		}
 
 		if (c->name)
-			strncpy(twl->name, c->name, HSMMC_NAME_LEN);
+			strncpy(hc->name, c->name, HSMMC_NAME_LEN);
 		else
-			snprintf(twl->name, ARRAY_SIZE(twl->name),
+			snprintf(hc->name, ARRAY_SIZE(hc->name),
 				"mmc%islot%i", c->mmc, 1);
-		mmc->slots[0].name = twl->name;
+		mmc->slots[0].name = hc->name;
 		mmc->nr_slots = 1;
 		mmc->slots[0].wires = c->wires;
 		mmc->slots[0].internal_clock = !c->ext_clock;
 		mmc->dma_mask = 0xffffffff;
 
-		mmc->get_context_loss_count =
-				twl4030_mmc_get_context_loss;
+		mmc->get_context_loss_count = hsmmc_get_context_loss;
 
 		mmc->slots[0].switch_pin = c->gpio_cd;
 		mmc->slots[0].gpio_wp = c->gpio_wp;
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index 87d67c1..e946b5f 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -6,7 +6,7 @@
  * published by the Free Software Foundation.
  */
 
-struct twl4030_hsmmc_info {
+struct omap2_hsmmc_info {
 	u8	mmc;		/* controller 1/2/3 */
 	u8	wires;		/* 1/4/8 wires */
 	bool	transceiver;	/* MMC-2 option */
@@ -23,11 +23,11 @@ struct twl4030_hsmmc_info {
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
-void twl4030_mmc_init(struct twl4030_hsmmc_info *);
+void omap2_hsmmc_init(struct omap2_hsmmc_info *);
 
 #else
 
-static inline void twl4030_mmc_init(struct twl4030_hsmmc_info *info)
+static inline void omap2_hsmmc_init(struct omap2_hsmmc_info *info)
 {
 }
 
-- 
1.6.0.4

