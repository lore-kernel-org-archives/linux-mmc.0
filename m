From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/5] mmc: sdhi: Make use of per-source irq handlers
Date: Tue, 16 Aug 2011 10:30:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108160953010.13154@axis700.grange>
References: <1313460499-3377-1-git-send-email-horms@verge.net.au>
 <1313460499-3377-5-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313460499-3377-5-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 16 Aug 2011, Simon Horman wrote:

> Make use of per-source irq handles if the
> platform (data) has multiple irq sources.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |   58 +++++++++++++++++++++++-------------
>  1 files changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 774f643..29dd0c8 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -96,7 +96,9 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>  	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
>  	struct tmio_mmc_host *host;
>  	char clk_name[8];
> -	int i, irq, ret;
> +	int irq, ret;
> +	irqreturn_t (*f)(int irq, void *devid);
> +	bool multi_irq = false;
>  
>  	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
>  	if (priv == NULL) {
> @@ -153,27 +155,33 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto eprobe;
>  
> -	for (i = 0; i < 3; i++) {
> -		irq = platform_get_irq(pdev, i);
> -		if (irq < 0) {
> -			if (i) {
> -				continue;
> -			} else {
> -				ret = irq;
> -				goto eirq;
> -			}
> -		}
> -		ret = request_irq(irq, tmio_mmc_irq, 0,
> +	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
> +	if (irq >= 0) {
> +		multi_irq = true;
> +		ret = request_irq(irq, tmio_mmc_sdio_irq, 0,
>  				  dev_name(&pdev->dev), host);
> -		if (ret) {
> -			while (i--) {
> -				irq = platform_get_irq(pdev, i);
> -				if (irq >= 0)
> -					free_irq(irq, host);
> -			}
> -			goto eirq;
> -		}
> +		if (ret)
> +			goto eirq_sdio;
>  	}
> +
> +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
> +	if (irq >= 0) {
> +		multi_irq = true;
> +		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,

Typo? You're checking card-detect and requesting sdcard_irq?

> +				  dev_name(&pdev->dev), host);
> +		if (ret)
> +			goto eirq_card_detect;
> +	} else if (multi_irq)
> +		goto eirq_card_detect;

Currently if any of SDIO or card-detect IRQs are missing in platform data 
the driver probing will just ignore them. Also for the case, when an SDIO 
IRQ is present and no card-detect IRQ is provided. Currently all platforms 
either only provide one interrupt, or all 3 of them, so, on them your 
version would work too, but isn't it possible, that a new platform will 
want to drop one of those "optional" IRQs? Actually, I am not sure what we 
want to do in such a partial case. Say, if the card-detect IRQ is missing. 
Do we then register the SDIO and SD-card IRQs with their respective 
handlers and drop card-detection completely (polling) or do we use the 
all-in-one ISR for the SD-card IRQ then? I think, the former would be more 
logical. I.e., if the platform provided > 1 IRQs, only request respective 
specialised ISRs and drop the rest. In any case erroring out as you do 
above seems wrong.

> +
> +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
> +	if (irq < 0)
> +		goto eirq_sdcard;
> +	f = multi_irq ? tmio_mmc_card_detect_irq : tmio_mmc_irq;

Also a typo? If your tests were successful (with card hot-plugging), then 
probably you swapped your macro values.

> +	ret = request_irq(irq, f, 0, dev_name(&pdev->dev), host);
> +	if (ret)
> +		goto eirq_sdcard;
> +
>  	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
>  		 mmc_hostname(host->mmc), (unsigned long)
>  		 (platform_get_resource(pdev,IORESOURCE_MEM, 0)->start),
> @@ -181,7 +189,15 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>  
>  	return ret;
>  
> -eirq:
> +eirq_sdcard:
> +	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
> +	if (irq >= 0)
> +		free_irq(irq, host);
> +eirq_card_detect:
> +	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
> +	if (irq >= 0)
> +		free_irq(irq, host);
> +eirq_sdio:
>  	tmio_mmc_host_remove(host);
>  eprobe:
>  	clk_disable(priv->clk);
> -- 
> 1.7.5.4

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
