From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [Patch v1]mmc:core: correct mmc_erase_timeout calculation
Date: Thu, 29 Mar 2012 12:29:46 +0900
Message-ID: <CAKYAXd_4dDTbTHT3myztMMgw0Qi4oZh2G00DSGk04+HzQ_rqTw@mail.gmail.com>
References: <20120328082933.GA27568@intel.com>
	<CAKYAXd8ec31WM2SBP3wMaAqKj60D2+hZ7nGTgv63_Jbh+KHanA@mail.gmail.com>
	<17296D9F8FF2234F831FC3DF505A87A90FD83C48@SHSMSX102.ccr.corp.intel.com>
	<CAKYAXd9N3sc_0Euzyf6tph8uNT=C7uyMkPVuO-dxq8JMGNRL_w@mail.gmail.com>
	<17296D9F8FF2234F831FC3DF505A87A90FD86BA2@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34348 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758638Ab2C2D3q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 23:29:46 -0400
Received: by iagz16 with SMTP id z16so2405622iag.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Mar 2012 20:29:46 -0700 (PDT)
In-Reply-To: <17296D9F8FF2234F831FC3DF505A87A90FD86BA2@SHSMSX102.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "Hunter, Adrian" <adrian.hunter@intel.com>

I think that write block delay * SECURE_ERASE_MULT is right in case of
secure erase + ERASE_GROUP_DEF disable.

See the specification contents on 4.4.1.
Erase / Secure Erase
The duration of an erase command will be (order of magnitude) the
number of Erase blocks to be erased
multiplied by the block write delay. If ERASE_GROUP_DEF (EXT_CSD byte
[175]) is enabled,
ERASE_TIMEOUT_MULT should be used to calculate the duration.
Secure Erase timeout is calculated based on the Erase Timeout and
additional SEC_ERASE_MULT factor
(EXT_CSD byte [230]).

Thanks.

2012/3/29 Dong, Chuanxiao <chuanxiao.dong@intel.com>:
>> -----Original Message-----
>> From: Namjae Jeon [mailto:linkinjeon@gmail.com]
>> Sent: Wednesday, March 28, 2012 8:36 PM
>> To: Dong, Chuanxiao
>> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; Hunter, Adrian
>> Subject: Re: [Patch v1]mmc:core: correct mmc_erase_timeout calculati=
on
>>
>> If ERASE_GROUP_DEF is disable with secure erase, erase timeout is ca=
lculated with
>> 300ms * ERASE_TIMEOUT_MULT. Is it right ?
>
> My understanding about the JESD84-A441 is different with current mmc_=
mmc_erase_timeout implemented. From the EXT_CSD[230], seems no matter E=
RASE_GROUP_DEF is enabled or not, secure erase timeout is calculated as=
 300ms * ERASE_TIMEOUT_MULT * SECURE_ERASE_MULT. That is why I submitte=
d this patch.
>
> Does someone else can correct me if my understanding about the erase =
timeout calculation is wrong?
>
> Thanks
> Chuanxiao
>
>>
>> Thanks.
>>
>> 2012/3/28 Dong, Chuanxiao <chuanxiao.dong@intel.com>:
>> > What I am checking with is eMMC4.41 spec, not eMMC4.5 spec.
>> > Forward you the link:
>> > www.jedec.org/sites/default/files/docs/JESD84-A441.pdf
>> >
>> > Thanks
>> > Chuanxiao
>> >
>> >> -----Original Message-----
>> >> From: Namjae Jeon [mailto:linkinjeon@gmail.com]
>> >> Sent: Wednesday, March 28, 2012 5:17 PM
>> >> To: Dong, Chuanxiao
>> >> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; Hunter, Adrian
>> >> Subject: Re: [Patch v1]mmc:core: correct mmc_erase_timeout
>> >> calculation
>> >>
>> >> Hi. Chuanxiao.
>> >> Would you share your specification with me ?
>> >> When I check the latest emmc 4.5 spec, I can not find it.
>> >> Thanks.
>> >>
>> >> 2012/3/28 Chuanxiao Dong <chuanxiao.dong@intel.com>:
>> >> > According to JEDEC 7.8.2, mmc_erase_timeout calculation should =
be follow:
>> >> > 1. Secure erase timeout =3D 300ms * ERASE_TIMEOUT_MULT *
>> >> > SEC_ERASE_MULT 2. Secure trim timeout =3D 300ms * ERASE_TIMEOUT=
_MULT *
>> SEC_TRIM_MULT 3.
>> >> > Trim timeout =3D 300ms * TRIM_MULT 4. Erase timeout:
>> >> > =C2=A0 a. if ERASE_GROUP_DEF is true: Erase timeout =3D 300ms *
>> >> > ERASE_TIMEOUT_MULT
>> >> > =C2=A0 b. if ERASE_GROUP_DEF is false: Erase timeout =3D write =
block delay
>> >> >
>> >> > Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
>> >> > ---
>> >> > =C2=A0drivers/mmc/core/core.c | =C2=A0 42
>> >> > +++++++++++++++++++++++++++++-------------
>> >> > =C2=A01 files changed, 29 insertions(+), 13 deletions(-)
>> >> >
>> >> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> >> > index 14f262e..d9d6d1c 100644
>> >> > --- a/drivers/mmc/core/core.c
>> >> > +++ b/drivers/mmc/core/core.c
>> >> > @@ -1405,12 +1405,36 @@ static unsigned int
>> >> > mmc_mmc_erase_timeout(struct mmc_card *card,
>> >> > =C2=A0{
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int erase_timeout;
>> >> >
>> >> > - =C2=A0 =C2=A0 =C2=A0 if (card->ext_csd.erase_group_def & 1) {
>> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* High Capa=
city Erase Group Size uses HC timeouts
>> >> > */
>> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg =3D=3D=
 MMC_TRIM_ARG)
>> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 erase_timeout =3D card->ext_csd.trim_timeout;
>> >> > + =C2=A0 =C2=A0 =C2=A0 /*
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* JEDEC 7.8.2
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 1. Secure erase/trim timeout is =
calculated absed on
>> >> > + Erase Timeout
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* and additional SEC_ERASE_MULT/SE=
C_TRIM_MULT.
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* So secure erase/trim timeout =3D=
 ERASE Timeout *
>> >> > + SEC_ERASE_MULT/
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* SEC_TRIM_MULT.
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* ERASE Timeout =3D 300ms * ERASE_=
TIMEOUT_MULT
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 2. trim timeout is calculated ba=
sed on the TRIM_MULT factor.
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* So trim timeout =3D 300ms * TRIM=
_MULT
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 3. erase timeout calculation:
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0a. if ERASE_=
GROUP_DEF is enabled,
>> >> > + ERASE_TIMEOUT_MULT should be
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0used to calc=
ulate erase timeout, so:
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0erase timeou=
t =3D 300 * ERASE_TIMEOUT_MULT
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0b. if ERASE_=
GROUP_DEF is diabled, the duration of
>> >> > + an erase
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0command will=
 be the number of Erase blocks to be
>> >> > + erased
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0 =C2=A0multiplied b=
y the block write delay.
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> >> > + =C2=A0 =C2=A0 =C2=A0 if (arg & MMC_SECURE_ARGS) {
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erase_timeou=
t =3D card->ext_csd.hc_erase_timeout;
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg =3D=3D=
 MMC_SECURE_ERASE_ARG)
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 erase_timeout *=3D
>> >> > + card->ext_csd.sec_erase_mult;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 erase_timeout =3D
>> >> > card->ext_csd.hc_erase_timeout;
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 erase_timeout *=3D
>> >> > + card->ext_csd.sec_trim_mult;
>> >> > + =C2=A0 =C2=A0 =C2=A0 } else if (arg & MMC_TRIM_ARGS) {
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erase_timeou=
t =3D card->ext_csd.trim_timeout;
>> >> > + =C2=A0 =C2=A0 =C2=A0 } else if (card->ext_csd.erase_group_def=
 & 1) {
>> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erase_timeou=
t =3D card->ext_csd.hc_erase_timeout;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CSD E=
rase Group Size uses write timeout */
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned=
 int mult =3D (10 << card->csd.r2w_factor); @@
>> >> > -1441,14 +1465,6 @@ static unsigned int
>> >> > mmc_mmc_erase_timeout(struct mmc_card *card,
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0erase_timeout =3D 1;
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >> >
>> >> > - =C2=A0 =C2=A0 =C2=A0 /* Multiplier for secure operations */
>> >> > - =C2=A0 =C2=A0 =C2=A0 if (arg & MMC_SECURE_ARGS) {
>> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg =3D=3D=
 MMC_SECURE_ERASE_ARG)
>> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 erase_timeout *=3D
>> >> > card->ext_csd.sec_erase_mult;
>> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 erase_timeout *=3D
>> >> > card->ext_csd.sec_trim_mult;
>> >> > - =C2=A0 =C2=A0 =C2=A0 }
>> >> > -
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0erase_timeout *=3D qty;
>> >> >
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>> >> > --
>> >> > 1.7.1
>> >> >
>> >> > --
>> >> > To unsubscribe from this list: send the line "unsubscribe linux=
-mmc"
>> >> > in the body of a message to majordomo@vger.kernel.org More
>> >> > majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
