From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] mmc: mxs: Initialize the spinlock prior to using it
Date: Thu, 27 Oct 2016 21:06:24 +0200
Message-ID: <15d2f274-f1a2-d657-59d0-863be475eae8@denx.de>
References: <1477594672-31611-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52543 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935449AbcJ0TJt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 15:09:49 -0400
In-Reply-To: <1477594672-31611-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, ulf.hansson@linaro.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, stefan.wahren@i2se.com, Fabio Estevam <fabio.estevam@nxp.com>

On 10/27/2016 08:57 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> An interrupt may occur right after devm_request_irq() is called and
> prior to the spinlock initialization, leading to a kernel oops,
> as the interrupt handler uses the spinlock.
> 
> In order to prevent this problem, move the spinlock initialization 
> prior to requesting the interrupts.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Nice, thanks.

Could you also check whether you can disable and clear interrupts in the
probe routine ? I think that might make sense too.

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/mmc/host/mxs-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index d839147..44ecebd 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -661,13 +661,13 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mmc);
>  
> +	spin_lock_init(&host->lock);
> +
>  	ret = devm_request_irq(&pdev->dev, irq_err, mxs_mmc_irq_handler, 0,
>  			       dev_name(&pdev->dev), host);
>  	if (ret)
>  		goto out_free_dma;
>  
> -	spin_lock_init(&host->lock);
> -
>  	ret = mmc_add_host(mmc);
>  	if (ret)
>  		goto out_free_dma;
> 


-- 
Best regards,
Marek Vasut
