From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 6/6] mmc: sdhci-pltfm: add pltfm-driver for imx35/51
Date: Tue, 28 Sep 2010 16:58:30 +0400
Message-ID: <20100928125830.GA421@oksana.dev.rtsoft.ru>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
 <1285677406-3359-7-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44567 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab0I1M6g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 08:58:36 -0400
Received: by mail-ey0-f174.google.com with SMTP id 6so1733089eyb.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 05:58:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285677406-3359-7-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, zhangfei gao <zhangfei.gao@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>

On Tue, Sep 28, 2010 at 02:36:46PM +0200, Wolfram Sang wrote:
> This driver adds basic support for the esdhc-core found on e.g.
> imx35/51. It adds up to the pltfm-core.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---

Just a few more nits:

> +++ b/drivers/mmc/host/Kconfig
> @@ -143,6 +143,16 @@ config MMC_SDHCI_MV
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_ESDHC

MMC_SDHCI_ESDHC_IMX

> +	bool "SDHCI platform support for the Freescale eSDHC controller"

SDHCI platform support for the Freescale eSDHC i.MX controller

[...]
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -0,0 +1,144 @@
> +/*
> + * Freescale eSDHC controller driver for the platform bus.

eSDHC i.MX

Other than that, looks good.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
