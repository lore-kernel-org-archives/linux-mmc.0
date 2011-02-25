From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sh_mmcif: support aggressive clock gating
Date: Fri, 25 Feb 2011 17:30:05 +0000
Message-ID: <20110225173005.GA25051@void.printf.net>
References: <Pine.LNX.4.64.1102251657290.26361@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1102251657290.26361@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Fri, Feb 25, 2011 at 04:58:38PM +0100, Guennadi Liakhovetski wrote:
> To support MMC aggressive clock gating the driver has to stop the interface
> clock, when the .set_ios() method is called with .clock == 0.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Tested on ap4evb and ecovec
> 
>  drivers/mmc/host/sh_mmcif.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 12884c2..3d735da 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -850,15 +850,15 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	struct sh_mmcif_host *host = mmc_priv(mmc);
>  	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
>  
> -	if (ios->power_mode == MMC_POWER_OFF) {
> +	if (ios->power_mode == MMC_POWER_UP) {
> +		if (p->set_pwr)
> +			p->set_pwr(host->pd, ios->power_mode);
> +	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
>  		/* clock stop */
>  		sh_mmcif_clock_control(host, 0);
> -		if (p->down_pwr)
> +		if (ios->power_mode == MMC_POWER_OFF && p->down_pwr)
>  			p->down_pwr(host->pd);
>  		return;
> -	} else if (ios->power_mode == MMC_POWER_UP) {
> -		if (p->set_pwr)
> -			p->set_pwr(host->pd, ios->power_mode);
>  	}
>  
>  	if (ios->clock)

Thanks, pushed to mmc-next for .39.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
