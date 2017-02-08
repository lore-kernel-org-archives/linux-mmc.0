From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3 2/3] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
Date: Wed, 8 Feb 2017 12:55:03 +0100
Message-ID: <CAPDyKFpfHYPe88aSf7d+FpE9MQjEeTvsy1A7zCRuw8Wf1MWf9A@mail.gmail.com>
References: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com> <1486483202-5515-3-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:36431 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753604AbdBHMBK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2017 07:01:10 -0500
Received: by mail-ua0-f180.google.com with SMTP id 96so107423437uaq.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2017 04:01:10 -0800 (PST)
In-Reply-To: <1486483202-5515-3-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uri Yanai <uri.yanai@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

On 7 February 2017 at 17:00, Uri Yanai <uri.yanai@sandisk.com> wrote:
> Adding dedicated flag for AUTO_BKOPS in card->ext_csd structure.
> Read AUTO_BKOPS bit value from the device EXT_CSD and set to the
> card->ext_csd structure.
> In mmc_decode_ext_csd() add a print message in case the AUTO_BKOPS
> is enabled
>
> Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - move the code inversing manual bkops to a separate patch
>
> Changes in v2:
> - inverse the logic for printing the debug message.
>   only print when bits are set.
>
> ---
>  drivers/mmc/core/mmc.c   | 6 ++++++
>  include/linux/mmc/card.h | 1 +
>  include/linux/mmc/mmc.h  | 1 +
>  3 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 9d1c149..f70f6a1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -533,6 +533,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card,=
 u8 *ext_csd)
>                         if (card->ext_csd.man_bkops_en)
>                                 pr_debug("%s: MAN_BKOPS_EN bit is set\n",
>                                         mmc_hostname(card->host));
> +                       card->ext_csd.auto_bkops_en =3D
> +                                       (ext_csd[EXT_CSD_BKOPS_EN] &
> +                                               EXT_CSD_AUTO_BKOPS_MASK);
> +                       if (card->ext_csd.auto_bkops_en)
> +                               pr_debug("%s: AUTO_BKOPS_EN bit is set\n"=
,
> +                                       mmc_hostname(card->host));
>                 }
>
>                 /* check whether the eMMC card supports HPI */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 00449e5..e3f1031 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -84,6 +84,7 @@ struct mmc_ext_csd {
>         unsigned int            hpi_cmd;                /* cmd used as HP=
I */
>         bool                    bkops;          /* background support bit=
 */
>         bool                    man_bkops_en;   /* manual bkops enable bi=
t */
> +       bool                    auto_bkops_en;  /* auto bkops enable bit =
*/
>         unsigned int            data_sector_size;       /* 512 bytes or 4=
KB */
>         unsigned int            data_tag_unit_size;     /* DATA TAG UNIT =
size */
>         unsigned int            boot_ro_lock;           /* ro lock suppor=
t */
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
> Western Digital Corporation (and its subsidiaries) E-mail Confidentiality=
 Notice & Disclaimer:
>
> This e-mail and any files transmitted with it may contain confidential or=
 legally privileged information of WDC and/or its affiliates, and are inten=
ded solely for the use of the individual or entity to which they are addres=
sed. If you are not the intended recipient, any disclosure, copying, distri=
bution or any action taken or omitted to be taken in reliance on it, is pro=
hibited. If you have received this e-mail in error, please notify the sende=
r immediately and delete the e-mail in its entirety from your system.
>
