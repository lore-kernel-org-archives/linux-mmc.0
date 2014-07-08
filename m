From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2=5D_mmc=3A_Allow_forward_compatibility_for_?=
	=?UTF-8?Q?e=E2=8B=85MMC?=
Date: Tue, 8 Jul 2014 14:26:09 +0200
Message-ID: <CAPDyKFq=GQLz=RsyHnja-UdLD776Yud=ZR3ROKqLNFB4y60M1Q@mail.gmail.com>
References: <53AC65FF.1010301@webtuner.tv>
	<1403859067-21142-1-git-send-email-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:47212 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbaGHM0K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jul 2014 08:26:10 -0400
Received: by mail-qa0-f45.google.com with SMTP id s7so766701qap.4
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jul 2014 05:26:09 -0700 (PDT)
In-Reply-To: <1403859067-21142-1-git-send-email-romain.izard.pro@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Derek Simkowiak <derek@webtuner.tv>

On 27 June 2014 10:51, Romain Izard <romain.izard.pro@gmail.com> wrote:
> As stated by the e=E2=8B=85MMC 5.0 specification, a chip should not b=
e rejected
> only because of the revision stated in the EXT_CSD_REV field of the
> EXT_CSD register.
>
> Remove the control on this value, the control of the CSD_STRUCTURE fi=
eld
> should be sufficient to reject future incompatible changes.
>
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks! Applied for next.

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1ab5f3a0af5b..ac9b8232133c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -293,13 +293,12 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd, u8 *ext_csd)
>                 }
>         }
>
> +       /*
> +        * The EXT_CSD format is meant to be forward compatible. As l=
ong
> +        * as CSD_STRUCTURE does not change, all values for EXT_CSD_R=
EV
> +        * are authorized, see JEDEC JESD84-B50 section B.8.
> +        */
>         card->ext_csd.rev =3D ext_csd[EXT_CSD_REV];
> -       if (card->ext_csd.rev > 7) {
> -               pr_err("%s: unrecognised EXT_CSD revision %d\n",
> -                       mmc_hostname(card->host), card->ext_csd.rev);
> -               err =3D -EINVAL;
> -               goto out;
> -       }
>
>         card->ext_csd.raw_sectors[0] =3D ext_csd[EXT_CSD_SEC_CNT + 0]=
;
>         card->ext_csd.raw_sectors[1] =3D ext_csd[EXT_CSD_SEC_CNT + 1]=
;
> --
> 1.9.1
>
