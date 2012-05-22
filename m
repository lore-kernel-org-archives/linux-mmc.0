From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v3 2/3] ARM: at91: add clocks for DT entries
Date: Tue, 22 May 2012 14:56:03 +0200
Message-ID: <4FBB8CE3.5010104@atmel.com>
References: <1337681352-18521-1-git-send-email-ludovic.desroches@atmel.com> <1337681352-18521-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:42092 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab2EVM4G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 May 2012 08:56:06 -0400
In-Reply-To: <1337681352-18521-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org

On 05/22/2012 12:09 PM, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Add clocks to clock lookup table for DT entries.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

This one will probably go through arm-soc git tree...

> ---
>  arch/arm/mach-at91/at91sam9260.c |    1 +
>  arch/arm/mach-at91/at91sam9g45.c |    2 ++
>  arch/arm/mach-at91/at91sam9x5.c  |    2 ++
>  3 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
> index 46f7742..c356471 100644
> --- a/arch/arm/mach-at91/at91sam9260.c
> +++ b/arch/arm/mach-at91/at91sam9260.c
> @@ -218,6 +218,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t1_clk", "fffdc000.timer", &tc4_clk),
>  	CLKDEV_CON_DEV_ID("t2_clk", "fffdc000.timer", &tc5_clk),
>  	CLKDEV_CON_DEV_ID("hclk", "500000.ohci", &ohci_clk),
> +	CLKDEV_CON_DEV_ID("mci_clk", "fffa8000.mmc", &mmc_clk),
>  	/* fake hclk clock */
>  	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
>  	CLKDEV_CON_ID("pioA", &pioA_clk),
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index d222f83..0a2c662 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -235,6 +235,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t0_clk", "fffd4000.timer", &tcb0_clk),
>  	CLKDEV_CON_DEV_ID("hclk", "700000.ohci", &uhphs_clk),
>  	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
> +	CLKDEV_CON_DEV_ID("mci_clk", "fff80000.mmc", &mmc0_clk),
> +	CLKDEV_CON_DEV_ID("mci_clk", "fffd0000.mmc", &mmc1_clk),
>  	/* fake hclk clock */
>  	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
>  	CLKDEV_CON_ID("pioA", &pioA_clk),
> diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
> index 13c8cae..39cbef3 100644
> --- a/arch/arm/mach-at91/at91sam9x5.c
> +++ b/arch/arm/mach-at91/at91sam9x5.c
> @@ -225,6 +225,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t0_clk", "f800c000.timer", &tcb0_clk),
>  	CLKDEV_CON_DEV_ID("dma_clk", "ffffec00.dma-controller", &dma0_clk),
>  	CLKDEV_CON_DEV_ID("dma_clk", "ffffee00.dma-controller", &dma1_clk),
> +	CLKDEV_CON_DEV_ID("mci_clk", "f0008000.mmc", &mmc0_clk),
> +	CLKDEV_CON_DEV_ID("mci_clk", "f000c000.mmc", &mmc1_clk),
>  	CLKDEV_CON_ID("pioA", &pioAB_clk),
>  	CLKDEV_CON_ID("pioB", &pioAB_clk),
>  	CLKDEV_CON_ID("pioC", &pioCD_clk),


-- 
Nicolas Ferre
