From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: mxs: Initialize the spinlock prior to using it
Date: Mon, 7 Nov 2016 13:43:42 +0100
Message-ID: <CAPDyKFrq_AaJM12tb22bQA=+30-m1YU5FqbW4VsDnD3w5uKzTQ@mail.gmail.com>
References: <1478375107-32513-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38403 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbcKGMno (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 07:43:44 -0500
Received: by mail-wm0-f51.google.com with SMTP id f82so116061975wmf.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 04:43:44 -0800 (PST)
In-Reply-To: <1478375107-32513-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Stefan Wahren <stefan.wahren@i2se.com>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>

On 5 November 2016 at 20:45, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> An interrupt may occur right after devm_request_irq() is called and
> prior to the spinlock initialization, leading to a kernel oops,
> as the interrupt handler uses the spinlock.
>
> In order to prevent this problem, move the spinlock initialization
> prior to requesting the interrupts.
>
> Fixes: e4243f13d10e (mmc: mxs-mmc: add mmc host driver for i.MX23/28)
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> Reviewed-by: Marek Vasut <marex@denx.de>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
> Changes since v2:
> - Add a Fixes tag as suggested by Stefan
> Changes since v1:
> - Make it a standalone patch instead of patch series
> - Cc stable as suggested by Stefan
>
>  drivers/mmc/host/mxs-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index d839147..44ecebd 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -661,13 +661,13 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, mmc);
>
> +       spin_lock_init(&host->lock);
> +
>         ret = devm_request_irq(&pdev->dev, irq_err, mxs_mmc_irq_handler, 0,
>                                dev_name(&pdev->dev), host);
>         if (ret)
>                 goto out_free_dma;
>
> -       spin_lock_init(&host->lock);
> -
>         ret = mmc_add_host(mmc);
>         if (ret)
>                 goto out_free_dma;
> --
> 2.7.4
>
