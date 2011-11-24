From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH RESEND V4] mmc: core: HS200 mode support for eMMC 4.5
Date: Thu, 24 Nov 2011 11:43:35 +0530
Message-ID: <000001ccaa70$35896e80$a09c4b80$@org>
References: <1319605188-2909-1-git-send-email-girish.shivananjappa@linaro.org>	<000301cca624$399373e0$acba5ba0$@org> <CAGxe1ZFmRiBOiLOS0uNh3+AGmg7a1u=C0YPNckriWUn02M63ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:5766 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab1KXGNl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2011 01:13:41 -0500
In-Reply-To: <CAGxe1ZFmRiBOiLOS0uNh3+AGmg7a1u=C0YPNckriWUn02M63ag@mail.gmail.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org

Hi Girish,

> -----Original Message-----
> From: Girish K S [mailto:girish.shivananjappa@linaro.org]
> Sent: Monday, November 21, 2011 4:12 PM
> To: Subhash Jadavani
> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; patches@linaro.org;
> linux-samsung-soc@vger.kernel.org
> Subject: Re: [PATCH RESEND V4] mmc: core: HS200 mode support for eMMC
> 4.5
>=20
> On 19 November 2011 00:29, Subhash Jadavani <subhashj@codeaurora.org>
> wrote:
> > Hi Girish,
> >
> >> -----Original Message-----
> >> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> >> owner@vger.kernel.org] On Behalf Of Girish K S
> >> Sent: Wednesday, October 26, 2011 10:30 AM
> >> To: linux-mmc@vger.kernel.org
> >> Cc: cjb@laptop.org; patches@linaro.org; linux-samsung-
> >> soc@vger.kernel.org; Girish K S
> >> Subject: [PATCH RESEND V4] mmc: core: HS200 mode support for eMMC
> 4.5
> >>
> >> This patch adds the support of the HS200 bus speed for eMMC 4.5
> >> devices.
> >> The eMMC 4.5 devices have support for 200MHz bus speed.The mmc cor=
e
> and
> >> host modules have been touched to add support for this module.
> >>
> >> It is necessary to know the card type in the sdhci.c file to add
> >> support
> >> for eMMC tuning function. So card.h file is included to import the
> card
> >> data structure.
> >
> > We don't need to know the card type in the host controller driver i=
f
> we pass
> > the command opcode as the 2nd argument to execute_tuning() ops.
> Command
> > opcode can have have either CMD19 or CMD21 as it's value depending =
on
> the
> > card type (whether it's SD3.0 card or eMMC4.5 card).

Can you see if we can implement this?

> >
> >
> >>
> >> cc: Chris Ball <cjb@laptop.org>
> >> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> >> ---
> >> Changes in v4:
> >> =A0 =A0 =A0 Rebased onto chris-mmc/mmc-next branch. This patch is
> >> successfully
> >> =A0 =A0 =A0 applied on commit with id
> >> de022ed3fdc14808299b2fa66dbb1ed5ab921912.
> >> Changes in v3:
> >> =A0 =A0 =A0 In the previous commits of chris-mmc/mmc-next branch, =
the
> patch
> >> with
> >> =A0 =A0 =A0 commit id (c0f22a2c92e357e7cb3988b0b13034d70b7461f9) d=
efines
> >> caps2 for
> >> =A0 =A0 =A0 more capabilities. This patch version deletes the memb=
er
> >> ext_caps(created
> >> =A0 =A0 =A0 in my earlier patch) from struct mmc_host and reuses a=
lready
> >> accepted
> >> =A0 =A0 =A0 caps2 member.
> >> Changes in v2:
> >> =A0 =A0 =A0 Rebased to latest chris-mmc/mmc-next branch. Resolved
> indentation
> >> =A0 =A0 =A0 problems identified in review. This patch has to be ap=
plied
> >> before
> >> =A0 =A0 =A0 the patch released for modifying the printk messages.
> >> Changes in v1:
> >> =A0 =A0 =A0 Case statements in switch that produce same result hav=
e
> >> =A0 =A0 =A0 been combined to reduce repeated assignments.
> >> =A0 =A0 =A0 patch recreated after rebase to chris balls mmc-next b=
ranch.
> >>
> >> =A0drivers/mmc/core/bus.c =A0 =A0| =A0 =A03 +-
> >> =A0drivers/mmc/core/mmc.c =A0 =A0| =A0 92
> >> ++++++++++++++++++++++++++++++++++++++++----
> >> =A0drivers/mmc/host/sdhci.c =A0| =A0 36 +++++++++++++++---
> >> =A0include/linux/mmc/card.h =A0| =A0 =A03 +
> >> =A0include/linux/mmc/host.h =A0| =A0 =A06 +++
> >> =A0include/linux/mmc/mmc.h =A0 | =A0 =A08 +++-
> >> =A0include/linux/mmc/sdhci.h | =A0 =A01 +
> >> =A07 files changed, 132 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> >> index 46b6e84..2f82f6b 100644
> >> --- a/drivers/mmc/core/bus.c
> >> +++ b/drivers/mmc/core/bus.c
> >> @@ -301,10 +301,11 @@ int mmc_add_card(struct mmc_card *card)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_ddr_mode(card=
) ? "DDR " : "",
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type);
> >> =A0 =A0 =A0 } else {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s: new %s%s%s card at=
 address
> %04x\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: new %s%s%s%s card at addres=
s %04x\n",
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->hos=
t),
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_sd_card_uhs(card) =
? "ultra high speed " :
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_highspeed(ca=
rd) ? "high speed " :
> ""),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_hs200(card) ? =
"HS200 " : ""),
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_ddr_mode(card=
) ? "DDR " : "",
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type, card->rca);
> >> =A0 =A0 =A0 }
> >> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> index 3627044..4db248c 100644
> >> --- a/drivers/mmc/core/mmc.c
> >> +++ b/drivers/mmc/core/mmc.c
> >> @@ -285,6 +285,39 @@ static int mmc_read_ext_csd(struct mmc_card
> *card,
> >> u8 *ext_csd)
> >> =A0 =A0 =A0 }
> >> =A0 =A0 =A0 card->ext_csd.raw_card_type =3D ext_csd[EXT_CSD_CARD_T=
YPE];
> >> =A0 =A0 =A0 switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE=
_MASK) {
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_200 |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1=
_8V |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1=
_2V |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_5=
2 |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD=
_TYPE_SDR_200;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_=
1_8V |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_=
1_2V |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_=
52 |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD=
_TYPE_SDR_1_2V;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_=
1_8V |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_=
1_2V |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_=
52 |
> >> + =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD=
_TYPE_SDR_1_8V;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >
> > Can't we optimize this? This looks like too many case statements.
> >
> > Basically we can have checks like this:
> >
> > temp =3D ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK;
> > if ((temp & EXT_CSD_CARD_TYPE_SDR_1_2V =3D=3D EXT_CSD_CARD_TYPE_SDR=
_1_2V)
> ||
> > =A0 =A0 =A0 =A0(temp & EXT_CSD_CARD_TYPE_SDR_1_8V =3D=3D
> EXT_CSD_CARD_TYPE_SDR_1_8V)) {
> > =A0 =A0 =A0 =A0card->ext_csd.hs_max_dtr =3D 200000000;
> > =A0 =A0 =A0 =A0card->ext_csd.card_type =3D EXT_CSD_CARD_TYPE_SDR_1_=
2V; /* we
> can have
> > some logic to identify the card type correctly */
> > }

Can you please respond to this?

> >
> >
> >> =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
> >> =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_26:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 52000000;
> >> @@ -699,6 +732,7 @@ static int mmc_init_card(struct mmc_host *host=
,
> u32
> >> ocr,
> >> =A0{
> >> =A0 =A0 =A0 struct mmc_card *card;
> >> =A0 =A0 =A0 int err, ddr =3D 0;
> >> + =A0 =A0 int hs_sdr =3D 0;
> >> =A0 =A0 =A0 u32 cid[4];
> >> =A0 =A0 =A0 unsigned int max_dtr;
> >> =A0 =A0 =A0 u32 rocr;
> >> @@ -890,11 +924,15 @@ static int mmc_init_card(struct mmc_host
> *host,
> >> u32 ocr,
> >> =A0 =A0 =A0 /*
> >> =A0 =A0 =A0 =A0* Activate high speed (if supported)
> >> =A0 =A0 =A0 =A0*/
> >> - =A0 =A0 if ((card->ext_csd.hs_max_dtr !=3D 0) &&
> >> - =A0 =A0 =A0 =A0 =A0 =A0 (host->caps & MMC_CAP_MMC_HIGHSPEED)) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET=
_NORMAL,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_C=
SD_HS_TIMING, 1,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card-=
>ext_csd.generic_cmd6_time);
> >> + =A0 =A0 if (card->ext_csd.hs_max_dtr !=3D 0) {
> >
> > We should enter into this if condition only if one of the this cap
> > (MMC_CAP2_HIGHSPEED_200 or MMC_CAP_MMC_HIGHSPEED) is set.
> card->ext_csd.hs_max_dtr is non zero for high speed only i.e for
> frequency above 26Mhz. For anything less than 26 Mhz  this if
> condition is skipped.

I guess that's not the correct assumption here. Even for
EXT_CSD_CARD_TYPE_26 card type we have non zero value hs_max_dtr. Pleas=
e
check.

	case EXT_CSD_CARD_TYPE_26:
		card->ext_csd.hs_max_dtr =3D 26000000;

> So its just enough if we check for less than 52 MHz and >=3D 52 Mhz.

> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hs_max_dtr > 52000000=
) &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 & MMC_CAP2_HIGHSPEE=
D_200))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card,=
 EXT_CSD_CMD_SET_NORMAL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0EXT_CSD_HS_TIMING, 2, 0);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 else if (host->caps & MMC_CAP_MMC_HIGHSP=
EED)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card,=
 EXT_CSD_CMD_SET_NORMAL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0EXT_CSD_HS_TIMING, 1, 0);
> >> +
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> >>
> >> @@ -903,7 +941,10 @@ static int mmc_init_card(struct mmc_host *hos=
t,
> >> u32 ocr,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hos=
tname(card->host));
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_highspeed(c=
ard);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.hs_max=
_dtr > 52000000)
> >
> > I think there should be AND condition with (host->caps2 &
> > MMC_CAP2_HIGHSPEED_200) for setting the card as HS200.
> Ok will add it.
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card=
_set_hs200(card);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card=
_set_highspeed(card);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->h=
ost, MMC_TIMING_MMC_HS);
> >
> > As mentioned earlier, there should be new timing mode defined for
> HS200.
> can you share Host controller specification will check it.

Our Qualcomm MSM SDCC host controller is not compliant to SDHCI (Standa=
rd
Host controller interface) specification so our host controller
implementation won't be same as controllers compliant to SDHCI. It's no=
t
just Qualcomm SDCC controller, there are many other SDCC controller (li=
ke
mmci) which are not compliant to SDHCI standard.

If you check the SD3.0 implementation (sd_set_bus_speed_mode() function=
 in
drivers/mmc/core/sd.c), core layer is setting the different timing mode=
s for
all the different UHS-I bus speed modes (like SDR104, SDR50, DDR50 etc =
=2E..).
Then it's upto the host controller driver to see whether they want to m=
ake
use this timing mode or not? Our host controller driver does make use o=
f it
for SD3.0 timing modes and similar we need to know HS200 timing mode in
order to program our controller properly.


> >
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> =A0 =A0 =A0 }
> >> @@ -929,7 +970,7 @@ static int mmc_init_card(struct mmc_host *host=
,
> u32
> >> ocr,
> >> =A0 =A0 =A0 =A0*/
> >> =A0 =A0 =A0 max_dtr =3D (unsigned int)-1;
> >>
> >> - =A0 =A0 if (mmc_card_highspeed(card)) {
> >> + =A0 =A0 if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_dtr > card->ext_csd.hs_max_dtr=
)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_dtr =3D card->ext_=
csd.hs_max_dtr;
> >> =A0 =A0 =A0 } else if (max_dtr > card->csd.max_dtr) {
> >> @@ -955,6 +996,22 @@ static int mmc_init_card(struct mmc_host *hos=
t,
> >> u32 ocr,
> >> =A0 =A0 =A0 }
> >>
> >> =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0* Indicate HS200 SDR mode (if supported).
> >> + =A0 =A0 =A0*/
> >> + =A0 =A0 if (mmc_card_hs200(card)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.card_type &
> EXT_CSD_CARD_TYPE_SDR_1_8V)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && ((host->caps2 & (MMC_=
CAP2_HS200_1_8V_SDR |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP2_HS20=
0))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D (=
MMC_CAP2_HS200_1_8V_SDR |
> > MMC_CAP2_HS200)))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hs_sdr =3D=
 MMC_1_8V_SDR_MODE;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 else if ((card->ext_csd.card_type &
> >> EXT_CSD_CARD_TYPE_SDR_1_2V)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& ((host->caps2 & (M=
MC_CAP2_HS200_1_2V_SDR |
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP2_HS2=
00))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D (=
MMC_CAP2_HS200_1_2V_SDR |
> > MMC_CAP2_HS200)))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hs_sdr =3D=
 MMC_1_2V_SDR_MODE;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /*
> >> =A0 =A0 =A0 =A0* Activate wide bus and DDR (if supported).
> >> =A0 =A0 =A0 =A0*/
> >> =A0 =A0 =A0 if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
> >> @@ -994,16 +1051,24 @@ static int mmc_init_card(struct mmc_host
> *host,
> >> u32 ocr,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_se=
t_bus_width(card->host,
> bus_width);
> >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((hos=
t->caps2 & MMC_CAP2_HS200) &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
card->host->ops->execute_tuning)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 err =3D card->host->ops-> \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 execute_tuning(card-
> >host);
> >
> > execute_tuning() should be executed immediately after the TIMING is
> changed
> > to HS200 and clock speed is changed to 200MHz. But here timing mode
> and
> > clock rate is changed and then you are also sending bus width chang=
e
> > command. As host controller timing tuning has not completed, this b=
us
> width
> > change command may fail with CMD/DATA CRC errors.
> > pls check the eMMC specification section 6.6.4  it says
> "Note that the host should switch to the required bus width before
> starting the tuning operation to
> allow the tuning sequence to be done using the proper bus operating
> conditions.

Agreed. But specification doesn't when exactly the bus width change sho=
uld
happen. Right before Step.6 (mentioned in section 6.6.4) or before sett=
ing
the HS200 mode in HS_TIMING and changing the clock speed.

I would say we should set the bus width before the step.1 (mentioned in
section 6.6.4). then proceed to execute all the step.1 and step.6 in
sequence.

As I had mentioned earlier, let's say at first you set the HS_TIMING=3D=
HS200
and set the clock speed to 200MHz. Now if you try to set the bus width =
(by
sending the CMD6 and then reading the STATUS via CMD13) without executi=
ng
tuning, CMD6/CMD13 may fail with CMD/RESPONSE CRC errors as controller
sampling point is still not tuned. We had exact similar issue faced wit=
h
SD3.0 as well on our host controller. You can take a look at this patch=
:
http://www.spinics.net/lists/linux-arm-msm/msg03867.html


> "
> > So basically this should be the sequence.
> > 1. set the bus width depending on the host controller and card
> capability
> > 2. If card support HS200 timing, change the timing of the card by
> sending
> > SWITCH command. Change the clock rate. Change the timing mode of
> controller.
> > 3. Now call the host controller execute_tuning ops to perform the
> controller
> > sampling point tuning.
> >
> > Also, let's pass the command opcode as the 2nd argument of the
> > execute_tuning() function. Which means host controller driver need
> not to
> > know the card type.
> >
> >> +
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* I=
f controller can't handle bus
> width
> > test,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* c=
ompare ext_csd previously read in
> 1 bit
> >> mode
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* a=
gainst ext_csd at new bus width
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(ho=
st->caps &
> MMC_CAP_BUS_WIDTH_TEST))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(ho=
st->caps &
> MMC_CAP_BUS_WIDTH_TEST)
> > &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
!err)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 err =3D
> mmc_compare_ext_csds(card,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 bus_width);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if =
(!err)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 err =3D mmc_bus_test(card,
> bus_width);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 pr_warning("tuning execution
> > failed\n");
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!e=
rr)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 break;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> @@ -1052,6 +1117,15 @@ static int mmc_init_card(struct mmc_host
> *host,
> >> u32 ocr,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_ddr_mode(=
card);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->h=
ost,
> MMC_TIMING_UHS_DDR50);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card=
->host, bus_width);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (hs_sdr) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hs_sdr =3D=3D EXT_CS=
D_CARD_TYPE_SDR_1_2V) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D =
mmc_set_signal_voltage(host,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 MMC_SIGNAL_VOLTAGE_120, 0);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 goto err;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->hos=
t, MMC_TIMING_MMC_HS);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card->=
host, bus_width);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> =A0 =A0 =A0 }
> >>
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index a69d269..28fb747 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -27,6 +27,7 @@
> >>
> >> =A0#include <linux/mmc/mmc.h>
> >> =A0#include <linux/mmc/host.h>
> >> +#include <linux/mmc/card.h>
> >>
> >> =A0#include "sdhci.h"
> >>
> >> @@ -1016,7 +1017,8 @@ static void sdhci_send_command(struct
> sdhci_host
> >> *host, struct mmc_command *cmd)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D SDHCI_CMD_INDEX;
> >>
> >> =A0 =A0 =A0 /* CMD19 is special in that the Data Present Select sh=
ould be
> set
> >> */
> >> - =A0 =A0 if (cmd->data || (cmd->opcode =3D=3D MMC_SEND_TUNING_BLO=
CK))
> >> + =A0 =A0 if (cmd->data || (cmd->opcode =3D=3D MMC_SEND_TUNING_BLO=
CK) ||
> >> + =A0 =A0 =A0 =A0 (cmd->opcode =3D=3D MMC_SEND_TUNING_BLOCK_HS200)=
)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D SDHCI_CMD_DATA;
> >>
> >> =A0 =A0 =A0 sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),
> >> SDHCI_COMMAND);
> >> @@ -1684,10 +1686,13 @@ static int sdhci_execute_tuning(struct
> mmc_host
> >> *mmc)
> >> =A0 =A0 =A0 =A0* Host Controller needs tuning only in case of SDR1=
04 mode
> >> =A0 =A0 =A0 =A0* and for SDR50 mode when Use Tuning for SDR50 is s=
et in
> >> =A0 =A0 =A0 =A0* Capabilities register.
> >> + =A0 =A0 =A0* If the Host Controller supports the HS200 mode then=
 tuning
> >> + =A0 =A0 =A0* function has to be executed.
> >> =A0 =A0 =A0 =A0*/
> >> =A0 =A0 =A0 if (((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D SDHCI_CTRL_UH=
S_SDR104) ||
> >> =A0 =A0 =A0 =A0 =A0 (((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D SDHCI_CT=
RL_UHS_SDR50) &&
> >> - =A0 =A0 =A0 =A0 (host->flags & SDHCI_SDR50_NEEDS_TUNING)))
> >> + =A0 =A0 =A0 =A0 (host->flags & SDHCI_SDR50_NEEDS_TUNING)) ||
> >> + =A0 =A0 =A0 =A0 (host->flags & SDHCI_HS200_NEEDS_TUNING))
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_EXEC_TUNING;
> >> =A0 =A0 =A0 else {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->lock);
> >> @@ -1723,7 +1728,10 @@ static int sdhci_execute_tuning(struct
> mmc_host
> >> *mmc)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tuning_loop_counter && !timeout)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >>
> >> - =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_SEND_TUNING_BLOCK;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->card->type =3D=3D MMC_TYPE_MMC)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_SEND_=
TUNING_BLOCK_HS200;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_SEND_=
TUNING_BLOCK;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.arg =3D 0;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADT=
C;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.retries =3D 0;
> >> @@ -1738,7 +1746,17 @@ static int sdhci_execute_tuning(struct
> mmc_host
> >> *mmc)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* block to the Host Controller. So =
we set the block
> size
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to 64 here.
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> - =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 6=
4),
> >> SDHCI_BLOCK_SIZE);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->card->type =3D=3D MMC_TYPE_MMC)=
 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->ios.bus_width =3D=
=3D MMC_BUS_WIDTH_8)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_wr=
itew(host, SDHCI_MAKE_BLKSZ(7,
> 128),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0SDHCI_BLOCK_SIZE);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (mmc->ios.bus_wi=
dth =3D=3D
> MMC_BUS_WIDTH_4)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_wr=
itew(host, SDHCI_MAKE_BLKSZ(7,
> 64),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0SDHCI_BLOCK_SIZE);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, SDHCI=
_MAKE_BLKSZ(7, 64),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0SDHCI_BLOCK_SIZE);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >>
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The tuning block is sent by the c=
ard to the host
> >> controller.
> >> @@ -2121,12 +2139,14 @@ static void sdhci_show_adma_error(struct
> >> sdhci_host *host) { }
> >>
> >> =A0static void sdhci_data_irq(struct sdhci_host *host, u32 intmask=
)
> >> =A0{
> >> + =A0 =A0 u32 command;
> >> =A0 =A0 =A0 BUG_ON(intmask =3D=3D 0);
> >>
> >> =A0 =A0 =A0 /* CMD19 generates _only_ Buffer Read Ready interrupt =
*/
> >> =A0 =A0 =A0 if (intmask & SDHCI_INT_DATA_AVAIL) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 if (SDHCI_GET_CMD(sdhci_readw(host, SDHC=
I_COMMAND)) =3D=3D
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEND_TUNING_BLOCK) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 command =3D SDHCI_GET_CMD(sdhci_readw(ho=
st,
> SDHCI_COMMAND));
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((command =3D=3D MMC_SEND_TUNING_BLOC=
K) ||
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (command =3D=3D MMC_SEND_TUNING_=
BLOCK_HS200)) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tuning_done =3D =
1;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up(&host->buf_rea=
dy_int);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> @@ -2731,6 +2751,10 @@ int sdhci_add_host(struct sdhci_host *host)
> >> =A0 =A0 =A0 if (caps[1] & SDHCI_USE_SDR50_TUNING)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_SDR50_NEEDS_TUN=
ING;
> >>
> >> + =A0 =A0 /* Does the host needs tuning for HS200? */
> >> + =A0 =A0 if (mmc->caps2 & MMC_CAP2_HS200)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_HS200_NEEDS_TUNIN=
G;
> >> +
> >> =A0 =A0 =A0 /* Driver Type(s) (A, C, D) supported by the host */
> >> =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_A)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DRIVER_TYPE_A;
> >> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> >> index 6e04e10..90af438 100644
> >> --- a/include/linux/mmc/card.h
> >> +++ b/include/linux/mmc/card.h
> >> @@ -206,6 +206,7 @@ struct mmc_card {
> >> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 /* card is in
> high
> >> speed mode */
> >> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* card is in
> ultra
> >> high speed mode */
> >> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<6) =A0=
 =A0 =A0 =A0 =A0/* card is
> SDXC */
> >> +#define MMC_STATE_HIGHSPEED_200 =A0 =A0 =A0(1<<7) =A0/* card is i=
n HS200
> >> mode */
> >> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
> >> =A0#define MMC_QUIRK_LENIENT_FN0 =A0 =A0 =A0 =A0(1<<0) =A0 =A0 =A0=
 =A0 =A0/* allow SDIO
> FN0
> >> writes outside of the VS CCCR range */
> >> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) /* use func-
> >> >cur_blksize */
> >> @@ -361,6 +362,7 @@ static inline void __maybe_unused
> >> remove_quirk(struct mmc_card *card, int data)
> >> =A0#define mmc_card_present(c) =A0((c)->state & MMC_STATE_PRESENT)
> >> =A0#define mmc_card_readonly(c) ((c)->state & MMC_STATE_READONLY)
> >> =A0#define mmc_card_highspeed(c) =A0 =A0 =A0 =A0((c)->state &
> MMC_STATE_HIGHSPEED)
> >> +#define mmc_card_hs200(c) =A0 =A0((c)->state & MMC_STATE_HIGHSPEE=
D_200)
> >> =A0#define mmc_card_blockaddr(c) =A0 =A0 =A0 =A0((c)->state &
> MMC_STATE_BLOCKADDR)
> >> =A0#define mmc_card_ddr_mode(c) ((c)->state & MMC_STATE_HIGHSPEED_=
DDR)
> >> =A0#define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPE=
ED)
> >> @@ -369,6 +371,7 @@ static inline void __maybe_unused
> >> remove_quirk(struct mmc_card *card, int data)
> >> =A0#define mmc_card_set_present(c) =A0 =A0 =A0((c)->state |=3D
> MMC_STATE_PRESENT)
> >> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_REA=
DONLY)
> >> =A0#define mmc_card_set_highspeed(c) ((c)->state |=3D
> MMC_STATE_HIGHSPEED)
> >> +#define mmc_card_set_hs200(c) =A0 =A0 =A0 =A0((c)->state |=3D
> >> MMC_STATE_HIGHSPEED_200)
> >> =A0#define mmc_card_set_blockaddr(c) ((c)->state |=3D
> MMC_STATE_BLOCKADDR)
> >> =A0#define mmc_card_set_ddr_mode(c) ((c)->state |=3D
> >> MMC_STATE_HIGHSPEED_DDR)
> >> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D
> >> MMC_STATE_ULTRAHIGHSPEED)
> >> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >> index a3ac9c4..20551f5 100644
> >> --- a/include/linux/mmc/host.h
> >> +++ b/include/linux/mmc/host.h
> >> @@ -60,6 +60,8 @@ struct mmc_ios {
> >> =A0#define MMC_SDR_MODE =A0 =A0 =A0 =A0 0
> >> =A0#define MMC_1_2V_DDR_MODE =A0 =A01
> >> =A0#define MMC_1_8V_DDR_MODE =A0 =A02
> >> +#define MMC_1_2V_SDR_MODE =A0 =A03
> >> +#define MMC_1_8V_SDR_MODE =A0 =A04
> >>
> >> =A0 =A0 =A0 unsigned char =A0 signal_voltage; =A0 =A0 =A0 =A0 /* s=
ignalling voltage
> >> (1.8V or 3.3V) */
> >>
> >> @@ -242,6 +244,10 @@ struct mmc_host {
> >> =A0#define MMC_CAP2_CACHE_CTRL =A0(1 << 1) =A0 =A0 =A0 =A0/* Allow=
 cache control
> */
> >> =A0#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0/* Notify powe=
roff
> >> supported */
> >> =A0#define MMC_CAP2_NO_MULTI_READ =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0=
 =A0/* Multiblock
> reads
> >> don't work */
> >> +#define MMC_CAP2_HS200 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4) =A0 =A0=
 =A0 =A0/* Host
> supports
> > HS200 mode
> >> */
> >
> > Why is this cap required? You have already defined this 2 caps
> > MMC_CAP2_HS200_1_8V_SDR & MMC_CAP2_HS200_1_2V_SDR which should be
> enough.
> >
> >> +#define MMC_CAP2_HS200_1_8V_SDR =A0 =A0 =A0(1 << 5) =A0 =A0 =A0 =A0=
/* can support
> */
> >> +#define MMC_CAP2_HS200_1_2V_SDR =A0 =A0 =A0(1 << 6) =A0 =A0 =A0 =A0=
/* can support
> */
> >> +#define MMC_CAP2_HIGHSPEED_200 =A0 =A0 =A0 (1 << 7) =A0 =A0 =A0 =A0=
/* Can do MMC
> HS200
> > Why is this is this cap required?
> >  will remove it

Both MMC_CAP2_HIGHSPEED_200 and MMC_CAP2_HS200 are redundant.

> >> timing */
> >>
> >> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm
> features */
> >> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
> >> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> >> index 0e71356..af4fa72 100644
> >> --- a/include/linux/mmc/mmc.h
> >> +++ b/include/linux/mmc/mmc.h
> >> @@ -51,6 +51,7 @@
> >> =A0#define MMC_READ_SINGLE_BLOCK =A0 =A017 =A0 /* adtc [31:0] data=
 addr =A0 R1
> >> */
> >> =A0#define MMC_READ_MULTIPLE_BLOCK =A018 =A0 /* adtc [31:0] data a=
ddr =A0 R1
> >> */
> >> =A0#define MMC_SEND_TUNING_BLOCK =A0 =A019 =A0 /* adtc =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0R1
> >> */
> >> +#define MMC_SEND_TUNING_BLOCK_HS200 =A021 =A0 =A0 =A0/* adtc R1 =A0=
*/
> >>
> >> =A0 =A0/* class 3 */
> >> =A0#define MMC_WRITE_DAT_UNTIL_STOP 20 =A0 /* adtc [31:0] data add=
r =A0 R1
> >> */
> >> @@ -333,13 +334,18 @@ struct _mmc_csd {
> >>
> >> =A0#define EXT_CSD_CARD_TYPE_26 (1<<0) =A0/* Card can run at 26MHz=
 */
> >> =A0#define EXT_CSD_CARD_TYPE_52 (1<<1) =A0/* Card can run at 52MHz=
 */
> >> -#define EXT_CSD_CARD_TYPE_MASK =A0 =A0 =A0 0xF =A0 =A0 /* Mask ou=
t reserved
> bits */
> >> +#define EXT_CSD_CARD_TYPE_MASK =A0 =A0 =A0 0x3F =A0 =A0/* Mask ou=
t reserved
> bits */
> >> =A0#define EXT_CSD_CARD_TYPE_DDR_1_8V =A0(1<<2) =A0 /* Card can ru=
n at
> 52MHz
> >> */
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* DDR mode @1.8V or 3V
> I/O */
> >> =A0#define EXT_CSD_CARD_TYPE_DDR_1_2V =A0(1<<3) =A0 /* Card can ru=
n at
> 52MHz
> >> */
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* DDR mode @1.2V I/O */
> >> =A0#define EXT_CSD_CARD_TYPE_DDR_52 =A0 =A0 =A0 (EXT_CSD_CARD_TYPE=
_DDR_1_8V
> =A0\
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_2V)
> >> +#define EXT_CSD_CARD_TYPE_SDR_1_8V =A0 (1<<4) =A0/* Card can run =
at
> >> 200MHz */
> >> +#define EXT_CSD_CARD_TYPE_SDR_1_2V =A0 (1<<5) =A0/* Card can run =
at
> >> 200MHz */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 /* SDR mode @1.2V I/O
> */
> >> +#define EXT_CSD_CARD_TYPE_SDR_200 =A0 =A0(EXT_CSD_CARD_TYPE_SDR_1=
_8V
> =A0 \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | EXT_CSD_CARD_TYPE_SDR_1_2V)
> >>
> >> =A0#define EXT_CSD_BUS_WIDTH_1 =A00 =A0 =A0 =A0 /* Card is in 1 bi=
t mode */
> >> =A0#define EXT_CSD_BUS_WIDTH_4 =A01 =A0 =A0 =A0 /* Card is in 4 bi=
t mode */
> >> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> >> index e4b6935..d9a2222 100644
> >> --- a/include/linux/mmc/sdhci.h
> >> +++ b/include/linux/mmc/sdhci.h
> >> @@ -121,6 +121,7 @@ struct sdhci_host {
> >> =A0#define SDHCI_AUTO_CMD23 =A0 =A0 (1<<7) =A0/* Auto CMD23 suppor=
t */
> >> =A0#define SDHCI_PV_ENABLED =A0 =A0 (1<<8) =A0/* Preset value enab=
led */
> >> =A0#define SDHCI_SDIO_IRQ_ENABLED =A0 =A0 =A0 (1<<9) =A0/* SDIO ir=
q enabled */
> >> +#define SDHCI_HS200_NEEDS_TUNING (1<<10) =A0 =A0 /* HS200 needs t=
uning
> */
> >>
> >> =A0 =A0 =A0 unsigned int version; =A0 /* SDHCI spec. version */
> >>
> >> --
> >> 1.7.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c"
> in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >
> >

