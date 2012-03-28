From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH V2] mmc: core: Add host capability check for power class
Date: Wed, 28 Mar 2012 16:39:44 +0530
Message-ID: <000401cd0cd3$4a6be470$df43ad50$@codeaurora.org>
References: <1323921517-31241-1-git-send-email-girish.shivananjappa@linaro.org>	<CAKLKtzc4HDmqStQhn_J6GZxdZ0vE_vb7=+xq+oEHqp6QxYDxsg@mail.gmail.com>	<CAGxe1ZEAj1PASOxQHNm=DNOSt2MWMvCQdWu4hKFnYoaLmnLShg@mail.gmail.com> <CAKLKtzfPC_+SnsaJ0YjWj6rpKeUdxhAxRxec=fDb_J5N1YRrkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:23610 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab2C1LJu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 07:09:50 -0400
In-Reply-To: <CAKLKtzfPC_+SnsaJ0YjWj6rpKeUdxhAxRxec=fDb_J5N1YRrkg@mail.gmail.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Saugata Das' <saugata.das@linaro.org>, 'Girish K S' <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Saugata Das
> Sent: Thursday, December 15, 2011 6:35 PM
> To: Girish K S
> Cc: linux-mmc@vger.kernel.org; patches@linaro.org; linux-samsung-
> soc@vger.kernel.org; subhashj@codeaurora.org; Chris Ball
> Subject: Re: [PATCH V2] mmc: core: Add host capability check for powe=
r
class
>=20
> On 15 December 2011 16:22, Girish K S <girish.shivananjappa@linaro.or=
g>
> wrote:
> > On 15 December 2011 15:34, Saugata Das <saugata.das@linaro.org> wro=
te:
> >> On 15 December 2011 09:28, Girish K S <girish.shivananjappa@linaro=
=2Eorg>
> wrote:
> >>> This patch adds a check whether the host supports maximum current
> >>> value obtained from the device's extended csd register for a
> >>> selected interface voltage and frequency.
> >>>
> >>> cc: Chris Ball <cjb@laptop.org>
> >>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> >>> ---
> >>> Changes in v2:
> >>> =A0 =A0 =A0 =A0deleted a unnecessary if else condition identified=
 by subhash
> >>> J Changes in v1:
> >>> =A0 =A0 =A0 reduced the number of comparisons as per Hein's sugge=
stion
> >>>
> >>> =A0drivers/mmc/core/mmc.c =A0 | =A0 19 +++++++++++++++++++
> >>> =A0include/linux/mmc/card.h | =A0 =A04 ++++
> >>> =A02 files changed, 23 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c inde=
x
> >>> 006e932..b9ef777 100644
> >>> --- a/drivers/mmc/core/mmc.c
> >>> +++ b/drivers/mmc/core/mmc.c
> >>> @@ -688,6 +688,25 @@ static int mmc_select_powerclass(struct
> >>> mmc_card *card,
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrclass_val =3D (pwrclass_val &
> >>> EXT_CSD_PWR_CL_4BIT_MASK) >>
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EX=
T_CSD_PWR_CL_4BIT_SHIFT;
> >>>
> >>> + =A0 =A0 =A0 if (pwrclass_val >=3D MMC_MAX_CURRENT_800)
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_80=
0;
> >>> + =A0 =A0 =A0 else if (pwrclass_val >=3D MMC_MAX_CURRENT_600)
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_60=
0;
> >>> + =A0 =A0 =A0 else if (pwrclass_val >=3D MMC_MAX_CURRENT_400)
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_40=
0;
> >>> + =A0 =A0 =A0 else
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_20=
0;
> >>> +
> >>> + =A0 =A0 =A0 if ((pwrclass_val =3D=3D MMC_MAX_CURRENT_800) &&
> >>> + =A0 =A0 =A0 =A0 =A0 !(card->host->caps & MMC_CAP_MAX_CURRENT_80=
0))
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_60=
0;
> >>> + =A0 =A0 =A0 if ((pwrclass_val =3D=3D MMC_MAX_CURRENT_600) &&
> >>> + =A0 =A0 =A0 =A0 =A0 !(card->host->caps & MMC_CAP_MAX_CURRENT_60=
0))
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_40=
0;
> >>> + =A0 =A0 =A0 if ((pwrclass_val =3D=3D MMC_MAX_CURRENT_400) &&
> >>> + =A0 =A0 =A0 =A0 =A0 !(card->host->caps & MMC_CAP_MAX_CURRENT_40=
0))
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_20=
0;
> >>> +
> >>> =A0 =A0 =A0 =A0/* If the power class is different from the defaul=
t value */
> >>> =A0 =A0 =A0 =A0if (pwrclass_val > 0) {
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(card, EXT_CSD_C=
MD_SET_NORMAL,
> >>
> >> It is not allowed to set the POWER_CLASS with any value other than
> >> what is mentioned in the PWR_CL_ff_vvv or PWR_CL_DDR_ff_vvv =A0for
> the
> >> corresponding frequency, voltage. That is, if PWR_CL_200_195 is 14
> >> and we want to operate at HS200 then the only value allowed for
> >> POWER_CLASS is 14. So, we need to check the PWR_CL numbers and
> choose
> >> the operating mode (HS200/DDR50/..) based on the platform capabili=
ty
> >> to support the current consumption and set the corresponding
> >> POWER_CLASS value.
> >>
> >> Please refer to section 6.6.5 of the 4.5 spec.
> >
> > The upstreamed code reads the extended csd value based on the alrea=
dy
> > set voltage level and frequency of host. So it will get the require=
d
> > power class value which can be set directly. Is my understanding
> > correct?
> >
>=20
> It is not enough to just check the voltage level and frequency.
> Consider this example, host has capability to support
> MMC_CAP_MAX_CURRENT_400, the PWR_CL_DDR_52_360 has the value 9
> (400mA) and PWR_CL_200_360 has the value 14 (800mA). Then even though
> the host might be capable to run 200MHz clock and 3.6V, it can only e=
nable
> DDR at 52MHz and set 9 in POWER_CLASS.
>=20
> I think, in mmc_select_powerclass, we need to loop through the power
> classes of all supported modes of transfer (HS200, DDR52, ... ) and c=
hoose
the
> mode which gives maximum bandwidth but falls within host capability o=
f
> current consumption. Then set this to POWER_CLASS byte and also use t=
he
> same information when setting HS_TIMING in mmc_init_card.

Hi Saugata,

Does the spec mandates you to set the power class to what is needed by
frequency/voltage combination? I can't see that mentioned anywhere
explicitly in eMMC4.5 spec (if it is mentioned in spec, please let me k=
now
section and line number). It may be still possible to set the power cla=
ss
lower than what is needed by frequency/voltage combination. Say for exa=
mple,
8-bit HS200 (200MHz) with high voltage cards may specify power class
(PWR_CL_200_3_6) value of 14 (800 mA) but that doesn't mean if you want=
 the
card to work in 8-bit HS200 mode, its POWER_CLASS value must be 14 (800=
mA).
If host's VDD regulator is only capable of say 600mA then it may still =
set
the POWER_CLASS to 12 (600 mA) which should be the indication to card t=
hat
host power supply is capable of sourcing only 600mA and I would assume =
card
will make sure that it doesn't draw anything more than that.=20

Hi Girish,

I see couple of other issues with your original power_class selection p=
atch.
1. mmc_select_powerclass() function considers 2.7v to 3.2v VDD range as
invalid. That's not correct. Valid high voltage range is from 2.7v to 3=
=2E6v.
Is there a specific reason you have skipped the 2.7v to 3.2v VDD range?=
 If
not, I should post following change:

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -626,6 +626,11 @@ static int mmc_select_powerclass(struct mmc_card *=
card,
                else if (host->ios.clock <=3D 200000000)
                        index =3D EXT_CSD_PWR_CL_200_195;
                break;
+       case MMC_VDD_27_28:
+       case MMC_VDD_28_29:
+       case MMC_VDD_29_30:
+       case MMC_VDD_30_31:
+       case MMC_VDD_31_32:
        case MMC_VDD_32_33:
        case MMC_VDD_33_34:
        case MMC_VDD_34_35:

2.  Currently in mmc_init_card(), power class selection is done if it's
normal (DS or HS) or DDR or HS200 card.
    If power class selection fails (mmc_select_powerclass() returns err=
or)
for DS/HS/DDR cards, we are just printing the error and going ahead wit=
h the
rest of the initialization where as if power class selection fails for =
HS200
cards, we are simply aborting the =20
    initialization and mark it as failed.=20

   There are my points:
       1.  Power class failure must be treated in same manner for
DS/HS/DDR/HS200 cards
       2.  If you agree on first point then we need to decide whether p=
ower
class selection failure is fatal enough to abort the MMC initialization=
? or
we can just print the warning and go ahead with rest of the initializat=
ion
in same bus speed mode?

Regards,
Subhash

>=20
> >>
> >>
> >>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> >>> index 9478a6b..c5e031a 100644
> >>> --- a/include/linux/mmc/card.h
> >>> +++ b/include/linux/mmc/card.h
> >>> @@ -195,6 +195,10 @@ struct mmc_part {
> >>> =A0#define MMC_BLK_DATA_AREA_GP =A0 (1<<2)
> >>> =A0};
> >>>
> >>> +#define MMC_MAX_CURRENT_200 =A0 =A0(0)
> >>> +#define MMC_MAX_CURRENT_400 =A0 =A0(7)
> >>> +#define MMC_MAX_CURRENT_600 =A0 =A0(11) #define
> MMC_MAX_CURRENT_800
> >>> +(13)
> >>> =A0/*
> >>> =A0* MMC device
> >>> =A0*/
> >>> --
> >>> 1.7.1
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-m=
mc"
> >>> in the body of a message to majordomo@vger.kernel.org More
> majordomo
> >>> info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

