From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
Date: Thu, 13 Oct 2016 09:36:14 +0200
Message-ID: <CAPDyKFo2BzcscQtL6rgTyj8OHqv5CdB4SdyA1ob=1n14vNhHkQ@mail.gmail.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com> <1472739890-3384-3-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33215 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbcJMHiN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2016 03:38:13 -0400
Received: by mail-lf0-f51.google.com with SMTP id x79so124887793lff.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2016 00:36:16 -0700 (PDT)
In-Reply-To: <1472739890-3384-3-git-send-email-alex.lemberg@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: alex lemberg <alex.lemberg@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Avi Shchislowski <avi.shchislowski@sandisk.com>

On 1 September 2016 at 16:24, alex lemberg <alex.lemberg@sandisk.com> wrote:
> Signed-off-by: alex lemberg <alex.lemberg@sandisk.com>
> ---
>  drivers/mmc/core/mmc.c   | 6 ++++++
>  include/linux/mmc/card.h | 1 +
>  include/linux/mmc/mmc.h  | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f2d185c..e2e987f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -531,6 +531,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                         if (!card->ext_csd.man_bkops_en)
>                                 pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
>                                         mmc_hostname(card->host));
> +                       card->ext_csd.auto_bkops_en =
> +                                       (ext_csd[EXT_CSD_BKOPS_EN] &
> +                                               EXT_CSD_AUTO_BKOPS_MASK);
> +                       if (!card->ext_csd.auto_bkops_en)
> +                               pr_debug("%s: AUTO_BKOPS_EN bit is not set\n",
> +                                       mmc_hostname(card->host));

According to discussions here [1], I am wondering whether we actually
should inverse the logic for when printing the debug message.

Isn't it more relevant to know when the bits *are* set than rather
when they aren't?

>                 }
>
>                 /* check whether the eMMC card supports HPI */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 73fad83..aaedb68 100644
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
> index c376209..0fe3908 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -436,6 +436,7 @@ struct _mmc_csd {
>   * BKOPS modes
>   */
>  #define EXT_CSD_MANUAL_BKOPS_MASK      0x01
> +#define EXT_CSD_AUTO_BKOPS_MASK        0x02
>
>  /*
>   * MMC_SWITCH access modes
> --
> 1.9.1
>

Kind regards
Uffe

[1]
http://www.spinics.net/lists/linux-mmc/msg39553.html
