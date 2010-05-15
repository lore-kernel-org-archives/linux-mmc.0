From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v4 1/5] OMAP4 HSMMC: Adding hsmmc support to board file
Date: Sat, 15 May 2010 23:51:06 +0530 (IST)
Message-ID: <22485.10.24.255.17.1273947666.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44552 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792Ab0EOSVV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 15 May 2010 14:21:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, adrian.hunter@nokia.com, santosh.shilimkar@ti.com

Adding support for MMC1 & MMC2 controllers of OMAP4430 SDP
to board file.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/Makefile        |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c |   59 ++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 203a414..a799453 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -137,7 +137,8 @@ obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
 					   hsmmc.o
-obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
+obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o \
+					   hsmmc.o

 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 921cde3..e4a5d66 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -33,6 +33,8 @@
 #include <plat/control.h>
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
+#include <plat/mmc.h>
+#include "hsmmc.h"

 #define ETH_KS8851_IRQ			34
 #define ETH_KS8851_POWER_ON		48
@@ -137,24 +139,66 @@ static struct omap_musb_board_data musb_board_data = {
 	.mode			= MUSB_PERIPHERAL,
 	.power			= 100,
 };
-static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
-	{
-		.supply = "vmmc",
-	},
+
+static struct omap2_hsmmc_info mmc[] = {
 	{
-		.supply = "vmmc",
+		.mmc		= 1,
+		.wires		= 8,
+		.gpio_wp	= -EINVAL,
 	},
 	{
-		.supply = "vmmc",
+		.mmc		= 2,
+		.wires		= 8,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+		.nonremovable   = true,
 	},
+	{}	/* Terminator */
+};
+
+static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
 	{
 		.supply = "vmmc",
+		.dev_name = "mmci-omap-hs.0",
 	},
 	{
 		.supply = "vmmc",
+		.dev_name = "mmci-omap-hs.1",
 	},
 };

+static int omap4_twl6030_hsmmc_late_init(struct device *dev)
+{
+	int ret = 0;
+	struct platform_device *pdev = container_of(dev,
+				struct platform_device, dev);
+	struct omap_mmc_platform_data *pdata = dev->platform_data;
+
+	/* Setting MMC1 Card detect Irq */
+	if (pdev->id == 0)
+		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
+						MMCDETECT_INTR_OFFSET;
+	return ret;
+}
+
+static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
+{
+	struct omap_mmc_platform_data *pdata = dev->platform_data;
+
+	pdata->init =	omap4_twl6030_hsmmc_late_init;
+}
+
+static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
+{
+	struct omap2_hsmmc_info *c;
+
+	omap2_hsmmc_init(controllers);
+	for (c = controllers; c->mmc; c++)
+		omap4_twl6030_hsmmc_set_late_init(c->dev);
+
+	return 0;
+}
+
 static struct regulator_init_data sdp4430_vaux1 = {
 	.constraints = {
 		.min_uV			= 1000000,
@@ -206,7 +250,7 @@ static struct regulator_init_data sdp4430_vmmc = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = 5,
+	.num_consumer_supplies  = 2,
 	.consumer_supplies      = sdp4430_vmmc_supply,
 };

@@ -329,6 +373,7 @@ static void __init omap_4430sdp_init(void)
 	omap4_i2c_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
+	omap4_twl6030_hsmmc_init(mmc);
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
 	usb_nop_xceiv_register();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
-- 
1.6.3.3


