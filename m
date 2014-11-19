From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxs-mmc: Register the irq with the device name
Date: Wed, 19 Nov 2014 12:00:21 +0100
Message-ID: <CAPDyKFq76yKwmxbQxjzB8J0khvm2R2by3pQbzHnnN8R_rwEY_Q@mail.gmail.com>
References: <1416278232-31263-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:37432 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbaKSLAW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 06:00:22 -0500
Received: by mail-qa0-f49.google.com with SMTP id s7so183444qap.8
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2014 03:00:21 -0800 (PST)
In-Reply-To: <1416278232-31263-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 18 November 2014 03:37, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Instead of registering the irq name with the driver's name, it's better to pass
> the device name so that we have a more explicit indication as to what mmc
> instance the irq is related:
>
> $ cat /proc/interrupts
>            CPU0
> ...
>  26:          6         -  96  80010000.ssp
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index cd74e51..339059a 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -660,7 +660,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, mmc);
>
>         ret = devm_request_irq(&pdev->dev, irq_err, mxs_mmc_irq_handler, 0,
> -                              DRIVER_NAME, host);
> +                              dev_name(&pdev->dev), host);
>         if (ret)
>                 goto out_free_dma;
>
> --
> 1.9.1
>
