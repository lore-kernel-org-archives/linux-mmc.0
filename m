From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: mxs-mmc: Propagate the real error
Date: Mon, 24 Nov 2014 09:36:22 +0100
Message-ID: <CAPDyKFrCbA6SJJqsK3GWSyaJj=rAoTZ9-OM6xdwMxeYyjKtdWg@mail.gmail.com>
References: <1416403019-6353-1-git-send-email-fabio.estevam@freescale.com>
	<1416403019-6353-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:42670 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbaKXIgX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Nov 2014 03:36:23 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so6495849qcv.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2014 00:36:22 -0800 (PST)
In-Reply-To: <1416403019-6353-2-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>

On 19 November 2014 at 14:16, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> If platform_get_irq() fails, it is better to propagate the real error value
> instead of a 'fake' one.
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
> index 0d30730..f2c49e0 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -583,7 +583,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>
>         irq_err = platform_get_irq(pdev, 0);
>         if (irq_err < 0)
> -               return -EINVAL;
> +               return irq_err;
>
>         mmc = mmc_alloc_host(sizeof(struct mxs_mmc_host), &pdev->dev);
>         if (!mmc)
> --
> 1.9.1
>
