From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Mon, 14 Feb 2011 16:39:52 +0100
Message-ID: <20110214153952.GE10709@pengutronix.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
 <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35955 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675Ab1BNPj7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 10:39:59 -0500
Content-Disposition: inline
In-Reply-To: <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index afe8c6f..42a9e21 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -319,6 +319,15 @@ config MMC_MXC
>  
>  	  If unsure, say N.
>  
> +config MMC_MXS
> +	tristate "Freescale MXS Multimedia Card Interface support"
> +	depends on ARCH_MXS
> +	help
> +	  This selects the Freescale SSP MMC controller found on MXS based
> +	  platforms like mx23/28.
> +
> +	  If unsure, say N.
> +

It should also depend on MXS_DMA?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
