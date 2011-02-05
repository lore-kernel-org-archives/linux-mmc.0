From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH 6/7] ARM: mxs/mx23evk: add mmc device
Date: Sat, 5 Feb 2011 10:18:46 +0800
Message-ID: <1296872327-21166-7-git-send-email-shawn.guo@freescale.com>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:13357 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab1BDSSP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Feb 2011 13:18:15 -0500
In-Reply-To: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@freescale.com>

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx23evk.c |   58 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index c9ac415..3f400cb 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -20,6 +20,7 @@ config MACH_MX23EVK
 	select SOC_IMX23
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_DMA
+	select MXS_HAVE_PLATFORM_MMC
 	default y
 	help
 	  Include support for MX23EVK platform. This includes specific
diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index 13c22a0..3e6bc46 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -26,10 +26,65 @@
 
 #include "devices-mx23.h"
 
+#define MX23EVK_MMC1_WRITE_PROTECT	MXS_GPIO_NR(1, 30)
+#define MX23EVK_MMC1_SLOT_POWER		MXS_GPIO_NR(1, 29)
+
 static const iomux_cfg_t mx23evk_pads[] __initconst = {
 	/* duart */
 	MX23_PAD_PWM0__DUART_RX | MXS_PAD_4MA,
 	MX23_PAD_PWM1__DUART_TX | MXS_PAD_4MA,
+
+	/* mmc */
+	MX23_PAD_SSP1_DATA0__SSP1_DATA0 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DATA1__SSP1_DATA1 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DATA2__SSP1_DATA2 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DATA3__SSP1_DATA3 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_GPMI_D08__SSP1_DATA4 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_GPMI_D09__SSP1_DATA5 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_GPMI_D10__SSP1_DATA6 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_GPMI_D11__SSP1_DATA7 |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_CMD__SSP1_CMD |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX23_PAD_SSP1_DETECT__SSP1_DETECT |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_SSP1_SCK__SSP1_SCK |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* write protect */
+	MX23_PAD_PWM4__GPIO_1_30 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* slot power enable */
+	MX23_PAD_PWM3__GPIO_1_29 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+};
+
+/* mmc */
+static void __init mx23evk_mmc_slot_poweron(int gpio)
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
+static struct mxs_mmc_platform_data mx23_mmc_pdata __initdata = {
+	.wp_gpio = MX23EVK_MMC1_WRITE_PROTECT,
 };
 
 static void __init mx23evk_init(void)
@@ -45,6 +100,9 @@ static void __init mx23evk_init(void)
 	 */
 	mx23_add_apbh_dma();
 	mx23_add_apbx_dma();
+
+	mx23evk_mmc_slot_poweron(MX23EVK_MMC1_SLOT_POWER);
+	mx23_add_mmc(0, &mx23_mmc_pdata);
 }
 
 static void __init mx23evk_timer_init(void)
-- 
1.7.1


