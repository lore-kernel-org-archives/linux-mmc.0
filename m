From: ajh mls <ajhmls@gmail.com>
Subject: Re: [PATCH] mmc: core: Fix the incorrect calculation for erase unit size.
Date: Sun, 11 Sep 2011 20:32:05 +0300
Message-ID: <CAN+dfcRYP2YktuDTUK5ARPEj87G3jO1nJoT_vCgATXFxFRizzA@mail.gmail.com>
References: <1315461565-16009-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1315461565-16009-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

On 08/09/2011, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Erase unit size of high capacity is multiple of 512KiB not 1024KiB.

Isn't hc_erase_size in sectors so 512 x 1024 / 512 = 1024 and so the
code is correct.

>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/core/mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index b148bb1..7991ecf 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -332,7 +332,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8
> *ext_csd)
>  		card->ext_csd.hc_erase_timeout = 300 *
>  			ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT];
>  		card->ext_csd.hc_erase_size =
> -			ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] << 10;
> +			ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] << 9;
>
>  		card->ext_csd.rel_sectors = ext_csd[EXT_CSD_REL_WR_SEC_C];
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
