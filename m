From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] mmc: block: skip trim for some kingston eMMCs
Date: Tue, 25 Aug 2015 14:06:18 +0200
Message-ID: <CAPDyKFodtrSgHgzUtxQcxc=TndVOBmqf+FZnNnhpr5-ifL5f7A@mail.gmail.com>
References: <1439356112-10734-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439356112-10734-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 August 2015 at 07:08, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> For some mass production of kingston eMMCs which adopt Phison's
> firmware will meet an unrecoverable data conrruption occasionally
> if performing trim due to a firmware bug confirmed by vendor. We
> found it on Intel-C3230RK platform. So we add fixup of broken trim
> for it.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next with a minor change (see below).

Kind regards
Uffe

>
> ---
>
>  drivers/mmc/card/block.c | 11 +++++++++++
>  drivers/mmc/core/core.c  |  3 ++-
>  include/linux/mmc/card.h |  2 ++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index a58287e..48be57b 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2389,6 +2389,7 @@ force_ro_fail:
>  #define CID_MANFID_TOSHIBA     0x11
>  #define CID_MANFID_MICRON      0x13
>  #define CID_MANFID_SAMSUNG     0x15
> +#define CID_MANFID_KINGSTON    0x70
>
>  static const struct mmc_fixup blk_fixups[] =
>  {
> @@ -2422,6 +2423,7 @@ static const struct mmc_fixup blk_fixups[] =
>         MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_BLK_NO_CMD23),
>
> +

This whitespace change I removed from the patch.

>         /*
>          * Some Micron MMC cards needs longer data read timeout than
>          * indicated in CSD.
> @@ -2451,6 +2453,15 @@ static const struct mmc_fixup blk_fixups[] =
>         MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
>
> +       /*
> +        *  On Some Kingston eMMCs, performing trim can result in
> +        *  unrecoverable data conrruption occasionally due to a firmware bug.
> +        */
> +       MMC_FIXUP("V10008", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_TRIM_BROKEN),
> +       MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_TRIM_BROKEN),
> +
>         END_FIXUP
>  };
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 083cade..8bbcc42 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2251,7 +2251,8 @@ EXPORT_SYMBOL(mmc_can_erase);
>
>  int mmc_can_trim(struct mmc_card *card)
>  {
> -       if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN)
> +       if ((card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN) &&
> +           (!(card->quirks & MMC_QUIRK_TRIM_BROKEN)))
>                 return 1;
>         return 0;
>  }
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8fcbcd1..fdd0779 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -279,6 +279,8 @@ struct mmc_card {
>  #define MMC_QUIRK_LONG_READ_TIME (1<<9)                /* Data read time > CSD says */
>  #define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN (1<<10)        /* Skip secure for erase/trim */
>  #define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx could create a fake interrupt */
> +#define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
> +
>
>         unsigned int            erase_size;     /* erase size in sectors */
>         unsigned int            erase_shift;    /* if erase unit is power 2 */
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
