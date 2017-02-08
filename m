From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v3 1/3] mmc: MAN_BKOPS_EN inverse debug message logic
Date: Wed, 8 Feb 2017 12:54:40 +0100
Message-ID: <CAPDyKFpzJkU0NxQyqTXzoMNKmrbJxhT286A=kJ_QWoDNsUJ_kg@mail.gmail.com>
References: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com> <1486483202-5515-2-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36609 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbdBHLym (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2017 06:54:42 -0500
Received: by mail-vk0-f44.google.com with SMTP id t8so99002044vke.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2017 03:54:41 -0800 (PST)
In-Reply-To: <1486483202-5515-2-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uri Yanai <uri.yanai@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

On 7 February 2017 at 17:00, Uri Yanai <uri.yanai@sandisk.com> wrote:
> Inverse the logic for printing the debug message.
> In mmc_decode_ext_csd() print message when MAN_BKOPS_EN is set
>
> Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c0e2507..9d1c149 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -530,8 +530,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, =
u8 *ext_csd)
>                                                 EXT_CSD_MANUAL_BKOPS_MASK=
);
>                         card->ext_csd.raw_bkops_status =3D
>                                 ext_csd[EXT_CSD_BKOPS_STATUS];
> -                       if (!card->ext_csd.man_bkops_en)
> -                               pr_debug("%s: MAN_BKOPS_EN bit is not set=
\n",
> +                       if (card->ext_csd.man_bkops_en)
> +                               pr_debug("%s: MAN_BKOPS_EN bit is set\n",
>                                         mmc_hostname(card->host));
>                 }
>
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
