From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH 7/7] ARM: mxs/mx28evk: add mmc device
Date: Sat, 5 Feb 2011 10:18:47 +0800
Message-ID: <1296872327-21166-8-git-send-email-shawn.guo@freescale.com>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: cjb@laptop.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@freescale.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c |  102 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 3f400cb..b00dd2a 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -32,6 +32,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_DMA
 	select MXS_HAVE_PLATFORM_FEC
+	select MXS_HAVE_PLATFORM_MMC
 	select MXS_OCOTP
 	default y
 	help
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 04ddec1..9752ec2 100644
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
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
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
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* write protect */
+	MX28_PAD_GPMI_RESETN__GPIO_0_28 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* slot power enable */
+	MX28_PAD_PWM4__GPIO_3_29 |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
 };
 
 /* fec */
@@ -159,6 +224,34 @@ error:
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
@@ -173,6 +266,11 @@ static void __init mx28evk_init(void)
 	mx28_add_apbh_dma();
 	mx28_add_apbx_dma();
 
+	mx28evk_mmc_slot_poweron(MX28EVK_MMC0_SLOT_POWER);
+	mx28_add_mmc(0, &mx28_mmc_pdata[0]);
+	mx28evk_mmc_slot_poweron(MX28EVK_MMC1_SLOT_POWER);
+	mx28_add_mmc(1, &mx28_mmc_pdata[0]);
+
 	if (mx28evk_fec_get_mac())
 		pr_warn("%s: failed on fec mac setup\n", __func__);
 
-- 
1.7.1
