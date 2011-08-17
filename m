From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/4] mmc: sdhi: Make use of per-source irq handlers
Date: Wed, 17 Aug 2011 13:24:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108171320310.18317@axis700.grange>
References: <1313578756-10413-1-git-send-email-horms@verge.net.au>
 <1313578756-10413-4-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63577 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1HQLZK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Aug 2011 07:25:10 -0400
In-Reply-To: <1313578756-10413-4-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

On Wed, 17 Aug 2011, Simon Horman wrote:

> Make use of per-source irq handles if the
> platform (data) has multiple irq sources.
> 
> Also, as suggested by Guennadi Liakhovetski,
> add and use defines the index or irqs in platform data.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> ---
> 
> v5
> * As suggested by Guennadi Liakhovetski:
>   - Allow only SH_MOBILE_SDHI_IRQ_SDCARD and
>     SH_MOBILE_SDHI_IRQ_SDIO to be specified in platform data

This means, CARD_DETECT is optional in a multi-irq configuration, agree.

> 
> v4
> * As suggested by Guennadi Liakhovetski:
>   - Correct inverted values of SH_MOBILE_SDHI_IRQ_SDCARD and
>     SH_MOBILE_SDHI_IRQ_CARD_DETECT
> 
> v3
> * Update for changes to "mmc: tmio: Provide separate interrupt handlers"
> * As suggested by Guennadi Liakhovetski:
>   - Merge in patch "mmc: sdhi: Add defines for platform irq indexes"
>   - Use an enum instead of defines for irq indexes
> 
> v2
> * Update for changes to "mmc: tmio: Provide separate interrupt handlers"
> * Make use of defines provided by
>   "mmc: sdhi: Add defines for platform irq indexes"
> * As suggested by Guennadi Liakhovetski:
>   - Don't use a loop to initialise irq handlers, the unrolled version
>     is easier on the eyes (and exactly the same number of lines of code!)
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c  |   59 ++++++++++++++++++++++-------------
>  include/linux/mmc/sh_mobile_sdhi.h |    7 ++++
>  2 files changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 774f643..73ecadb 100644
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
> @@ -153,27 +155,32 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
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
> +	}
> +
> +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
> +	if (irq >= 0) {
> +		multi_irq = true;
> +		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,
> +				  dev_name(&pdev->dev), host);
> +		if (ret)
> +			goto eirq_sdcard;
>  	}

This means SDCARD is optional in both single- and multi-irq 
configurations.

> +
> +	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
> +	if (irq < 0)
> +		goto eirq_card_detect;

This means, CARD_DETECT is compulsory in all configurations.

One of us must be speaking klingonish today.

> +	f = multi_irq ? tmio_mmc_card_detect_irq : tmio_mmc_irq;
> +	ret = request_irq(irq, f, 0, dev_name(&pdev->dev), host);
> +	if (ret)
> +		goto eirq_card_detect;
> +
>  	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
>  		 mmc_hostname(host->mmc), (unsigned long)
>  		 (platform_get_resource(pdev,IORESOURCE_MEM, 0)->start),
> @@ -181,7 +188,15 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>  
>  	return ret;
>  
> -eirq:
> +eirq_card_detect:
> +	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
> +	if (irq >= 0)
> +		free_irq(irq, host);
> +eirq_sdcard:
> +	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
> +	if (irq >= 0)
> +		free_irq(irq, host);
> +eirq_sdio:
>  	tmio_mmc_host_remove(host);
>  eprobe:
>  	clk_disable(priv->clk);
> @@ -203,7 +218,7 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
>  
>  	tmio_mmc_host_remove(host);
>  
> -	for (i = 0; i < 3; i++) {
> +	for (i = 0; i < SH_MOBILE_SDHI_IRQ_MAX; i++) {
>  		irq = platform_get_irq(pdev, i);
>  		if (irq >= 0)
>  			free_irq(irq, host);
> diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
> index bd50b36..80d3629 100644
> --- a/include/linux/mmc/sh_mobile_sdhi.h
> +++ b/include/linux/mmc/sh_mobile_sdhi.h
> @@ -3,6 +3,13 @@
>  
>  #include <linux/types.h>
>  
> +enum {
> +	SH_MOBILE_SDHI_IRQ_CARD_DETECT = 0,
> +	SH_MOBILE_SDHI_IRQ_SDCARD,
> +	SH_MOBILE_SDHI_IRQ_SDIO,
> +	SH_MOBILE_SDHI_IRQ_MAX
> +};
> +
>  struct platform_device;
>  struct tmio_mmc_data;
>  
> -- 
> 1.7.5.4
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
