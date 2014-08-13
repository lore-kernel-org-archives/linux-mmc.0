From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: check EXT_CSD_PARTITION_SETTING_COMPLETED before
 creating partitions
Date: Wed, 13 Aug 2014 10:36:19 +0200
Message-ID: <CAPDyKFoRpQBHGGCMPvEKdeVGjTO-rnyYVostLZGCV3dudD1rmA@mail.gmail.com>
References: <53C7E45E.2060102@neotion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:57772 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbaHMIgU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 04:36:20 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so10343551qgd.23
        for <linux-mmc@vger.kernel.org>; Wed, 13 Aug 2014 01:36:19 -0700 (PDT)
In-Reply-To: <53C7E45E.2060102@neotion.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?R3LDqWdvcnkgU291dGFkw6k=?= <gsoutade@neotion.com>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 17 July 2014 16:57, Gr=C3=A9gory Soutad=C3=A9 <gsoutade@neotion.com>=
 wrote:
> Create MMC general purpose partitions only if
> EXT_CSD_PARTITION_SETTING_COMPLETED bit is set.
> Some tools may set general purpose partition size(s) but fail or stop
> without finalize.
> Another case is to set invalid partition size(s).
>
> Signed-off-by: Gr=C3=A9gory Soutad=C3=A9 <gsoutade@neotion.com>
> ---
>  drivers/mmc/core/mmc.c  |   15 +++++++++++----
>  include/linux/mmc/mmc.h |    2 ++
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> From commit b6603fe574af289dbe9eb9fb4c540bca04f5a053 in master linux =
tree.
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 793c6f7..b9fe211 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -471,10 +471,17 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd, u8 *ext_csd)
>                                 ext_csd[EXT_CSD_GP_SIZE_MULT + idx * =
3];
>                                 part_size *=3D (size_t)(hc_erase_grp_=
sz *
>                                         hc_wp_grp_sz);
> -                               mmc_part_add(card, part_size << 19,
> -                                       EXT_CSD_PART_CONFIG_ACC_GP0 +=
 idx,
> -                                       "gp%d", idx, false,
> -                                       MMC_BLK_DATA_AREA_GP);
> +                               if (ext_csd[EXT_CSD_PARTITION_SETTING=
_COMPLETED] &
> +                               EXT_CSD_PART_SETTING_COMPLETED) {

Some minor comments here.

I think you could move this if statement up and into the previous "if"
where we check for "ext_csd[EXT_CSD_PARTITION_SUPPORT] &
EXT_CSD_PART_SUPPORT_PART_EN".

Additionally, please run checkpatch.

Kind regards
Uffe

> +                                       mmc_part_add(card, part_size =
<< 19,
> +                                               EXT_CSD_PART_CONFIG_A=
CC_GP0 + idx,
> +                                               "gp%d", idx, false,
> +                                               MMC_BLK_DATA_AREA_GP)=
;
> +                               } else {
> +                                       pr_warn("%s: has partition si=
ze defined, but setting is not complete\n",
> +                                               mmc_hostname(card->ho=
st));
> +                                       break;
> +                               }
>                         }
>                 }
>                 card->ext_csd.sec_trim_mult =3D
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 64ec963..78753bc 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -281,6 +281,7 @@ struct _mmc_csd {
>  #define EXT_CSD_EXP_EVENTS_CTRL                56      /* R/W, 2 byt=
es */
>  #define EXT_CSD_DATA_SECTOR_SIZE       61      /* R */
>  #define EXT_CSD_GP_SIZE_MULT           143     /* R/W */
> +#define EXT_CSD_PARTITION_SETTING_COMPLETED 155        /* R/W */
>  #define EXT_CSD_PARTITION_ATTRIBUTE    156     /* R/W */
>  #define EXT_CSD_PARTITION_SUPPORT      160     /* RO */
>  #define EXT_CSD_HPI_MGMT               161     /* R/W */
> @@ -349,6 +350,7 @@ struct _mmc_csd {
>  #define EXT_CSD_PART_CONFIG_ACC_RPMB   (0x3)
>  #define EXT_CSD_PART_CONFIG_ACC_GP0    (0x4)
>
> +#define EXT_CSD_PART_SETTING_COMPLETED (0x1)
>  #define EXT_CSD_PART_SUPPORT_PART_EN   (0x1)
>
>  #define EXT_CSD_CMD_SET_NORMAL         (1<<0)
> --
> 1.7.0.4
