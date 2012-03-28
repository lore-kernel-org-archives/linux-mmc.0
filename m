From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [Patch v1]mmc:core: correct mmc_erase_timeout calculation
Date: Wed, 28 Mar 2012 21:35:52 +0900
Message-ID: <CAKYAXd9N3sc_0Euzyf6tph8uNT=C7uyMkPVuO-dxq8JMGNRL_w@mail.gmail.com>
References: <20120328082933.GA27568@intel.com>
	<CAKYAXd8ec31WM2SBP3wMaAqKj60D2+hZ7nGTgv63_Jbh+KHanA@mail.gmail.com>
	<17296D9F8FF2234F831FC3DF505A87A90FD83C48@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56232 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab2C1Mfw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 08:35:52 -0400
Received: by iagz16 with SMTP id z16so1434653iag.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Mar 2012 05:35:52 -0700 (PDT)
In-Reply-To: <17296D9F8FF2234F831FC3DF505A87A90FD83C48@SHSMSX102.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "Hunter, Adrian" <adrian.hunter@intel.com>

If ERASE_GROUP_DEF is disable with secure erase, erase timeout is
calculated with 300ms * ERASE_TIMEOUT_MULT. Is it right ?

Thanks.

2012/3/28 Dong, Chuanxiao <chuanxiao.dong@intel.com>:
> What I am checking with is eMMC4.41 spec, not eMMC4.5 spec.
> Forward you the link: www.jedec.org/sites/default/files/docs/JESD84-A=
441.pdf
>
> Thanks
> Chuanxiao
>
>> -----Original Message-----
>> From: Namjae Jeon [mailto:linkinjeon@gmail.com]
>> Sent: Wednesday, March 28, 2012 5:17 PM
>> To: Dong, Chuanxiao
>> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; Hunter, Adrian
>> Subject: Re: [Patch v1]mmc:core: correct mmc_erase_timeout calculati=
on
>>
>> Hi. Chuanxiao.
>> Would you share your specification with me ?
>> When I check the latest emmc 4.5 spec, I can not find it.
>> Thanks.
>>
>> 2012/3/28 Chuanxiao Dong <chuanxiao.dong@intel.com>:
>> > According to JEDEC 7.8.2, mmc_erase_timeout calculation should be =
follow:
>> > 1. Secure erase timeout =3D 300ms * ERASE_TIMEOUT_MULT * SEC_ERASE=
_MULT
>> > 2. Secure trim timeout =3D 300ms * ERASE_TIMEOUT_MULT * SEC_TRIM_M=
ULT 3.
>> > Trim timeout =3D 300ms * TRIM_MULT 4. Erase timeout:
>> > =C2=A0 a. if ERASE_GROUP_DEF is true: Erase timeout =3D 300ms *
>> > ERASE_TIMEOUT_MULT
>> > =C2=A0 b. if ERASE_GROUP_DEF is false: Erase timeout =3D write blo=
ck delay
>> >
>> > Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
>> > ---
>> > =C2=A0drivers/mmc/core/core.c | =C2=A0 42
>> > +++++++++++++++++++++++++++++-------------
>> > =C2=A01 files changed, 29 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c ind=
ex
>> > 14f262e..d9d6d1c 100644
>> > --- a/drivers/mmc/core/core.c
>> > +++ b/drivers/mmc/core/core.c
>> > @@ -1405,12 +1405,36 @@ static unsigned int
>> > mmc_mmc_erase_timeout(struct mmc_card *card,
>> > =C2=A0{
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int erase_timeout;
>> >
>> > - =C2=A0 =C2=A0 =C2=A0 if (card->ext_csd.erase_group_def & 1) {
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* High Capacit=
y Erase Group Size uses HC timeouts */
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg =3D=3D =
MMC_TRIM_ARG)
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 erase_timeout =3D card->ext_csd.trim_timeout;
>> > + =C2=A0 =C2=A0 =C2=A0 /*
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* JEDEC 7.8.2
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 1. Secure erase/trim timeout is cal=
culated absed on Erase
>> > + Timeout
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* and additional SEC_ERASE_MULT/SEC_T=
RIM_MULT.
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* So secure erase/trim timeout =3D ER=
ASE Timeout *
>> > + SEC_ERASE_MULT/
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* SEC_TRIM_MULT.
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* ERASE Timeout =3D 300ms * ERASE_TIM=
EOUT_MULT
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 2. trim timeout is calculated based=
 on the TRIM_MULT factor.
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* So trim timeout =3D 300ms * TRIM_MU=
LT
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 3. erase timeout calculation:
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0a. if ERASE_GRO=
UP_DEF is enabled, ERASE_TIMEOUT_MULT
>> > + should be
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0used to calcula=
te erase timeout, so:
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0erase timeout =3D=
 300 * ERASE_TIMEOUT_MULT
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0b. if ERASE_GRO=
UP_DEF is diabled, the duration of an
>> > + erase
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0command will be=
 the number of Erase blocks to be
>> > + erased
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0multiplied by t=
he block write delay.
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> > + =C2=A0 =C2=A0 =C2=A0 if (arg & MMC_SECURE_ARGS) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erase_timeout =3D=
 card->ext_csd.hc_erase_timeout;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg =3D=3D =
MMC_SECURE_ERASE_ARG)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 erase_timeout *=3D card->ext_csd.sec_erase_mult;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 erase_timeout =3D
>> > card->ext_csd.hc_erase_timeout;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 erase_timeout *=3D card->ext_csd.sec_trim_mult;
>> > + =C2=A0 =C2=A0 =C2=A0 } else if (arg & MMC_TRIM_ARGS) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erase_timeout =3D=
 card->ext_csd.trim_timeout;
>> > + =C2=A0 =C2=A0 =C2=A0 } else if (card->ext_csd.erase_group_def & =
1) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erase_timeout =3D=
 card->ext_csd.hc_erase_timeout;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CSD Eras=
e Group Size uses write timeout */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned in=
t mult =3D (10 << card->csd.r2w_factor); @@
>> > -1441,14 +1465,6 @@ static unsigned int mmc_mmc_erase_timeout(stru=
ct
>> > mmc_card *card,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0erase_timeout =3D 1;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >
>> > - =C2=A0 =C2=A0 =C2=A0 /* Multiplier for secure operations */
>> > - =C2=A0 =C2=A0 =C2=A0 if (arg & MMC_SECURE_ARGS) {
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg =3D=3D =
MMC_SECURE_ERASE_ARG)
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 erase_timeout *=3D card->ext_csd.sec_erase_mult;
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 erase_timeout *=3D card->ext_csd.sec_trim_mult;
>> > - =C2=A0 =C2=A0 =C2=A0 }
>> > -
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0erase_timeout *=3D qty;
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>> > --
>> > 1.7.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mm=
c"
>> > in the body of a message to majordomo@vger.kernel.org More majordo=
mo
>> > info at =C2=A0http://vger.kernel.org/majordomo-info.html
