From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Remove unneeded code
Date: Fri, 8 May 2015 06:41:24 +0200
Message-ID: <20150508044124.GU6325@pengutronix.de>
References: <1431021609-6932-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58289 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbbEHEla (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 00:41:30 -0400
Content-Disposition: inline
In-Reply-To: <1431021609-6932-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: ulf.hansson@linaro.org, shawn.guo@linaro.org, linux-mmc@vger.kernel.org, kernel@pengutronix.de

On Thu, May 07, 2015 at 03:00:09PM -0300, Fabio Estevam wrote:
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
>  	if (!np)
>  		return -ENODEV;
>  
> -	if (of_get_property(np, "non-removable", NULL))
> -		boarddata->cd_type = ESDHC_CD_PERMANENT;
> -
>  	if (of_get_property(np, "fsl,cd-controller", NULL))
>  		boarddata->cd_type = ESDHC_CD_CONTROLLER;
>  
>  	if (of_get_property(np, "fsl,wp-controller", NULL))
>  		boarddata->wp_type = ESDHC_WP_CONTROLLER;
>  
> -	boarddata->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
> -	if (gpio_is_valid(boarddata->cd_gpio))
> -		boarddata->cd_type = ESDHC_CD_GPIO;
> -
>  	boarddata->wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
>  	if (gpio_is_valid(boarddata->wp_gpio))
>  		boarddata->wp_type = ESDHC_WP_GPIO;

This is equally unused.

Commit 8d86e4fcccf61ba mmc: sdhci-esdhc-imx: Call mmc_of_parse()
is seriously broken. It removed the calls to

mmc_gpio_request_ro(host->mmc, boarddata->wp_gpio);

and

mmc_gpio_request_cd(host->mmc, boarddata->cd_gpio, 0);

This makes the boarddata gpios unused, thus effectivly breaking
platform_data provided cd/wp gpios. Not that I care much about
platform_data based boards, but maybe we should make that explicit.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
