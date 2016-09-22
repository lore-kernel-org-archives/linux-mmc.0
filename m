From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/4] mmc: dw_mmc: split out preparation of desc for
 IDMAC32 and IDMAC64
Date: Thu, 22 Sep 2016 13:25:47 +0900
Message-ID: <a879ad4e-281d-2cc0-f746-0598f934d792@samsung.com>
References: <CGME20160902041949epcas1p443d773752cd7fb202beee72e88dbe8b9@epcas1p4.samsung.com>
 <1472789679-15121-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59812 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbcIVEZu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 00:25:50 -0400
In-reply-to: <1472789679-15121-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org

On 09/02/2016 01:14 PM, Shawn Lin wrote:
> We intend to add more check for descriptors when
> preparing desc. Let's spilt out the separate body
> to make the dw_mci_translate_sglist not so lengthy.
> After spliting out these two functions, we could
> remove dw_mci_translate_sglist and call both of them
> when staring idmac.

Applied on my tree. Thanks!

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - remove dw_mci_translate_sglist
> 
>  drivers/mmc/host/dw_mmc.c | 149 ++++++++++++++++++++++++----------------------
>  1 file changed, 79 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 22dacae..782b303 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -467,112 +467,121 @@ static void dw_mci_dmac_complete_dma(void *arg)
>  	}
>  }
>  
> -static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
> -				    unsigned int sg_len)
> +static inline void dw_mci_prepare_desc64(struct dw_mci *host,
> +					 struct mmc_data *data,
> +					 unsigned int sg_len)
>  {
>  	unsigned int desc_len;
> +	struct idmac_desc_64addr *desc_first, *desc_last, *desc;
>  	int i;
>  
> -	if (host->dma_64bit_address == 1) {
> -		struct idmac_desc_64addr *desc_first, *desc_last, *desc;
> -
> -		desc_first = desc_last = desc = host->sg_cpu;
> +	desc_first = desc_last = desc = host->sg_cpu;
>  
> -		for (i = 0; i < sg_len; i++) {
> -			unsigned int length = sg_dma_len(&data->sg[i]);
> +	for (i = 0; i < sg_len; i++) {
> +		unsigned int length = sg_dma_len(&data->sg[i]);
>  
> -			u64 mem_addr = sg_dma_address(&data->sg[i]);
> +		u64 mem_addr = sg_dma_address(&data->sg[i]);
>  
> -			for ( ; length ; desc++) {
> -				desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
> -					   length : DW_MCI_DESC_DATA_LENGTH;
> +		for ( ; length ; desc++) {
> +			desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
> +				   length : DW_MCI_DESC_DATA_LENGTH;
>  
> -				length -= desc_len;
> +			length -= desc_len;
>  
> -				/*
> -				 * Set the OWN bit and disable interrupts
> -				 * for this descriptor
> -				 */
> -				desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC |
> -							IDMAC_DES0_CH;
> +			/*
> +			 * Set the OWN bit and disable interrupts
> +			 * for this descriptor
> +			 */
> +			desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC |
> +						IDMAC_DES0_CH;
>  
> -				/* Buffer length */
> -				IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, desc_len);
> +			/* Buffer length */
> +			IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, desc_len);
>  
> -				/* Physical address to DMA to/from */
> -				desc->des4 = mem_addr & 0xffffffff;
> -				desc->des5 = mem_addr >> 32;
> +			/* Physical address to DMA to/from */
> +			desc->des4 = mem_addr & 0xffffffff;
> +			desc->des5 = mem_addr >> 32;
>  
> -				/* Update physical address for the next desc */
> -				mem_addr += desc_len;
> +			/* Update physical address for the next desc */
> +			mem_addr += desc_len;
>  
> -				/* Save pointer to the last descriptor */
> -				desc_last = desc;
> -			}
> +			/* Save pointer to the last descriptor */
> +			desc_last = desc;
>  		}
> +	}
>  
> -		/* Set first descriptor */
> -		desc_first->des0 |= IDMAC_DES0_FD;
> +	/* Set first descriptor */
> +	desc_first->des0 |= IDMAC_DES0_FD;
>  
> -		/* Set last descriptor */
> -		desc_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
> -		desc_last->des0 |= IDMAC_DES0_LD;
> +	/* Set last descriptor */
> +	desc_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
> +	desc_last->des0 |= IDMAC_DES0_LD;
> +}
>  
> -	} else {
> -		struct idmac_desc *desc_first, *desc_last, *desc;
>  
> -		desc_first = desc_last = desc = host->sg_cpu;
> +static inline void dw_mci_prepare_desc32(struct dw_mci *host,
> +					 struct mmc_data *data,
> +					 unsigned int sg_len)
> +{
> +	unsigned int desc_len;
> +	struct idmac_desc *desc_first, *desc_last, *desc;
> +	int i;
>  
> -		for (i = 0; i < sg_len; i++) {
> -			unsigned int length = sg_dma_len(&data->sg[i]);
> +	desc_first = desc_last = desc = host->sg_cpu;
>  
> -			u32 mem_addr = sg_dma_address(&data->sg[i]);
> +	for (i = 0; i < sg_len; i++) {
> +		unsigned int length = sg_dma_len(&data->sg[i]);
>  
> -			for ( ; length ; desc++) {
> -				desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
> -					   length : DW_MCI_DESC_DATA_LENGTH;
> +		u32 mem_addr = sg_dma_address(&data->sg[i]);
>  
> -				length -= desc_len;
> +		for ( ; length ; desc++) {
> +			desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
> +				   length : DW_MCI_DESC_DATA_LENGTH;
>  
> -				/*
> -				 * Set the OWN bit and disable interrupts
> -				 * for this descriptor
> -				 */
> -				desc->des0 = cpu_to_le32(IDMAC_DES0_OWN |
> -							 IDMAC_DES0_DIC |
> -							 IDMAC_DES0_CH);
> +			length -= desc_len;
>  
> -				/* Buffer length */
> -				IDMAC_SET_BUFFER1_SIZE(desc, desc_len);
> +			/*
> +			 * Set the OWN bit and disable interrupts
> +			 * for this descriptor
> +			 */
> +			desc->des0 = cpu_to_le32(IDMAC_DES0_OWN |
> +						 IDMAC_DES0_DIC |
> +						 IDMAC_DES0_CH);
>  
> -				/* Physical address to DMA to/from */
> -				desc->des2 = cpu_to_le32(mem_addr);
> +			/* Buffer length */
> +			IDMAC_SET_BUFFER1_SIZE(desc, desc_len);
>  
> -				/* Update physical address for the next desc */
> -				mem_addr += desc_len;
> +			/* Physical address to DMA to/from */
> +			desc->des2 = cpu_to_le32(mem_addr);
>  
> -				/* Save pointer to the last descriptor */
> -				desc_last = desc;
> -			}
> -		}
> -
> -		/* Set first descriptor */
> -		desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
> +			/* Update physical address for the next desc */
> +			mem_addr += desc_len;
>  
> -		/* Set last descriptor */
> -		desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH |
> -					       IDMAC_DES0_DIC));
> -		desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
> +			/* Save pointer to the last descriptor */
> +			desc_last = desc;
> +		}
>  	}
>  
> -	wmb(); /* drain writebuffer */
> +	/* Set first descriptor */
> +	desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
> +
> +	/* Set last descriptor */
> +	desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH |
> +				       IDMAC_DES0_DIC));
> +	desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
>  }
>  
>  static int dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
>  {
>  	u32 temp;
>  
> -	dw_mci_translate_sglist(host, host->data, sg_len);
> +	if (host->dma_64bit_address == 1)
> +		dw_mci_prepare_desc64(host, host->data, sg_len);
> +	else
> +		dw_mci_prepare_desc32(host, host->data, sg_len);
> +
> +	/* drain writebuffer */
> +	wmb();
>  
>  	/* Make sure to reset DMA in case we did PIO before this */
>  	dw_mci_ctrl_reset(host, SDMMC_CTRL_DMA_RESET);
> 

