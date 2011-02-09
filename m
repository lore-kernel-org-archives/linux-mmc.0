From: Estevam Fabio-R49496 <R49496@freescale.com>
Subject: RE: [PATCH] mmc: mmc_mxc: Allow selection only for the correct
 platforms
Date: Wed, 9 Feb 2011 00:40:51 +0000
Message-ID: <F09210E57DF486449C294B7BFB86534713C019@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
 <20110121103517.GD9041@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:12979 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab1BIAlH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2011 19:41:07 -0500
In-Reply-To: <20110121103517.GD9041@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "cjb@laptop.org" <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <s.hauer@pengutronix.de>

Chris?

-----Original Message-----
From: Sascha Hauer [mailto:s.hauer@pengutronix.de] 
Sent: Friday, January 21, 2011 8:35 AM
To: Estevam Fabio-R49496
Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; kernel@pengutronix.de; u.kleine-koenig@pengutronix.de; linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mmc: mmc_mxc: Allow selection only for the correct platforms

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
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig index 
> d618e86..a3a9ec1 100644
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


