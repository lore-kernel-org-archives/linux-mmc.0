From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for
 dw_mmc
Date: Tue, 30 Aug 2011 09:56:01 +0100
Message-ID: <4E5CA5A1.1060901@imgtec.com>
References: <1314692959-4139-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:11332 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841Ab1H3I4G (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Aug 2011 04:56:06 -0400
In-Reply-To: <1314692959-4139-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi Shashidhar

Thanks for the updated patch.

On 08/30/2011 09:29 AM, Shashidhar Hiremath wrote:
> This Patch adds the support for Dual Buffer Descriptor mode of
> Operation for the dw_mmc driver.The patch also provides the configurability
> Option for choosing DUAL_BUFFER mode or the chained modes through menuconfig.
> The Menuconfig option for selecting Dual Buffer mode or chained mode
> is selected only if Internal DMAC is enabled.
> 
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> v2:
> * As per suggestions by Will Newton and James Hogan
> -Config symbol Names prefixed with MMC_DW
> -Added more Description for Config parameters added
> -Removed unnecessary config opion IDMAC_DESC_MODE
> -IDMAC_SET_BUFFER_SIZE chenged IDMAC_SET_BUFFER_SIZES
> -fixed typos and indented commments correctly
> -if ((i +1) <= sg_len changed to ((i +1) < sg_len
> -duplication "desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC" line removed
> -fixed bug in making DSL value zero
> -removed ANDing the des1 with zero before writing buffer lengths to it
> -Added proper multiline comments
> ---
>  drivers/mmc/host/Kconfig  |   19 +++++++++++++++++
>  drivers/mmc/host/dw_mmc.c |   49 +++++++++++++++++++++++++++++++++++---------
>  drivers/mmc/host/dw_mmc.h |    2 +
>  3 files changed, 60 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8c87096..1e20dfa 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -534,6 +534,25 @@ config MMC_DW_IDMAC
>  	  Designware Mobile Storage IP block. This disables the external DMA
>  	  interface.
>  
> +choice
> +	prompt "select  IDMAC Descriptors Mode"
> +	depends on MMC_DW_IDMAC
> +
> +config MMC_DW_CHAIN_DESC
> +	bool "Chain Descriptor Structure"
> +	help
> +	  Select this option to enable Chained Mode of Operation and the
> +	  Chained Mode operates in a mode where only one Buffer will be used
> +	  for each descriptor when the transfer is happening in DMA mode.
> +
> +config MMC_DW_DUAL_BUFFER_DESC
> +	bool "Dual Buffer Descriptor Structure"
> +	help
> +	  Select this option to enable Dual Buffer Desc Mode of Operation and
> +	  Dual Buffer Descriptor Mode or the Ring Mode indicates that two
> +	  buffers can be used for each descriptor during DMA mode transfer.
> +endchoice
> +
>  config MMC_SH_MMCIF
>  	tristate "SuperH Internal MMCIF support"
>  	depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0f714..ee02208 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -63,6 +63,9 @@ struct idmac_desc {
>  	u32		des1;	/* Buffer sizes */
>  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
>  	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
> +#define IDMAC_SET_BUFFER_SIZES(d, s1, s2) \
> +	((d)->des1 = (((d)->des1)  | \
> +	(((s1) & 0x1fff) | ((s2) & 0x1fff << 13))))

This still doesn't look right. The fields which get OR'd in don't get
cleared first, so if there is already a value you'll get the OR of the
old and new value. I think you were correct before in masking with 0,
but that means you can entirely drop the reference to (d)->des1, since
the new value doesn't depend on the old value.

>  
>  	u32		des2;	/* buffer 1 physical address */
>  
> @@ -348,17 +351,38 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
>  	struct idmac_desc *desc = host->sg_cpu;
>  
>  	for (i = 0; i < sg_len; i++, desc++) {
> -		unsigned int length = sg_dma_len(&data->sg[i]);
> -		u32 mem_addr = sg_dma_address(&data->sg[i]);
> +		/* Length and mem_address of first buffer */
> +		unsigned int length1 = sg_dma_len(&data->sg[i]);
> +		u32 mem_addr1 = sg_dma_address(&data->sg[i]);
> +#ifdef CONFIG_DUAL_BUFFER_DESC

don't forget to rename the configs here too.

> +		unsigned int length2;
> +		u32 mem_addr2;
>  
> -		/* Set the OWN bit and disable interrupts for this descriptor */
> +		/*
> +		 * Set the OWN bit and disable interrupts
> +		 * for this descriptor
> +		 */
> +		desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC
> +		if ((i+1) < sg_len) {
> +			length2 = sg_dma_len(&data->sg[i+1]);
> +			mem_addr2 = sg_dma_address(&data->sg[i+1]);
> +			/* Buffer length being set for Buffer1 and Buffer2 */
> +			IDMAC_SET_BUFFER_SIZES(desc, length1, length2);
> +			desc->des3 = mem_addr2;
> +			/* Incrementing for the second buffer */
> +			i++;
> +		} else {
> +			/* Buffer length being set for Buffer1 and Buffer2 */
> +			IDMAC_SET_BUFFER_SIZES(desc, length1, 0);
> +		}
> +#elif CONFIG_CHAIN_DESC

here too

> +		/* Set OWN bit and disable interrupts for this descriptor */
>  		desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
> -
> -		/* Buffer length */
> -		IDMAC_SET_BUFFER1_SIZE(desc, length);
> -
> +		/* Buffer length for Buffer1 */
> +		IDMAC_SET_BUFFER1_SIZE(desc, length1);
> +#endif
>  		/* Physical address to DMA to/from */
> -		desc->des2 = mem_addr;
> +		desc->des2 = mem_addr1;
>  	}
>  
>  	/* Set first descriptor */
> @@ -369,6 +393,10 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
>  	desc = host->sg_cpu + (i - 1) * sizeof(struct idmac_desc);
>  	desc->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
>  	desc->des0 |= IDMAC_DES0_LD;
> +#ifdef CONFIG_DUAL_BUFFER_DESC

and here

> +	/* Set the End of Ring bit */
> +	desc->des0 |= IDMAC_DES0_ER;
> +#endif
>  
>  	wmb();
>  }
> @@ -388,7 +416,8 @@ static void dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>  
>  	/* Enable the IDMAC */
>  	temp = mci_readl(host, BMOD);
> -	temp |= SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
> +	/* The Descriptor Skip length is made zero */
> +	temp |= SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB | SDMMC_BMOD_DSL(0);

this won't actually set the DSL to zero (you cannot clear bits with a |=
operator. You probably want to clear the DSL bits in temp, and then OR
in the new DSL value (or not in the case of setting it to 0).

>  	mci_writel(host, BMOD, temp);
>  
>  	/* Start it running */
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 027d377..0520dc8 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -72,6 +72,8 @@
>  /* Clock Enable register defines */
>  #define SDMMC_CLKEN_LOW_PWR		BIT(16)
>  #define SDMMC_CLKEN_ENABLE		BIT(0)
> +/* BMOD register defines */
> +#define SDMMC_BMOD_DSL(n)		_SBF(2, (n))
>  /* time-out register defines */
>  #define SDMMC_TMOUT_DATA(n)		_SBF(8, (n))
>  #define SDMMC_TMOUT_DATA_MSK		0xFFFFFF00

Cheers
James

