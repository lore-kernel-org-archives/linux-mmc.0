From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 05/11] mmc: sh-mmcif: use mmc_of_parse() to parse standard MMC DT bindings
Date: Mon, 28 Jan 2013 17:25:15 -0500
Message-ID: <87zjzt54j8.fsf@laptop.org>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
	<1358955158-1510-6-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1358955158-1510-6-git-send-email-g.liakhovetski@gmx.de>
	(Guennadi Liakhovetski's message of "Wed, 23 Jan 2013 16:32:32 +0100")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Wed, Jan 23 2013, Guennadi Liakhovetski wrote:
> Use mmc_of_parse() to get interface capability flags and used GPIOs from
> device-tree bindings.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/mmc/host/sh_mmcif.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 741aeb9..4de94a1 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1329,6 +1329,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>  		ret = -ENOMEM;
>  		goto ealloch;
>  	}
> +	mmc_of_parse(mmc);
>  	host		= mmc_priv(mmc);
>  	host->mmc	= mmc;
>  	host->addr	= reg;
> @@ -1341,7 +1342,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>  	mmc->ops = &sh_mmcif_ops;
>  	sh_mmcif_init_ocr(host);
>  
> -	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
> +	mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
>  	if (pd && pd->caps)
>  		mmc->caps |= pd->caps;
>  	mmc->max_segs = 32;

This patch doesn't apply because you don't seem to have this patch:

Author: Teppei Kamijou <teppei.kamijou.yb@renesas.com>
Date:   Wed Dec 12 15:38:10 2012 +0100
Subject: mmc: sh_mmcif: Avoid unnecessary mmc_delay() at mmc_card_sleepawake()

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
