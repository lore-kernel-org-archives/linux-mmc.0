From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_mmc=3A_Allow_forward_compatibility_for_e?=
	=?UTF-8?Q?=E2=8B=85MMC?=
Date: Fri, 29 Nov 2013 10:55:26 +0100
Message-ID: <CAPDyKFpsxrrr6zJvdzwO+fbgMRYKndeLxDKRuoY998bhMxOV6Q@mail.gmail.com>
References: <867gbsjzmf.fsf@void.printf.net>
	<1385714317-28911-1-git-send-email-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:52723 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab3K2Jz1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Nov 2013 04:55:27 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so1645307qab.16
        for <linux-mmc@vger.kernel.org>; Fri, 29 Nov 2013 01:55:26 -0800 (PST)
In-Reply-To: <1385714317-28911-1-git-send-email-romain.izard.pro@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 29 November 2013 09:38, Romain Izard <romain.izard.pro@gmail.com> wr=
ote:
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

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/core/mmc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f631f5a9bf79..73b43574e1b4 100644
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
> 1.8.3.2
>
