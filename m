From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [RFC/PATCH] mmc: core: Kill block requests if card is removed
Date: Wed, 12 Oct 2011 16:04:22 +0530
Message-ID: <4E956D2E.5070706@codeaurora.org>
References: <1318405013-32434-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1318405013-32434-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Sujit,

On 10/12/2011 1:06 PM, Sujit Reddy Thumma wrote:
> Kill block requests when the host knows that the card is
> removed from the slot and is sure that it can no longer
> accept any requests.
> 
> Kill this silently so that the block layer don't output
> error messages unnecessarily.
> 
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>
<snip>
>  
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 0ea4a06..7cdbc14 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -196,6 +196,7 @@ struct mmc_card {
>  #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
>  #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
>  #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
> +#define MMC_STATE_INSERTED      (1<<7)          /* card present in the slot */
>  	unsigned int		quirks; 	/* card quirks */
>  #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
>  #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
> @@ -344,6 +345,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>  #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
>  
>  #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
> +#define mmc_card_inserted(c)     ((c)->state & MMC_STATE_INSERTED)
>  #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
>  #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
>  #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
> @@ -352,6 +354,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>  #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>  
>  #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
> +#define mmc_card_set_inserted(c) ((c)->state |= MMC_STATE_INSERTED)
>  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
>  #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
>  #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)

Why do we need another flag to indicate card's presence? can not we use
MMC_STATE_PRESENT flag? This flag is set in mmc_add_card(). But not
cleared any where...

Thanks,
Pavan


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
