From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: fix error return code in
 sh_mobile_sdhi_probe()
Date: Wed, 29 May 2013 08:58:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305290841080.14157@axis700.grange>
References: <CAPgLHd_dwxRp8Ug7=05=3gTTa9bPME5tb-Mq1aqRFXZSrgqFGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51584 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933908Ab3E2G6T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 May 2013 02:58:19 -0400
In-Reply-To: <CAPgLHd_dwxRp8Ug7=05=3gTTa9bPME5tb-Mq1aqRFXZSrgqFGg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: ian@mnementh.co.uk, cjb@laptop.org, grant.likely@linaro.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi

On Tue, 28 May 2013, Wei Yongjun wrote:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code instead of 0 when we cannot get
> IRQ source by platform_get_irq(), as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks for the patch. Do you think the following version would be even a 
bit simpler?

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index fe90853..76661b6 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -255,18 +255,17 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (multiplexed_isr) {
 		while (1) {
 			irq = platform_get_irq(pdev, i);
-			if (irq < 0)
-				break;
+			/* There must be at least one IRQ source */
+			if (irq < 0) {
+				ret = irq;
+				goto eirq;
+			}
 			i++;
 			ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
 					  dev_name(&pdev->dev), host);
 			if (ret)
 				goto eirq;
 		}
-
-		/* There must be at least one IRQ source */
-		if (!i)
-			goto eirq;
 	}
 
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",

If you agree, maybe you could send a v2 of your patch in this form, I'll 
ack it then.

Thanks
Guennadi

> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index cc4c872..a4316b3 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -273,8 +273,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  		}
>  
>  		/* There must be at least one IRQ source */
> -		if (!i)
> +		if (!i) {
> +			ret = irq;
>  			goto eirq;
> +		}
>  	}
>  
>  	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
