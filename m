From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Assemble the codes of related to eMMC4.5
Date: Mon, 24 Oct 2011 07:09:15 -0400
Message-ID: <m2obx64pes.fsf@bob.laptop.org>
References: <001b01cc9238$156a65a0$403f30e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001b01cc9238$156a65a0$403f30e0$%jun@samsung.com> (Seungwon
	Jeon's message of "Mon, 24 Oct 2011 19:31:25 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi Seungwon,

On Mon, Oct 24 2011, Seungwon Jeon wrote:
> Code cleanup. The codes of related to eMMC4.5 are scattered.
> This patch removes a duplicate if-statement and assembles all.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/core/mmc.c |   20 +++++++++-----------
>  1 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index fb5bf01..3627044 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -467,29 +467,27 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  		card->ext_csd.rst_n_function = ext_csd[EXT_CSD_RST_N_FUNCTION];
>  	}
>
> -	/* eMMC v4.5 or later */
> -	if (card->ext_csd.rev >= 6)
> -		card->ext_csd.feature_support |= MMC_DISCARD_FEATURE;
> -
>  	card->ext_csd.raw_erased_mem_count = ext_csd[EXT_CSD_ERASED_MEM_CONT];
>  	if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
>  		card->erased_byte = 0xFF;
>  	else
>  		card->erased_byte = 0x0;
>
> +	/* eMMC v4.5 or later */
>  	if (card->ext_csd.rev >= 6) {
> +		card->ext_csd.feature_support |= MMC_DISCARD_FEATURE;
> +
>  		card->ext_csd.generic_cmd6_time = 10 *
>  			ext_csd[EXT_CSD_GENERIC_CMD6_TIME];
>  		card->ext_csd.power_off_longtime = 10 *
>  			ext_csd[EXT_CSD_POWER_OFF_LONG_TIME];
> -	} else
> -		card->ext_csd.generic_cmd6_time = 0;

Your patch removes this line completely.  Why is that?  You should
explain it in the commit message.

>
> -	card->ext_csd.cache_size =
> -		ext_csd[EXT_CSD_CACHE_SIZE + 0] << 0 |
> -		ext_csd[EXT_CSD_CACHE_SIZE + 1] << 8 |
> -		ext_csd[EXT_CSD_CACHE_SIZE + 2] << 16 |
> -		ext_csd[EXT_CSD_CACHE_SIZE + 3] << 24;
> +		card->ext_csd.cache_size =
> +			ext_csd[EXT_CSD_CACHE_SIZE + 0] << 0 |
> +			ext_csd[EXT_CSD_CACHE_SIZE + 1] << 8 |
> +			ext_csd[EXT_CSD_CACHE_SIZE + 2] << 16 |
> +			ext_csd[EXT_CSD_CACHE_SIZE + 3] << 24;
> +	}
>
>  out:
>  	return err;

The rest looks good, thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
