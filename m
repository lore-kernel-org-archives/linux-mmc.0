From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH v2 7/7] ARM: mxs/mx28evk: add mmc device
Date: Mon, 14 Feb 2011 10:32:26 +0800
Message-ID: <1297650746-12841-8-git-send-email-shawn.guo@freescale.com>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.185]:53455
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754676Ab1BMSbP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 13:31:15 -0500
In-Reply-To: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@freescale.com>

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c |  102 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index f47fae3..287e0f8 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -30,6 +30,7 @@ config MACH_MX28EVK
 	select SOC_IMX28
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_FEC
+	select MXS_HAVE_PLATFORM_MMC
 	select MXS_OCOTP
 	default y
 	help
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index e8db99f..55a9b55 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -28,8 +28,13 @@
 #include "devices-mx28.h"
 #include "gpio.h"
 
-#define MX28EVK_FEC_PHY_POWER	MXS_GPIO_NR(2, 15)
-#define MX28EVK_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
+#define MX28EVK_FEC_PHY_POWER		MXS_GPIO_NR(2, 15)
+#define MX28EVK_FEC_PHY_RESET		MXS_GPIO_NR(4, 13)
+
+#define MX28EVK_MMC0_WRITE_PROTECT	MXS_GPIO_NR(2, 12)
+#define MX28EVK_MMC1_WRITE_PROTECT	MXS_GPIO_NR(0, 28)
+#define MX28EVK_MMC0_SLOT_POWER		MXS_GPIO_NR(3, 28)
+#define MX28EVK_MMC1_SLOT_POWER		MXS_GPIO_NR(3, 29)
 
 static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	/* duart */
@@ -76,6 +81,66 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	/* phy reset line */
 	MX28_PAD_ENET0_RX_CLK__GPIO_4_13 |
 		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
+	/* mmc0 */
+	MX28_PAD_SSP0_DATA0__SSP0_D0 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA1__SSP0_D1 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA2__SSP0_D2 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA3__SSP0_D3 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA4__SSP0_D4 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA5__SSP0_D5 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA6__SSP0_D6 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DATA7__SSP0_D7 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_CMD__SSP0_CMD |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_SSP0_SCK__SSP0_SCK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* write protect */
+	MX28_PAD_SSP1_SCK__GPIO_2_12 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* slot power enable */
+	MX28_PAD_PWM3__GPIO_3_28 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
+	/* mmc1 */
+	MX28_PAD_GPMI_D00__SSP1_D0 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D01__SSP1_D1 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D02__SSP1_D2 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D03__SSP1_D3 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D04__SSP1_D4 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D05__SSP1_D5 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D06__SSP1_D6 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_D07__SSP1_D7 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_RDY1__SSP1_CMD |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_GPMI_RDY0__SSP1_CARD_DETECT |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_GPMI_WRN__SSP1_SCK |
+		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* write protect */
+	MX28_PAD_GPMI_RESETN__GPIO_0_28 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* slot power enable */
+	MX28_PAD_PWM4__GPIO_3_29 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
 };
 
 /* fec */
@@ -159,12 +224,45 @@ error:
 	return -ETIMEDOUT;
 }
 
+/* mmc */
+static void __init mx28evk_mmc_slot_poweron(int gpio)
+{
+	int ret;
+
+	ret = gpio_request(gpio, "mmc-slot-power");
+	if (ret) {
+		pr_err("Failed to request gpio mmc-slot-power: %d\n", ret);
+		return;
+	}
+
+	ret = gpio_direction_output(gpio, 0);
+	if (ret) {
+		pr_err("Failed to drive gpio mmc-slot-power: %d\n", ret);
+		return;
+	}
+}
+
+static struct mxs_mmc_platform_data mx28_mmc_pdata[] __initdata = {
+	{
+		/* mmc0 */
+		.wp_gpio = MX28EVK_MMC0_WRITE_PROTECT,
+	}, {
+		/* mmc1 */
+		.wp_gpio = MX28EVK_MMC1_WRITE_PROTECT,
+	},
+};
+
 static void __init mx28evk_init(void)
 {
 	mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
 
 	mx28_add_duart();
 
+	mx28evk_mmc_slot_poweron(MX28EVK_MMC0_SLOT_POWER);
+	mx28_add_mmc(0, &mx28_mmc_pdata[0]);
+	mx28evk_mmc_slot_poweron(MX28EVK_MMC1_SLOT_POWER);
+	mx28_add_mmc(1, &mx28_mmc_pdata[1]);
+
 	if (mx28evk_fec_get_mac())
 		pr_warn("%s: failed on fec mac setup\n", __func__);
 
-- 
1.7.1


