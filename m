From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 6/10] omap: RX51: Remux to pull eMMC lines down when powering off
Date: Sun, 17 Jan 2010 03:33:36 +0200
Message-ID: <20100117013336.17308.685.sendpatchset@ahunter-work.research.nokia.com>
References: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58035 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab0AQBeS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jan 2010 20:34:18 -0500
In-Reply-To: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

>From 58f549be326b94b9e1eb74f31d751d01605229d5 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 15 Jan 2010 15:18:39 +0200
Subject: [PATCH] omap: RX51: Remux to pull eMMC lines down when powering off

It has been discovered that, when eMMC is powered off, current
will flow from OMAP eMMC data pull-ups to the eMMC voltage supply.
Configuring pads for OMAP off-mode does not help because eMMC is
powered off independently of OMAP off-mode.  Hence the pads are
now re-configured when eMMC is powered on or off.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   43 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/hsmmc.c                  |    8 +++++
 arch/arm/mach-omap2/hsmmc.h                  |    2 +
 arch/arm/plat-omap/include/plat/mmc.h        |    1 +
 4 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ab07ca2..4377a4c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -209,6 +209,46 @@ static struct twl4030_madc_platform_data rx51_madc_data = {
 	.irq_line		= 1,
 };
 
+/* Enable input logic and pull all lines up when eMMC is on. */
+static struct omap_board_mux rx51_mmc2_on_mux[] = {
+	OMAP3_MUX(SDMMC2_CMD, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT0, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT1, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT2, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT3, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT4, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT5, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT6, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT7, OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+/* Disable input logic and pull all lines down when eMMC is off. */
+static struct omap_board_mux rx51_mmc2_off_mux[] = {
+	OMAP3_MUX(SDMMC2_CMD, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT0, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT1, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT2, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT3, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT4, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT5, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT6, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	OMAP3_MUX(SDMMC2_DAT7, OMAP_PULL_ENA | OMAP_MUX_MODE0),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+/*
+ * Current flows to eMMC when eMMC is off and the data lines are pulled up,
+ * so pull them down. N.B. we pull 8 lines because we are using 8 lines.
+ */
+static void rx51_mmc2_remux(struct device *dev, int slot, int power_on)
+{
+	if (power_on)
+		omap_mux_write_array(rx51_mmc2_on_mux);
+	else
+		omap_mux_write_array(rx51_mmc2_off_mux);
+}
+
 static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
@@ -222,11 +262,12 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "internal",
 		.mmc		= 2,
-		.wires		= 8,
+		.wires		= 8, /* See also rx51_mmc2_remux */
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.nonremovable	= true,
 		.power_saving	= true,
+		.remux		= rx51_mmc2_remux,
 	},
 	{}	/* Terminator */
 };
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 2a88f49..0ac5e4e 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -48,6 +48,9 @@ static void hsmmc1_before_set_reg(struct device *dev, int slot,
 	u32 reg, prog_io;
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
+	if (mmc->slots[0].remux)
+		mmc->slots[0].remux(dev, slot, power_on);
+
 	/*
 	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
 	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
@@ -121,6 +124,9 @@ static void hsmmc23_before_set_reg(struct device *dev, int slot,
 {
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
+	if (mmc->slots[0].remux)
+		mmc->slots[0].remux(dev, slot, power_on);
+
 	if (power_on) {
 		/* Only MMC2 supports a CLKIN */
 		if (mmc->slots[0].internal_clock) {
@@ -184,6 +190,8 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		mmc->slots[0].switch_pin = c->gpio_cd;
 		mmc->slots[0].gpio_wp = c->gpio_wp;
 
+		mmc->slots[0].remux = c->remux;
+
 		if (c->cover_only)
 			mmc->slots[0].cover = 1;
 
diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
index e946b5f..f641f59 100644
--- a/arch/arm/mach-omap2/hsmmc.h
+++ b/arch/arm/mach-omap2/hsmmc.h
@@ -19,6 +19,8 @@ struct omap2_hsmmc_info {
 	char	*name;		/* or NULL for default */
 	struct device *dev;	/* returned: pointer to mmc adapter */
 	int	ocr_mask;	/* temporary HACK */
+	/* Remux (pad configuation) when powering on/off */
+	void (*remux)(struct device *dev, int slot, int power_on);
 };
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 515701b..8b23d32 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -105,6 +105,7 @@ struct omap_mmc_platform_data {
 		int (*get_ro)(struct device *dev, int slot);
 		int (*set_sleep)(struct device *dev, int slot, int sleep,
 				 int vdd, int cardsleep);
+		void (*remux)(struct device *dev, int slot, int power_on);
 		/* Call back before enabling / disabling regulators */
 		void (*before_set_reg)(struct device *dev, int slot,
 				       int power_on, int vdd);
-- 
1.6.0.4

