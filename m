From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: use lower/upper_32_bits() macros for DMA
 addresses
Date: Wed, 28 Aug 2019 16:01:37 +0300
Message-ID: <0d5da294-61f8-4b9f-1a6e-7212da40f572@intel.com>
References: <20190828111453.4023-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190828111453.4023-1-yamada.masahiro@socionext.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 28/08/19 2:14 PM, Masahiro Yamada wrote:
> Currently, the DMA addresses are casted to (u64) for the upper 32bits
> to avoid "right shift count >= width of type" warning.
> 
> <linux/kernel.h> provides macros to address this, and the macro names
> are self-documenting.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/mmc/host/sdhci.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a5dc5aae973e..07144a195a9f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -668,10 +668,10 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>  	/* 32-bit and 64-bit descriptors have these members in same position */
>  	dma_desc->cmd = cpu_to_le16(cmd);
>  	dma_desc->len = cpu_to_le16(len);
> -	dma_desc->addr_lo = cpu_to_le32((u32)addr);
> +	dma_desc->addr_lo = cpu_to_le32(lower_32_bits(addr));
>  
>  	if (host->flags & SDHCI_USE_64_BIT_DMA)
> -		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
> +		dma_desc->addr_hi = cpu_to_le32(upper_32_bits(addr));
>  
>  	*desc += host->desc_sz;
>  }
> @@ -827,9 +827,10 @@ static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>  static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
>  {
>  	if (host->v4_mode) {

To reduce line wrapping, how about using:

		u32 lo = lower_32_bits(addr);
		u32 hi = upper_32_bits(addr);

> -		sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
> +		sdhci_writel(host, lower_32_bits(addr), SDHCI_ADMA_ADDRESS);
>  		if (host->flags & SDHCI_USE_64_BIT_DMA)
> -			sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
> +			sdhci_writel(host, upper_32_bits(addr),
> +				     SDHCI_ADMA_ADDRESS_HI);
>  	} else {
>  		sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
>  	}
> @@ -1096,10 +1097,11 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  		} else if (host->flags & SDHCI_USE_ADMA) {

To reduce line wrapping, how about using:

			u32 lo = lower_32_bits(host->adma_addr);
			u32 hi = upper_32_bits(host->adma_addr);

>  			sdhci_adma_table_pre(host, data, sg_cnt);
>  
> -			sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
> +			sdhci_writel(host, lower_32_bits(host->adma_addr),
> +				     SDHCI_ADMA_ADDRESS);
>  			if (host->flags & SDHCI_USE_64_BIT_DMA)
>  				sdhci_writel(host,
> -					     (u64)host->adma_addr >> 32,
> +					     upper_32_bits(host->adma_addr),
>  					     SDHCI_ADMA_ADDRESS_HI);
>  		} else {
>  			WARN_ON(sg_cnt != 1);
> 
