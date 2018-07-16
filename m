From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3 3/7] mmc: sdhci: add ADMA2 64-bit addressing support
 for V4 mode
Date: Mon, 16 Jul 2018 16:34:50 +0300
Message-ID: <412b1257-393d-8697-3521-30d8515b0258@intel.com>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
 <1531106398-14062-4-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531106398-14062-4-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
List-Id: linux-mmc@vger.kernel.org

On 09/07/18 06:19, Chunyan Zhang wrote:
> ADMA2 64-bit addressing support is divided into V3 mode and V4 mode.
> So there are two kinds of descriptors for ADMA2 64-bit addressing
> i.e. 96-bit Descriptor for V3 mode, and 128-bit Descriptor for V4
> mode. 128-bit Descriptor is aligned to 8-byte.
> 
> For V4 mode, ADMA2 64-bit addressing is enabled via Host Control 2
> register.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 28 ++++++++++++++++++++++++----
>  drivers/mmc/host/sdhci.h | 14 ++++++++++++--
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c7de6a5..7871ae2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3486,6 +3486,26 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>  	return 0;
>  }
>  
> +static inline bool sdhci_use_64bit_dma(struct sdhci_host *host)

I would prefer to call this sdhci_can_64bit_dma()

> +{
> +	u32 addr64bit_en;
> +
> +	/*
> +	 * According to SD Host Controller spec v4.10, bit[27] added from
> +	 * version 4.10 in Capabilities Register is used as 64-bit System
> +	 * Address support for V4 mode, 64-bit DMA Addressing for V4 mode
> +	 * is enabled only if 64-bit Addressing =1 in the Host Control 2
> +	 * register.
> +	 */
> +	if (host->version == SDHCI_SPEC_410 && host->v4_mode) {

That should be >= not ==

> +		addr64bit_en = (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
> +				SDHCI_CTRL_64BIT_ADDR);

This seems the wrong way around.  We should write SDHCI_CTRL_64BIT_ADDR when
we decide to use 64-bit DMA in V4 mode.

> +		return addr64bit_en && (host->caps & SDHCI_CAN_64BIT_V4);
> +	}
> +
> +	return host->caps & SDHCI_CAN_64BIT;
> +}
> +
>  int sdhci_setup_host(struct sdhci_host *host)
>  {
>  	struct mmc_host *mmc;
> @@ -3557,7 +3577,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
>  	 * implement.
>  	 */
> -	if (host->caps & SDHCI_CAN_64BIT)
> +	if (sdhci_use_64bit_dma(host))
>  		host->flags |= SDHCI_USE_64_BIT_DMA;
>  
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
> @@ -3591,8 +3611,8 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		 */
>  		if (host->flags & SDHCI_USE_64_BIT_DMA) {
>  			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
> -					      SDHCI_ADMA2_64_DESC_SZ;
> -			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
> +					      SDHCI_ADMA2_64_DESC_SZ(host);
> +			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ(host);
>  		} else {
>  			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
>  					      SDHCI_ADMA2_32_DESC_SZ;
> @@ -3600,7 +3620,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		}
>  
>  		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
> -		buf = dma_alloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
> +		buf = dma_zalloc_coherent(mmc_dev(mmc), host->align_buffer_sz +

The reason for the zalloc could use a comment

>  					 host->adma_table_sz, &dma, GFP_KERNEL);
>  		if (!buf) {
>  			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index e98249b..24fa58a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -185,6 +185,7 @@
>  #define  SDHCI_CTRL_EXEC_TUNING		0x0040
>  #define  SDHCI_CTRL_TUNED_CLK		0x0080
>  #define  SDHCI_CTRL_V4_MODE		0x1000
> +#define  SDHCI_CTRL_64BIT_ADDR		0x2000
>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
>  
>  #define SDHCI_CAPABILITIES	0x40
> @@ -205,6 +206,7 @@
>  #define  SDHCI_CAN_VDD_330	0x01000000
>  #define  SDHCI_CAN_VDD_300	0x02000000
>  #define  SDHCI_CAN_VDD_180	0x04000000
> +#define  SDHCI_CAN_64BIT_V4	0x08000000
>  #define  SDHCI_CAN_64BIT	0x10000000
>  
>  #define  SDHCI_SUPPORT_SDR50	0x00000001
> @@ -271,6 +273,8 @@
>  #define   SDHCI_SPEC_100	0
>  #define   SDHCI_SPEC_200	1
>  #define   SDHCI_SPEC_300	2
> +#define   SDHCI_SPEC_400	3
> +#define   SDHCI_SPEC_410	4

Let's also add

#define   SDHCI_SPEC_420	5

>  
>  /*
>   * End of controller registers.
> @@ -306,8 +310,14 @@ struct sdhci_adma2_32_desc {
>   */
>  #define SDHCI_ADMA2_DESC_ALIGN	8
>  
> -/* ADMA2 64-bit DMA descriptor size */
> -#define SDHCI_ADMA2_64_DESC_SZ	12
> +/*
> + * ADMA2 64-bit DMA descriptor size
> + * According to SD Host Controller spec v4.10, there are two kinds of
> + * descriptors for 64-bit addressing mode: 96-bit Descriptor and 128-bit
> + * Descriptor, if Host Version 4 Enable is set in the Host Control 2
> + * register, 128-bit Descriptor will be selected.
> + */
> +#define SDHCI_ADMA2_64_DESC_SZ(host)	((host)->v4_mode ? 16 : 12)
>  
>  /*
>   * ADMA2 64-bit descriptor. Note 12-byte descriptor can't always be 8-byte
> 
