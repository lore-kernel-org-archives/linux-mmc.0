From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 09/25] mmc: sdhci: allocate alignment and DMA
 descriptor buffer together
Date: Wed, 27 Jan 2016 11:14:41 +0200
Message-ID: <56A88A81.8090505@intel.com>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
 <E1aO3qd-0005iN-OG@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19052 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbcA0JSH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jan 2016 04:18:07 -0500
In-Reply-To: <E1aO3qd-0005iN-OG@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On 26/01/16 15:39, Russell King wrote:
> Allocate both the alignment and DMA descriptor buffers together.  The
> size of the alignment buffer will always be aligned to the hosts
> required alignment, which gives appropriate alignment to the DMA
> descriptors.
> 
> We have a maximum of 128 segments, and a maximum alignment of 64 bits.
> This gives a maximum alignment buffer size of 1024 bytes.
> 
> The DMA descriptors are a maximum of 12 bytes, and we allocate 128 * 2
> + 1 of these, which gives a maximum DMA descriptor buffer size of 3084
> bytes.
> 
> This means the allocation for a 4K page sized system will be an order-1
> allocation, since the resulting overall size is 4108.  This is more
> prone to failure than page-sized allocations, but since this allocation
> commonly occurs at startup, the chances of failure are small.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/sdhci.c | 55 +++++++++++++++++-------------------------------
>  1 file changed, 19 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c70a2d2eb6d9..f23fdb485393 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2932,6 +2932,9 @@ int sdhci_add_host(struct sdhci_host *host)
>  		host->flags &= ~SDHCI_USE_SDMA;
>  
>  	if (host->flags & SDHCI_USE_ADMA) {
> +		dma_addr_t dma;
> +		void *buf;
> +
>  		/*
>  		 * The DMA descriptor table size is calculated as the maximum
>  		 * number of segments times 2, to allow for an alignment
> @@ -2947,45 +2950,27 @@ int sdhci_add_host(struct sdhci_host *host)
>  					      SDHCI_ADMA2_32_DESC_SZ;
>  			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
>  		}
> -		host->adma_table = dma_alloc_coherent(mmc_dev(mmc),
> -						      host->adma_table_sz,
> -						      &host->adma_addr,
> -						      GFP_KERNEL);
> +
>  		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
> -		host->align_buffer = dma_alloc_coherent(mmc_dev(mmc),
> -							host->align_buffer_sz,
> -							&host->align_addr,
> -							GFP_KERNEL);
> -		if (!host->adma_table || !host->align_buffer) {
> -			if (host->adma_table)
> -				dma_free_coherent(mmc_dev(mmc),
> -						  host->adma_table_sz,
> -						  host->adma_table,
> -						  host->adma_addr);
> -			if (host->align_buffer)
> -				dma_free_coherent(mmc_dev(mmc),
> -						  host->align_buffer_sz,
> -						  host->align_buffer,
> -						  host->align_addr);
> +		buf = dma_alloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
> +					 host->adma_table_sz, &dma, GFP_KERNEL);
> +		if (!buf) {
>  			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
>  				mmc_hostname(mmc));
>  			host->flags &= ~SDHCI_USE_ADMA;
> -			host->adma_table = NULL;
> -			host->align_buffer = NULL;
> -		} else if (host->adma_addr & (SDHCI_ADMA2_DESC_ALIGN - 1)) {
> +		} else if (dma & SDHCI_ADMA2_MASK) {

The descriptor table has a bigger alignment requirement, so that should remain the check i.e.

		} else if ((dma + host->align_buffer_sz) & (SDHCI_ADMA2_DESC_ALIGN - 1)) {


>  			pr_warn("%s: unable to allocate aligned ADMA descriptor\n",
>  				mmc_hostname(mmc));
>  			host->flags &= ~SDHCI_USE_ADMA;
> -			dma_free_coherent(mmc_dev(mmc), host->adma_table_sz,
> -					  host->adma_table, host->adma_addr);
> -			dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz,
> -					  host->align_buffer, host->align_addr);
> -			host->adma_table = NULL;
> -			host->align_buffer = NULL;
> -		}
> +			dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
> +					  host->adma_table_sz, buf, dma);
> +		} else {
> +			host->align_buffer = buf;
> +			host->align_addr = dma;
>  
> -		/* dma_alloc_coherent returns page aligned and sized buffers */
> -		BUG_ON(host->align_addr & SDHCI_ADMA2_MASK);
> +			host->adma_table = buf + host->align_buffer_sz;
> +			host->adma_addr = dma + host->align_buffer_sz;
> +		}
>  	}
>  
>  	/*
> @@ -3446,12 +3431,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>  	if (!IS_ERR(mmc->supply.vqmmc))
>  		regulator_disable(mmc->supply.vqmmc);
>  
> -	if (host->adma_table)
> -		dma_free_coherent(mmc_dev(mmc), host->adma_table_sz,
> -				  host->adma_table, host->adma_addr);
>  	if (host->align_buffer)
> -		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz,
> -				  host->align_buffer, host->align_addr);
> +		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
> +				  host->adma_table_sz, host->align_buffer,
> +				  host->align_addr);
>  
>  	host->adma_table = NULL;
>  	host->align_buffer = NULL;
> 

