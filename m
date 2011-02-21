From: Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH 2/5] ARM: imx51/53: add sdhc3/4 clock
Date: Mon, 21 Feb 2011 17:54:52 +0800
Message-ID: <1298282095-2279-2-git-send-email-richard.zhao@freescale.com>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:20374 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab1BUJz0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 04:55:26 -0500
Received: from mail151-tx2 (localhost.localdomain [127.0.0.1])	by
 mail151-tx2-R.bigfish.com (Postfix) with ESMTP id DC904F584D3	for
 <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 09:55:24 +0000 (UTC)
Received: from TX2EHSMHS022.bigfish.com (unknown [10.9.14.242])	by
 mail151-tx2.bigfish.com (Postfix) with ESMTP id 0632D1348050	for
 <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 09:55:23 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id p1L9t14t022401	for
 <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 02:55:11 -0700 (MST)
Received: from b20223-02 (B20223-02.ap.freescale.net [10.192.242.48])	by
 de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id p1L9sxPU026755	for
 <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 03:55:00 -0600 (CST)
In-Reply-To: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, r65037@freescale.com, Richard Zhao <richard.zhao@freescale.com>

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 8164b1d..8ac61d5 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -42,6 +42,7 @@ static struct clk usboh3_clk;
 static struct clk emi_fast_clk;
 static struct clk ipu_clk;
 static struct clk mipi_hsc1_clk;
+static struct clk esdhc1_clk;
 
 #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
 
@@ -1147,6 +1148,34 @@ CLK_GET_RATE(esdhc2, 1, ESDHC2_MSHC2)
 CLK_SET_PARENT(esdhc2, 1, ESDHC2_MSHC2)
 CLK_SET_RATE(esdhc2, 1, ESDHC2_MSHC2)
 
+static int clk_esdhc3_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 reg;
+
+	reg = __raw_readl(MXC_CCM_CSCMR1);
+	if (parent == &esdhc1_clk)
+		reg &= ~MXC_CCM_CSCMR1_ESDHC3_CLK_SEL;
+	else
+		reg |= MXC_CCM_CSCMR1_ESDHC3_CLK_SEL;
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
+	else
+		reg |= MXC_CCM_CSCMR1_ESDHC4_CLK_SEL;
+	__raw_writel(reg, MXC_CCM_CSCMR1);
+
+	return 0;
+}
+
 #define DEFINE_CLOCK_FULL(name, i, er, es, gr, sr, e, d, p, s)		\
 	static struct clk name = {					\
 		.id		= i,					\
@@ -1253,6 +1282,32 @@ DEFINE_CLOCK_FULL(esdhc2_ipg_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG2_OFFSET,
 	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
 DEFINE_CLOCK_MAX(esdhc2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG3_OFFSET,
 	clk_esdhc2, &pll2_sw_clk, &esdhc2_ipg_clk);
+DEFINE_CLOCK_FULL(esdhc3_ipg_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG4_OFFSET,
+	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
+DEFINE_CLOCK_FULL(esdhc4_ipg_clk, 3, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG6_OFFSET,
+	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
+
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
+
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
 
 DEFINE_CLOCK(mipi_esc_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG5_OFFSET, NULL, NULL, NULL, &pll2_sw_clk);
 DEFINE_CLOCK(mipi_hsc2_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG4_OFFSET, NULL, NULL, &mipi_esc_clk, &pll2_sw_clk);
@@ -1312,6 +1367,8 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, esdhc4_clk)
 	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
 	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
@@ -1333,6 +1390,8 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, esdhc4_clk)
 	_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
 	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
@@ -1412,6 +1471,14 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 	ckih2_reference = ckih2;
 	oscillator_reference = osc;
 
+	esdhc2_clk.get_rate = NULL;
+	esdhc2_clk.set_rate = NULL;
+	esdhc2_clk.set_parent = clk_esdhc3_set_parent;
+	esdhc2_clk.parent = &esdhc1_clk;
+	esdhc3_clk.get_rate = clk_esdhc2_get_rate;
+	esdhc3_clk.set_rate = clk_esdhc2_set_rate;
+	esdhc3_clk.set_parent = clk_esdhc2_set_parent;
+
 	for (i = 0; i < ARRAY_SIZE(mx53_lookups); i++)
 		clkdev_add(&mx53_lookups[i]);
 
@@ -1425,6 +1492,14 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 	mx53_revision();
 	clk_disable(&iim_clk);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(&esdhc1_clk, &pll2_sw_clk);
+	clk_set_parent(&esdhc3_clk, &pll2_sw_clk);
+
+	/* set SDHC root clock as 200MHZ*/
+	clk_set_rate(&esdhc1_clk, 200000000);
+	clk_set_rate(&esdhc3_clk, 200000000);
+
 	/* System timer */
 	mxc_timer_init(&gpt_clk, MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR),
 		MX53_INT_GPT);
-- 
1.7.1


