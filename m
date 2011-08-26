From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/1] mmc: Support of DUAL BUFFER DESC[ring] mode for dw_mmc
Date: Fri, 26 Aug 2011 14:39:54 +0100
Message-ID: <4E57A22A.7050604@imgtec.com>
References: <CANYdXno+b6ZZ=3upGMwYxxbJMbKSteWKGM=RxtKhSOYr3iov4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:18789 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505Ab1HZNj6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Aug 2011 09:39:58 -0400
In-Reply-To: <CANYdXno+b6ZZ=3upGMwYxxbJMbKSteWKGM=RxtKhSOYr3iov4g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi,

Thanks for sending the patch.

On 08/26/2011 11:31 AM, Shashidhar Hiremath wrote:
> This Patch adds the support for Dual Buffer Descriptor mode of
> Operation for the dw_mmc driver.The patch also provides the configurability
> Option for choosing DUAL_BUFFER mode or the chained modes through menuconfig.
> The Menuconfig option for selecting Dual Buffer mode or chained mode
> is selected only if
> Internal DMAC is enabled.
> 
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
>  drivers/mmc/host/Kconfig  |   22 ++++++++++++++++++
>  drivers/mmc/host/dw_mmc.c |   55 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 67 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8c87096..e10f585 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -534,6 +534,28 @@ config MMC_DW_IDMAC
>  	  Designware Mobile Storage IP block. This disables the external DMA
>  	  interface.
> 
> +config IDMAC_DESC_MODE

I think this config needs to be more specific, otherwise it could
conflict with drivers for other hardware with an internal DMAC, i.e.
something like MMC_DW_IDMAC_DESC_MODE.

> +	bool "Internal DMAC Descriptor Operating Mode"
> +	depends on MMC_DW_IDMAC
> +	help
> +	  This selects the Operating mode for the Descriptors.

Am I right that there are 3 modes, dual buffer, chain descriptor, and
something else?
This config option doesn't seem necessary. I would put "optional" in the
choice below, or add a choice for whatever the mode is called when
neither option is selected.
If there are only the two options, don't have the choice depend on
IDMAC_DESC_MODE, otherwise if you don't select it, neither of the
choices will be set.

> +
> +choice
> +	prompt "select configuration"
> +	depends on IDMAC_DESC_MODE
> +
> +config CHAIN_DESC

same here (config name)

> +	bool "Chain Descriptor Structure"
> +	help
> +	  Select this option to enable Chained Mode of Operation.
> +
> +config DUAL_BUFFER_DESC

same here (config name)

> +	bool "Dual Buffer Descriptor Structure"
> +	help
> +	  Select this option to enable Dual Buffer Desc Mode of Operation.
> +endchoice
> +
> +

probably no need for the extra newline

>  config MMC_SH_MMCIF
>  	tristate "SuperH Internal MMCIF support"
>  	depends on MMC_BLOCK && (SUPERH || ARCH_SHMOBILE)
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0f714..a590856 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -63,6 +63,9 @@ struct idmac_desc {
>  	u32		des1;	/* Buffer sizes */
>  #define IDMAC_SET_BUFFER1_SIZE(d, s) \
>  	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
> +#define IDMAC_SET_BUFFER_SIZE(d, s1, s2) \
> +	((d)->des1 = ((d)->des1 & 0x0) | \

Do you mean to & with 0 there?

> +	(((s1) & 0x1fff) | ((s2) & 0x1fff << 13)))
> 
>  	u32		des2;	/* buffer 1 physical address */
> 
> @@ -348,17 +351,44 @@ static void dw_mci_translate_sglist(struct
> dw_mci *host, struct mmc_data *data,
>  	struct idmac_desc *desc = host->sg_cpu;
> 
>  	for (i = 0; i < sg_len; i++, desc++) {
> -		unsigned int length = sg_dma_len(&data->sg[i]);
> -		u32 mem_addr = sg_dma_address(&data->sg[i]);
> -
> -		/* Set the OWN bit and disable interrupts for this descriptor */
> +		/*length and mem_aadress of first buffer*/

it'd be nice to have a space after /* and before */ to be consistent.

> +		unsigned int length1 = sg_dma_len(&data->sg[i]);
> +		u32 mem_addr1 = sg_dma_address(&data->sg[i]);
> +#ifdef CONFIG_DUAL_BUFFER_DESC
> +		unsigned int length2;
> +		u32 mem_addr2;
> +		if ((i+1) <= sg_len) {

should that be "< sg_len", it never hit sg[sg_len] before, but it will
below?

> +			length2 = sg_dma_len(&data->sg[i+1]);
> +			mem_addr2 = sg_dma_address(&data->sg[i+1]);
> +
> +			/* Set the OWN bit and disable interrupts
> +			 * for this descriptor
> +			 */

the coding style says to have multiline comments with nothing on the
first line, i.e.
/*
 * Set the OWN ....
 * ....
 */

> +			desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC
> +			desc->des0 &= (~IDMAC_DES0_CH);

is this line necessary, since you only just set it without that bit.

> +			/* Buffer length being set for Buffer1
> +			 * and Buffer2 being set
> +			 */

same here (multiline comment)

> +			IDMAC_SET_BUFFER_SIZE(desc, length1, length2);
> +			desc->des3 = mem_addr2;
> +			/* Incrementing for the second buffer */
> +			i++;
> +		} else {
> +			desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC
> +			desc->des0 &= (~IDMAC_DES0_CH);

same here (necessary?)

Also, should this be the same as the non-dual case (also have
IDMAC_DES0_CH), since there is only one sg buffer left?

> +			/* Buffer length being set for Buffer1
> +			 * and Buffer2 being set
> +			 */

same here (multiline comment)

> +			IDMAC_SET_BUFFER_SIZE(desc, length1, 0);
> +		}
> +#elif CONFIG_CHAIN_DESC
> +		/* Set OWN bit and disable interrupts for this descriptor */
>  		desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
> -
> -		/* Buffer length */
> -		IDMAC_SET_BUFFER1_SIZE(desc, length);
> -
> +		/* Buffer length for Buffer1*/

same here (comment spacing)

> +		IDMAC_SET_BUFFER1_SIZE(desc, length1);
> +#endif
>  		/* Physical address to DMA to/from */
> -		desc->des2 = mem_addr;
> +		desc->des2 = mem_addr1;
>  	}
> 
>  	/* Set first descriptor */
> @@ -369,6 +399,10 @@ static void dw_mci_translate_sglist(struct dw_mci
> *host, struct mmc_data *data,
>  	desc = host->sg_cpu + (i - 1) * sizeof(struct idmac_desc);
>  	desc->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
>  	desc->des0 |= IDMAC_DES0_LD;
> +#ifdef CONFIG_DUAL_BUFFER_DESC
> +	/*Set the End of Ring bit */

same here (comment spacing)

> +	desc->des0 |= IDMAC_DES0_ER;
> +#endif
> 
>  	wmb();
>  }
> @@ -388,7 +422,8 @@ static void dw_mci_idmac_start_dma(struct dw_mci
> *host, unsigned int sg_len)
> 
>  	/* Enable the IDMAC */
>  	temp = mci_readl(host, BMOD);
> -	temp |= SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB;
> +	/* The Descriptor Skip length is made zero */
> +	temp |= SDMMC_IDMAC_ENABLE | SDMMC_IDMAC_FB & SDMMC_BMOD_DSL(0);

should that be a | instead of &?

Also, where is SDMMC_BMOD_DSL defined?

>  	mci_writel(host, BMOD, temp);
> 
>  	/* Start it running */

Thanks
James

