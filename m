From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] SDHCI: Don't assign mmc->caps at SDHCI directly
Date: Mon, 28 Jun 2010 11:34:15 -0700
Message-ID: <20100628113415.a36c1348.akpm@linux-foundation.org>
References: <20100612054450.GA25682@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59565 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750808Ab0F1Seu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jun 2010 14:34:50 -0400
In-Reply-To: <20100612054450.GA25682@july>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-mmc@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>

On Sat, 12 Jun 2010 14:44:50 +0900
Kyungmin Park <kyungmin.park@samsung.com> wrote:

> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Some host controller can set mmc->caps before sdhci_add_host.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4321e0c..142419c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1791,7 +1791,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  	else
>  		mmc->f_min = host->max_clk / 256;
>  	mmc->f_max = host->max_clk;
> -	mmc->caps = MMC_CAP_SDIO_IRQ;
> +	mmc->caps |= MMC_CAP_SDIO_IRQ;
>  
>  	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
>  		mmc->caps |= MMC_CAP_4_BIT_DATA;

A great shower of MMC patches have magically turned up in linux-next,
apparently via some tree of Grant's.  Those patches changed the above
code to look like:

        if (!(host->quirks & SDHCI_QUIRK_NO_SDIO_IRQ))
                mmc->caps |= MMC_CAP_SDIO_IRQ;

So it appears that this bug is fixed in that code as well.  So I'll
drop your patch.  If the above changes end up not getting merged into
mainline then your fix will be lost.

That fix was unchangelogged.  In fact the patch was completely
unchangelogged and I haven't looked at it at all and as far as I can
tell none of it has been sent to the mmc list.

