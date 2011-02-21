From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/5] ARM: imx51/53: add sdhc3/4 clock
Date: Mon, 21 Feb 2011 17:21:54 +0100
Message-ID: <20110221162154.GR24426@pengutronix.de>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
 <1298282095-2279-2-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43213 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab1BUQWF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 11:22:05 -0500
Content-Disposition: inline
In-Reply-To: <1298282095-2279-2-git-send-email-richard.zhao@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, r65037@freescale.com

On Mon, Feb 21, 2011 at 05:54:52PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> 
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 8164b1d..8ac61d5 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -42,6 +42,7 @@ static struct clk usboh3_clk;
>  static struct clk emi_fast_clk;
>  static struct clk ipu_clk;
>  static struct clk mipi_hsc1_clk;
> +static struct clk esdhc1_clk;
>  
>  #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
>  
> @@ -1147,6 +1148,34 @@ CLK_GET_RATE(esdhc2, 1, ESDHC2_MSHC2)
>  CLK_SET_PARENT(esdhc2, 1, ESDHC2_MSHC2)
>  CLK_SET_RATE(esdhc2, 1, ESDHC2_MSHC2)
>  
> +static int clk_esdhc3_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	u32 reg;
> +
> +	reg = __raw_readl(MXC_CCM_CSCMR1);
> +	if (parent == &esdhc1_clk)
> +		reg &= ~MXC_CCM_CSCMR1_ESDHC3_CLK_SEL;
> +	else
> +		reg |= MXC_CCM_CSCMR1_ESDHC3_CLK_SEL;

parent != &esdhc1_clk doesn't mean parent is a valid parent for this
clock. Please do the parameter checking properly.

> +	__raw_writel(reg, MXC_CCM_CSCMR1);
> +
> +	return 0;
> +}
> +
> +static int clk_esdhc4_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	u32 reg;
> +
> +	reg = __raw_readl(MXC_CCM_CSCMR1);
> +	if (parent == &esdhc1_clk)
> +		reg &= ~MXC_CCM_CSCMR1_ESDHC4_CLK_SEL;
> +	else
> +		reg |= MXC_CCM_CSCMR1_ESDHC4_CLK_SEL;

ditto.

> +	__raw_writel(reg, MXC_CCM_CSCMR1);
> +
> +	return 0;
> +}
> +
>  #define DEFINE_CLOCK_FULL(name, i, er, es, gr, sr, e, d, p, s)		\
>  	static struct clk name = {					\
>  		.id		= i,					\
> @@ -1253,6 +1282,32 @@ DEFINE_CLOCK_FULL(esdhc2_ipg_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG2_OFFSET,
>  	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
>  DEFINE_CLOCK_MAX(esdhc2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG3_OFFSET,
>  	clk_esdhc2, &pll2_sw_clk, &esdhc2_ipg_clk);
> +DEFINE_CLOCK_FULL(esdhc3_ipg_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG4_OFFSET,
> +	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
> +DEFINE_CLOCK_FULL(esdhc4_ipg_clk, 3, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG6_OFFSET,
> +	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
> +
> +static struct clk esdhc3_clk = {
> +	.id = 2,
> +	.parent = &esdhc1_clk,
> +	.set_parent = clk_esdhc3_set_parent,
> +	.enable_reg = MXC_CCM_CCGR3,
> +	.enable_shift = MXC_CCM_CCGRx_CG5_OFFSET,
> +	.enable  = _clk_max_enable,
> +	.disable = _clk_max_disable,
> +	.secondary = &esdhc3_ipg_clk,
> +};
> +
> +static struct clk esdhc4_clk = {
> +	.id = 3,
> +	.parent = &esdhc1_clk,
> +	.set_parent = clk_esdhc4_set_parent,
> +	.enable_reg = MXC_CCM_CCGR3,
> +	.enable_shift = MXC_CCM_CCGRx_CG7_OFFSET,
> +	.enable  = _clk_max_enable,
> +	.disable = _clk_max_disable,
> +	.secondary = &esdhc4_ipg_clk,
> +};
>  
>  DEFINE_CLOCK(mipi_esc_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG5_OFFSET, NULL, NULL, NULL, &pll2_sw_clk);
>  DEFINE_CLOCK(mipi_hsc2_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG4_OFFSET, NULL, NULL, &mipi_esc_clk, &pll2_sw_clk);
> @@ -1312,6 +1367,8 @@ static struct clk_lookup mx51_lookups[] = {
>  	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
> +	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_clk)
> +	_REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, esdhc4_clk)
>  	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
>  	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
>  	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
> @@ -1333,6 +1390,8 @@ static struct clk_lookup mx53_lookups[] = {
>  	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
> +	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_clk)
> +	_REGISTER_CLOCK("sdhci-esdhc-imx.3", NULL, esdhc4_clk)
>  	_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
>  	_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
>  	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
> @@ -1412,6 +1471,14 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
>  	ckih2_reference = ckih2;
>  	oscillator_reference = osc;
>  
> +	esdhc2_clk.get_rate = NULL;
> +	esdhc2_clk.set_rate = NULL;
> +	esdhc2_clk.set_parent = clk_esdhc3_set_parent;
> +	esdhc2_clk.parent = &esdhc1_clk;
> +	esdhc3_clk.get_rate = clk_esdhc2_get_rate;
> +	esdhc3_clk.set_rate = clk_esdhc2_set_rate;
> +	esdhc3_clk.set_parent = clk_esdhc2_set_parent;
> +

This is just too confusing and will be hard to cleanup when we get
clkops for i.MX. Please make SoC specific clocks from this and do not
reassign the function pointers.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
