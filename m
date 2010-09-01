From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 7/9] esdhc-3 mx51: Modify the MSL codes when upstreaming fsl
	esdhc driver
Date: Wed, 1 Sep 2010 17:48:38 +0800
Message-ID: <1283334518-12758-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Richard Zhu <r65037@freescale.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Modify the MSL codes and add the eSDHC1 and eSDHC2 support
on MX51 BBG platform.
IOMUX, CLOCK, register the device.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |   70 +++++++++++
 arch/arm/mach-mx5/clock-mx51.c         |  197 ++++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/devices.c            |   52 +++++++++
 arch/arm/mach-mx5/devices.h            |    2 +
 4 files changed, 321 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 6e384d9..57873fb 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -24,6 +24,7 @@
 #include <mach/iomux-mx51.h>
 #include <mach/i2c.h>
 #include <mach/mxc_ehci.h>
+#include <mach/mmc.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
@@ -33,6 +34,8 @@
 
 #include "devices.h"
 
+#define BABBAGE_SDHCI1_WP	(0*32 + 1)	/* GPIO_1_1 */
+#define BABBAGE_SDHCI2_WP	(0*32 + 5)	/* GPIO_1_5 */
 #define BABBAGE_USB_HUB_RESET	(0*32 + 7)	/* GPIO_1_7 */
 #define BABBAGE_USBH1_STP	(0*32 + 27)	/* GPIO_1_27 */
 #define BABBAGE_PHY_RESET (1*32 +5)	/* GPIO_2_5 */
@@ -93,6 +96,24 @@ static struct pad_desc mx51babbage_pads[] = {
 
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
+	MX51_PAD_GPIO_1_0__GPIO_1_0,
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
@@ -240,6 +261,53 @@ static int __init babbage_otg_mode(char *options)
 }
 __setup("otg_mode=", babbage_otg_mode);
 
+static int sdhc_write_protect(struct device *dev)
+{
+	struct pad_desc sdhci1wp_gpio = MX51_PAD_GPIO_1_1__GPIO_1_1;
+	struct pad_desc sdhci2wp_gpio = MX51_PAD_GPIO_1_5__GPIO_1_5;
+	int ret;
+
+	/* Set SDHCI1_WP to GPIO1_1 */
+	mxc_iomux_v3_setup_pad(&sdhci1wp_gpio);
+	ret = gpio_request(BABBAGE_SDHCI1_WP, "sdhci1_wp");
+
+	if (ret) {
+		pr_debug("failed to get MX51_PAD_GPIO_1_1__GPIO1_1: %d\n", ret);
+		return ret;
+	}
+	/* Set SDHCI2_WP to GPIO1_5 */
+	mxc_iomux_v3_setup_pad(&sdhci2wp_gpio);
+	ret = gpio_request(BABBAGE_SDHCI1_WP, "sdhci2_wp");
+
+	if (ret) {
+		pr_debug("failed to get MX51_PAD_GPIO_1_5__GPIO1_5: %d\n", ret);
+		return ret;
+	}
+	gpio_direction_input(BABBAGE_SDHCI1_WP);
+	gpio_direction_input(BABBAGE_SDHCI2_WP);
+
+	if (to_platform_device(dev)->id == 0)
+		ret = gpio_get_value(BABBAGE_SDHCI1_WP);
+	else if (to_platform_device(dev)->id == 1)
+		ret = gpio_get_value(BABBAGE_SDHCI2_WP);
+
+	return ret;
+}
+
+ static struct imxmmc_platform_data mmc1_data = {
+	.caps = MMC_CAP_4_BIT_DATA,
+	.min_clk = 400000,
+	.max_clk = 52000000,
+	.wp_status = sdhc_write_protect,
+};
+
+ static struct imxmmc_platform_data mmc2_data = {
+	.caps = MMC_CAP_4_BIT_DATA,
+	.min_clk = 400000,
+	.max_clk = 52000000,
+	.wp_status = sdhc_write_protect,
+};
+
 /*
  * Board specific initialization.
  */
@@ -255,6 +323,8 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxc_i2c_device0, &babbage_i2c_data);
 	mxc_register_device(&mxc_i2c_device1, &babbage_i2c_data);
 	mxc_register_device(&mxc_hsi2c_device, &babbage_hsi2c_data);
+	mxc_register_device(&mxcsdhc1_device, &mmc1_data);
+	mxc_register_device(&mxcsdhc2_device, &mmc2_data);
 
 	if (otg_mode_host)
 		mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 6af69de..a7a8c3d 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -38,9 +38,40 @@ static struct clk periph_apm_clk;
 static struct clk ahb_clk;
 static struct clk ipg_clk;
 static struct clk usboh3_clk;
+static struct clk esdhc1_clk[];
+static struct clk esdhc2_clk[];
 
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
@@ -762,6 +793,160 @@ static struct clk kpp_clk = {
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
@@ -837,6 +1022,10 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
+	_REGISTER_CLOCK("imx-sdhci.0", "esdhc_clk", esdhc1_clk[0])
+	_REGISTER_CLOCK("imx-sdhci.0", "esdhc_ipg_clk", esdhc1_clk[1])
+	_REGISTER_CLOCK("imx-sdhci.1", "esdhc_clk", esdhc2_clk[0])
+	_REGISTER_CLOCK("imx-sdhci.1", "esdhc_ipg_clk", esdhc2_clk[1])
 };
 
 static void clk_tree_init(void)
@@ -880,6 +1069,14 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
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
index 1920ff4..bf553b0 100644
--- a/arch/arm/mach-mx5/devices.c
+++ b/arch/arm/mach-mx5/devices.c
@@ -245,6 +245,58 @@ struct platform_device mxc_keypad_device = {
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
+	{
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
+	{
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
-- 
1.7.0
