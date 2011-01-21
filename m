From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] mmc: mmc_mxc: Allow selection only for the correct
 platforms
Date: Fri, 21 Jan 2011 11:35:17 +0100
Message-ID: <20110121103517.GD9041@pengutronix.de>
References: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57086 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab1AUKfW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2011 05:35:22 -0500
Content-Disposition: inline
In-Reply-To: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-arm-kernel@lists.infradead.org

On Thu, Jan 20, 2011 at 03:02:59PM -0200, Fabio Estevam wrote:
> Currently MMC_MXC driver can be selected by all i.MX devices.
> 
> Restrict its use only for the appropriate processors.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index d618e86..a3a9ec1 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -288,7 +288,7 @@ config MMC_MSM
>  
>  config MMC_MXC
>  	tristate "Freescale i.MX2/3 Multimedia Card Interface support"
> -	depends on ARCH_MXC
> +	depends on MACH_MX21 || MACH_MX27 || ARCH_MX31
>  	help
>  	  This selects the Freescale i.MX2/3 Multimedia card Interface.
>  	  If you have a i.MX platform with a Multimedia Card slot,
> -- 
> 1.6.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
