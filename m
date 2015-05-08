From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Remove unneeded code
Date: Fri, 8 May 2015 13:49:07 +0200
Message-ID: <CAPDyKFoWDCYq94jFXq5bO736hPvZLN7uiVWu2SHxUUPawc3xaQ@mail.gmail.com>
References: <1431021609-6932-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:35364 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbEHLtI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 07:49:08 -0400
Received: by qcbgu10 with SMTP id gu10so35476599qcb.2
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2015 04:49:07 -0700 (PDT)
In-Reply-To: <1431021609-6932-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>

On 7 May 2015 at 20:00, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> Since commit 8d86e4fcccf61 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()")
> the 'non-removable' and 'cd-gpios' properties are handled by
> mmc_of_parse(), so we can safely remove the pieces of code that still
> handles them.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 8eed843..d7b0a39 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -872,19 +872,12 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>         if (!np)
>                 return -ENODEV;
>
> -       if (of_get_property(np, "non-removable", NULL))
> -               boarddata->cd_type = ESDHC_CD_PERMANENT;
> -
>         if (of_get_property(np, "fsl,cd-controller", NULL))
>                 boarddata->cd_type = ESDHC_CD_CONTROLLER;
>
>         if (of_get_property(np, "fsl,wp-controller", NULL))
>                 boarddata->wp_type = ESDHC_WP_CONTROLLER;
>
> -       boarddata->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
> -       if (gpio_is_valid(boarddata->cd_gpio))
> -               boarddata->cd_type = ESDHC_CD_GPIO;
> -
>         boarddata->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);

This seems like a leftover as well!?

>         if (gpio_is_valid(boarddata->wp_gpio))
>                 boarddata->wp_type = ESDHC_WP_GPIO;
> --
> 1.9.1
>

Kind regards
Uffe
