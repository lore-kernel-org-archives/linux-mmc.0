From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/3] mmc: sh_mmcif: Simplify calculation of mmc->f_min
Date: Wed, 28 Mar 2012 11:26:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1203281125560.4583@axis700.grange>
References: <1332925271-23860-1-git-send-email-horms@verge.net.au>
 <1332925271-23860-4-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55502 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187Ab2C1J1H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 05:27:07 -0400
In-Reply-To: <1332925271-23860-4-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Cao Minh Hiep <hiepcm@gmail.com>

On Wed, 28 Mar 2012, Simon Horman wrote:

> There is no need to tune mmc->f_min to a value near 400kHz as the MMC core
> begins testing frequencies at 400kHz regardless of the value of mmc->f_min.
> 
> As suggested by Guennadi Liakhovetski.
> 
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Tested-by: Cao Minh Hiep <hiepcm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
>  drivers/mmc/host/sh_mmcif.c |    8 +-------
>  1 files changed, 1 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 1410baa..f23b9bd 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1298,13 +1298,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
>  
>  	mmc->ops = &sh_mmcif_ops;
>  	mmc->f_max = host->clk / 2;
> -	/* close to 400KHz */
> -	if (host->clk < 51200000)
> -		mmc->f_min = host->clk / 128;
> -	else if (host->clk < 102400000)
> -		mmc->f_min = host->clk / 256;
> -	else
> -		mmc->f_min = host->clk / 512;
> +	mmc->f_min = host->clk / 512;
>  	if (pd->ocr)
>  		mmc->ocr_avail = pd->ocr;
>  	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
> -- 
> 1.7.6.3
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
