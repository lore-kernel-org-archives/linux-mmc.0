From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: mxs-mmc: No need to do NULL check on 'iores'
Date: Mon, 24 Nov 2014 09:36:09 +0100
Message-ID: <CAPDyKFpXe9duttSAq3H3=e_gZOn+2q84ouMP+pF0zCpNw3Sdwg@mail.gmail.com>
References: <1416403019-6353-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:40731 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbaKXIgK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Nov 2014 03:36:10 -0500
Received: by mail-qc0-f172.google.com with SMTP id m20so6569645qcx.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2014 00:36:09 -0800 (PST)
In-Reply-To: <1416403019-6353-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>

On 19 November 2014 at 14:16, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> devm_ioremap_resource() already checks if 'iores' is NULL or not, so we can
> skip this manual check.
>
> While at it, move platform_get_resource() closer to devm_ioremap_resource() for
> better readability.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mxs-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index c049ac7..0d30730 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -581,9 +581,8 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         struct regulator *reg_vmmc;
>         struct mxs_ssp *ssp;
>
> -       iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         irq_err = platform_get_irq(pdev, 0);
> -       if (!iores || irq_err < 0)
> +       if (irq_err < 0)
>                 return -EINVAL;
>
>         mmc = mmc_alloc_host(sizeof(struct mxs_mmc_host), &pdev->dev);
> @@ -593,6 +592,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         host = mmc_priv(mmc);
>         ssp = &host->ssp;
>         ssp->dev = &pdev->dev;
> +       iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         ssp->base = devm_ioremap_resource(&pdev->dev, iores);
>         if (IS_ERR(ssp->base)) {
>                 ret = PTR_ERR(ssp->base);
> --
> 1.9.1
>
