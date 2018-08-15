From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH mmc-next v3 1/3] mmc: sdhci: add adma_table_num member to
 struct sdhci_host
Date: Wed, 15 Aug 2018 10:39:57 +0300
Message-ID: <553759fd-cf6d-a79d-1670-8bf94079725e@intel.com>
References: <20180730104424.44fa39a5@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180730104424.44fa39a5@xhacker.debian>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 30/07/18 05:44, Jisheng Zhang wrote:
> This patch adds adma_table_num member to struct sdhci_host to give more
> flexibility to drivers to control the ADMA table number.
> 
> Default value of adma_table_num is set to (SDHCI_MAX_SEGS * 2 + 1).
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci.c | 17 +++++++++--------
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a7b5602ef6f7..14dd4a49e03b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3316,6 +3316,13 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>  
>  	host->sdma_boundary = SDHCI_DEFAULT_BOUNDARY_ARG;
>  
> +	/*
> +	 * The DMA descriptor table number is calculated as the maximum

	 * The DMA table descriptor count is calculated as the maximum

> +	 * number of segments times 2, to allow for an alignment
> +	 * descriptor for each segment, plus 1 for a nop end descriptor.
> +	 */
> +	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1;

Let's make this adma_table_cnt

> +
>  	return host;
>  }
>  
> @@ -3561,18 +3568,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		dma_addr_t dma;
>  		void *buf;
>  
> -		/*
> -		 * The DMA descriptor table size is calculated as the maximum
> -		 * number of segments times 2, to allow for an alignment
> -		 * descriptor for each segment, plus 1 for a nop end descriptor,
> -		 * all multipled by the descriptor size.
> -		 */
>  		if (host->flags & SDHCI_USE_64_BIT_DMA) {
> -			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
> +			host->adma_table_sz = host->adma_table_num *
>  					      SDHCI_ADMA2_64_DESC_SZ;
>  			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
>  		} else {
> -			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
> +			host->adma_table_sz = host->adma_table_num *
>  					      SDHCI_ADMA2_32_DESC_SZ;
>  			host->desc_sz = SDHCI_ADMA2_32_DESC_SZ;
>  		}
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 23966f887da6..d55fd7033e93 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -563,6 +563,8 @@ struct sdhci_host {
>  	/* Host SDMA buffer boundary. */
>  	u32			sdma_boundary;
>  
> +	u32			adma_table_num;

Could use a comment

> +
>  	u64			data_timeout;
>  
>  	unsigned long private[0] ____cacheline_aligned;
> 
