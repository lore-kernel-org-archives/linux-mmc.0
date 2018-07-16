From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 2/7] mmc: sdhci: made changes for System Address
 register of SDMA
Date: Mon, 16 Jul 2018 16:03:01 +0300
Message-ID: <1653583c-8d5b-6781-e923-9dcfd1e96403@intel.com>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
 <1531106398-14062-3-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531106398-14062-3-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
List-Id: linux-mmc@vger.kernel.org

On 09/07/18 06:19, Chunyan Zhang wrote:
> According to the SD host controller specification version 4.10, when
> Host Version 4 is enabled, SDMA uses ADMA System Address register
> (05Fh-058h) instead of using SDMA System Address register to
> support both 32-bit and 64-bit addressing.

The commit message is good but the subject is not so good.  What about
"Change SDMA address register for V4 mode"

> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 525862f..c7de6a5 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -701,7 +701,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  	}
>  }
>  
> -static u32 sdhci_sdma_address(struct sdhci_host *host)
> +static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
>  {
>  	if (host->bounce_buffer)
>  		return host->bounce_addr;
> @@ -709,6 +709,18 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
>  		return sg_dma_address(host->data->sg);
>  }
>  
> +static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
> +{
> +	if (host->v4_mode) {
> +		sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
> +		if (host->flags & SDHCI_USE_64_BIT_DMA)
> +			sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
> +	} else {
> +		sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
> +	}
> +
> +}
> +
>  static unsigned int sdhci_target_timeout(struct sdhci_host *host,
>  					 struct mmc_command *cmd,
>  					 struct mmc_data *data)
> @@ -968,8 +980,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  					     SDHCI_ADMA_ADDRESS_HI);
>  		} else {
>  			WARN_ON(sg_cnt != 1);
> -			sdhci_writel(host, sdhci_sdma_address(host),
> -				     SDHCI_DMA_ADDRESS);
> +			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
>  		}
>  	}
>  
> @@ -2796,7 +2807,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  		 * some controllers are faulty, don't trust them.
>  		 */
>  		if (intmask & SDHCI_INT_DMA_END) {
> -			u32 dmastart, dmanow;
> +			dma_addr_t dmastart, dmanow;
>  
>  			dmastart = sdhci_sdma_address(host);
>  			dmanow = dmastart + host->data->bytes_xfered;
> @@ -2807,9 +2818,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  				~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +

That isn't going to work with 64-bit addresses.  Need to cast
SDHCI_DEFAULT_BOUNDARY_SIZE to dma_addr_t

>  				SDHCI_DEFAULT_BOUNDARY_SIZE;
>  			host->data->bytes_xfered = dmanow - dmastart;
> -			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
> -			    dmastart, host->data->bytes_xfered, dmanow);
> -			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
> +			DBG("DMA base 0x%016llx, transferred 0x%06x bytes, next 0x%016llx\n",

Can you use %pad for dma_addr_t

> +			    (u64)dmastart, host->data->bytes_xfered, (u64)dmanow);
> +			sdhci_set_sdma_addr(host, dmanow);
>  		}
>  
>  		if (intmask & SDHCI_INT_DATA_END) {
> 
