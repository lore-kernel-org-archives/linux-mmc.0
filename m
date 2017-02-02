From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
Date: Thu, 2 Feb 2017 12:50:02 +0100
Message-ID: <CAPDyKFpohgbC-ujr0EVpFdBkrhxYSpA_n2UCcvmV3+aS7YUUhA@mail.gmail.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com> <1485076535-20572-2-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36578 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbdBBLuE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2017 06:50:04 -0500
Received: by mail-wm0-f41.google.com with SMTP id c85so86523481wmi.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2017 03:50:03 -0800 (PST)
In-Reply-To: <1485076535-20572-2-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uri Yanai <uri.yanai@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>

On 22 January 2017 at 10:15, Uri Yanai <uri.yanai@sandisk.com> wrote:
> Read from the device EXT_CSD and set to the card->ext_csd structure
>

Please improve the change-log. Ask yourself the questions, what, how
and why when you update it.

> Changes in v2:
> - inverse the logic for printing the debug message.
>   only print when bits are set.

It's good that you provide the a revision history, although this shall
not be apart of the change log.

Instead use "patch notes". That is, add a newline after "---" below,
type your text, add a new line and add "---".

>
> Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
> ---
>  drivers/mmc/core/mmc.c   | 10 ++++++++--
>  include/linux/mmc/card.h |  1 +
>  include/linux/mmc/mmc.h  |  1 +
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c0e2507..f70f6a1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -530,8 +530,14 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                                                 EXT_CSD_MANUAL_BKOPS_MASK);
>                         card->ext_csd.raw_bkops_status =
>                                 ext_csd[EXT_CSD_BKOPS_STATUS];
> -                       if (!card->ext_csd.man_bkops_en)
> -                               pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
> +                       if (card->ext_csd.man_bkops_en)
> +                               pr_debug("%s: MAN_BKOPS_EN bit is set\n",
> +                                       mmc_hostname(card->host));

This change seem reasonable to me.

However the change-log refers only to AUTO_BKOPS. So, I think it's
better if you move this change into a separate patch, preceding
@subject patch.

> +                       card->ext_csd.auto_bkops_en =
> +                                       (ext_csd[EXT_CSD_BKOPS_EN] &
> +                                               EXT_CSD_AUTO_BKOPS_MASK);
> +                       if (card->ext_csd.auto_bkops_en)
> +                               pr_debug("%s: AUTO_BKOPS_EN bit is set\n",
>                                         mmc_hostname(card->host));
>                 }
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 00449e5..e3f1031 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -84,6 +84,7 @@ struct mmc_ext_csd {
>         unsigned int            hpi_cmd;                /* cmd used as HPI */
>         bool                    bkops;          /* background support bit */
>         bool                    man_bkops_en;   /* manual bkops enable bit */
> +       bool                    auto_bkops_en;  /* auto bkops enable bit */
>         unsigned int            data_sector_size;       /* 512 bytes or 4KB */
>         unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>         unsigned int            boot_ro_lock;           /* ro lock support */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index a074082..126b8d5 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -449,6 +449,7 @@ struct _mmc_csd {
>   * BKOPS modes
>   */
>  #define EXT_CSD_MANUAL_BKOPS_MASK      0x01
> +#define EXT_CSD_AUTO_BKOPS_MASK                0x02
>
>  /*
>   * Command Queue
> --
> 1.9.1
>

Kind regards
Uffe
