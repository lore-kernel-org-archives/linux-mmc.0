From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: split out preparation of desc for IDMAC32
 and IDMAC64
Date: Wed, 31 Aug 2016 15:55:15 +0900
Message-ID: <6e8fbd6b-c3ce-c360-663d-70aeaf87f641@samsung.com>
References: <CGME20160819095620epcas1p28ffdabf62af8d6e3c01941fde8c8b96b@epcas1p2.samsung.com>
 <1471599615-6249-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59855 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbcHaGzR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2016 02:55:17 -0400
In-reply-to: <1471599615-6249-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org

Hi Shawn,

On 08/19/2016 06:40 PM, Shawn Lin wrote:
> We intend to add more check for descriptors when
> preparing desc. Let's spilt out the separate body
> to make the dw_mci_translate_sglist not so lengthy.

Sorry for reviewing late.

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 148 +++++++++++++++++++++++++---------------------
>  1 file changed, 81 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 32380d5..0a5a49f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -467,103 +467,117 @@ static void dw_mci_dmac_complete_dma(void *arg)
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
> +			/* Update physical address for the next desc */
> +			mem_addr += desc_len;
> +
> +			/* Save pointer to the last descriptor */
> +			desc_last = desc;
>  		}
> +	}
>  
> -		/* Set first descriptor */
> -		desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
> +	/* Set first descriptor */
> +	desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
>  
> -		/* Set last descriptor */
> -		desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH |
> -					       IDMAC_DES0_DIC));
> -		desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
> -	}
> +	/* Set last descriptor */
> +	desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH |
> +				       IDMAC_DES0_DIC));
> +	desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
> +}
> +
> +static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
> +				    unsigned int sg_len)
> +{
> +	if (host->dma_64bit_address == 1)
> +		dw_mci_prepare_desc64(host, data, sg_len);
> +	else
> +		dw_mci_prepare_desc32(host, data, sg_len);

I think dw_mci_translate_sglist can be removed.
Instead, these functions should be called in dw_mci_idamc_start_dma().
How about? 

Best Regards,
Jaehoon Chung

>  
>  	wmb(); /* drain writebuffer */
>  }
> 

