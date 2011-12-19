From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH V6 1/2] mmc: core: HS200 mode support for eMMC 4.5
Date: Mon, 19 Dec 2011 16:23:43 +0530
Message-ID: <000301ccbe3c$7bbbc440$73334cc0$@org>
References: <1324276594-16412-1-git-send-email-girish.shivananjappa@linaro.org>	<1324276594-16412-2-git-send-email-girish.shivananjappa@linaro.org>	<000001ccbe36$67435880$35ca0980$@org> <CAGxe1ZHmnsN19vuTAGah53UQSHdGp-4oaQKY9LoWShhrznZs+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAGxe1ZHmnsN19vuTAGah53UQSHdGp-4oaQKY9LoWShhrznZs+w@mail.gmail.com>
Content-Language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Girish K S [mailto:girish.shivananjappa@linaro.org]
> Sent: Monday, December 19, 2011 4:20 PM
> To: Subhash Jadavani
> Cc: linux-mmc@vger.kernel.org; patches@linaro.org; linux-samsung-
> soc@vger.kernel.org; Chris Ball
> Subject: Re: [PATCH V6 1/2] mmc: core: HS200 mode support for eMMC 4.=
5
>=20
> On 19 December 2011 15:40, Subhash Jadavani <subhashj@codeaurora.org>
> wrote:
> > Hi Girish,
> >
> > Overall this patch looks good. I have only 2 minor comments inline
> below.
> >
> > Regards,
> > Subhash
> >
> >
> >> -----Original Message-----
> >> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> >> owner@vger.kernel.org] On Behalf Of Girish K S
> >> Sent: Monday, December 19, 2011 12:07 PM
> >> To: linux-mmc@vger.kernel.org
> >> Cc: patches@linaro.org; linux-samsung-soc@vger.kernel.org; Girish =
K
> S;
> >> Chris Ball
> >> Subject: [PATCH V6 1/2] mmc: core: HS200 mode support for eMMC 4.5
> >>
> >> This patch adds the support of the HS200 bus speed for eMMC 4.5
> >> devices.
> >> The eMMC 4.5 devices have support for 200MHz bus speed. The functi=
on
> >> prototype of the tuning function is modified to handle the tuning
> >> command
> >> number which is different in sd and mmc case.
> >>
> >> cc: Chris Ball <cjb@laptop.org>
> >> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> >> ---
> >> =A0drivers/mmc/core/bus.c =A0 =A0 | =A0 =A03 +-
> >> =A0drivers/mmc/core/debugfs.c | =A0 =A03 +
> >> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0147
> >> +++++++++++++++++++++++++++++++++++++++++---
> >> =A0drivers/mmc/core/sd.c =A0 =A0 =A0| =A0 =A03 +-
> >> =A0drivers/mmc/core/sdio.c =A0 =A0| =A0 =A04 +-
> >> =A0include/linux/mmc/card.h =A0 | =A0 =A03 +
> >> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 66 +++++++++++++++++++-
> >> =A07 files changed, 216 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> >> index f8a228a..5d011a3 100644
> >> --- a/drivers/mmc/core/bus.c
> >> +++ b/drivers/mmc/core/bus.c
> >> @@ -303,10 +303,11 @@ int mmc_add_card(struct mmc_card *card)
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
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_uhs(card) ? "=
ultra high speed " :
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_highspeed(ca=
rd) ? "high speed " :
> ""),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_hs200(card) ? =
"HS200 " : ""),
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_ddr_mode(card=
) ? "DDR " : "",
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type, card->rca);
> >> =A0 =A0 =A0 }
> >> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs=
=2Ec
> >> index 027615d..9ab5b17 100644
> >> --- a/drivers/mmc/core/debugfs.c
> >> +++ b/drivers/mmc/core/debugfs.c
> >> @@ -135,6 +135,9 @@ static int mmc_ios_show(struct seq_file *s, vo=
id
> >> *data)
> >> =A0 =A0 =A0 case MMC_TIMING_UHS_DDR50:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 str =3D "sd uhs DDR50";
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 case MMC_TIMING_MMC_HS200:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 str =3D "mmc high-speed SDR200";
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> =A0 =A0 =A0 default:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 str =3D "invalid";
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> index f0a9f1f..d5d93de 100644
> >> --- a/drivers/mmc/core/mmc.c
> >> +++ b/drivers/mmc/core/mmc.c
> >> @@ -286,6 +286,27 @@ static int mmc_read_ext_csd(struct mmc_card
> *card,
> >> u8 *ext_csd)
> >> =A0 =A0 =A0 }
> >> =A0 =A0 =A0 card->ext_csd.raw_card_type =3D ext_csd[EXT_CSD_CARD_T=
YPE];
> >> =A0 =A0 =A0 switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE=
_MASK) {
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD=
_TYPE_SDR_200;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_ALL:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD=
_TYPE_SDR_1_2V;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_ALL:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V:
> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD=
_TYPE_SDR_1_8V;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
> >> =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_26:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 52000000;
> >> @@ -700,6 +721,52 @@ static int mmc_select_powerclass(struct
> mmc_card
> >> *card,
> >> =A0}
> >>
> >> =A0/*
> >> + * Selects the desired buswidth and switch to the HS200 mode
> >> + * if bus width set without error
> >> + */
> >> +static int mmc_select_hs200(struct mmc_card *card)
> >> +{
> >> + =A0 =A0 int err =3D 0;
> >> + =A0 =A0 struct mmc_host *host;
> >> + =A0 =A0 u32 bus_width =3D MMC_BUS_WIDTH_4;
> >> +
> >> + =A0 =A0 BUG_ON(!card);
> >> +
> >> + =A0 =A0 host =3D card->host;
> >> +
> >> + =A0 =A0 /*
> >> + =A0 =A0 =A0* Host is capable of 8bit transfer, then switch
> >> + =A0 =A0 =A0* the device to work in 8bit transfer mode. If the
> >> + =A0 =A0 =A0* mmc switch command returns error then switch to
> >> + =A0 =A0 =A0* 4bit transfer mode. On success set the correspondin=
g
> >> + =A0 =A0 =A0* bus width on the host.
> >> + =A0 =A0 =A0*/
> >> + =A0 =A0 if (host->caps & MMC_CAP_8_BIT_DATA) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET=
_NORMAL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_C=
SD_BUS_WIDTH,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_C=
SD_BUS_WIDTH_8,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card-=
>ext_csd.generic_cmd6_time);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 bus_width =3D MMC_BUS_WIDTH_8;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /* If the 8bit mode fails switch to 4 bit mode */
> >> + =A0 =A0 if (err)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET=
_NORMAL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_C=
SD_BUS_WIDTH,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_C=
SD_BUS_WIDTH_4,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card-=
>ext_csd.generic_cmd6_time);
> >
> > Don't you need to set the bus_width =3D MMC_BUS_WIDTH_4 after sendi=
ng
> the
> > switch?
> > Let's say if the host->caps says it support the 8-bit mode but
> mmc_switch()
> > fails but your bus_width will still be MMC_BUS_WIDTH_8. Now you try
> to set
> > the bus width to 4-bit which will succeed but bus_width variable is
> not
> > initialize to 4-bit yet.
>=20
> Thanks just missed it.
>=20
> >
> >
> >
> >> +
> >> + =A0 =A0 /* switch to HS200 mode if bus width set successfully */
> >> + =A0 =A0 if (!err) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card->host, bus_width)=
;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET=
_NORMAL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_C=
SD_HS_TIMING, 2, 0);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 return err;
> >> +}
> >> +
> >> +/*
> >> =A0 * Handle the detection and initialisation of a card.
> >> =A0 *
> >> =A0 * In the case of a resume, "oldcard" will contain the card
> >> @@ -905,11 +972,15 @@ static int mmc_init_card(struct mmc_host
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
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hs_max_dtr > 52000000=
) &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 & MMC_CAP2_HS200))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_select_hs200=
(card);
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
> >> @@ -918,8 +989,15 @@ static int mmc_init_card(struct mmc_host *hos=
t,
> >> u32 ocr,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hos=
tname(card->host));
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_highspeed(c=
ard);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->hos=
t, MMC_TIMING_MMC_HS);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hs_ma=
x_dtr > 52000000) &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 & M=
MC_CAP2_HS200)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card=
_set_hs200(card);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_=
timing(card->host,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0MMC_TIMING_MMC_HS200);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card=
_set_highspeed(card);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_=
timing(card->host,
> > MMC_TIMING_MMC_HS);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> =A0 =A0 =A0 }
> >>
> >> @@ -944,7 +1022,7 @@ static int mmc_init_card(struct mmc_host *hos=
t,
> >> u32 ocr,
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
> >> @@ -970,9 +1048,60 @@ static int mmc_init_card(struct mmc_host
> *host,
> >> u32 ocr,
> >> =A0 =A0 =A0 }
> >>
> >> =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0* Indicate HS200 SDR mode (if supported).
> >> + =A0 =A0 =A0*/
> >> + =A0 =A0 if (mmc_card_hs200(card)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 u32 ext_csd_bits;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 u32 bus_width =3D card->host->ios.bus_wi=
dth;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* For devices supporting HS200 mode, =
the bus width
> has
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* to be set before executing the tuni=
ng function. If
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* set before tuning, then device will=
 respond with
> CRC
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* errors for responses on CMD line. S=
o for HS200 the
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* sequence will be
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 1. set bus width 4bit / 8 bit (1 bi=
t not supported)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 2. switch to HS200 mode
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 3. set the clock to > 52Mhz <=3D200=
MHz and
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* 4. execute tuning for HS200
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((host->caps2 & MMC_CAP2_HS200) &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->ops->execute_tuning)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops-=
>execute_tuning(card-
> >host,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 MMC_SEND_TUNING_BLOCK_HS200);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("tuning execu=
tion failed\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ext_csd_bits =3D (bus_width =3D=3D MMC_B=
US_WIDTH_8) ?
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 EXT_CSD_BUS_WIDTH_8 :
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 EXT_CSD_BUS_WIDTH_4;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_select_powerclass(card, ext_=
csd_bits,
> ext_csd);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: power class =
selection to bus
> width"
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%d faile=
d\n", mmc_hostname(card-
> >host),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 << bus_=
width);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.card_type &
> EXT_CSD_CARD_TYPE_SDR_1_2V)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host->caps2 & MMC_CA=
P2_HS200_1_2V_SDR)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_set_signal_v=
oltage(host,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SIGN=
AL_VOLTAGE_120, 0);
> >
> > Shouldn't this voltage switch be done in mmc_select_hs200() before
> selecting
> > the bus width and timings?
>=20
> Will it affect the functionality?. Since it it IO voltage I think it
> can be done here. And I am setting the Host specific timing and
> buswidth again.
> is ur intention to avoid setting timing and buswidth again?

Actually both. execute_tuning should be run with actual I/O voltage in =
which
card is going to run. But here you are first running the execute_tuning=
()
may be at 3.3v/1.8v then changing the I/O voltage which I guess doesn't=
 look
correct.

SD3.01 specification has specifically mentioned that first the I/O volt=
age
switch should happen and then only execute_tuning() should happen. So i=
t's
better to check if the eMMC4.5 spec. also implies this restriction anyw=
here
or not.

>=20
> >
> >
> >
> >
> >
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err=
;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->hos=
t,
> MMC_TIMING_MMC_HS200);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card->=
host, bus_width);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /*
> >> =A0 =A0 =A0 =A0* Activate wide bus and DDR (if supported).
> >> =A0 =A0 =A0 =A0*/
> >> - =A0 =A0 if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
> >> + =A0 =A0 if (!mmc_card_hs200(card) &&
> >> + =A0 =A0 =A0 =A0 (card->csd.mmca_vsn >=3D CSD_SPEC_VER_3) &&
> >> =A0 =A0 =A0 =A0 =A0 (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_=
BIT_DATA)))
> {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 static unsigned ext_csd_bits[][2] =3D =
{
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { EXT_CSD_BUS_WIDTH_8,=
 EXT_CSD_DDR_BUS_WIDTH_8
> },
> >> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> >> index 6f27d35..a775131 100644
> >> --- a/drivers/mmc/core/sd.c
> >> +++ b/drivers/mmc/core/sd.c
> >> @@ -661,7 +661,8 @@ static int mmc_sd_init_uhs_card(struct mmc_car=
d
> >> *card)
> >>
> >> =A0 =A0 =A0 /* SPI mode doesn't define CMD19 */
> >> =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && card->host->ops-
> >> >execute_tuning)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tuning(=
card->host);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tuning(=
card->host,
> =A0 \
> >> +
> > MMC_SEND_TUNING_BLOCK);
> >>
> >> =A0out:
> >> =A0 =A0 =A0 kfree(status);
> >> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> >> index b77f770..bd7bacc 100644
> >> --- a/drivers/mmc/core/sdio.c
> >> +++ b/drivers/mmc/core/sdio.c
> >> @@ -14,6 +14,7 @@
> >>
> >> =A0#include <linux/mmc/host.h>
> >> =A0#include <linux/mmc/card.h>
> >> +#include <linux/mmc/mmc.h>
> >> =A0#include <linux/mmc/sdio.h>
> >> =A0#include <linux/mmc/sdio_func.h>
> >> =A0#include <linux/mmc/sdio_ids.h>
> >> @@ -556,7 +557,8 @@ static int mmc_sdio_init_uhs_card(struct
> mmc_card
> >> *card)
> >>
> >> =A0 =A0 =A0 /* Initialize and start re-tuning timer */
> >> =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && card->host->ops-
> >> >execute_tuning)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tuning(=
card->host);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops->execute_tuning(=
card->host,
> >> +
> > MMC_SEND_TUNING_BLOCK);
> >>
> >> =A0out:
> >>
> >> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> >> index 9478a6b..9f22ba5 100644
> >> --- a/include/linux/mmc/card.h
> >> +++ b/include/linux/mmc/card.h
> >> @@ -216,6 +216,7 @@ struct mmc_card {
> >> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* card is in
> ultra
> >> high speed mode */
> >> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<6) =A0=
 =A0 =A0 =A0 =A0/* card is
> SDXC */
> >> =A0#define MMC_CARD_REMOVED =A0 =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* c=
ard has been
> >> removed */
> >> +#define MMC_STATE_HIGHSPEED_200 =A0 =A0 =A0(1<<8) =A0 =A0 =A0 =A0=
 =A0/* card is in
> >> HS200 mode */
> >> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
> >> =A0#define MMC_QUIRK_LENIENT_FN0 =A0 =A0 =A0 =A0(1<<0) =A0 =A0 =A0=
 =A0 =A0/* allow SDIO
> FN0
> >> writes outside of the VS CCCR range */
> >> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) /* use func-
> >> >cur_blksize */
> >> @@ -374,6 +375,7 @@ static inline void __maybe_unused
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
> >> =A0#define mmc_card_uhs(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->state =
&
> >> MMC_STATE_ULTRAHIGHSPEED)
> >> @@ -384,6 +386,7 @@ static inline void __maybe_unused
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
> >> =A0#define mmc_card_set_uhs(c) ((c)->state |=3D
> MMC_STATE_ULTRAHIGHSPEED)
> >> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> >> index 665548e..2c8cc69 100644
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
> >> @@ -339,13 +340,76 @@ struct _mmc_csd {
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
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_200 =A0 =A0(EXT_CSD_CARD_TYPE_SDR_1=
_8V
> =A0 \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | EXT_CSD_CARD_TYPE_SDR_1_2V)
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_ALL =A0 =A0(EXT_CSD_CARD_TYPE_SDR_2=
00
> =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | EXT_CSD_CARD_TYPE_52
> =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define =A0 =A0 =A0EXT_CSD_CARD_TYPE_SDR_1_2V_ALL
> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_2V =A0 =A0 \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | EXT_CSD_CARD_TYPE_52
> =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define =A0 =A0 =A0EXT_CSD_CARD_TYPE_SDR_1_8V_ALL
> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_8V =A0 =A0 \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | EXT_CSD_CARD_TYPE_52
> =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V
> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_2V =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_DDR_1_8V
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V
> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_8V =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_DDR_1_8V
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V
> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_2V =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_DDR_1_2V
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V
> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_8V =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_DDR_1_2V
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52
> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_2V =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_DDR_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52
> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_8V =A0\
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_DDR_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V
> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_200 =A0 \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_DDR_1_8V
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V
> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_200 =A0 \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_DDR_1_2V
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_26)
> >> +
> >> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52
> (EXT_CSD_CARD_TYPE_SDR_200
> >> \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_DDR_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 | EXT_CSD_CARD_TYPE_52
> > \
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
> EXT_CSD_CARD_TYPE_26)
> >>
> >> =A0#define EXT_CSD_BUS_WIDTH_1 =A00 =A0 =A0 =A0 /* Card is in 1 bi=
t mode */
> >> =A0#define EXT_CSD_BUS_WIDTH_4 =A01 =A0 =A0 =A0 /* Card is in 4 bi=
t mode */
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
