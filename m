From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH V3] Powerpc eSDHC Recover from the ADMA error
Date: Wed, 19 Sep 2012 08:41:40 -0700
Message-ID: <20120919154140.GA1743@lizard>
References: <1348046559-13215-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46312 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab2ISPoU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 11:44:20 -0400
Received: by pbbrr13 with SMTP id rr13so2755032pbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 19 Sep 2012 08:44:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348046559-13215-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun.Zhang@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Wed, Sep 19, 2012 at 05:22:39PM +0800, Haijun.Zhang@freescale.com wrote:
> From: Haijun Zhang <Haijun.Zhang@freescale.com>
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
[...]
> ---
> changes for v3:
>         - Correct the if statement in function workground
> 
> changes for v2:
>         - Invert the condition of the if statement in function workground

Just two minor cosmetic comments...

>  drivers/mmc/host/sdhci-of-esdhc.c |   53 ++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c          |    2 +
>  drivers/mmc/host/sdhci.h          |    5 +++-
>  3 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 1cba55a..7a4c410 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -21,6 +21,7 @@
>  #include "sdhci-esdhc.h"
>  
>  #define VENDOR_V_22	0x12
> +#define VENDOR_V_23    0x13

The above line uses tab, but you add spaces.
A bit inconsistent.

[...]
> +static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
> +{
> +	u32 tmp;
> +	bool applicable;
> +	dma_addr_t dmastart;
> +	dma_addr_t dmanow;
> +
> +	tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
> +	tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> +
> +	applicable = (intmask & SDHCI_INT_DATA_END) &&
> +			(intmask & SDHCI_INT_BLK_GAP) &&
> +			(tmp == VENDOR_V_23);
> +	if (!applicable)
> +		return;
> +
> +	host->data->error = 0;
> +	dmastart = sg_dma_address(host->data->sg);
> +	dmanow = dmastart + host->data->bytes_xfered;
> +	/*
> +	 * Force update to the next DMA block boundary.
> +	 */
> +	dmanow = (dmanow &
> +		~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +

These two lines can be put into one.

> +		SDHCI_DEFAULT_BOUNDARY_SIZE;
> +	host->data->bytes_xfered = dmanow - dmastart;
> +	sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +}

The rest looks OK, so for of-esdhc part, feel free to add:

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!
