From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] Production State Awareness support in host side
Date: Mon, 17 Nov 2014 14:33:58 +0100
Message-ID: <CAPDyKFrCpoSsgECvC=gnMp6WDYAV+2os-uhzp03K-=E+Yv10AA@mail.gmail.com>
References: <1416228726-8514-1-git-send-email-avi.shchislowski@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:54918 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbaKQNd7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Nov 2014 08:33:59 -0500
Received: by mail-qg0-f43.google.com with SMTP id f51so14914014qge.16
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2014 05:33:58 -0800 (PST)
In-Reply-To: <1416228726-8514-1-git-send-email-avi.shchislowski@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <avi.shchislowski@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Alex Lemberg <alex.lemberg@sandisk.com>

On 17 November 2014 13:52, Avi Shchislowski
<avi.shchislowski@sandisk.com> wrote:
> Adding support for PSA (Production State Awareness)
> feature for all eMMC devices with revision >=3D5.0
> In this patch the eMMC driver will check if device was completed
> its Production State mode, and will switch it to Normal (field) mode.
> Switching to normal mode signal the device to complete its work in pr=
oduction mode
> and start working in regular performance mode.

Please add some detail to what this patch does. Additionally why it's n=
eeded.

Also, make sure to use proper prefix in the commit header.

>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 02ad792..2d59722 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -605,6 +605,20 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d)
>                                 mmc_hostname(card->host));
>                         err =3D 0;
>                 }
> +       /* eMMC v5.0 or later */
> +       if (card->ext_csd.rev > 6) {
> +               card->ext_csd.psa =3D
> +                       ext_csd[EXT_CSD_PSA];
> +               if (ext_csd[EXT_CSD_PSA_TIMEOUT] > 0) {
> +                       card->ext_csd.psa_timeout =3D
> +                               100 *
> +                               (1 << ext_csd[EXT_CSD_PSA_TIMEOUT]);
> +               } else {
> +                       card->ext_csd.psa_timeout =3D 0;

This assignment isn't needed. It's 0 as default.

> +                       pr_warn("%s: EXT_CSD PSA Timeout is zero\n",
> +                                       mmc_hostname(card->host));

Shouldn't we treat this as an error?

> +               }
> +       }
>
>                 return err;
>         }
> @@ -1330,6 +1344,25 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>         if (card->csd.dsr_imp && host->dsr_req)
>                 mmc_set_dsr(host);
>
> +    /*
> +     * eMMC v5.0 or later
> +     * and Production State Awareness state is EXT_CSD_PSA_POST_SOLD=
ERING_WRITES
> +     * The host should set the device to NORMAL mode
> +     */
> +       if ((card->ext_csd.rev > 6)
> +               && (card->ext_csd.psa =3D=3D EXT_CSD_PSA_POST_SOLDERI=
NG_WRITES)) {
> +               unsigned int timeout;
> +               /*Zero value in PSA Timeout =E2=80=93 PSA is not defi=
ned*/
> +               if (card->ext_csd.psa_timeout !=3D 0) {
> +                       timeout =3D DIV_ROUND_UP(card->ext_csd.psa_ti=
meout, 1000);

Can you give an example of a typical value for the timeout?

> +                       card->ext_csd.psa =3D EXT_CSD_PSA_NORMAL;
> +                       err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORM=
AL,
> +                               EXT_CSD_PSA, card->ext_csd.psa, timeo=
ut);
> +                       if (err && err !=3D -EBADMSG)
> +                               goto free_card;
> +               }

So if there is no timeout specified what happens then?

> +       }
> +
>         /*
>          * Select card, as all following commands rely on that.
>          */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 4d69c00..09ac3b0 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -60,9 +60,11 @@ struct mmc_ext_csd {
>         u8                      packed_event_en;
>         unsigned int            part_time;              /* Units: ms =
*/
>         unsigned int            sa_timeout;             /* Units: 100=
ns */
> +       unsigned int            psa_timeout;            /* Units: 100=
us */
>         unsigned int            generic_cmd6_time;      /* Units: 10m=
s */
>         unsigned int            power_off_longtime;     /* Units: ms =
*/
>         u8                      power_off_notification; /* state */
> +       u8                      psa; /* production state awareness */
>         unsigned int            hs_max_dtr;
>         unsigned int            hs200_max_dtr;
>  #define MMC_HIGH_26_MAX_DTR    26000000
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 49ad7a9..eb170ff 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -285,6 +285,9 @@ struct _mmc_csd {
>  #define EXT_CSD_EXP_EVENTS_STATUS      54      /* RO, 2 bytes */
>  #define EXT_CSD_EXP_EVENTS_CTRL                56      /* R/W, 2 byt=
es */
>  #define EXT_CSD_DATA_SECTOR_SIZE       61      /* R */
> +#define EXT_CSD_QRDY_SUPPORT           96      /* RO */
> +#define EXT_CSD_CMDQ_QRDY_FUNCTION     97      /* R/W */

What's these?

> +#define EXT_CSD_PSA                    133     /* R/W/E */
>  #define EXT_CSD_GP_SIZE_MULT           143     /* R/W */
>  #define EXT_CSD_PARTITION_SETTING_COMPLETED 155        /* R/W */
>  #define EXT_CSD_PARTITION_ATTRIBUTE    156     /* R/W */
> @@ -315,6 +318,7 @@ struct _mmc_csd {
>  #define EXT_CSD_PWR_CL_26_360          203     /* RO */
>  #define EXT_CSD_SEC_CNT                        212     /* RO, 4 byte=
s */
>  #define EXT_CSD_S_A_TIMEOUT            217     /* RO */
> +#define EXT_CSD_PSA_TIMEOUT            218     /* RO */
>  #define EXT_CSD_REL_WR_SEC_C           222     /* RO */
>  #define EXT_CSD_HC_WP_GRP_SIZE         221     /* RO */
>  #define EXT_CSD_ERASE_TIMEOUT_MULT     223     /* RO */
> @@ -433,6 +437,13 @@ struct _mmc_csd {
>  #define EXT_CSD_BKOPS_LEVEL_2          0x2
>
>  /*
> + * PRODUCTION STATE AWARENESS fields
> + */
> +
> +#define EXT_CSD_PSA_NORMAL                             0x00
> +#define EXT_CSD_PSA_POST_SOLDERING_WRITES      0x02
> +
> +/*
>   * MMC_SWITCH access modes
>   */
>
> --
> 1.7.9.5
>

Kind regards
Uffe
