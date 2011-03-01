From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V4 2/4] ARM: imx51/53: add sdhc3/4 clock
Date: Tue, 1 Mar 2011 17:58:18 +0800
Message-ID: <1298973500-2858-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1298973500-2858-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:45196
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755948Ab1CAJ7N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 04:59:13 -0500
In-Reply-To: <1298973500-2858-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, richard.zhao@freescale.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |  140 ++++++++++++++++++++++++++++++++++-
 arch/arm/mach-mx5/crm_regs.h        |    7 ++
 2 files changed, 146 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 8164b1d..652ace4 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -42,6 +42,9 @@ static struct clk usboh3_clk;
 static struct clk emi_fast_clk;
 static struct clk ipu_clk;
 static struct clk mipi_hsc1_clk;
+static struct clk esdhc1_clk;
+static struct clk esdhc2_clk;
+static struct clk esdhc3_mx53_clk;
 
 #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
 
@@ -1143,10 +1146,80 @@ CLK_GET_RATE(esdhc1, 1, ESDHC1_MSHC1)
 CLK_SET_PARENT(esdhc1, 1, ESDHC1_MSHC1)
 CLK_SET_RATE(esdhc1, 1, ESDHC1_MSHC1)
 
+/* mx51 specific */
 CLK_GET_RATE(esdhc2, 1, ESDHC2_MSHC2)
 CLK_SET_PARENT(esdhc2, 1, ESDHC2_MSHC2)
 CLK_SET_RATE(esdhc2, 1, ESDHC2_MSHC2)
 
+static int clk_esdhc3_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 reg;
+
+	reg = __raw_readl(MXC_CCM_CSCMR1);
+	if (parent == &esdhc1_clk)
+		reg &= ~MXC_CCM_CSCMR1_ESDHC3_CLK_SEL;
+	else if (parent == &esdhc2_clk)
+		reg |= MXC_CCM_CSCMR1_ESDHC3_CLK_SEL;
+	else
+		return -EINVAL;
+	__raw_writel(reg, MXC_CCM_CSCMR1);
+
+	return 0;
+}
+
+static int clk_esdhc4_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 reg;
+
+	reg = __raw_readl(MXC_CCM_CSCMR1);
+	if (parent == &esdhc1_clk)
+		reg &= ~MXC_CCM_CSCMR1_ESDHC4_CLK_SEL;
+	else if (parent == &esdhc2_clk)
+		reg |= MXC_CCM_CSCMR1_ESDHC4_CLK_SEL;
+	else
+		return -EINVAL;
+	__raw_writel(reg, MXC_CCM_CSCMR1);
+
+	return 0;
+}
+
+/* mx53 specific */
+static int clk_esdhc2_mx53_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 reg;
+
+	reg = __raw_readl(MXC_CCM_CSCMR1);
+	if (parent == &esdhc1_clk)
+		reg &= ~MXC_CCM_CSCMR1_ESDHC2_MSHC2_MX53_CLK_SEL;
+	else if (parent == &esdhc3_mx53_clk)
+		reg |= MXC_CCM_CSCMR1_ESDHC2_MSHC2_MX53_CLK_SEL;
+	else
+		return -EINVAL;
+	__raw_writel(reg, MXC_CCM_CSCMR1);
+
+	return 0;
+}
+
+CLK_GET_RATE(esdhc3_mx53, 1, ESDHC3_MX53)
+CLK_SET_PARENT(esdhc3_mx53, 1, ESDHC3_MX53)
+CLK_SET_RATE(esdhc3_mx53, 1, ESDHC3_MX53)
+
+static int clk_esdhc4_mx53_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 reg;
+
+	reg = __raw_readl(MXC_CCM_CSCMR1);
+	if (parent == &esdhc1_clk)
+		reg &= ~MXC_CCM_CSCMR1_ESDHC4_CLK_SEL;
+	else if (parent == &esdhc3_mx53_clk)
+		reg |= MXC_CCM_CSCMR1_ESDHC4_CLK_SEL;
+	else
+		return -EINVAL;
+	__raw_writel(reg, MXC_CCM_CSCMR1);
+
+	return 0;
+}
+
 #define DEFINE_CLOCK_FULL(name, i, er, es, gr, sr, e, d, p, s)		\
 	static struct clk name = {					\
 		.id		= i,					\
@@ -1251,9 +1324,62 @@ DEFINE_CLOCK_MAX(esdhc1_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG1_OFFSET,
 	clk_esdhc1, &pll2_sw_clk, &esdhc1_ipg_clk);
 DEFINE_CLOCK_FULL(esdhc2_ipg_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG2_OFFSET,
 	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
+DEFINE_CLOCK_FULL(esdhc3_ipg_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG4_OFFSET,
+	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
+DEFINE_CLOCK_FULL(esdhc4_ipg_clk, 3, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG6_OFFSET,
+	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
+
+/* mx51 specific */
 DEFINE_CLOCK_MAX(esdhc2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG3_OFFSET,
 	clk_esdhc2, &pll2_sw_clk, &esdhc2_ipg_clk);
 
+static struct clk esdhc3_clk = {
+	.id = 2,
+	.parent = &esdhc1_clk,
+	.set_parent = clk_esdhc3_set_parent,
+	.enable_reg = MXC_CCM_CCGR3,
+	.enable_shift = MXC_CCM_CCGRx_CG5_OFFSET,
+	.enable  = _clk_max_enable,
+	.disable = _clk_max_disable,
+	.secondary = &esdhc3_ipg_clk,
+};
+static struct clk esdhc4_clk = {
+	.id = 3,
+	.parent = &esdhc1_clk,
+	.set_parent = clk_esdhc4_set_parent,
+	.enable_reg = MXC_CCM_CCGR3,
+	.enable_shift = MXC_CCM_CCGRx_CG7_OFFSET,
+	.enable  = _clk_max_enable,
+	.disable = _clk_max_disable,
+	.secondary = &esdhc4_ipg_clk,
+};
+
+/* mx53 specific */
+static struct clk esdhc2_mx53_clk = {
+	.id = 2,
+	.parent = &esdhc1_clk,
+	.set_parent = clk_esdhc2_mx53_set_parent,
+	.enable_reg = MXC_CCM_CCGR3,
+	.enable_shift = MXC_CCM_CCGRx_CG3_OFFSET,
+	.enable  = _clk_max_enable,
+	.disable = _clk_max_disable,
+	.secondary = &esdhc3_ipg_clk,
+};
+
+DEFINE_CLOCK_MAX(esdhc3_mx53_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG5_OFFSET,
+	clk_esdhc3_mx53, &pll2_sw_clk, &esdhc2_ipg_clk);
+
+static struct clk esdhc4_mx53_clk = {
+	.id = 3,
+	.parent = &esdhc1_clk,
+	.set_parent = clk_esdhc4_mx53_set_parent,
+	.enable_reg = MXC_CCM_CCGR3,
+	.enable_shift = MXC_CCM_CCGRx_CG7_OFFSET,
+	.enable  = _clk_max_enable,
+	.disable = _clk_max_disable,
+	.secondary = &esdhc4_ipg_clk,
+};
+
 DEFINE_CLOCK(mipi_esc_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG5_OFFSET, NULL, NULL, NULL, &pll2_sw_clk);
 DEFINE_CLOCK(mipi_hsc2_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG4_OFFSET, NULL, NULL, &mipi_esc_clk, &pll2_sw_clk);
 DEFINE_CLOCK(mipi_hsc1_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG3_OFFSET, NULL, NULL, &mipi_hsc2_clk, &pll2_sw_clk);
@@ -1312,6 +1438,8 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, esdhc4_clk)
 	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
 	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
@@ -1332,7 +1460,9 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_mx53_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_mx53_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, esdhc4_mx53_clk)
 	_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
 	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
@@ -1425,6 +1555,14 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 	mx53_revision();
 	clk_disable(&iim_clk);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(&esdhc1_clk, &pll2_sw_clk);
+	clk_set_parent(&esdhc3_mx53_clk, &pll2_sw_clk);
+
+	/* set SDHC root clock as 200MHZ*/
+	clk_set_rate(&esdhc1_clk, 200000000);
+	clk_set_rate(&esdhc3_mx53_clk, 200000000);
+
 	/* System timer */
 	mxc_timer_init(&gpt_clk, MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR),
 		MX53_INT_GPT);
diff --git a/arch/arm/mach-mx5/crm_regs.h b/arch/arm/mach-mx5/crm_regs.h
index b462c22..87c0c58 100644
--- a/arch/arm/mach-mx5/crm_regs.h
+++ b/arch/arm/mach-mx5/crm_regs.h
@@ -217,9 +217,12 @@
 #define MXC_CCM_CSCMR1_ESDHC1_MSHC1_CLK_SEL_OFFSET	(20)
 #define MXC_CCM_CSCMR1_ESDHC1_MSHC1_CLK_SEL_MASK	(0x3 << 20)
 #define MXC_CCM_CSCMR1_ESDHC3_CLK_SEL			(0x1 << 19)
+#define MXC_CCM_CSCMR1_ESDHC2_MSHC2_MX53_CLK_SEL	(0x1 << 19)
 #define MXC_CCM_CSCMR1_ESDHC4_CLK_SEL			(0x1 << 18)
 #define MXC_CCM_CSCMR1_ESDHC2_MSHC2_CLK_SEL_OFFSET	(16)
 #define MXC_CCM_CSCMR1_ESDHC2_MSHC2_CLK_SEL_MASK	(0x3 << 16)
+#define MXC_CCM_CSCMR1_ESDHC3_MX53_CLK_SEL_OFFSET	(16)
+#define MXC_CCM_CSCMR1_ESDHC3_MX53_CLK_SEL_MASK		(0x3 << 16)
 #define MXC_CCM_CSCMR1_SSI1_CLK_SEL_OFFSET		(14)
 #define MXC_CCM_CSCMR1_SSI1_CLK_SEL_MASK		(0x3 << 14)
 #define MXC_CCM_CSCMR1_SSI2_CLK_SEL_OFFSET		(12)
@@ -271,6 +274,10 @@
 #define MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PRED_MASK	(0x7 << 22)
 #define MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PODF_OFFSET	(19)
 #define MXC_CCM_CSCDR1_ESDHC2_MSHC2_CLK_PODF_MASK	(0x7 << 19)
+#define MXC_CCM_CSCDR1_ESDHC3_MX53_CLK_PRED_OFFSET	(22)
+#define MXC_CCM_CSCDR1_ESDHC3_MX53_CLK_PRED_MASK	(0x7 << 22)
+#define MXC_CCM_CSCDR1_ESDHC3_MX53_CLK_PODF_OFFSET	(19)
+#define MXC_CCM_CSCDR1_ESDHC3_MX53_CLK_PODF_MASK	(0x7 << 19)
 #define MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PRED_OFFSET	(16)
 #define MXC_CCM_CSCDR1_ESDHC1_MSHC1_CLK_PRED_MASK	(0x7 << 16)
 #define MXC_CCM_CSCDR1_PGC_CLK_PODF_OFFSET		(14)
-- 
1.7.1


