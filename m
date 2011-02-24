From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH v4 6/6] OMAP: hsmmc: Rename the device and driver
Date: Fri, 25 Feb 2011 00:56:54 +0530
Message-ID: <1298575614-9388-7-git-send-email-kishore.kadiyala@ti.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>
List-Id: linux-mmc@vger.kernel.org

Modifying the device & driver name from "mmci-omap-hs" to
"omap_hsmmc".

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Chris Ball <cjb@laptop.org
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c          |    6 +++---
 arch/arm/mach-omap2/board-4430sdp.c          |    4 ++--
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-igep0020.c         |    6 +++---
 arch/arm/mach-omap2/board-igep0030.c         |    6 +++---
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |    6 +++---
 arch/arm/mach-omap2/board-omap4panda.c       |    4 ++--
 arch/arm/mach-omap2/board-rm680.c            |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    8 ++++----
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
 arch/arm/mach-omap2/clock2430_data.c         |   12 ++++++------
 arch/arm/mach-omap2/clock3xxx_data.c         |   12 ++++++------
 arch/arm/mach-omap2/clock44xx_data.c         |   20 ++++++++++----------
 arch/arm/mach-omap2/hsmmc.c                  |    2 +-
 drivers/mmc/host/omap_hsmmc.c                |    2 +-
 17 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index cc42d47..ab0880b 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -149,7 +149,7 @@ static void __init omap_2430sdp_init_early(void)
 }
 
 static struct regulator_consumer_supply sdp2430_vmmc1_supplies[] = {
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0"),
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 8950ecc..40b0174 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -410,15 +410,15 @@ static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
 };
 
 static struct regulator_consumer_supply sdp3430_vmmc1_supplies[] = {
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0"),
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
 
 static struct regulator_consumer_supply sdp3430_vsim_supplies[] = {
-	REGULATOR_SUPPLY("vmmc_aux", "mmci-omap-hs.0"),
+	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0"),
 };
 
 static struct regulator_consumer_supply sdp3430_vmmc2_supplies[] = {
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1"),
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1"),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1a943be..cca2fbc 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -367,13 +367,13 @@ static struct omap2_hsmmc_info mmc[] = {
 static struct regulator_consumer_supply sdp4430_vaux_supply[] = {
 	{
 		.supply = "vmmc",
-		.dev_name = "mmci-omap-hs.1",
+		.dev_name = "omap_hsmmc.1",
 	},
 };
 static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
 	{
 		.supply = "vmmc",
-		.dev_name = "mmci-omap-hs.0",
+		.dev_name = "omap_hsmmc.0",
 	},
 };
 
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 54abdd0..c9170f4 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -140,7 +140,7 @@ static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
 }
 
 static struct regulator_consumer_supply devkit8000_vmmc1_supply =
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
 
 /* ads7846 on SPI */
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 54e6318..1877c28 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -250,7 +250,7 @@ static inline void __init igep2_init_smsc911x(void) { }
 #endif
 
 static struct regulator_consumer_supply igep2_vmmc1_supply =
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
 static struct regulator_init_data igep2_vmmc1 = {
@@ -268,7 +268,7 @@ static struct regulator_init_data igep2_vmmc1 = {
 };
 
 static struct regulator_consumer_supply igep2_vio_supply =
-	REGULATOR_SUPPLY("vmmc_aux", "mmci-omap-hs.1");
+	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.1");
 
 static struct regulator_init_data igep2_vio = {
 	.constraints = {
@@ -286,7 +286,7 @@ static struct regulator_init_data igep2_vio = {
 };
 
 static struct regulator_consumer_supply igep2_vmmc2_supply =
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
 
 static struct regulator_init_data igep2_vmmc2 = {
 	.constraints		= {
diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index d75028e..4273d06 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -142,7 +142,7 @@ static void __init igep3_flash_init(void) {}
 #endif
 
 static struct regulator_consumer_supply igep3_vmmc1_supply =
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
 static struct regulator_init_data igep3_vmmc1 = {
@@ -160,7 +160,7 @@ static struct regulator_init_data igep3_vmmc1 = {
 };
 
 static struct regulator_consumer_supply igep3_vio_supply =
-	REGULATOR_SUPPLY("vmmc_aux", "mmci-omap-hs.1");
+	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.1");
 
 static struct regulator_init_data igep3_vio = {
 	.constraints = {
@@ -178,7 +178,7 @@ static struct regulator_init_data igep3_vio = {
 };
 
 static struct regulator_consumer_supply igep3_vmmc2_supply =
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
 
 static struct regulator_init_data igep3_vmmc2 = {
 	.constraints	= {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5364147..cccc817 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -605,7 +605,7 @@ static struct regulator_init_data omap3evm_vio = {
 
 static struct regulator_consumer_supply omap3evm_vmmc2_supply = {
 	.supply			= "vmmc",
-	.dev_name		= "mmci-omap-hs.1",
+	.dev_name		= "omap_hsmmc.1",
 };
 
 /* VMMC2 for driving the WL12xx module */
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 17ef547..ed13869 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -333,13 +333,13 @@ static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
 };
 
 static struct regulator_consumer_supply pandora_vmmc1_supply =
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
 static struct regulator_consumer_supply pandora_vmmc2_supply =
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
 
 static struct regulator_consumer_supply pandora_vmmc3_supply =
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.2");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.2");
 
 static struct regulator_consumer_supply pandora_vdda_dac_supply =
 	REGULATOR_SUPPLY("vdda_dac", "omapdss");
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 3dd241b..12bf09a 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -180,13 +180,13 @@ static struct omap2_hsmmc_info mmc[] = {
 static struct regulator_consumer_supply omap4_panda_vmmc_supply[] = {
 	{
 		.supply = "vmmc",
-		.dev_name = "mmci-omap-hs.0",
+		.dev_name = "omap_hsmmc.0",
 	},
 };
 
 static struct regulator_consumer_supply omap4_panda_vmmc5_supply = {
 	.supply = "vmmc",
-	.dev_name = "mmci-omap-hs.4",
+	.dev_name = "omap_hsmmc.4",
 };
 
 static struct regulator_init_data panda_vmmc5 = {
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index bdebcb7..2af8b05 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -33,7 +33,7 @@
 #include "sdram-nokia.h"
 
 static struct regulator_consumer_supply rm680_vemmc_consumers[] = {
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1"),
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1"),
 };
 
 /* Fixed regulator for internal eMMC */
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index e75e240..b74357f 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -331,13 +331,13 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 };
 
 static struct regulator_consumer_supply rx51_vmmc1_supply =
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0");
 
 static struct regulator_consumer_supply rx51_vaux3_supply =
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
 
 static struct regulator_consumer_supply rx51_vsim_supply =
-	REGULATOR_SUPPLY("vmmc_aux", "mmci-omap-hs.1");
+	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.1");
 
 static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
 	/* tlv320aic3x analog supplies */
@@ -348,7 +348,7 @@ static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
 	/* tpa6130a2 */
 	REGULATOR_SUPPLY("Vdd", "2-0060"),
 	/* Keep vmmc as last item. It is not iterated for newer boards */
-	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1"),
+	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1"),
 };
 
 static struct regulator_consumer_supply rx51_vio_supplies[] = {
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index e0e040f..7a098a4 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -118,7 +118,7 @@ static struct regulator_consumer_supply zoom_vmmc2_supply = {
 
 static struct regulator_consumer_supply zoom_vmmc3_supply = {
 	.supply		= "vmmc",
-	.dev_name	= "mmci-omap-hs.2",
+	.dev_name	= "omap_hsmmc.2",
 };
 
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index c047dcd..5c647ce 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1984,15 +1984,15 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X),
 	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X),
 	CLK("musb-omap2430",	"ick",	&usbhs_ick,	CK_243X),
-	CLK("mmci-omap-hs.0", "ick",	&mmchs1_ick,	CK_243X),
-	CLK("mmci-omap-hs.0", "fck",	&mmchs1_fck,	CK_243X),
-	CLK("mmci-omap-hs.1", "ick",	&mmchs2_ick,	CK_243X),
-	CLK("mmci-omap-hs.1", "fck",	&mmchs2_fck,	CK_243X),
+	CLK("omap_hsmmc.0", "ick",	&mmchs1_ick,	CK_243X),
+	CLK("omap_hsmmc.0", "fck",	&mmchs1_fck,	CK_243X),
+	CLK("omap_hsmmc.1", "ick",	&mmchs2_ick,	CK_243X),
+	CLK("omap_hsmmc.1", "fck",	&mmchs2_fck,	CK_243X),
 	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_243X),
 	CLK(NULL,	"gpio5_fck",	&gpio5_fck,	CK_243X),
 	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
-	CLK("mmci-omap-hs.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
-	CLK("mmci-omap-hs.1", "mmchsdb_fck", 	&mmchsdb2_fck,	CK_243X),
+	CLK("omap_hsmmc.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
+	CLK("omap_hsmmc.1", "mmchsdb_fck",	&mmchsdb2_fck,	CK_243X),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index f14d986..052ac32 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3290,10 +3290,10 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap-mcbsp.1",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK("omap-mcbsp.5",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
-	CLK("mmci-omap-hs.2",	"fck",	&mmchs3_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_3XXX),
+	CLK("omap_hsmmc.2",	"fck",	&mmchs3_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("omap_hsmmc.1",	"fck",	&mmchs2_fck,	CK_3XXX),
 	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_34XX | CK_36XX),
-	CLK("mmci-omap-hs.0",	"fck",	&mmchs1_fck,	CK_3XXX),
+	CLK("omap_hsmmc.0",	"fck",	&mmchs1_fck,	CK_3XXX),
 	CLK("omap_i2c.3", "fck",	&i2c3_fck,	CK_3XXX),
 	CLK("omap_i2c.2", "fck",	&i2c2_fck,	CK_3XXX),
 	CLK("omap_i2c.1", "fck",	&i2c1_fck,	CK_3XXX),
@@ -3323,13 +3323,13 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_3XXX),
 	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("ehci-omap.0",	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("omap_hsmmc.2",	"ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_34XX | CK_36XX),
 	CLK("omap-aes",	"ick",	&aes2_ick,	CK_34XX | CK_36XX),
 	CLK("omap-sham",	"ick",	&sha12_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"des2_ick",	&des2_ick,	CK_34XX | CK_36XX),
-	CLK("mmci-omap-hs.1",	"ick",	&mmchs2_ick,	CK_3XXX),
-	CLK("mmci-omap-hs.0",	"ick",	&mmchs1_ick,	CK_3XXX),
+	CLK("omap_hsmmc.1",	"ick",	&mmchs2_ick,	CK_3XXX),
+	CLK("omap_hsmmc.0",	"ick",	&mmchs1_ick,	CK_3XXX),
 	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_34XX | CK_36XX),
 	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_3XXX),
 	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index de9ec8d..fdbc042 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3158,11 +3158,11 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap2_mcspi.2",	"fck",				&mcspi2_fck,	CK_443X),
 	CLK("omap2_mcspi.3",	"fck",				&mcspi3_fck,	CK_443X),
 	CLK("omap2_mcspi.4",	"fck",				&mcspi4_fck,	CK_443X),
-	CLK("mmci-omap-hs.0",	"fck",				&mmc1_fck,	CK_443X),
-	CLK("mmci-omap-hs.1",	"fck",				&mmc2_fck,	CK_443X),
-	CLK("mmci-omap-hs.2",	"fck",				&mmc3_fck,	CK_443X),
-	CLK("mmci-omap-hs.3",	"fck",				&mmc4_fck,	CK_443X),
-	CLK("mmci-omap-hs.4",	"fck",				&mmc5_fck,	CK_443X),
+	CLK("omap_hsmmc.0",	"fck",				&mmc1_fck,	CK_443X),
+	CLK("omap_hsmmc.1",	"fck",				&mmc2_fck,	CK_443X),
+	CLK("omap_hsmmc.2",	"fck",				&mmc3_fck,	CK_443X),
+	CLK("omap_hsmmc.3",	"fck",				&mmc4_fck,	CK_443X),
+	CLK("omap_hsmmc.4",	"fck",				&mmc5_fck,	CK_443X),
 	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",	&ocp2scp_usb_phy_phy_48m,	CK_443X),
 	CLK(NULL,	"ocp2scp_usb_phy_ick",		&ocp2scp_usb_phy_ick,	CK_443X),
 	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_443X),
@@ -3245,11 +3245,11 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK("omap_i2c.2",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap_i2c.3",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap_i2c.4",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.0",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.1",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.2",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.3",	"ick",				&dummy_ck,	CK_443X),
-	CLK("mmci-omap-hs.4",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap_hsmmc.0",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap_hsmmc.1",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap_hsmmc.2",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap_hsmmc.3",	"ick",				&dummy_ck,	CK_443X),
+	CLK("omap_hsmmc.4",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.1",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.2",	"ick",				&dummy_ck,	CK_443X),
 	CLK("omap-mcbsp.3",	"ick",				&dummy_ck,	CK_443X),
diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index c370c75..9b31724 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -451,7 +451,7 @@ static int omap_mmc_init(struct omap_hwmod *oh, void *hsmmcinfo)
 	}
 
 	idx = c->mmc - 1 ;
-	name = "mmci-omap-hs";
+	name = "omap_hsmmc";
 	ohl = omap_hsmmc_latency;
 	ohl_cnt = ARRAY_SIZE(omap_hsmmc_latency);
 	omap_hsmmc_mux(mmc, idx);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index d0bd2b4..191332b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -118,7 +118,7 @@
 
 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MASTER_CLOCK	96000000
-#define DRIVER_NAME		"mmci-omap-hs"
+#define DRIVER_NAME		"omap_hsmmc"
 
 /* Timeouts for entering power saving states on inactivity, msec */
 #define OMAP_MMC_DISABLED_TIMEOUT	100
-- 
1.7.1

