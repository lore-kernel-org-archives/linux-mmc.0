From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/7] mmc: host: sdhci-esdhc-imx: fix broken email address
Date: Tue, 5 May 2015 10:33:57 +0200
Message-ID: <CAPDyKFroUmeBTjOJxWbE5K9ygQPDrH1aEORBVxHE5eY1fwJ+Ow@mail.gmail.com>
References: <1429537917-7433-1-git-send-email-wsa@the-dreams.de>
	<1429537917-7433-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429537917-7433-5-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20 April 2015 at 15:51, Wolfram Sang <wsa@the-dreams.de> wrote:
> My Pengutronix address is not valid anymore, redirect people to the Pengutronix
> kernel team.
>
> Reported-by: Harald Geyer <harald@ccbib.org>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Robert Schwebel <r.schwebel@pengutronix.de>

Thanks, applied.

Kind regards
Uffe

> ---
> These patches shall go via the individual subsystem trees.
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 10ef8244a23963..3d7aa50e04578a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -4,7 +4,7 @@
>   * derived from the OF-version.
>   *
>   * Copyright (c) 2010 Pengutronix e.K.
> - *   Author: Wolfram Sang <w.sang@pengutronix.de>
> + *   Author: Wolfram Sang <kernel@pengutronix.de>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -1173,5 +1173,5 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
>  module_platform_driver(sdhci_esdhc_imx_driver);
>
>  MODULE_DESCRIPTION("SDHCI driver for Freescale i.MX eSDHC");
> -MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
> +MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
>  MODULE_LICENSE("GPL v2");
> --
> 2.1.4
>
