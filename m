From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhi: initialise mmc_data->flags before use
Date: Fri, 19 Aug 2011 13:18:02 -0400
Message-ID: <m2vcttmib9.fsf@bob.laptop.org>
References: <1313716027-19470-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313716027-19470-1-git-send-email-horms@verge.net.au> (Simon
	Horman's message of "Fri, 19 Aug 2011 10:07:07 +0900")
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Aug 18 2011, Simon Horman wrote:
> This corrects a logic error that I introduced in
> "mmc: sdhi: Add write16_hook"
>
> Reported-by: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 2fa7bbc..68702e4 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -121,11 +121,11 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>  	mmc_data->hclk = clk_get_rate(priv->clk);
>  	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
>  	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
> -	if (mmc_data->flags & TMIO_MMC_HAS_IDLE_WAIT)
> -		mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
>  	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
>  	if (p) {
>  		mmc_data->flags = p->tmio_flags;
> +		if (mmc_data->flags & TMIO_MMC_HAS_IDLE_WAIT)
> +			mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
>  		mmc_data->ocr_mask = p->tmio_ocr_mask;
>  		mmc_data->capabilities |= p->tmio_caps;

Thanks, Simon, pushed to mmc-next for 3.1-rc.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
