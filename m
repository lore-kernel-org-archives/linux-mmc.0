From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: mxcmmc: Fix MODULE_ALIAS
Date: Mon, 29 Oct 2012 21:42:53 +0100
Message-ID: <20121029204253.GT1641@pengutronix.de>
References: <1349810765-12351-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53473 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760824Ab2J2Um5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 16:42:57 -0400
Content-Disposition: inline
In-Reply-To: <1349810765-12351-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Tue, Oct 09, 2012 at 04:26:05PM -0300, Fabio Estevam wrote:
> The correct name for the driver is "mxc-mmc".
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/mmc/host/mxcmmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 565c2e4..6290b7f 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1134,4 +1134,4 @@ module_platform_driver(mxcmci_driver);
>  MODULE_DESCRIPTION("i.MX Multimedia Card Interface Driver");
>  MODULE_AUTHOR("Sascha Hauer, Pengutronix");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:imx-mmc");
> +MODULE_ALIAS("platform:mxc-mmc");
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
