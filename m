From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: mxs: fix card detection in case of 'broken-cd' flag
 set
Date: Mon, 7 Jul 2014 08:27:55 +0200
Message-ID: <20140707062755.GE23235@pengutronix.de>
References: <1402412222-18020-1-git-send-email-r.peniaev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51103 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaGGG2K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jul 2014 02:28:10 -0400
Content-Disposition: inline
In-Reply-To: <1402412222-18020-1-git-send-email-r.peniaev@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roman Pen <r.peniaev@gmail.com>
Cc: Chris Ball <chris@printf.net>, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 10, 2014 at 11:57:02PM +0900, Roman Pen wrote:
> In case of reboot my olinuxino imx23 board does not see
> mmc card any more. mmc_rescan is being called by delayed
> work in loop, but mxs_mmc_get_cd always returns 0, so we
> will never pass the card detection check and will not do
> further card inition.
> 
> This patch is just an attempt to partially revert the patch
> a91fe279ae of Sascha Hauer, where it is claimed that upper
> layer will handle broken card detection using the polling
> logic and MMC_CAP_NEEDS_POLL capability, but seems it is not
> true, because upper logic still expects 1 from 'get_cd'.
> 
> So, here we always return 1 (card present) in case of
> MMC_CAP_NEEDS_POLL capability set.
> 
> Signed-off-by: Roman Pen <r.peniaev@gmail.com>
> CC: Chris Ball <chris@printf.net>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org

I still didn't find the time to take a proper look at it. Since this
fixes a bug for you:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/mmc/host/mxs-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 073e871..9187ce1 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -82,7 +82,8 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>  	if (ret >= 0)
>  		return ret;
>  
> -	present = !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
> +	present = mmc->caps & MMC_CAP_NEEDS_POLL ||
> +		!(readl(ssp->base + HW_SSP_STATUS(ssp)) &
>  			BM_SSP_STATUS_CARD_DETECT);
>  
>  	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
> -- 
> 1.9.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
