From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v4 1/4]enable HW reset capbility
Date: Thu, 9 Dec 2010 15:05:25 +0900
Message-ID: <AANLkTincey6stwEhyK1ZRwcp5eUzC73GQv6Q_We=+gcX@mail.gmail.com>
References: <20101201124900.GB5421@intel.com>
	<AANLkTimv5f43mgtubgps_rgiHXa3=NGRb4kNrps8ViJn@mail.gmail.com>
	<5D8008F58939784290FAB48F549751983263F995AB@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59112 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab0LIGF1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Dec 2010 01:05:27 -0500
In-Reply-To: <5D8008F58939784290FAB48F549751983263F995AB@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On Thu, Dec 9, 2010 at 2:40 PM, Dong, Chuanxiao
<chuanxiao.dong@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: kyungmin78@gmail.com [mailto:kyungmin78@gmail.com] On Behalf O=
f
>> Kyungmin Park
>> Sent: Thursday, December 09, 2010 1:24 PM
>> To: Dong, Chuanxiao
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; cjb@lap=
top.org;
>> arjan@linux.intel.com; alan@linux.intel.com; akpm@linux-foundation.o=
rg
>> Subject: Re: [PATCH v4 1/4]enable HW reset capbility
>>
>> On Wed, Dec 1, 2010 at 9:49 PM, Chuanxiao Dong <chuanxiao.dong@intel=
=2Ecom>
>> wrote:
>> > From d3be0b4fe8e8a40294830dfd8d0543d1e957fd29 Mon Sep 17 00:00:00 =
2001
>> > From: Chuanxiao Dong <chuanxiao.dong@intel.com>
>> > Date: Wed, 1 Dec 2010 19:14:02 +0800
>> > Subject: [PATCH 1/4] enable HW reset caps of MMC card if card supp=
orts
>> >
>> > HW reset capbility enable bit is byte 162 in card EXT_CSD
>> > register, only version4.4 card or later can support to enable
>> > this feature.
>> >
>> > HW reset feature can be used to reset eMMC card when occures
>> > timeout errors during read/write/erase.
>> >
>> > Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
>> > ---
>> > =A0drivers/mmc/core/mmc.c =A0 | =A0 29 +++++++++++++++++++++++++++=
++
>> > =A0include/linux/mmc/card.h | =A0 =A01 +
>> > =A0include/linux/mmc/mmc.h =A0| =A0 =A01 +
>> > =A03 files changed, 31 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index 77f93c3..85cc7f6 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -310,6 +310,10 @@ static int mmc_read_ext_csd(struct mmc_card *=
card)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_SEC=
_FEATURE_SUPPORT];
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.trim_timeout =3D 300 =
*
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_TRI=
M_MULT];
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* check Hardware reset cap
>> Check hardware.
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rst =3D ext_csd[EXT_CS=
D_RST];
>> > =A0 =A0 =A0 =A0}
>> >
>> > =A0 =A0 =A0 =A0if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
>> > @@ -484,6 +488,31 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32
>> ocr,
>> > =A0 =A0 =A0 =A0}
>> >
>> > =A0 =A0 =A0 =A0/*
>> > + =A0 =A0 =A0 =A0* eMMC4.4 version card has HW reset capbility.
>> capability.
>> > + =A0 =A0 =A0 =A0* Enable this feature here:
>> > + =A0 =A0 =A0 =A0* RST_N_FUNCTION register is W/R, one time progra=
mmable
>> Use RST_n_FUNCTION as spec.
>> > + =A0 =A0 =A0 =A0* or readable.
>> > + =A0 =A0 =A0 =A0* So need to enable this register only once after=
 power on
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 if (card->csd.mmca_vsn >=3D CSD_SPEC_VER_4 &&
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rev >=3D=
 4 &&
>> it should be card->ext_csd.rev >=3D 5 since 4 is obsolete.
>>
>> Thank you,
>> Kyungmin Park
>
> Thanks, Park. I will fix this.
> And by the way, I noticed mmc_read_ext_csd function also used card->e=
xt_csd.rev >=3D4. Is there some other reason for this kind of using? Or=
 it is just because at that time the value 4 has not be obsolete yet...=
=2E?

Maybe need to fix it also.

And remaining patches also need to fix 'capability' typo.

Thank you,
Kyungmin Park
>
> Thanks.
> Chuanxiao
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rst =3D=
=3D 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD=
_SET_NORMAL,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_=
CSD_RST, 1);
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING =
"%s: switch to rst enable
>> "
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"failed %d\n",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0mmc_hostname(card->host), err);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rst =3D=
 1;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 /*
>> > =A0 =A0 =A0 =A0 * Activate high speed (if supported)
>> > =A0 =A0 =A0 =A0 */
>> > =A0 =A0 =A0 =A0if ((card->ext_csd.hs_max_dtr !=3D 0) &&
>> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> > index 8ce0827..ebee676 100644
>> > --- a/include/linux/mmc/card.h
>> > +++ b/include/linux/mmc/card.h
>> > @@ -54,6 +54,7 @@ struct mmc_ext_csd {
>> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sec_trim_mult; =
=A0/* Secure trim
>> multiplier =A0*/
>> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sec_erase_mult;=
 /* Secure erase multiplier
>> */
>> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0trim_timeout; =A0=
 =A0 =A0 =A0 =A0 /* In
>> milliseconds */
>> > + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0rst; /* hardware=
 reset enable bit */
>> > =A0};
>> >
>> > =A0struct sd_scr {
>> > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> > index 956fbd8..b7ab0da 100644
>> > --- a/include/linux/mmc/mmc.h
>> > +++ b/include/linux/mmc/mmc.h
>> > @@ -251,6 +251,7 @@ struct _mmc_csd {
>> > =A0* EXT_CSD fields
>> > =A0*/
>> >
>> > +#define EXT_CSD_RST =A0 =A0 =A0 =A0 =A0 =A0162 =A0 =A0 /* onetime=
 programmable R/W
>> */
>> > =A0#define EXT_CSD_ERASE_GROUP_DEF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
175 =A0 =A0 /* R/W */
>> > =A0#define EXT_CSD_ERASED_MEM_CONT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
181 =A0 =A0 /* RO */
>> > =A0#define EXT_CSD_BUS_WIDTH =A0 =A0 =A0 =A0 =A0 =A0 =A0183 =A0 =A0=
 /* R/W */
>> > --
>> > 1.6.6.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
