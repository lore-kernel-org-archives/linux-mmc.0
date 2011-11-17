From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH RESEND V4] mmc: core: HS200 mode support for eMMC 4.5
Date: Thu, 17 Nov 2011 17:39:38 +0530
Message-ID: <CAGxe1ZFC5jWmVCA0c-4GvavQ3dm6xtHMc6LhNF=B2s2W6r+8Pg@mail.gmail.com>
References: <1319605188-2909-1-git-send-email-girish.shivananjappa@linaro.org>
	<4EB8EACC.8030205@codeaurora.org>
	<000701cca4ea$d0c5d3b0$72517b10$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <000701cca4ea$d0c5d3b0$72517b10$@org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Sahitya Tummala <stummala@codeaurora.org>, linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 17 November 2011 11:06, Subhash Jadavani <subhashj@codeaurora.org> w=
rote:
> Hi Girish,
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Sahitya Tummala
>> Sent: Tuesday, November 08, 2011 2:10 PM
>> To: Girish K S
>> Cc: linux-mmc@vger.kernel.org; cjb@laptop.org; patches@linaro.org;
>> linux-samsung-soc@vger.kernel.org
>> Subject: Re: [PATCH RESEND V4] mmc: core: HS200 mode support for eMM=
C
>> 4.5
>>
>> Hi Girish,
>>
>> On 10/26/2011 10:29 AM, Girish K S wrote:
>> > This patch adds the support of the HS200 bus speed for eMMC 4.5
>> devices.
>> > The eMMC 4.5 devices have support for 200MHz bus speed.The mmc cor=
e
>> and
>> > host modules have been touched to add support for this module.
>> >
>> > It is necessary to know the card type in the sdhci.c file to add
>> support
>> > for eMMC tuning function. So card.h file is included to import the
>> card
>> > data structure.
>> >
>> > cc: Chris Ball<cjb@laptop.org>
>> > Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
>> > ---
>> > Changes in v4:
>> > =A0 =A0 Rebased onto chris-mmc/mmc-next branch. This patch is
>> successfully
>> > =A0 =A0 applied on commit with id
>> de022ed3fdc14808299b2fa66dbb1ed5ab921912.
>> > Changes in v3:
>> > =A0 =A0 In the previous commits of chris-mmc/mmc-next branch, the =
patch
>> with
>> > =A0 =A0 commit id (c0f22a2c92e357e7cb3988b0b13034d70b7461f9) defin=
es
>> caps2 for
>> > =A0 =A0 more capabilities. This patch version deletes the member
>> ext_caps(created
>> > =A0 =A0 in my earlier patch) from struct mmc_host and reuses alrea=
dy
>> accepted
>> > =A0 =A0 caps2 member.
>> > Changes in v2:
>> > =A0 =A0 Rebased to latest chris-mmc/mmc-next branch. Resolved inde=
ntation
>> > =A0 =A0 problems identified in review. This patch has to be applie=
d
>> before
>> > =A0 =A0 the patch released for modifying the printk messages.
>> > Changes in v1:
>> > =A0 =A0 Case statements in switch that produce same result have
>> > =A0 =A0 been combined to reduce repeated assignments.
>> > =A0 =A0 patch recreated after rebase to chris balls mmc-next branc=
h.
>> >
>> > =A0 drivers/mmc/core/bus.c =A0 =A0| =A0 =A03 +-
>> > =A0 drivers/mmc/core/mmc.c =A0 =A0| =A0 92
>> ++++++++++++++++++++++++++++++++++++++++----
>> > =A0 drivers/mmc/host/sdhci.c =A0| =A0 36 +++++++++++++++---
>> > =A0 include/linux/mmc/card.h =A0| =A0 =A03 +
>> > =A0 include/linux/mmc/host.h =A0| =A0 =A06 +++
>> > =A0 include/linux/mmc/mmc.h =A0 | =A0 =A08 +++-
>> > =A0 include/linux/mmc/sdhci.h | =A0 =A01 +
>> > =A0 7 files changed, 132 insertions(+), 17 deletions(-)
>> >
>> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> > index 46b6e84..2f82f6b 100644
>> > --- a/drivers/mmc/core/bus.c
>> > +++ b/drivers/mmc/core/bus.c
>> > @@ -301,10 +301,11 @@ int mmc_add_card(struct mmc_card *card)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_ddr_mode(card) ? =
"DDR " : "",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type);
>> > =A0 =A0 } else {
>> > - =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s: new %s%s%s card at add=
ress %04x\n",
>> > + =A0 =A0 =A0 =A0 =A0 pr_info("%s: new %s%s%s%s card at address %0=
4x\n",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_sd_card_uhs(card) ? "u=
ltra high speed " :
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_highspeed(card) =
? "high speed " : ""),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_hs200(card) ? "HS2=
00 " : ""),
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_ddr_mode(card) ? =
"DDR " : "",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type, card->rca);
>> > =A0 =A0 }
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index 3627044..4db248c 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -285,6 +285,39 @@ static int mmc_read_ext_csd(struct mmc_card
>> *card, u8 *ext_csd)
>> > =A0 =A0 }
>> > =A0 =A0 card->ext_csd.raw_card_type =3D ext_csd[EXT_CSD_CARD_TYPE]=
;
>> > =A0 =A0 switch (ext_csd[EXT_CSD_CARD_TYPE]& =A0EXT_CSD_CARD_TYPE_M=
ASK) {
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_200 |
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1_8V =
|
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1_2V =
|
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_52 |
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
>> > + =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD_TYP=
E_SDR_200;
>> > + =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V |
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_1_8V=
 |
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_1_2V=
 |
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_52 |
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
>> > + =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD_TYP=
E_SDR_1_2V;
>> > + =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V |
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_1_8V=
 |
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_1_2V=
 |
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_52 |
>> > + =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> > + =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
>> > + =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CARD_TYP=
E_SDR_1_8V;
>> > + =A0 =A0 =A0 =A0 =A0 break;
>> > =A0 =A0 case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
>> > =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_26:
>> > =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 52000000;
>> > @@ -699,6 +732,7 @@ static int mmc_init_card(struct mmc_host *host=
,
>> u32 ocr,
>> > =A0 {
>> > =A0 =A0 struct mmc_card *card;
>> > =A0 =A0 int err, ddr =3D 0;
>> > + =A0 int hs_sdr =3D 0;
>> > =A0 =A0 u32 cid[4];
>> > =A0 =A0 unsigned int max_dtr;
>> > =A0 =A0 u32 rocr;
>> > @@ -890,11 +924,15 @@ static int mmc_init_card(struct mmc_host *ho=
st,
>> u32 ocr,
>> > =A0 =A0 /*
>> > =A0 =A0 =A0* Activate high speed (if supported)
>> > =A0 =A0 =A0*/
>> > - =A0 if ((card->ext_csd.hs_max_dtr !=3D 0)&&
>> > - =A0 =A0 =A0 =A0 =A0 (host->caps& =A0MMC_CAP_MMC_HIGHSPEED)) {
>> > - =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NOR=
MAL,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_H=
S_TIMING, 1,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext=
_csd.generic_cmd6_time);
>> > + =A0 if (card->ext_csd.hs_max_dtr !=3D 0) {
>> > + =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hs_max_dtr> =A052000000)&=
&
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2& =A0MMC_CAP2_HIGHSPEED_=
200))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT=
_CSD_CMD_SET_NORMAL,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0EXT_CSD_HS_TIMING, 2, 0);
>> > + =A0 =A0 =A0 =A0 =A0 else if (host->caps& =A0MMC_CAP_MMC_HIGHSPEE=
D)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT=
_CSD_CMD_SET_NORMAL,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0EXT_CSD_HS_TIMING, 1, 0);
>> > +
>> > =A0 =A0 =A0 =A0 =A0 =A0 if (err&& =A0err !=3D -EBADMSG)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
>> >
>> > @@ -903,7 +941,10 @@ static int mmc_init_card(struct mmc_host *hos=
t,
>> u32 ocr,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostnam=
e(card->host));
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
>> > =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_highspeed(card)=
;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.hs_max_dtr=
> =A052000000)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set=
_hs200(card);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set=
_highspeed(card);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->host,=
 MMC_TIMING_MMC_HS);
>> > =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 }
>> > @@ -929,7 +970,7 @@ static int mmc_init_card(struct mmc_host *host=
,
>> u32 ocr,
>> > =A0 =A0 =A0*/
>> > =A0 =A0 max_dtr =3D (unsigned int)-1;
>> >
>> > - =A0 if (mmc_card_highspeed(card)) {
>> > + =A0 if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 if (max_dtr> =A0card->ext_csd.hs_max_dtr)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_dtr =3D card->ext_csd.=
hs_max_dtr;
>> > =A0 =A0 } else if (max_dtr> =A0card->csd.max_dtr) {
>> > @@ -955,6 +996,22 @@ static int mmc_init_card(struct mmc_host *hos=
t,
>> u32 ocr,
>> > =A0 =A0 }
>> >
>> > =A0 =A0 /*
>> > + =A0 =A0* Indicate HS200 SDR mode (if supported).
>> > + =A0 =A0*/
>> > + =A0 if (mmc_card_hs200(card)) {
>> > + =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.card_type& =A0EXT_CSD_CAR=
D_TYPE_SDR_1_8V)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && =A0((host->caps2& =A0(MMC=
_CAP2_HS200_1_8V_SDR |
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP2_HS200))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D (MMC_=
CAP2_HS200_1_8V_SDR |
> MMC_CAP2_HS200)))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hs_sdr =3D M=
MC_1_8V_SDR_MODE;
>> > + =A0 =A0 =A0 =A0 =A0 else if ((card->ext_csd.card_type&
>> EXT_CSD_CARD_TYPE_SDR_1_2V)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && =A0((host->caps2& =A0(MMC=
_CAP2_HS200_1_2V_SDR |
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP2_HS200))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D (MMC_=
CAP2_HS200_1_2V_SDR |
> MMC_CAP2_HS200)))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hs_sdr =3D M=
MC_1_2V_SDR_MODE;
>> > + =A0 }
>> > +
>> > + =A0 /*
>> > =A0 =A0 =A0* Activate wide bus and DDR (if supported).
>> > =A0 =A0 =A0*/
>> > =A0 =A0 if ((card->csd.mmca_vsn>=3D CSD_SPEC_VER_4)&&
>> > @@ -994,16 +1051,24 @@ static int mmc_init_card(struct mmc_host
>> *host, u32 ocr,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bu=
s_width(card->host, bus_width);
>> >
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->c=
aps2& =A0MMC_CAP2_HS200)&&
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card=
->host->ops->execute_tuning)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 err =3D card->host->ops-> \
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 execute_tuning(card->host);
>> > +
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If co=
ntroller can't handle bus width
> test,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* compa=
re ext_csd previously read in 1 bit
>> mode
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* again=
st ext_csd at new bus width
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(host->=
caps& =A0MMC_CAP_BUS_WIDTH_TEST))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(host->=
caps& =A0MMC_CAP_BUS_WIDTH_TEST)&&
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !err=
)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 err =3D mmc_compare_ext_csds(card,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 bus_width);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (!er=
r)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 err =3D mmc_bus_test(card, bus_width);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 pr_warning("tuning execution
> failed\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > @@ -1052,6 +1117,15 @@ static int mmc_init_card(struct mmc_host
>> *host, u32 ocr,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_ddr_mode(card=
);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->host,=
 MMC_TIMING_UHS_DDR50);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card->ho=
st, bus_width);
>> > + =A0 =A0 =A0 =A0 =A0 } else if (hs_sdr) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hs_sdr =3D=3D EXT_CSD_CA=
RD_TYPE_SDR_1_2V) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_=
set_signal_voltage(host,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 MMC_SIGNAL_VOLTAGE_120, 0);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 goto err;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->host, M=
MC_TIMING_MMC_HS);
>> Can you define a new timing mode for HS200 instead of using the same
>> high speed
>> timing mode MMC_TIMING_MMC_HS? =A0The host driver might need to conf=
igure
>> it's controller with a different timing mode for HS200 cards.
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card->host=
, bus_width);
>> > =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 }
> Any comment on using the new timing mode for HS200?
> Will look into it tomorrow and let you know
> Regards,
> Subhash
>
>> Thanks,
>> Sahitya.
>>
>> --
>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
>> Forum.
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
