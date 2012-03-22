From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 2/4] arm: at91: at91sam9x5 add mci clk_lookup
Date: Thu, 22 Mar 2012 15:51:42 +0100
Message-ID: <4F6B3C7E.5050305@atmel.com>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com> <1332352994-20983-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:23122 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab2CVOvy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Mar 2012 10:51:54 -0400
In-Reply-To: <1332352994-20983-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>

On 03/21/2012 07:03 PM, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/at91sam9x5.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
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
