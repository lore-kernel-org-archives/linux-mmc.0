From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch 1/1] sdhci: support MMC_CAP_MMC_HIGHSPEED
Date: Tue, 17 Aug 2010 08:57:59 +0100
Message-ID: <20100817075759.GA1733@console-pimps.org>
References: <AANLkTim8q285b==R7Q+QdqgJG5Q5D9yXpft7wZNA6Suw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:48928 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752692Ab0HQH6A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2010 03:58:00 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim8q285b==R7Q+QdqgJG5Q5D9yXpft7wZNA6Suw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

On Mon, Aug 16, 2010 at 09:22:30AM -0400, zhangfei gao wrote:
>
> From 165986b1ce3da7de57089ceb4547e84a5b530e64 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Mon, 16 Aug 2010 21:15:32 -0400
> Subject: [PATCH] sdhci: support MMC_CAP_MMC_HIGHSPEED
> 
> 
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7855121..913555e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1823,7 +1823,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;
>  
>  	if (caps & SDHCI_CAN_DO_HISPD)
> -		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
> +		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>  
>  	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>  		mmc->caps |= MMC_CAP_NEEDS_POLL;

Acked-by: Matt Fleming <matt@console-pimps.org>
