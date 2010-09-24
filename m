From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 2/4] esdhc-2 mx51: Modify the MSL codes when upstreaming fsl esdhc driver
Date: Fri, 24 Sep 2010 11:43:06 +0800
Message-ID: <1285299788-32209-3-git-send-email-r65037@freescale.com>
References: <1285299788-32209-1-git-send-email-r65037@freescale.com>
 <1285299788-32209-2-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:4274
	"EHLO DB3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754229Ab0IXDje (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 23:39:34 -0400
Received: from mail22-db3 (localhost.localdomain [127.0.0.1])	by
 mail22-db3-R.bigfish.com (Postfix) with ESMTP id 7AC1327036D	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:49:54 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.251])	by
 mail22-db3.bigfish.com (Postfix) with ESMTP id 5E252C4804C	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:49:52 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o8O3dSUR012701	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 20:39:28
 -0700 (MST)
Received: from shlinux1.ap.freescale.net ([10.192.225.216])	by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o8O3dXn3012365	for
 <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 22:39:34 -0500 (CDT)
In-Reply-To: <1285299788-32209-2-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>

Modify the machine specific codes and add the eSDHC1 and eSDHC2 support
on MX51 BBG platform.
IOMUX, CLOCK, register the device.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c      |   38 ++++++
 arch/arm/mach-mx5/clock-mx51.c              |  193 +++++++++++++++++++++++++++
 arch/arm/mach-mx5/devices.c                 |   46 +++++++
 arch/arm/mach-mx5/devices.h                 |    2 +
 arch/arm/plat-mxc/include/mach/iomux-mx51.h |   33 +++--
 5 files changed, 298 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 6e384d9..e79f8a1 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/fsl_devices.h>
+#include <linux/sdhci-pltfm.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -24,6 +25,7 @@
 #include <mach/iomux-mx51.h>
 #include <mach/i2c.h>
 #include <mach/mxc_ehci.h>
+#include <mach/mmc.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
@@ -33,6 +35,8 @@
 
 #include "devices.h"
 
+#define BABBAGE_SDHCI1_WP	(0*32 + 1)	/* GPIO_1_1 */
+#define BABBAGE_SDHCI2_WP	(0*32 + 5)	/* GPIO_1_5 */
 #define BABBAGE_USB_HUB_RESET	(0*32 + 7)	/* GPIO_1_7 */
 #define BABBAGE_USBH1_STP	(0*32 + 27)	/* GPIO_1_27 */
 #define BABBAGE_PHY_RESET (1*32 +5)	/* GPIO_2_5 */
@@ -93,6 +97,24 @@ static struct pad_desc mx51babbage_pads[] = {
 
 	/* USB HUB reset line*/
 	MX51_PAD_GPIO_1_7__GPIO_1_7,
+
+	/* SDHCI1 IOMUX */
+	MX51_PAD_SD1_CMD__SD1_CMD,
+	MX51_PAD_SD1_CLK__SD1_CLK,
+	MX51_PAD_SD1_DATA0__SD1_DATA0,
+	MX51_PAD_SD1_DATA1__SD1_DATA1,
+	MX51_PAD_SD1_DATA2__SD1_DATA2,
+	MX51_PAD_SD1_DATA3__SD1_DATA3,
+	MX51_PAD_GPIO_1_1__GPIO_1_1,
+
+	/* SDHCI2 IOMUX */
+	MX51_PAD_SD2_CMD__SD2_CMD,
+	MX51_PAD_SD2_CLK__SD2_CLK,
+	MX51_PAD_SD2_DATA0__SD2_DATA0,
+	MX51_PAD_SD2_DATA1__SD2_DATA1,
+	MX51_PAD_SD2_DATA2__SD2_DATA2,
+	MX51_PAD_SD2_DATA3__SD2_DATA3,
+	MX51_PAD_GPIO_1_5__GPIO_1_5,
 };
 
 /* Serial ports */
@@ -240,6 +262,20 @@ static int __init babbage_otg_mode(char *options)
 }
 __setup("otg_mode=", babbage_otg_mode);
 
+struct sdhci_pltfm_data mmc1_data = {
+	/* Board specified max bus width */
+	.caps = MMC_CAP_4_BIT_DATA,
+	/* GPIO pin number that used as the Write Protect */
+	.wp_gpio = BABBAGE_SDHCI1_WP,
+};
+
+struct sdhci_pltfm_data mmc2_data = {
+	/* Board specified max bus width */
+	.caps = MMC_CAP_4_BIT_DATA,
+	/* GPIO pin number that used as the Write Protect */
+	.wp_gpio = BABBAGE_SDHCI2_WP,
+};
+
 /*
  * Board specific initialization.
  */
@@ -255,6 +291,8 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_i2c_device0, &babbage_i2c_data);
 	mxc_register_device(&mxc_i2c_device1, &babbage_i2c_data);
 	mxc_register_device(&mxc_hsi2c_device, &babbage_hsi2c_data);
+	mxc_register_device(&mxcsdhc1_device, &mmc1_data);
+	mxc_register_device(&mxcsdhc2_device, &mmc2_data);
 
 	if (otg_mode_host)
 		mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 6af69de..3526fd3 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -41,6 +41,35 @@ static struct clk usboh3_clk;
 
 #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
 
+static void __calc_pre_post_dividers(u32 div, u32 *pre, u32 *post)
+{
+	u32 min_pre, temp_pre, old_err, err;
+
+	if (div >= 512) {
+		*pre = 8;
+		*post = 64;
+	} else if (div >= 8) {
+		min_pre = (div - 1) / 64 + 1;
+		old_err = 8;
+		for (temp_pre = 8; temp_pre >= min_pre; temp_pre--) {
+			err = div % temp_pre;
+			if (err == 0) {
+				*pre = temp_pre;
+				break;
+			}
+			err = temp_pre - err;
+			if (err < old_err) {
+				old_err = err;
+				*pre = temp_pre;
+			}
+		}
+		*post = (div + *pre - 1) / *pre;
+	} else if (div < 8) {
+		*pre = div;
+		*post = 1;
+	}
+}
+
 static int _clk_ccgr_enable(struct clk *clk)
 {
 	u32 reg;
@@ -762,6 +791,160 @@ static struct clk kpp_clk = {
 	.id = 0,
 };
 
+static int _clk_esdhc1_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 reg, mux;
+	mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk,
+			&pll3_sw_clk, &lp_apm_clk);
+	reg = __raw_readl(MXC_CCM_CSCMR1) &
+		~MXC_CCM_CSCMR1_ESDHC1_MSHC1_CLK_SEL_MASK;
+	reg |= mux << MXC_CCM_CSCMR1_ESDHC1_MSHC1_CLK_SEL_OFFSET;
+	__raw_writel(reg, MXC_CCM_CSCMR1);
+
+	return 0;
+}
+
+static unsigned long _clk_esdhc1_get_rate(struct clk *clk)
+{
+	u32 reg, prediv, podf;
+	unsigned long parent_rate;
+
+	parent_rate = clk_get_rate(clk->parent);
+
+	reg = __raw_readl(MXC_CCM_CSCDR1);
+	prediv = ((reg & MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PRED_MASK) >>
+		  MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PRED_OFFSET) + 1;
+	podf = ((reg & MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PODF_MASK) >>
+		MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PODF_OFFSET) + 1;
+
+	return parent_rate / (prediv * podf);
+}
+
+static int _clk_esdhc1_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 reg, div, parent_rate;
+	u32 pre = 0, post = 0;
+
+	parent_rate = clk_get_rate(clk->parent);
+	div = parent_rate / rate;
+
+	if ((parent_rate / div) != rate)
+		return -EINVAL;
+
+	__calc_pre_post_dividers(div, &pre, &post);
+
+	/* Set sdhc1 clock divider */
+	reg = __raw_readl(MXC_CCM_CSCDR1) &
+		~(MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PRED_MASK
+				| MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PODF_MASK);
+	reg |= (post - 1) << MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PODF_OFFSET;
+	reg |= (pre - 1) << MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PRED_OFFSET;
+	__raw_writel(reg, MXC_CCM_CSCDR1);
+
+	return 0;
+}
+
+static struct clk esdhc1_clk[] = {
+	{
+		.id = 0,
+		.parent = &pll2_sw_clk,
+		.secondary = &esdhc1_clk[1],
+		.enable_shift = MXC_CCM_CCGRx_CG1_OFFSET,
+		.enable_reg = MXC_CCM_CCGR3,
+		.get_rate = _clk_esdhc1_get_rate,
+		.set_rate = _clk_esdhc1_set_rate,
+		.enable = _clk_max_enable,
+		.disable = _clk_max_disable,
+		.set_parent = _clk_esdhc1_set_parent,
+	},
+	{
+		.id = 0,
+		.parent = &ipg_clk,
+		.secondary = NULL,
+		.enable = _clk_max_enable,
+		.enable_reg = MXC_CCM_CCGR3,
+		.enable_shift = MXC_CCM_CCGRx_CG0_OFFSET,
+		.disable = _clk_max_disable,
+	}
+};
+
+static int _clk_esdhc2_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 reg, mux;
+
+	mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk,
+			&pll3_sw_clk, &lp_apm_clk);
+	reg = __raw_readl(MXC_CCM_CSCMR1) &
+		~MXC_CCM_CSCMR1_ESDHC2_MSHC2_CLK_SEL_MASK;
+	reg |= mux << MXC_CCM_CSCMR1_ESDHC2_MSHC2_CLK_SEL_OFFSET;
+
+	__raw_writel(reg, MXC_CCM_CSCMR1);
+	return 0;
+}
+
+static unsigned long _clk_esdhc2_get_rate(struct clk *clk)
+{
+	u32 reg, prediv, podf;
+	unsigned long parent_rate;
+
+	parent_rate = clk_get_rate(clk->parent);
+
+	reg = __raw_readl(MXC_CCM_CSCDR1);
+	prediv = ((reg & MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PRED_MASK) >>
+		  MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PRED_OFFSET) + 1;
+	podf = ((reg & MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PODF_MASK) >>
+		MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PODF_OFFSET) + 1;
+
+	return parent_rate / (prediv * podf);
+}
+
+static int _clk_esdhc2_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 reg, div, parent_rate;
+	u32 pre = 0, post = 0;
+
+	parent_rate = clk_get_rate(clk->parent);
+	div = parent_rate / rate;
+	if ((parent_rate / div) != rate)
+		return -EINVAL;
+
+	__calc_pre_post_dividers(div, &pre, &post);
+
+	/* Set sdhc1 clock divider */
+	reg = __raw_readl(MXC_CCM_CSCDR1) &
+		~(MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PRED_MASK
+				| MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PODF_MASK);
+	reg |= (post - 1) << MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PODF_OFFSET;
+	reg |= (pre - 1) << MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PRED_OFFSET;
+	__raw_writel(reg, MXC_CCM_CSCDR1);
+
+	return 0;
+}
+
+static struct clk esdhc2_clk[] = {
+	{
+		.id = 1,
+		.parent = &pll2_sw_clk,
+		.secondary = &esdhc2_clk[1],
+		.enable_shift = MXC_CCM_CCGRx_CG3_OFFSET,
+		.enable_reg = MXC_CCM_CCGR3,
+		.get_rate = _clk_esdhc2_get_rate,
+		.set_rate = _clk_esdhc2_set_rate,
+		.enable = _clk_max_enable,
+		.disable = _clk_max_disable,
+		.set_parent = _clk_esdhc2_set_parent,
+	},
+	{
+		.id = 1,
+		.parent = &ipg_clk,
+		.secondary = NULL,
+		.enable_shift = MXC_CCM_CCGRx_CG2_OFFSET,
+		.enable_reg = MXC_CCM_CCGR3,
+		.enable = _clk_max_enable,
+		.disable = _clk_max_disable,
+	}
+};
+
 #define DEFINE_CLOCK(name, i, er, es, gr, sr, p, s)	\
 	static struct clk name = {			\
 		.id		= i,			\
@@ -837,6 +1020,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
+	_REGISTER_CLOCK("imx-sdhci.0", "imx_sdhc_clk", esdhc1_clk[0])
+	_REGISTER_CLOCK("imx-sdhci.1", "imx_sdhc_clk", esdhc2_clk[0])
 };
 
 static void clk_tree_init(void)
@@ -880,6 +1065,14 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 	/* set the usboh3_clk parent to pll2_sw_clk */
 	clk_set_parent(&usboh3_clk, &pll2_sw_clk);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(&esdhc1_clk[0], &pll2_sw_clk);
+	clk_set_parent(&esdhc2_clk[0], &pll2_sw_clk);
+
+	/* set SDHC root clock as 166.25MHZ*/
+	clk_set_rate(&esdhc1_clk[0], 166250000);
+	clk_set_rate(&esdhc2_clk[0], 166250000);
+
 	/* System timer */
 	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
 		MX51_MXC_INT_GPT);
diff --git a/arch/arm/mach-mx5/devices.c b/arch/arm/mach-mx5/devices.c
index 1920ff4..c137b36 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -245,6 +245,52 @@ struct platform_device mxc_keypad_device = {
 	.resource = mxc_kpp_resources,
 };
 
+static struct resource mxcsdhc1_resources[] = {
+	{
+		.start = MX51_MMC_SDHC1_BASE_ADDR,
+		.end = MX51_MMC_SDHC1_BASE_ADDR + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = MX51_MXC_INT_MMC_SDHC1,
+		.end = MX51_MXC_INT_MMC_SDHC1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource mxcsdhc2_resources[] = {
+	{
+		.start = MX51_MMC_SDHC2_BASE_ADDR,
+		.end = MX51_MMC_SDHC2_BASE_ADDR + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = MX51_MXC_INT_MMC_SDHC2,
+		.end = MX51_MXC_INT_MMC_SDHC2,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+ struct platform_device mxcsdhc1_device = {
+	.name = "imx-sdhci",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(mxcsdhc1_resources),
+	.resource = mxcsdhc1_resources,
+	.dev = {
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+};
+
+ struct platform_device mxcsdhc2_device = {
+	.name = "imx-sdhci",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(mxcsdhc2_resources),
+	.resource = mxcsdhc2_resources,
+	.dev = {
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+};
+
 static struct mxc_gpio_port mxc_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
diff --git a/arch/arm/mach-mx5/devices.h b/arch/arm/mach-mx5/devices.h
index e509cfa..21b9a6f 100644
--- a/arch/arm/mach-mx5/devices.h
+++ b/arch/arm/mach-mx5/devices.h
@@ -10,3 +10,5 @@ extern struct platform_device mxc_i2c_device0;
 extern struct platform_device mxc_i2c_device1;
 extern struct platform_device mxc_hsi2c_device;
 extern struct platform_device mxc_keypad_device;
+extern struct platform_device mxcsdhc1_device;
+extern struct platform_device mxcsdhc2_device;
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
index 21bfa46..8963852 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
@@ -45,6 +45,9 @@ typedef enum iomux_config {
 				PAD_CTL_PKE | PAD_CTL_HYS)
 #define MX51_GPIO_PAD_CTRL		(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | \
 				PAD_CTL_SRE_FAST)
+#define MX51_SDHCI_PAD_CTRL 	(PAD_CTL_DSE_HIGH | PAD_CTL_PUS_47K_UP | \
+				PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_SRE_FAST | \
+				PAD_CTL_DVS)
 
 /*
  * The naming convention for the pad modes is MX51_PAD_<padname>__<padmode>
@@ -294,20 +297,22 @@ typedef enum iomux_config {
 #define MX51_PAD_DISP2_DAT13__DISP2_DAT13       IOMUX_PAD(0x790, 0x388, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP2_DAT14__DISP2_DAT14       IOMUX_PAD(0x794, 0x38C, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_DISP2_DAT15__DISP2_DAT15       IOMUX_PAD(0x798, 0x390, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_CMD__SD1_CMD               IOMUX_PAD(0x79C, 0x394, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_CLK__SD1_CLK               IOMUX_PAD(0x7A0, 0x398, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA0__SD1_DATA0           IOMUX_PAD(0x7A4, 0x39C, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA1__SD1_DATA1           IOMUX_PAD(0x7A8, 0x3A0, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA2__SD1_DATA2           IOMUX_PAD(0x7AC, 0x3A4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD1_DATA3__SD1_DATA3           IOMUX_PAD(0x7B0, 0x3A8, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_SD1_CMD__SD1_CMD	IOMUX_PAD(0x79C, 0x394, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_CLK__SD1_CLK 	IOMUX_PAD(0x7A0, 0x398, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL \
+		| PAD_CTL_HYS)
+#define MX51_PAD_SD1_DATA0__SD1_DATA0	IOMUX_PAD(0x7A4, 0x39C, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_DATA1__SD1_DATA1	IOMUX_PAD(0x7A8, 0x3A0, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_DATA2__SD1_DATA2	IOMUX_PAD(0x7AC, 0x3A4, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD1_DATA3__SD1_DATA3	IOMUX_PAD(0x7B0, 0x3A8, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_GPIO_1_0__GPIO_1_0		IOMUX_PAD(0x7B4, 0x3AC, 1, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, 1, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_CMD__SD2_CMD               IOMUX_PAD(0x7BC, 0x3B4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_CLK__SD2_CLK               IOMUX_PAD(0x7C0, 0x3B8, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA0__SD2_DATA0           IOMUX_PAD(0x7C4, 0x3BC, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA1__SD2_DATA1           IOMUX_PAD(0x7C8, 0x3C0, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA2__SD2_DATA2           IOMUX_PAD(0x7CC, 0x3C4, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_SD2_DATA3__SD2_DATA3           IOMUX_PAD(0x7D0, 0x3C8, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_1__GPIO_1_1	IOMUX_PAD(0x7B8, 0x3B0, IOMUX_CONFIG_GPIO, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_CMD__SD2_CMD	IOMUX_PAD(0x7BC, 0x3B4, IOMUX_CONFIG_SION, 0x0, 1, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_CLK__SD2_CLK	IOMUX_PAD(0x7C0, 0x3B8, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL \
+		| PAD_CTL_HYS)
+#define MX51_PAD_SD2_DATA0__SD2_DATA0	IOMUX_PAD(0x7C4, 0x3BC, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA1__SD2_DATA1	IOMUX_PAD(0x7C8, 0x3C0, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA2__SD2_DATA2	IOMUX_PAD(0x7CC, 0x3C4, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
+#define MX51_PAD_SD2_DATA3__SD2_DATA3	IOMUX_PAD(0x7D0, 0x3C8, IOMUX_CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_GPIO_1_2__GPIO_1_2		IOMUX_PAD(0x7D4, 0x3CC, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_2__I2C2_SCL		IOMUX_PAD(0x7D4, 0x3CC, (2 | IOMUX_CONFIG_SION), \
 							0x9b8,   3, MX51_I2C_PAD_CTRL)
@@ -316,7 +321,7 @@ typedef enum iomux_config {
 							0x9bc,   3, MX51_I2C_PAD_CTRL)
 #define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, 0, 0x0,   0, NO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 0, 0x0,   0, NO_PAD_CTRL)
-#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 0, 0x0,   0, NO_PAD_CTRL)
+#define MX51_PAD_GPIO_1_5__GPIO_1_5	IOMUX_PAD(0x808, 0x3DC, IOMUX_CONFIG_GPIO, 0x0, 1, MX51_SDHCI_PAD_CTRL)
 #define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_7__GPIO_1_7		IOMUX_PAD(0x810, 0x3E4, 0, 0x0,   0, MX51_GPIO_PAD_CTRL)
 #define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,   1, MX51_GPIO_PAD_CTRL)
-- 
1.7.0


