From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH] mmc: remove MMC_CAP_NEEDS_POLL setting in sdhci_add_host
Date: Tue, 25 Sep 2012 00:04:01 -0700
Message-ID: <20120925070401.GA32230@lizard>
References: <1348554847-14190-1-git-send-email-yongd@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64624 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab2IYHGn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 03:06:43 -0400
Received: by pbbrr4 with SMTP id rr4so8566222pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 25 Sep 2012 00:06:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348554847-14190-1-git-send-email-yongd@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yongd <yongd@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Daniel Drake <dsd@laptop.org>, Zhangfei Gao <zhangfei.gao@marvell.com>

On Tue, Sep 25, 2012 at 02:34:07PM +0800, yongd wrote:
> From: yongd <yongd@marvell.com>
[...]
> And the better one to decide whether we use polling or not should be
> the host driver itself. Actually, some host driver has already been
> like this. Eg, in drivers/mmc/host/Au1xmmc.c, polling will be enabled
> only after the board-specific card detection can't be set up successfully.

I guess it's not that simple. If you remove this, you have to add
appropriate CAP_NEEDS_POLL for these drivers:

 linux/drivers/mmc/host$ git grep -l SDHCI_QUIRK_BROKEN_CARD_DETECTION | xargs grep -L NEEDS_POLL
 sdhci-esdhc-imx.c
 sdhci-of-esdhc.c
 sdhci-pci.c
 sdhci-pxav2.c
 sdhci-pxav3.c
 sdhci-s3c.c

> Change-Id: I27774488a7b9191d7bc39699fd7d62ee21bbf157
> Signed-off-by: yongd <yongd@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0e15c79..900d5f4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2840,10 +2840,6 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (caps[0] & SDHCI_CAN_DO_HISPD)
>  		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>  
> -	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> -	    !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
> -		mmc->caps |= MMC_CAP_NEEDS_POLL;
> -
>  	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
>  	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
>  	if (IS_ERR(host->vqmmc)) {
> -- 
> 1.7.9.5
