From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v3 2/5] OMAP4 HSMMC: Adding hsmmc support to board file
Date: Fri, 14 May 2010 01:41:37 +0530 (IST)
Message-ID: <12490.10.24.255.17.1273781497.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34145 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692Ab0EMULv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 May 2010 16:11:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, adrian.hunter@nokia.com

Support for MMC1 & MMC2 controllers is added to the board file.
Also includes configuration of MMC1 Card detect initially.

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/Makefile        |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c |   64 +++++++++++++++++++++++++++++++----
 include/linux/i2c/twl.h             |   44 ++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ffe600a..65d8d11 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -140,7 +140,8 @@ obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-omap3touchbook.o \
 					   hsmmc.o
-obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
+obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o \
+					   hsmmc.o

 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index d86e22d..70c8ab7 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -32,6 +32,8 @@
 #include <plat/control.h>
 #include <plat/timer-gp.h>
 #include <plat/usb.h>
+#include <plat/mmc.h>
+#include "hsmmc.h"

 static struct platform_device sdp4430_lcd_device = {
 	.name		= "sdp4430_lcd",
@@ -68,24 +70,71 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };

-static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
-	{
-		.supply = "vmmc",
-	},
+static struct omap2_hsmmc_info mmc[] = {
 	{
-		.supply = "vmmc",
+		.mmc		= 1,
+		.wires		= 8,
+		.gpio_cd	= TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET,
+		.cd_type	= NON_GPIO,
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
+	/* MMC1 Card detect Configuration */
+	if (pdev->id == 0) {
+		ret = omap4_hsmmc1_card_detect_config();
+		if (ret < 0)
+			pr_err("Unable to configure Card detect for MMC1\n");
+		pdata->slots[0].card_detect_irq = TWL6030_IRQ_BASE +
+						MMCDETECT_INTR_OFFSET;
+	}
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
@@ -137,7 +186,7 @@ static struct regulator_init_data sdp4430_vmmc = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = 5,
+	.num_consumer_supplies  = 2,
 	.consumer_supplies      = sdp4430_vmmc_supply,
 };

@@ -256,6 +305,7 @@ static void __init omap_4430sdp_init(void)
 	omap4_i2c_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
+	omap4_twl6030_hsmmc_init(mmc);
 	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
 	usb_nop_xceiv_register();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index fb6784e..f382d59 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -141,6 +141,15 @@
 #define TWL6030_CHARGER_CTRL_INT_MASK 	0x10
 #define TWL6030_CHARGER_FAULT_INT_MASK 	0x60

+#define TWL6030_MMCCTRL			0xEE
+#define VMMC_AUTO_OFF			(0x1 << 3)
+#define SW_FC				(0x1 << 2)
+#define STS_MMC				0x1
+
+#define TWL6030_CFG_INPUT_PUPD3		0xF2
+#define MMC_PU				(0x1 << 3)
+#define MMC_PD				(0x1 << 2)
+

 #define TWL4030_CLASS_ID 		0x4030
 #define TWL6030_CLASS_ID 		0x6030
@@ -173,6 +182,41 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);

+/* Configuring Card Detect for MMC1 */
+static inline int omap4_hsmmc1_card_detect_config(void)
+{
+	int res = -1;
+	u8 reg_val = 0;
+
+	/* Unmasking the Card detect Interrupt line for MMC1 from Phoenix */
+	if (twl_class_is_6030()) {
+		twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_MASK,
+							REG_INT_MSK_LINE_B);
+		twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_MASK,
+							REG_INT_MSK_STS_B);
+	}
+
+	/*
+	 * Intially Configuring MMC_CTRL for receving interrupts &
+	 * Card status on TWL6030 for MMC1
+	 */
+	res = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, TWL6030_MMCCTRL);
+	if (res < 0)
+		return res;
+	reg_val &= ~VMMC_AUTO_OFF;
+	reg_val |= SW_FC;
+	twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCCTRL);
+
+	res = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
+						TWL6030_CFG_INPUT_PUPD3);
+	if (res < 0)
+		return res;
+	reg_val &= ~(MMC_PU | MMC_PD);
+	twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
+						TWL6030_CFG_INPUT_PUPD3);
+	return res;
+}
+
 /*----------------------------------------------------------------------*/

 /*
-- 
1.6.3.3

