Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9049EC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 06:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B62E207FB
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 06:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbgEYGCI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 02:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388589AbgEYGCH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 May 2020 02:02:07 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1562E2075F;
        Mon, 25 May 2020 06:02:04 +0000 (UTC)
Subject: Re: [PATCH v6 1/4] m68k: mcf5441x: add support for esdhc mmc
 controller
To:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-m68k@vger.kernel.org
References: <20200518191742.1251440-1-angelo.dureghello@timesys.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <fdfe557a-49fe-410a-cb05-5bff5e04fdd0@linux-m68k.org>
Date:   Mon, 25 May 2020 16:02:01 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518191742.1251440-1-angelo.dureghello@timesys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Angelo,

Have you seen this breakage being reported in linux-next?

     arch/m68k/coldfire/clk.c:78:60: error: 'MCFSDHC_CLK' undeclared (first
     use in this function); did you mean 'MCF_CLK'?
     arch/m68k/coldfire/clk.c:83:61: error: 'MCFSDHC_CLK' undeclared (first
     use in this function); did you mean 'MCF_CLK'?
     make[2]: *** [scripts/Makefile.build:272: arch/m68k/coldfire/clk.o] 
     Error 1
     make[1]: *** [Makefile:1736: arch/m68k/coldfire] Error 2
     make: *** [Makefile:185: __sub-make] Error 2

This is when compiling for pretty much anything other than an mcf5441x 
target.


On 19/5/20 5:17 am, Angelo Dureghello wrote:
> Add support for sdhci-edshc mmc controller.
> 
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
> Changes for v3:
> - removed volatile cast from clk.c
> Changes for v4:
> - comment style fix in m5441xsim.h
> Changes for v5:
> - fix compilation warnings from __clk_enable2 and __clk_disable2
> Changes for v6:
> none
> ---
>   arch/m68k/coldfire/clk.c                    | 15 ++++++++++
>   arch/m68k/coldfire/device.c                 | 33 +++++++++++++++++++--
>   arch/m68k/coldfire/m5441x.c                 | 12 +++++++-
>   arch/m68k/include/asm/m5441xsim.h           | 15 ++++++++++
>   arch/m68k/include/asm/mcfclk.h              |  2 ++
>   include/linux/platform_data/mmc-esdhc-mcf.h | 17 +++++++++++
>   6 files changed, 91 insertions(+), 3 deletions(-)
>   create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h
> 
> diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
> index 7bc666e482eb..75a057445472 100644
> --- a/arch/m68k/coldfire/clk.c
> +++ b/arch/m68k/coldfire/clk.c
> @@ -73,6 +73,21 @@ struct clk_ops clk_ops1 = {
>   #endif /* MCFPM_PPMCR1 */
>   #endif /* MCFPM_PPMCR0 */
>   
> +static void __clk_enable2(struct clk *clk)
> +{
> +	__raw_writel(__raw_readl(MCFSDHC_CLK) | (1 << clk->slot), MCFSDHC_CLK);
> +}

MCFSDHC_CLK will not be defiend for anything other than mcf5441x targets.

This mechanism looks a little out of place here, given how specific
it is to the sdhc hardware module of the 5441x. Can you move this
to the m5441x specific code resolving this?

Regards
Greg


> +static void __clk_disable2(struct clk *clk)
> +{
> +	__raw_writel(__raw_readl(MCFSDHC_CLK) & ~(1 << clk->slot), MCFSDHC_CLK);
> +}
> +
> +struct clk_ops clk_ops2 = {
> +	.enable		= __clk_enable2,
> +	.disable	= __clk_disable2,
> +};
> +
>   struct clk *clk_get(struct device *dev, const char *id)
>   {
>   	const char *clk_name = dev ? dev_name(dev) : id ? id : NULL;
> diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
> index b4103b6bfdeb..9ef4ec0aea00 100644
> --- a/arch/m68k/coldfire/device.c
> +++ b/arch/m68k/coldfire/device.c
> @@ -22,6 +22,7 @@
>   #include <asm/mcfqspi.h>
>   #include <linux/platform_data/edma.h>
>   #include <linux/platform_data/dma-mcf-edma.h>
> +#include <linux/platform_data/mmc-esdhc-mcf.h>
>   
>   /*
>    *	All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
> @@ -551,9 +552,35 @@ static struct platform_device mcf_edma = {
>   		.platform_data = &mcf_edma_data,
>   	}
>   };
> -
>   #endif /* IS_ENABLED(CONFIG_MCF_EDMA) */
>   
> +#if IS_ENABLED(CONFIG_MMC)
> +static struct mcf_esdhc_platform_data mcf_esdhc_data = {
> +	.max_bus_width = 4,
> +	.cd_type = ESDHC_CD_NONE,
> +};
> +
> +static struct resource mcf_esdhc_resources[] = {
> +	{
> +		.start = MCFSDHC_BASE,
> +		.end = MCFSDHC_BASE + MCFSDHC_SIZE - 1,
> +		.flags = IORESOURCE_MEM,
> +	}, {
> +		.start = MCF_IRQ_SDHC,
> +		.end = MCF_IRQ_SDHC,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device mcf_esdhc = {
> +	.name			= "sdhci-esdhc-mcf",
> +	.id			= 0,
> +	.num_resources		= ARRAY_SIZE(mcf_esdhc_resources),
> +	.resource		= mcf_esdhc_resources,
> +	.dev.platform_data	= &mcf_esdhc_data,
> +};
> +#endif /* IS_ENABLED(CONFIG_MMC) */
> +
>   static struct platform_device *mcf_devices[] __initdata = {
>   	&mcf_uart,
>   #if IS_ENABLED(CONFIG_FEC)
> @@ -586,6 +613,9 @@ static struct platform_device *mcf_devices[] __initdata = {
>   #if IS_ENABLED(CONFIG_MCF_EDMA)
>   	&mcf_edma,
>   #endif
> +#if IS_ENABLED(CONFIG_MMC)
> +	&mcf_esdhc,
> +#endif
>   };
>   
>   /*
> @@ -614,4 +644,3 @@ static int __init mcf_init_devices(void)
>   }
>   
>   arch_initcall(mcf_init_devices);
> -
> diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
> index 5bd24c9b865d..ffa02de1a3fb 100644
> --- a/arch/m68k/coldfire/m5441x.c
> +++ b/arch/m68k/coldfire/m5441x.c
> @@ -52,7 +52,7 @@ DEFINE_CLK(0, "mcfssi.0", 47, MCF_CLK);
>   DEFINE_CLK(0, "pll.0", 48, MCF_CLK);
>   DEFINE_CLK(0, "mcfrng.0", 49, MCF_CLK);
>   DEFINE_CLK(0, "mcfssi.1", 50, MCF_CLK);
> -DEFINE_CLK(0, "mcfsdhc.0", 51, MCF_CLK);
> +DEFINE_CLK(0, "sdhci-esdhc-mcf.0", 51, MCF_CLK);
>   DEFINE_CLK(0, "enet-fec.0", 53, MCF_CLK);
>   DEFINE_CLK(0, "enet-fec.1", 54, MCF_CLK);
>   DEFINE_CLK(0, "switch.0", 55, MCF_CLK);
> @@ -74,6 +74,10 @@ DEFINE_CLK(1, "mcfpwm.0", 34, MCF_BUSCLK);
>   DEFINE_CLK(1, "sys.0", 36, MCF_BUSCLK);
>   DEFINE_CLK(1, "gpio.0", 37, MCF_BUSCLK);
>   
> +DEFINE_CLK(2, "ipg.0", 0, MCF_CLK);
> +DEFINE_CLK(2, "ahb.0", 1, MCF_CLK);
> +DEFINE_CLK(2, "per.0", 2, MCF_CLK);
> +
>   struct clk *mcf_clks[] = {
>   	&__clk_0_2,
>   	&__clk_0_8,
> @@ -131,6 +135,11 @@ struct clk *mcf_clks[] = {
>   	&__clk_1_34,
>   	&__clk_1_36,
>   	&__clk_1_37,
> +
> +	&__clk_2_0,
> +	&__clk_2_1,
> +	&__clk_2_2,
> +
>   	NULL,
>   };
>   
> @@ -151,6 +160,7 @@ static struct clk * const enable_clks[] __initconst = {
>   	&__clk_0_33, /* pit.1 */
>   	&__clk_0_37, /* eport */
>   	&__clk_0_48, /* pll */
> +	&__clk_0_51, /* esdhc */
>   
>   	&__clk_1_36, /* CCM/reset module/Power management */
>   	&__clk_1_37, /* gpio */
> diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
> index 4892f314ff38..e091e36d3464 100644
> --- a/arch/m68k/include/asm/m5441xsim.h
> +++ b/arch/m68k/include/asm/m5441xsim.h
> @@ -278,6 +278,13 @@
>   #define MCFGPIO_IRQ_VECBASE	(MCFINT_VECBASE - MCFGPIO_IRQ_MIN)
>   #define MCFGPIO_PIN_MAX		87
>   
> +/*
> + * Phase Locked Loop (PLL)
> + */
> +#define MCF_PLL_CR		0xFC0C0000
> +#define MCF_PLL_DR		0xFC0C0004
> +#define MCF_PLL_SR		0xFC0C0008
> +
>   /*
>    *  DSPI module.
>    */
> @@ -298,5 +305,13 @@
>   #define MCFEDMA_IRQ_INTR16	(MCFINT1_VECBASE + MCFEDMA_EDMA_INTR16)
>   #define MCFEDMA_IRQ_INTR56	(MCFINT2_VECBASE + MCFEDMA_EDMA_INTR56)
>   #define MCFEDMA_IRQ_ERR	(MCFINT0_VECBASE + MCFINT0_EDMA_ERR)
> +/*
> + *  esdhc module.
> + */
> +#define MCFSDHC_BASE		0xfc0cc000
> +#define MCFSDHC_SIZE		256
> +#define MCFINT2_SDHC		31
> +#define MCF_IRQ_SDHC		(MCFINT2_VECBASE + MCFINT2_SDHC)
> +#define MCFSDHC_CLK		(MCFSDHC_BASE + 0x2c)
>   
>   #endif /* m5441xsim_h */
> diff --git a/arch/m68k/include/asm/mcfclk.h b/arch/m68k/include/asm/mcfclk.h
> index 0aca504fae31..722627e06d66 100644
> --- a/arch/m68k/include/asm/mcfclk.h
> +++ b/arch/m68k/include/asm/mcfclk.h
> @@ -30,6 +30,8 @@ extern struct clk_ops clk_ops0;
>   extern struct clk_ops clk_ops1;
>   #endif /* MCFPM_PPMCR1 */
>   
> +extern struct clk_ops clk_ops2;
> +
>   #define DEFINE_CLK(clk_bank, clk_name, clk_slot, clk_rate) \
>   static struct clk __clk_##clk_bank##_##clk_slot = { \
>   	.name = clk_name, \
> diff --git a/include/linux/platform_data/mmc-esdhc-mcf.h b/include/linux/platform_data/mmc-esdhc-mcf.h
> new file mode 100644
> index 000000000000..85cb786a62fe
> --- /dev/null
> +++ b/include/linux/platform_data/mmc-esdhc-mcf.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
> +#define __LINUX_PLATFORM_DATA_MCF_ESDHC_H__
> +
> +enum cd_types {
> +	ESDHC_CD_NONE,		/* no CD, neither controller nor gpio */
> +	ESDHC_CD_CONTROLLER,	/* mmc controller internal CD */
> +	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
> +};
> +
> +struct mcf_esdhc_platform_data {
> +	int max_bus_width;
> +	int cd_type;
> +};
> +
> +#endif /* __LINUX_PLATFORM_DATA_MCF_ESDHC_H__ */
> 

