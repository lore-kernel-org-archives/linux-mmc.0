From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 3/7] mmc: omap: clarify DDR timing mode between SD-UHS
 and eMMC
Date: Thu, 16 Jan 2014 16:31:35 +0530
Message-ID: <52D7BC0F.20007@ti.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org> <002101cf11fb$bf5c6280$3e152780$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51978 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbaAPLBt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 06:01:49 -0500
In-Reply-To: <002101cf11fb$bf5c6280$3e152780$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Chris Ball' <chris@printf.net>, linux-mmc@vger.kernel.org

On Wednesday 15 January 2014 07:41 PM, Seungwon Jeon wrote:
> Replaced UHS_DDR50 with MMC_DDR52.
>
> CC: Balaji T K <balajitk@ti.com>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Looks good to me

Acked-by: Balaji T K <balajitk@ti.com>

> ---
>   drivers/mmc/host/omap_hsmmc.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index dbd32ad..cca397e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -540,7 +540,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
>   	 *	- MMC/SD clock coming out of controller > 25MHz
>   	 */
>   	if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
> -	    (ios->timing != MMC_TIMING_UHS_DDR50) &&
> +	    (ios->timing != MMC_TIMING_MMC_DDR52) &&
>   	    ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) == HSS)) {
>   		regval = OMAP_HSMMC_READ(host->base, HCTL);
>   		if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
> @@ -560,7 +560,7 @@ static void omap_hsmmc_set_bus_width(struct omap_hsmmc_host *host)
>   	u32 con;
>
>   	con = OMAP_HSMMC_READ(host->base, CON);
> -	if (ios->timing == MMC_TIMING_UHS_DDR50)
> +	if (ios->timing == MMC_TIMING_MMC_DDR52)
>   		con |= DDR;	/* configure in DDR mode */
>   	else
>   		con &= ~DDR;
>

