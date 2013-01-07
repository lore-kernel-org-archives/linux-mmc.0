From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mmc: mxs-mmc: Add MODULE_ALIAS()
Date: Mon, 7 Jan 2013 23:43:19 +0100
Message-ID: <201301072343.19898.marex@denx.de>
References: <1357598512-24189-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:49496 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab3AGWnX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jan 2013 17:43:23 -0500
In-Reply-To: <1357598512-24189-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Dear Fabio Estevam,

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add an entry for MODULE_ALIAS().
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/mmc/host/mxs-mmc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 206fe49..b9a9ca0 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -804,3 +804,4 @@ module_platform_driver(mxs_mmc_driver);
>  MODULE_DESCRIPTION("FREESCALE MXS MMC peripheral");
>  MODULE_AUTHOR("Freescale Semiconductor");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRIVER_NAME);

Best regards,
Marek Vasut
