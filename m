From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [Patch v1]mmc:core: correct mmc_erase_timeout calculation
Date: Wed, 28 Mar 2012 18:17:29 +0900
Message-ID: <CAKYAXd8ec31WM2SBP3wMaAqKj60D2+hZ7nGTgv63_Jbh+KHanA@mail.gmail.com>
References: <20120328082933.GA27568@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47381 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231Ab2C1JRa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 05:17:30 -0400
Received: by iagz16 with SMTP id z16so1223571iag.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Mar 2012 02:17:29 -0700 (PDT)
In-Reply-To: <20120328082933.GA27568@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, adrian.hunter@intel.com

Hi. Chuanxiao.
Would you share your specification with me ?
When I check the latest emmc 4.5 spec, I can not find it.
Thanks.

2012/3/28 Chuanxiao Dong <chuanxiao.dong@intel.com>:
> According to JEDEC 7.8.2, mmc_erase_timeout calculation should be fol=
low:
> 1. Secure erase timeout =3D 300ms * ERASE_TIMEOUT_MULT * SEC_ERASE_MU=
LT
> 2. Secure trim timeout =3D 300ms * ERASE_TIMEOUT_MULT * SEC_TRIM_MULT
> 3. Trim timeout =3D 300ms * TRIM_MULT
> 4. Erase timeout:
> =C2=A0 a. if ERASE_GROUP_DEF is true: Erase timeout =3D 300ms * ERASE=
_TIMEOUT_MULT
> =C2=A0 b. if ERASE_GROUP_DEF is false: Erase timeout =3D write block =
delay
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> =C2=A0drivers/mmc/core/core.c | =C2=A0 42 +++++++++++++++++++++++++++=
++-------------
> =C2=A01 files changed, 29 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 14f262e..d9d6d1c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1405,12 +1405,36 @@ static unsigned int mmc_mmc_erase_timeout(str=
uct mmc_card *card,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int erase_timeout;
>
> - =C2=A0 =C2=A0 =C2=A0 if (card->ext_csd.erase_group_def & 1) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* High Capacity E=
rase Group Size uses HC timeouts */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg =3D=3D MMC=
_TRIM_ARG)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 erase_timeout =3D card->ext_csd.trim_timeout;
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* JEDEC 7.8.2
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 1. Secure erase/trim timeout is calcul=
ated absed on Erase Timeout
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* and additional SEC_ERASE_MULT/SEC_TRIM=
_MULT.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* So secure erase/trim timeout =3D ERASE=
 Timeout * SEC_ERASE_MULT/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* SEC_TRIM_MULT.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* ERASE Timeout =3D 300ms * ERASE_TIMEOU=
T_MULT
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 2. trim timeout is calculated based on=
 the TRIM_MULT factor.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* So trim timeout =3D 300ms * TRIM_MULT
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 3. erase timeout calculation:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0a. if ERASE_GROUP_=
DEF is enabled, ERASE_TIMEOUT_MULT should be
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0used to calculate =
erase timeout, so:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0erase timeout =3D =
300 * ERASE_TIMEOUT_MULT
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0b. if ERASE_GROUP_=
DEF is diabled, the duration of an erase
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0command will be th=
e number of Erase blocks to be erased
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0multiplied by the =
block write delay.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (arg & MMC_SECURE_ARGS) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erase_timeout =3D =
card->ext_csd.hc_erase_timeout;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg =3D=3D MMC=
_SECURE_ERASE_ARG)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 erase_timeout *=3D card->ext_csd.sec_erase_mult;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 erase_timeout =3D card->ext_csd.hc_erase_timeout;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 erase_timeout *=3D card->ext_csd.sec_trim_mult;
> + =C2=A0 =C2=A0 =C2=A0 } else if (arg & MMC_TRIM_ARGS) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erase_timeout =3D =
card->ext_csd.trim_timeout;
> + =C2=A0 =C2=A0 =C2=A0 } else if (card->ext_csd.erase_group_def & 1) =
{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erase_timeout =3D =
card->ext_csd.hc_erase_timeout;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CSD Erase G=
roup Size uses write timeout */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int m=
ult =3D (10 << card->csd.r2w_factor);
> @@ -1441,14 +1465,6 @@ static unsigned int mmc_mmc_erase_timeout(stru=
ct mmc_card *card,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0erase_timeout =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 /* Multiplier for secure operations */
> - =C2=A0 =C2=A0 =C2=A0 if (arg & MMC_SECURE_ARGS) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg =3D=3D MMC=
_SECURE_ERASE_ARG)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 erase_timeout *=3D card->ext_csd.sec_erase_mult;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 erase_timeout *=3D card->ext_csd.sec_trim_mult;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0erase_timeout *=3D qty;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
