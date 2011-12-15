From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V5] mmc: core: HS200 mode support for eMMC 4.5
Date: Thu, 15 Dec 2011 09:15:06 +0530
Message-ID: <CAGxe1ZGyR31diVkqrxEmCmUXgofVOeQDSBtmrj9pfNBQk-5fcw@mail.gmail.com>
References: <1322643228-10320-1-git-send-email-girish.shivananjappa@linaro.org>
	<000301ccb010$6da0c5c0$48e25140$@org>
	<CAGxe1ZH-JQEFksaaLEODVEZL8wsEt6e2tsugRRnYiCXGsiY0+w@mail.gmail.com>
	<000901ccb018$08286330$18792990$@org>
	<CAGxe1ZHZTqzRbgL1Z-KQVarW14sW=dWNy0jN1KdoZEk9zjfMMg@mail.gmail.com>
	<000c01ccb057$8d81d040$a88570c0$@org>
	<CAGxe1ZGwVrCGD0eFTc9448u-=HPSffxN5k1CB-YLqS_QY4+QPw@mail.gmail.com>
	<000001ccb315$7b5bf150$7213d3f0$@org>
	<CAGxe1ZG=2Pq8fcOYqabN4GVpZT3QoiAS-P74Arx+DJT6nk8wCw@mail.gmail.com>
	<000901ccb341$19f0f650$4dd2e2f0$@org>
	<CAKLKtzd_yXeV5_R2EzemS=bzUHZX=cVGQLjBG+=1P_gkPBEwDA@mail.gmail.com>
	<CAGxe1ZGXk8j4R8XOKQgo_cTy5aVSbeuKtPf3UFGiTDX5LJzOpQ@mail.gmail.com>
	<CAGxe1ZHkeAGJXgcb3T7UeniAps2J2cv95x-N_pCkuZT=UpDXYA@mail.gmail.com>
	<CAKLKtzcxTJ5UGaL6abwKWXBve9PvJLLwvYn30g3Mw76xEByupg@mail.gmail.com>
	<000301ccba73$e0924730$a1b6d590$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <000301ccba73$e0924730$a1b6d590$@org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Saugata Das <saugata.das@linaro.org>, linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On 14 December 2011 20:50, Subhash Jadavani <subhashj@codeaurora.org> w=
rote:
> Just a thought (not sure if it's explicitly specified in 4.5 spec or =
not):
> Do we really need to perform bus test in HS200 mode? because in HS200=
, we
> are anyways going to perform the tuning sequence (which achieves what=
 bus
> test command does).
>
you are right. i have removed it in the modified version. It does only
tuning and power class selection

> Regards,
> Subhash
>
>> -----Original Message-----
>> From: Saugata Das [mailto:saugata.das@linaro.org]
>> Sent: Tuesday, December 13, 2011 11:03 AM
>> To: Girish K S
>> Cc: Subhash Jadavani; linux-mmc@vger.kernel.org; patches@linaro.org;
>> linux-samsung-soc@vger.kernel.org; Chris Ball
>> Subject: Re: [PATCH V5] mmc: core: HS200 mode support for eMMC 4.5
>>
>> On 13 December 2011 10:13, Girish K S <girish.shivananjappa@linaro.o=
rg>
>> wrote:
>> > On 12 December 2011 12:20, Girish K S
>> <girish.shivananjappa@linaro.org> wrote:
>> >> On 5 December 2011 20:29, Saugata Das <saugata.das@linaro.org>
>> wrote:
>> >>> Hi Girish
>> >>>
>> >>> Please refer to Figure 71 (HS200 device output timing) of the MM=
C-
>> 4.5
>> >>> spec. It shows that both CMD and DATA[7-0] will have some latenc=
y
>> till
>> >>> valid window. This implies that even the CMD line will need tuni=
ng
>> for
>> >>> reading the response. The specification talks about identifying
>> >>> sampling point for data lines by reading tuning blocks. Based on
>> host
>> >>> controller capability, even the CMD line will get the good sampl=
e
>> >>> point during the same tuning sequence.
>> >>>
>> >>> We need to have the tuning done (execute_tuning) soon after
>> switching
>> >>> to HS200 mode and 200MHz clock.
>> >>>
>> >> If i make a change as per subhash suggestion"set bus width before
>> >> setting the HS200 mode." then it will affect the entire frame wor=
k
>> of
>> >> mmc which is developed as per Annexure A6.1 A.6.2 A.6.3 (mentions
>> the
>> >> steps for bus initialization). can any of you suggest a way to do
>> >> this.
>>
>> Note that, we need to make this modification only for HS200 mode. Fo=
r
>> DDR mode, it is required that we keep the current way (i.e. setting
>> BUS_WIDTH after HS_TIMING).
>>
>> >
>> > Any inputs on this
>> >
>> >>>
>> >>> Regards
>> >>> Saugata
>> >>>
>> >>>
>> >>> On 5 December 2011 16:59, Subhash Jadavani
>> <subhashj@codeaurora.org> wrote:
>> >>>>
>> >>>>
>> >>>>> -----Original Message-----
>> >>>>> From: Girish K S [mailto:girish.shivananjappa@linaro.org]
>> >>>>> Sent: Monday, December 05, 2011 12:20 PM
>> >>>>> To: Subhash Jadavani
>> >>>>> Cc: linux-mmc@vger.kernel.org; patches@linaro.org; linux-samsu=
ng-
>> >>>>> soc@vger.kernel.org; Chris Ball
>> >>>>> Subject: Re: [PATCH V5] mmc: core: HS200 mode support for eMMC
>> 4.5
>> >>>>>
>> >>>>> On 5 December 2011 11:46, Subhash Jadavani
>> <subhashj@codeaurora.org>
>> >>>>> wrote:
>> >>>>> >
>> >>>>> >
>> >>>>> >> -----Original Message-----
>> >>>>> >> From: Girish K S [mailto:girish.shivananjappa@linaro.org]
>> >>>>> >> Sent: Friday, December 02, 2011 5:08 PM
>> >>>>> >> To: Subhash Jadavani
>> >>>>> >> Cc: linux-mmc@vger.kernel.org; patches@linaro.org; linux-
>> samsung-
>> >>>>> >> soc@vger.kernel.org; Chris Ball
>> >>>>> >> Subject: Re: [PATCH V5] mmc: core: HS200 mode support for e=
MMC
>> 4.5
>> >>>>> >>
>> >>>>> >> On 2 December 2011 00:02, Subhash Jadavani
>> <subhashj@codeaurora.org>
>> >>>>> >> wrote:
>> >>>>> >> >
>> >>>>> >> >
>> >>>>> >> >> -----Original Message-----
>> >>>>> >> >> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> >>>>> >> >> owner@vger.kernel.org] On Behalf Of Girish K S
>> >>>>> >> >> Sent: Thursday, December 01, 2011 7:48 PM
>> >>>>> >> >> To: Subhash Jadavani
>> >>>>> >> >> Cc: linux-mmc@vger.kernel.org; patches@linaro.org; linux=
-
>> samsung-
>> >>>>> >> >> soc@vger.kernel.org; Chris Ball
>> >>>>> >> >> Subject: Re: [PATCH V5] mmc: core: HS200 mode support fo=
r
>> eMMC
>> >>>>> 4.5
>> >>>>> >> >>
>> >>>>> >> >> On 1 December 2011 16:27, Subhash Jadavani
>> >>>>> <subhashj@codeaurora.org>
>> >>>>> >> >> wrote:
>> >>>>> >> >> >
>> >>>>> >> >> >
>> >>>>> >> >> >> -----Original Message-----
>> >>>>> >> >> >> From: linux-mmc-owner@vger.kernel.org [mailto:linux-m=
mc-
>> >>>>> >> >> >> owner@vger.kernel.org] On Behalf Of Girish K S
>> >>>>> >> >> >> Sent: Thursday, December 01, 2011 3:58 PM
>> >>>>> >> >> >> To: Subhash Jadavani
>> >>>>> >> >> >> Cc: linux-mmc@vger.kernel.org; patches@linaro.org;
>> linux-
>> >>>>> samsung-
>> >>>>> >> >> >> soc@vger.kernel.org; Chris Ball
>> >>>>> >> >> >> Subject: Re: [PATCH V5] mmc: core: HS200 mode support
>> for eMMC
>> >>>>> >> 4.5
>> >>>>> >> >> >>
>> >>>>> >> >> >> On 1 December 2011 15:33, Subhash Jadavani
>> >>>>> >> <subhashj@codeaurora.org>
>> >>>>> >> >> >> wrote:
>> >>>>> >> >> >> > Hi Girish,
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >> -----Original Message-----
>> >>>>> >> >> >> >> From: linux-mmc-owner@vger.kernel.org [mailto:linu=
x-
>> mmc-
>> >>>>> >> >> >> >> owner@vger.kernel.org] On Behalf Of Girish K S
>> >>>>> >> >> >> >> Sent: Wednesday, November 30, 2011 2:24 PM
>> >>>>> >> >> >> >> To: linux-mmc@vger.kernel.org
>> >>>>> >> >> >> >> Cc: patches@linaro.org; linux-samsung-
>> soc@vger.kernel.org;
>> >>>>> >> >> >> >> subhashj@codeaurora.org; Girish K S; Chris Ball
>> >>>>> >> >> >> >> Subject: [PATCH V5] mmc: core: HS200 mode support =
for
>> eMMC
>> >>>>> 4.5
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> This patch adds the support of the HS200 bus speed
>> for eMMC
>> >>>>> >> 4.5
>> >>>>> >> >> >> >> devices.
>> >>>>> >> >> >> >> The eMMC 4.5 devices have support for 200MHz bus
>> speed.The
>> >>>>> mmc
>> >>>>> >> >> core
>> >>>>> >> >> >> and
>> >>>>> >> >> >> >> host modules have been touched to add support for
>> this
>> >>>>> module.
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> It is necessary to know the card type in the sdhci=
=2Ec
>> file
>> >>>>> to
>> >>>>> >> add
>> >>>>> >> >> >> >> support
>> >>>>> >> >> >> >> for eMMC tuning function. So card.h file is includ=
ed
>> to
>> >>>>> import
>> >>>>> >> >> the
>> >>>>> >> >> >> card
>> >>>>> >> >> >> >> data structure.
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> cc: Chris Ball <cjb@laptop.org>
>> >>>>> >> >> >> >> Signed-off-by: Girish K S
>> <girish.shivananjappa@linaro.org>
>> >>>>> >> >> >> >> ---
>> >>>>> >> >> >> >> Changes in v5:
>> >>>>> >> >> >> >> =A0 =A0 =A0 Reduced the case statements for better=
 code
>> >>>>> readability.
>> >>>>> >> >> >> Removed
>> >>>>> >> >> >> >> =A0 =A0 =A0 unused macro definitions. Modified the=
 tuning
>> >>>>> function
>> >>>>> >> >> >> prototype
>> >>>>> >> >> >> >> =A0 =A0 =A0 and definition to support tuning for b=
oth SD
>> and eMMC
>> >>>>> >> >> cards.
>> >>>>> >> >> >> >> Changes in v4:
>> >>>>> >> >> >> >> =A0 =A0 =A0 Rebased onto chris-mmc/mmc-next branch=
=2E This
>> patch is
>> >>>>> >> >> >> >> successfully
>> >>>>> >> >> >> >> =A0 =A0 =A0 applied on commit with id
>> >>>>> >> >> >> >> de022ed3fdc14808299b2fa66dbb1ed5ab921912.
>> >>>>> >> >> >> >> Changes in v3:
>> >>>>> >> >> >> >> =A0 =A0 =A0 In the previous commits of chris-mmc/m=
mc-next
>> branch,
>> >>>>> >> the
>> >>>>> >> >> >> patch
>> >>>>> >> >> >> >> with
>> >>>>> >> >> >> >> =A0 =A0 =A0 commit id
>> (c0f22a2c92e357e7cb3988b0b13034d70b7461f9)
>> >>>>> >> >> defines
>> >>>>> >> >> >> >> caps2 for
>> >>>>> >> >> >> >> =A0 =A0 =A0 more capabilities. This patch version =
deletes
>> the
>> >>>>> member
>> >>>>> >> >> >> >> ext_caps(created
>> >>>>> >> >> >> >> =A0 =A0 =A0 in my earlier patch) from struct mmc_h=
ost and
>> reuses
>> >>>>> >> >> already
>> >>>>> >> >> >> >> accepted
>> >>>>> >> >> >> >> =A0 =A0 =A0 caps2 member.
>> >>>>> >> >> >> >> Changes in v2:
>> >>>>> >> >> >> >> =A0 =A0 =A0 Rebased to latest chris-mmc/mmc-next b=
ranch.
>> Resolved
>> >>>>> >> >> >> indentation
>> >>>>> >> >> >> >> =A0 =A0 =A0 problems identified in review. This pa=
tch has
>> to be
>> >>>>> >> applied
>> >>>>> >> >> >> >> before
>> >>>>> >> >> >> >> =A0 =A0 =A0 the patch released for modifying the p=
rintk
>> messages.
>> >>>>> >> >> >> >> Changes in v1:
>> >>>>> >> >> >> >> =A0 =A0 =A0 Case statements in switch that produce=
 same
>> result
>> >>>>> have
>> >>>>> >> >> >> >> =A0 =A0 =A0 been combined to reduce repeated assig=
nments.
>> >>>>> >> >> >> >> =A0 =A0 =A0 patch recreated after rebase to chris =
balls
>> mmc-next
>> >>>>> >> >> branch.
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0drivers/mmc/core/bus.c =A0 =A0| =A0 =A03 +-
>> >>>>> >> >> >> >> =A0drivers/mmc/core/mmc.c =A0 =A0| =A0 77
>> >>>>> >> >> >> >> ++++++++++++++++++++++++++++++++++++++++----
>> >>>>> >> >> >> >> =A0drivers/mmc/core/sd.c =A0 =A0 | =A0 =A03 +-
>> >>>>> >> >> >> >> =A0drivers/mmc/core/sdio.c =A0 | =A0 =A04 ++-
>> >>>>> >> >> >> >> =A0drivers/mmc/host/sdhci.c =A0| =A0 38 ++++++++++=
+++++++--
>> ---
>> >>>>> >> >> >> >> =A0include/linux/mmc/card.h =A0| =A0 =A03 ++
>> >>>>> >> >> >> >> =A0include/linux/mmc/host.h =A0| =A0 11 ++++++-
>> >>>>> >> >> >> >> =A0include/linux/mmc/mmc.h =A0 | =A0 66
>> >>>>> >> >> >> >> ++++++++++++++++++++++++++++++++++++++-
>> >>>>> >> >> >> >> =A0include/linux/mmc/sdhci.h | =A0 =A01 +
>> >>>>> >> >> >> >> =A09 files changed, 185 insertions(+), 21 deletion=
s(-)
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> diff --git a/drivers/mmc/core/bus.c
>> >>>>> b/drivers/mmc/core/bus.c
>> >>>>> >> >> >> >> index 5639fdf..83c9f8d 100644
>> >>>>> >> >> >> >> --- a/drivers/mmc/core/bus.c
>> >>>>> >> >> >> >> +++ b/drivers/mmc/core/bus.c
>> >>>>> >> >> >> >> @@ -301,10 +301,11 @@ int mmc_add_card(struct
>> mmc_card
>> >>>>> *card)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ca=
rd_ddr_mode(card) ? "DDR
>> " :
>> >>>>> "",
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type);
>> >>>>> >> >> >> >> =A0 =A0 =A0 } else {
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s: ne=
w %s%s%s card
>> at
>> >>>>> address
>> >>>>> >> >> >> %04x\n",
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: new %s%s%s%=
s card at
>> address
>> >>>>> >> %04x\n",
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ho=
stname(card->host),
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ca=
rd_uhs(card) ? "ultra
>> high
>> >>>>> speed "
>> >>>>> >> :
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_c=
ard_highspeed(card) ?
>> "high
>> >>>>> speed
>> >>>>> >> " :
>> >>>>> >> >> >> ""),
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_car=
d_hs200(card) ? "HS200
>> " :
>> >>>>> ""),
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ca=
rd_ddr_mode(card) ? "DDR
>> " :
>> >>>>> "",
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type, =
card->rca);
>> >>>>> >> >> >> >> =A0 =A0 =A0 }
>> >>>>> >> >> >> >> diff --git a/drivers/mmc/core/mmc.c
>> >>>>> b/drivers/mmc/core/mmc.c
>> >>>>> >> >> >> >> index a1223bd..f4124d6 100644
>> >>>>> >> >> >> >> --- a/drivers/mmc/core/mmc.c
>> >>>>> >> >> >> >> +++ b/drivers/mmc/core/mmc.c
>> >>>>> >> >> >> >> @@ -285,6 +285,27 @@ static int
>> mmc_read_ext_csd(struct
>> >>>>> >> mmc_card
>> >>>>> >> >> >> *card,
>> >>>>> >> >> >> >> u8 *ext_csd)
>> >>>>> >> >> >> >> =A0 =A0 =A0 }
>> >>>>> >> >> >> >> =A0 =A0 =A0 card->ext_csd.raw_card_type =3D
>> >>>>> >> ext_csd[EXT_CSD_CARD_TYPE];
>> >>>>> >> >> >> >> =A0 =A0 =A0 switch (ext_csd[EXT_CSD_CARD_TYPE] &
>> >>>>> >> >> EXT_CSD_CARD_TYPE_MASK) {
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL:
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V:
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V:
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52:
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr=
 =3D 200000000;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =
=3D
>> >>>>> >> >> EXT_CSD_CARD_TYPE_SDR_200;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_ALL:
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V=
:
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V=
:
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52:
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr=
 =3D 200000000;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =
=3D
>> >>>>> >> >> EXT_CSD_CARD_TYPE_SDR_1_2V;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_ALL:
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V=
:
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V=
:
>> >>>>> >> >> >> >> + =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52:
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr=
 =3D 200000000;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =
=3D
>> >>>>> >> >> EXT_CSD_CARD_TYPE_SDR_1_8V;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >>>>> >> >> >> >> =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_DDR_52 |
>> EXT_CSD_CARD_TYPE_52
>> >>>>> |
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_26:
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_d=
tr =3D 52000000;
>> >>>>> >> >> >> >> @@ -699,6 +720,7 @@ static int mmc_init_card(struc=
t
>> >>>>> mmc_host
>> >>>>> >> >> *host,
>> >>>>> >> >> >> u32
>> >>>>> >> >> >> >> ocr,
>> >>>>> >> >> >> >> =A0{
>> >>>>> >> >> >> >> =A0 =A0 =A0 struct mmc_card *card;
>> >>>>> >> >> >> >> =A0 =A0 =A0 int err, ddr =3D 0;
>> >>>>> >> >> >> >> + =A0 =A0 int hs_sdr =3D 0;
>> >>>>> >> >> >> >> =A0 =A0 =A0 u32 cid[4];
>> >>>>> >> >> >> >> =A0 =A0 =A0 unsigned int max_dtr;
>> >>>>> >> >> >> >> =A0 =A0 =A0 u32 rocr;
>> >>>>> >> >> >> >> @@ -894,11 +916,16 @@ static int mmc_init_card(str=
uct
>> >>>>> mmc_host
>> >>>>> >> >> >> *host,
>> >>>>> >> >> >> >> u32 ocr,
>> >>>>> >> >> >> >> =A0 =A0 =A0 /*
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0* Activate high speed (if supported=
)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0*/
>> >>>>> >> >> >> >> - =A0 =A0 if ((card->ext_csd.hs_max_dtr !=3D 0) &&
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 (host->caps & MMC_CAP_MM=
C_HIGHSPEED)) {
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card,
>> >>>>> EXT_CSD_CMD_SET_NORMAL,
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0EXT_CSD_HS_TIMING, 1,
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0card-
>> >>>>> >> >ext_csd.generic_cmd6_time);
>> >>>>> >> >> >> >> + =A0 =A0 if (card->ext_csd.hs_max_dtr !=3D 0) {
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hs_ma=
x_dtr >
>> 52000000) &&
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 & M=
MC_CAP2_HS200))
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D =
mmc_switch(card,
>> >>>>> >> >> EXT_CSD_CMD_SET_NORMAL,
>> >>>>> >> >> >> >> +
>> =A0EXT_CSD_HS_TIMING,
>> >>>>> 2,
>> >>>>> >> 0);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 else if (host->caps &
>> MMC_CAP_MMC_HIGHSPEED)
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D =
mmc_switch(card,
>> >>>>> >> >> EXT_CSD_CMD_SET_NORMAL,
>> >>>>> >> >> >> >> +
>> =A0EXT_CSD_HS_TIMING,
>> >>>>> 1,
>> >>>>> >> 0);
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -E=
BADMSG)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto f=
ree_card;
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> @@ -907,7 +934,11 @@ static int mmc_init_card(stru=
ct
>> >>>>> mmc_host
>> >>>>> >> >> *host,
>> >>>>> >> >> >> >> u32 ocr,
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0mmc_hostname(card-
>> >host));
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D=
 0;
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card=
_set_highspeed(card);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((car=
d->ext_csd.hs_max_dtr >
>> >>>>> >> 52000000)
>> >>>>> >> >> &&
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
(host->caps2 &
>> MMC_CAP2_HS200))
>> >>>>> >> >> >> >> +
>> mmc_card_set_hs200(card);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> >>>>> >> >> >> >> +
>> mmc_card_set_highspeed(card);
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_se=
t_timing(card->host,
>> >>>>> >> >> MMC_TIMING_MMC_HS);
>> >>>>> >> >> >> >
>> >>>>> >> >> >> > MMC_TIMING_MMC_HS200 is defined but still not used.
>> >>>>> >> >> >> >
>> >>>>> >> >> >> > So I guess it should be like this ::
>> >>>>> >> >> >> > =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if =
((card->ext_csd.hs_max_dtr
>> >
>> >>>>> >> 52000000)
>> >>>>> >> >> &&
>> >>>>> >> >> >> > =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(host->caps2 &
>> MMC_CAP2_HS200))
>> >>>>> {
>> >>>>> >> >> >> > =A0+
>> =A0mmc_card_set_hs200(card);
>> >>>>> >> >> >> > =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc=
_set_timing(card->host,
>> >>>>> >> >> >> MMC_TIMING_MMC_HS200)
>> >>>>> >> >> >> > =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} e=
lse {
>> >>>>> >> >> >> > =A0+
>> >>>>> =A0mmc_card_set_highspeed(card);
>> >>>>> >> >> >> > =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0mmc_set_timing(card-
>> >host,
>> >>>>> >> >> >> > MMC_TIMING_MMC_HS)
>> >>>>> >> >> >> > =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >>>>> >> >> >> >> =A0 =A0 =A0 }
>> >>>>> >> >> >> >> @@ -933,7 +964,7 @@ static int mmc_init_card(struc=
t
>> >>>>> mmc_host
>> >>>>> >> >> *host,
>> >>>>> >> >> >> u32
>> >>>>> >> >> >> >> ocr,
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0*/
>> >>>>> >> >> >> >> =A0 =A0 =A0 max_dtr =3D (unsigned int)-1;
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> - =A0 =A0 if (mmc_card_highspeed(card)) {
>> >>>>> >> >> >> >> + =A0 =A0 if (mmc_card_highspeed(card) ||
>> mmc_card_hs200(card))
>> >>>>> {
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_dtr > card->ex=
t_csd.hs_max_dtr)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_dt=
r =3D card-
>> >ext_csd.hs_max_dtr;
>> >>>>> >> >> >> >> =A0 =A0 =A0 } else if (max_dtr > card->csd.max_dtr=
) {
>> >>>>> >> >> >> >> @@ -959,6 +990,18 @@ static int mmc_init_card(stru=
ct
>> >>>>> mmc_host
>> >>>>> >> >> *host,
>> >>>>> >> >> >> >> u32 ocr,
>> >>>>> >> >> >> >> =A0 =A0 =A0 }
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 /*
>> >>>>> >> >> >> >> + =A0 =A0 =A0* Indicate HS200 SDR mode (if support=
ed).
>> >>>>> >> >> >> >> + =A0 =A0 =A0*/
>> >>>>> >> >> >> >> + =A0 =A0 if (mmc_card_hs200(card)) {
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.card_=
type &
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_SDR_1_8V)
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host=
->caps2 &
>> >>>>> >> MMC_CAP2_HS200_1_8V_SDR))
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 hs_sdr =3D
>> MMC_1_8V_SDR_MODE;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 else if ((card->ext_csd.=
card_type &
>> >>>>> >> >> >> >> EXT_CSD_CARD_TYPE_SDR_1_2V)
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host=
->caps2 &
>> >>>>> >> MMC_CAP2_HS200_1_2V_SDR))
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 hs_sdr =3D
>> MMC_1_2V_SDR_MODE;
>> >>>>> >> >> >> >> + =A0 =A0 }
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> + =A0 =A0 /*
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0* Activate wide bus and DDR (if sup=
ported).
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0*/
>> >>>>> >> >> >> >> =A0 =A0 =A0 if ((card->csd.mmca_vsn >=3D CSD_SPEC_=
VER_4) &&
>> >>>>> >> >> >> >> @@ -998,6 +1041,17 @@ static int mmc_init_card(str=
uct
>> >>>>> mmc_host
>> >>>>> >> >> >> *host,
>> >>>>> >> >> >> >> u32 ocr,
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!e=
rr) {
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_set_bus_width(card-
>> >host,
>> >>>>> >> >> >> bus_width);
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if ((host->caps2 &
>> >>>>> >> MMC_CAP2_HS200)
>> >>>>> >> >> &&
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 card->host->ops-
>> >>>>> >> >> >execute_tuning)
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 err =3D card-
>> >host-
>> >>>>> >ops->
>> >>>>> >> \
>> >>>>> >> >> >> >> +
>> >>>>> >> execute_tuning(card-
>> >>>>> >> >> >> >host,
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> > MMC_SEND_TUNING_BLOCK_HS200);
>> >>>>> >> >> >> >
>> >>>>> >> >> >> >
>> >>>>> >> >> >> > execute_tuning should be done right after the timin=
g
>> is
>> >>>>> changed
>> >>>>> >> to
>> >>>>> >> >> >> HS200 and
>> >>>>> >> >> >> > clock rate is changed to 200Mhz. This is not the
>> correct
>> >>>>> >> sequence
>> >>>>> >> >> to
>> >>>>> >> >> >> call
>> >>>>> >> >> >> > the execute_tuning().
>> >>>>> >> >> >> > As told earlier, It is mentioned in the spec that
>> tuning
>> >>>>> should
>> >>>>> >> be
>> >>>>> >> >> >> executed after change of buswidth (mandatory). Also i=
t
>> >>>>> mentions
>> >>>>> >> that
>> >>>>> >> >> >> "The host may invoke the HS200 tuning sequence, by
>> sending
>> >>>>> CMD21
>> >>>>> >> to
>> >>>>> >> >> the
>> >>>>> >> >> >> device". It means that
>> >>>>> >> >> >> =A0after setting the HS200 mode, Changing to freq > 5=
2Mhz
>> and
>> >>>>> >> changing
>> >>>>> >> >> >> the bus width tuning can be executed anytime to ident=
ify
>> the
>> >>>>> >> >> sampling
>> >>>>> >> >> >> point to read.(By anytime i mean before actual block
>> read
>> >>>>> >> >> Operation).
>> >>>>> >> >> >> Can you please point me to the place in the spec wher=
e
>> it
>> >>>>> >> specifies
>> >>>>> >> >> >> tuning should be done immediately after freq change (=
may
>> be i
>> >>>>> >> missed
>> >>>>> >> >> >> to read it).
>> >>>>> >> >> >
>> >>>>> >> >> >
>> >>>>> >> >> > Ok. let me ask you this. Why do we run the
>> execute_tuning()?
>> >>>>> It's
>> >>>>> >> to
>> >>>>> >> >> tune
>> >>>>> >> >> > the sampling clock generator of host controller before
>> you
>> >>>>> start
>> >>>>> >> any
>> >>>>> >> >> read
>> >>>>> >> >> > operation (on command line or data line) from card. If
>> you
>> >>>>> don't
>> >>>>> >> tune
>> >>>>> >> >> the
>> >>>>> >> >> > sampling clock generator before the read operation (af=
ter
>> >>>>> changing
>> >>>>> >> >> the
>> >>>>> >> >> > timing to HS200 and clock rate to 200mhz), you can't b=
e
>> sure
>> >>>>> that
>> >>>>> >> >> read
>> >>>>> >> >> > operation from card will be completed without errors. =
You
>> may
>> >>>>> get
>> >>>>> >> the
>> >>>>> >> >> data /
>> >>>>> >> >> > cmd response CRC errors. At least this will surely fai=
l
>> on our
>> >>>>> MSM
>> >>>>> >> >> SDCC host
>> >>>>> >> >> > controller. That's what we had faced with SD3.0 UHS-I
>> tuning as
>> >>>>> >> well
>> >>>>> >> >> as
>> >>>>> >> >> > mentioned in http://www.spinics.net/lists/linux-arm-
>> >>>>> >> >> msm/msg03867.html.
>> >>>>> >> >
>> >>>>> >> >> > this tuning is done before any read opration for the b=
est
>> bus
>> >>>>> >> width
>> >>>>> >> >> supported.
>> >>>>> >> > Agreed. But can we be sure that "command response" for bu=
s
>> width
>> >>>>> >> change via
>> >>>>> >> > CMD6, will not have any command CRC failures if tuning is
>> not
>> >>>>> done?
>> >>>>> >> All responses are sent on CMD line not on data lines, And
>> sampling
>> >>>>> is
>> >>>>> >> done for Data lines before reading. So command CRC failure
>> doesnt
>> >>>>> >> depend on tuning. If you get error during CMD6 it could be
>> that
>> >>>>> device
>> >>>>> >> cannot support the bus width at the set frequency.
>> >>>>> >
>> >>>>> > I guess it's not the correct assumption here. Sampling point
>> tuning
>> >>>>> is to
>> >>>>> Its Not assumption "Specification says responses are all sent =
on
>> CMD
>> >>>>> only"
>> >>>>
>> >>>>
>> >>>>
>> >>>> Where does it say that tuning is not required for data received=
 on
>> command
>> >>>> line? If the 200Mhz clock can effect the data received on DATA
>> lines then
>> >>>> why it won't affect the data (responses) received on CMD lines?
>> >>>> If you still have doubt, I would suggest to get the clarificati=
on
>> from
>> >>>> JEDEC. =A0From SD3.01 spec, for sure CMD lines also requires tu=
ning.
>> >>>>
>> >>>> "Sampling clock generation" on our host controller also says th=
at
>> tuning is
>> >>>> required for data transfer on both DATA and CMD lines.
>> >>>>
>> >>>> I am not sure what is the issue with doing the tuning immediate=
ly
>> after
>> >>>> changing to bus speed mode to HS200 (changing controller timing=
,
>> changing
>> >>>> clock etc ...)? This is what we are doing it for SD3.0 cards as
>> well.
>> >>>>
>> >>>> Your current implementation is not going to work with all host
>> controllers.
>> >>>>
>> >>>>
>> >>>>
>> >>>>
>> >>>>
>> >>>>
>> >>>>> > tune the sampling point for data received on both CMD and DA=
TA
>> lines
>> >>>>> (not
>> >>>>> > just data lines). I can't find detailed mentioning of this i=
n
>> eMMC4.5
>> >>>>> Pls check the section 6.6.7.1. the 2nd paragraph quotes "which=
 in
>> turn
>> >>>>> uses it to find the
>> >>>>> optimal sampling point for the data lines"
>> >>>>> > (that's the documentation short coming, you can even confirm
>> whether
>> >>>>> tuning
>> >>>>> > procedure is required for CMD line or not from JEDEC) but
>> SD3.01
>> >>>>> > specification does mention this tuning procedure in great
>> details.
>> >>>>> NOTE:
>> >>>>> > eMMC4.5 HS200 mode is mostly inspired from SD3.01 UHS-I bus
>> speed
>> >>>>> modes.
>> >>>>> >
>> >>>>> > Section " 4.2.4.5 Tuning Command" in "SD3.01 - Simplified
>> >>>>> >
>> >>>>>
>> (Part_1_Physical_Layer_Simplified_Specification_Ver_3.01_Final_10051=
8)"
>> >>>>> > specification(can be downloaded from here:
>> >>>>> > https://www.sdcard.org/downloads/pls/), clearly states this:
>> >>>>> >
>> >>>>> > 4.2.4.5 Tuning Command
>> >>>>> > CMD19 is defined for Send Tuning Block Command. R1 type
>> response is
>> >>>>> defined.
>> >>>>> > CMD19 can be
>> >>>>> > executed in transfer state of 1.8V signaling mode while the
>> card is
>> >>>>> > unlocked. The other case, CMD19 is
>> >>>>> > treated as illegal command. Data block, carried by DAT[3:0],
>> contains
>> >>>>> a
>> >>>>> > pattern for tuning sampling
>> >>>>> > position to receive data on the CMD and DAT[3:0] line. The
>> block
>> >>>>> length of
>> >>>>> > CMD19 is fixed and CMD16
>> >>>>> > is not required.
>> >>>>> > I have no idea of the SD spec. I have just seen the eMMC spe=
c
>> and
>> >>>>> above quotes might answer your doubt
>> >>>>> > So before tuning, you may get the Command CRC errors in HS20=
0
>> mode.
>> >>>>> >
>> >>>>> > Regards,
>> >>>>> > Subhash
>> >>>>> >
>> >>>>> >> >
>> >>>>> >> >> ps:Chris need your comment on this
>> >>>>> >> >> >
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (err) {
>> >>>>> >> >> >> >> +
>> pr_warning("tuning
>> >>>>> >> >> execution
>> >>>>> >> >> >> > failed\n");
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 continue;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 }
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /*
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0* If controller can't
>> handle
>> >>>>> >> bus
>> >>>>> >> >> >> width
>> >>>>> >> >> >> > test,
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0* compare ext_csd
>> previously
>> >>>>> >> read
>> >>>>> >> >> in
>> >>>>> >> >> >> 1 bit
>> >>>>> >> >> >> >> mode
>> >>>>> >> >> >> >> @@ -1056,6 +1110,15 @@ static int
>> mmc_init_card(struct
>> >>>>> >> mmc_host
>> >>>>> >> >> >> *host,
>> >>>>> >> >> >> >> u32 ocr,
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ca=
rd_set_ddr_mode(card);
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_se=
t_timing(card->host,
>> >>>>> >> >> >> MMC_TIMING_UHS_DDR50);
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_se=
t_bus_width(card->host,
>> >>>>> >> bus_width);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (hs_sdr) {
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hs_s=
dr =3D=3D
>> >>>>> >> EXT_CSD_CARD_TYPE_SDR_1_2V) {
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 err =3D
>> >>>>> >> mmc_set_signal_voltage(host,
>> >>>>> >> >> >> >> +
>> >>>>> MMC_SIGNAL_VOLTAGE_120,
>> >>>>> >> 0);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (err)
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_=
timing(card->host,
>> >>>>> >> >> MMC_TIMING_MMC_HS);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_=
bus_width(card->host,
>> >>>>> >> bus_width);
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >>>>> >> >> >> >> =A0 =A0 =A0 }
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> diff --git a/drivers/mmc/core/sd.c
>> b/drivers/mmc/core/sd.c
>> >>>>> >> >> >> >> index 1d5a3bd..c1d3ee3 100644
>> >>>>> >> >> >> >> --- a/drivers/mmc/core/sd.c
>> >>>>> >> >> >> >> +++ b/drivers/mmc/core/sd.c
>> >>>>> >> >> >> >> @@ -660,7 +660,8 @@ static int
>> mmc_sd_init_uhs_card(struct
>> >>>>> >> >> mmc_card
>> >>>>> >> >> >> >> *card)
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 /* SPI mode doesn't define CMD19 */
>> >>>>> >> >> >> >> =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && ca=
rd->host-
>> >ops-
>> >>>>> >> >> >> >> >execute_tuning)
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops-
>> >execute_tuning(card-
>> >>>>> >> >host);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops-
>> >execute_tuning(card-
>> >>>>> >> >host,
>> >>>>> >> >> >> =A0 \
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> > MMC_SEND_TUNING_BLOCK);
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0out:
>> >>>>> >> >> >> >> =A0 =A0 =A0 kfree(status);
>> >>>>> >> >> >> >> diff --git a/drivers/mmc/core/sdio.c
>> >>>>> b/drivers/mmc/core/sdio.c
>> >>>>> >> >> >> >> index 8c04f7f..8ef8817 100644
>> >>>>> >> >> >> >> --- a/drivers/mmc/core/sdio.c
>> >>>>> >> >> >> >> +++ b/drivers/mmc/core/sdio.c
>> >>>>> >> >> >> >> @@ -14,6 +14,7 @@
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0#include <linux/mmc/host.h>
>> >>>>> >> >> >> >> =A0#include <linux/mmc/card.h>
>> >>>>> >> >> >> >> +#include <linux/mmc/mmc.h>
>> >>>>> >> >> >> >> =A0#include <linux/mmc/sdio.h>
>> >>>>> >> >> >> >> =A0#include <linux/mmc/sdio_func.h>
>> >>>>> >> >> >> >> =A0#include <linux/mmc/sdio_ids.h>
>> >>>>> >> >> >> >> @@ -556,7 +557,8 @@ static int
>> >>>>> mmc_sdio_init_uhs_card(struct
>> >>>>> >> >> >> mmc_card
>> >>>>> >> >> >> >> *card)
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 /* Initialize and start re-tuning time=
r */
>> >>>>> >> >> >> >> =A0 =A0 =A0 if (!mmc_host_is_spi(card->host) && ca=
rd->host-
>> >ops-
>> >>>>> >> >> >> >> >execute_tuning)
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops-
>> >execute_tuning(card-
>> >>>>> >> >host);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D card->host->ops-
>> >execute_tuning(card-
>> >>>>> >> >host,
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> > MMC_SEND_TUNING_BLOCK);
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0out:
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> diff --git a/drivers/mmc/host/sdhci.c
>> >>>>> >> b/drivers/mmc/host/sdhci.c
>> >>>>> >> >> >> >> index a7c2311..13d74bb 100644
>> >>>>> >> >> >> >> --- a/drivers/mmc/host/sdhci.c
>> >>>>> >> >> >> >> +++ b/drivers/mmc/host/sdhci.c
>> >>>>> >> >> >> >> @@ -49,7 +49,7 @@ static void
>> sdhci_finish_data(struct
>> >>>>> >> sdhci_host
>> >>>>> >> >> >> *);
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0static void sdhci_send_command(struct sdhci_hos=
t *,
>> struct
>> >>>>> >> >> >> mmc_command
>> >>>>> >> >> >> >> *);
>> >>>>> >> >> >> >> =A0static void sdhci_finish_command(struct sdhci_h=
ost
>> *);
>> >>>>> >> >> >> >> -static int sdhci_execute_tuning(struct mmc_host
>> *mmc);
>> >>>>> >> >> >> >> +static int sdhci_execute_tuning(struct mmc_host
>> *mmc, u32
>> >>>>> >> >> opcode);
>> >>>>> >> >> >> >> =A0static void sdhci_tuning_timer(unsigned long da=
ta);
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0#ifdef CONFIG_PM_RUNTIME
>> >>>>> >> >> >> >> @@ -1016,7 +1016,8 @@ static void
>> sdhci_send_command(struct
>> >>>>> >> >> >> sdhci_host
>> >>>>> >> >> >> >> *host, struct mmc_command *cmd)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D SDHCI_CMD_I=
NDEX;
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 /* CMD19 is special in that the Data P=
resent
>> Select
>> >>>>> >> should
>> >>>>> >> >> be
>> >>>>> >> >> >> set
>> >>>>> >> >> >> >> */
>> >>>>> >> >> >> >> - =A0 =A0 if (cmd->data || (cmd->opcode =3D=3D
>> >>>>> MMC_SEND_TUNING_BLOCK))
>> >>>>> >> >> >> >> + =A0 =A0 if (cmd->data || (cmd->opcode =3D=3D
>> >>>>> MMC_SEND_TUNING_BLOCK)
>> >>>>> >> ||
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 (cmd->opcode =3D=3D
>> MMC_SEND_TUNING_BLOCK_HS200))
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D SDHCI_CMD_D=
ATA;
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 sdhci_writew(host, SDHCI_MAKE_CMD(cmd-=
>opcode,
>> >>>>> flags),
>> >>>>> >> >> >> >> SDHCI_COMMAND);
>> >>>>> >> >> >> >> @@ -1287,7 +1288,7 @@ static void
>> sdhci_request(struct
>> >>>>> >> mmc_host
>> >>>>> >> >> >> *mmc,
>> >>>>> >> >> >> >> struct mmc_request *mrq)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags &
>> SDHCI_NEEDS_RETUNING) &&
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(present_stat=
e &
>> (SDHCI_DOING_WRITE |
>> >>>>> >> >> >> >> SDHCI_DOING_READ))) {
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_u=
nlock_irqrestore(&host-
>> >lock,
>> >>>>> >> flags);
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_ex=
ecute_tuning(mmc);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_ex=
ecute_tuning(mmc, mrq-
>> >cmd-
>> >>>>> >> >> >opcode);
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_l=
ock_irqsave(&host->lock,
>> >>>>> flags);
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Res=
tore original mmc_request
>> >>>>> >> structure
>> >>>>> >> >> */
>> >>>>> >> >> >> >> @@ -1673,7 +1674,7 @@ static int
>> >>>>> >> >> >> >> sdhci_start_signal_voltage_switch(struct mmc_host
>> *mmc,
>> >>>>> >> >> >> >> =A0 =A0 =A0 return err;
>> >>>>> >> >> >> >> =A0}
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> -static int sdhci_execute_tuning(struct mmc_host
>> *mmc)
>> >>>>> >> >> >> >> +static int sdhci_execute_tuning(struct mmc_host
>> *mmc, u32
>> >>>>> >> >> opcode)
>> >>>>> >> >> >> >> =A0{
>> >>>>> >> >> >> >> =A0 =A0 =A0 struct sdhci_host *host;
>> >>>>> >> >> >> >> =A0 =A0 =A0 u16 ctrl;
>> >>>>> >> >> >> >> @@ -1694,10 +1695,13 @@ static int
>> >>>>> sdhci_execute_tuning(struct
>> >>>>> >> >> >> mmc_host
>> >>>>> >> >> >> >> *mmc)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0* Host Controller needs tuning only=
 in case of
>> >>>>> SDR104
>> >>>>> >> mode
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0* and for SDR50 mode when Use Tunin=
g for SDR50
>> is
>> >>>>> set
>> >>>>> >> in
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0* Capabilities register.
>> >>>>> >> >> >> >> + =A0 =A0 =A0* If the Host Controller supports the=
 HS200
>> mode
>> >>>>> then
>> >>>>> >> >> tuning
>> >>>>> >> >> >> >> + =A0 =A0 =A0* function has to be executed.
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0*/
>> >>>>> >> >> >> >> =A0 =A0 =A0 if (((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D
>> >>>>> >> SDHCI_CTRL_UHS_SDR104)
>> >>>>> >> >> ||
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 (((ctrl & SDHCI_CTRL_UHS_MASK)=
 =3D=3D
>> >>>>> >> SDHCI_CTRL_UHS_SDR50)
>> >>>>> >> >> &&
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 (host->flags & SDHCI_SDR50_NEEDS=
_TUNING)))
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 (host->flags & SDHCI_SDR50_NEEDS=
_TUNING))
>> ||
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 (host->flags & SDHCI_HS200_NEEDS=
_TUNING))
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_E=
XEC_TUNING;
>> >>>>> >> >> >> >> =A0 =A0 =A0 else {
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->loc=
k);
>> >>>>> >> >> >> >> @@ -1733,7 +1737,7 @@ static int
>> >>>>> sdhci_execute_tuning(struct
>> >>>>> >> >> >> mmc_host
>> >>>>> >> >> >> >> *mmc)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tuning_loop_count=
er && !timeout)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_SEND_=
TUNING_BLOCK;
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D opcode;
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.arg =3D 0;
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.flags =3D MMC_RSP_=
R1 | MMC_CMD_ADTC;
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.retries =3D 0;
>> >>>>> >> >> >> >> @@ -1748,7 +1752,17 @@ static int
>> >>>>> sdhci_execute_tuning(struct
>> >>>>> >> >> >> mmc_host
>> >>>>> >> >> >> >> *mmc)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* block to the Host=
 Controller. So we
>> set
>> >>>>> the
>> >>>>> >> >> block
>> >>>>> >> >> >> size
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to 64 here.
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, SDHCI=
_MAKE_BLKSZ(7,
>> 64),
>> >>>>> >> >> >> >> SDHCI_BLOCK_SIZE);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (cmd.opcode =3D=3D
>> >>>>> MMC_SEND_TUNING_BLOCK_HS200) {
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc-=
>ios.bus_width =3D=3D
>> >>>>> >> MMC_BUS_WIDTH_8)
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 sdhci_writew(host,
>> >>>>> >> >> SDHCI_MAKE_BLKSZ(7,
>> >>>>> >> >> >> 128),
>> >>>>> >> >> >> >> +
>> >>>>> =A0SDHCI_BLOCK_SIZE);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if =
(mmc->ios.bus_width =3D=3D
>> >>>>> >> >> >> MMC_BUS_WIDTH_4)
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 sdhci_writew(host,
>> >>>>> >> >> SDHCI_MAKE_BLKSZ(7,
>> >>>>> >> >> >> 64),
>> >>>>> >> >> >> >> +
>> >>>>> =A0SDHCI_BLOCK_SIZE);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_wr=
itew(host,
>> >>>>> SDHCI_MAKE_BLKSZ(7,
>> >>>>> >> 64),
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0SDHCI_BLOCK_SIZE);
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The tuning block =
is sent by the card
>> to
>> >>>>> the
>> >>>>> >> host
>> >>>>> >> >> >> >> controller.
>> >>>>> >> >> >> >> @@ -2131,12 +2145,14 @@ static void
>> >>>>> >> sdhci_show_adma_error(struct
>> >>>>> >> >> >> >> sdhci_host *host) { }
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0static void sdhci_data_irq(struct sdhci_host *h=
ost,
>> u32
>> >>>>> >> intmask)
>> >>>>> >> >> >> >> =A0{
>> >>>>> >> >> >> >> + =A0 =A0 u32 command;
>> >>>>> >> >> >> >> =A0 =A0 =A0 BUG_ON(intmask =3D=3D 0);
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 /* CMD19 generates _only_ Buffer Read =
Ready
>> interrupt
>> >>>>> */
>> >>>>> >> >> >> >> =A0 =A0 =A0 if (intmask & SDHCI_INT_DATA_AVAIL) {
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 if (SDHCI_GET_CMD(sdhci_=
readw(host,
>> >>>>> >> SDHCI_COMMAND))
>> >>>>> >> >> =3D=3D
>> >>>>> >> >> >> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEND_TUNING_=
BLOCK) {
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 command =3D
>> SDHCI_GET_CMD(sdhci_readw(host,
>> >>>>> >> >> >> SDHCI_COMMAND));
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 if ((command =3D=3D MMC_=
SEND_TUNING_BLOCK)
>> ||
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (command =3D=3D
>> MMC_SEND_TUNING_BLOCK_HS200))
>> >>>>> {
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->=
tuning_done =3D 1;
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_u=
p(&host->buf_ready_int);
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
;
>> >>>>> >> >> >> >> @@ -2741,6 +2757,10 @@ int sdhci_add_host(struct
>> sdhci_host
>> >>>>> >> >> *host)
>> >>>>> >> >> >> >> =A0 =A0 =A0 if (caps[1] & SDHCI_USE_SDR50_TUNING)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D
>> SDHCI_SDR50_NEEDS_TUNING;
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> + =A0 =A0 /* Does the host needs tuning for HS200?=
 */
>> >>>>> >> >> >> >> + =A0 =A0 if (mmc->caps2 & MMC_CAP2_HS200)
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D
>> SDHCI_HS200_NEEDS_TUNING;
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> =A0 =A0 =A0 /* Driver Type(s) (A, C, D) supported =
by the
>> host */
>> >>>>> >> >> >> >> =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_A)
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP=
_DRIVER_TYPE_A;
>> >>>>> >> >> >> >> diff --git a/include/linux/mmc/card.h
>> >>>>> >> b/include/linux/mmc/card.h
>> >>>>> >> >> >> >> index 534974c..e76f649 100644
>> >>>>> >> >> >> >> --- a/include/linux/mmc/card.h
>> >>>>> >> >> >> >> +++ b/include/linux/mmc/card.h
>> >>>>> >> >> >> >> @@ -209,6 +209,7 @@ struct mmc_card {
>> >>>>> >> >> >> >> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4)
>> /*
>> >>>>> card
>> >>>>> >> is
>> >>>>> >> >> in
>> >>>>> >> >> >> high
>> >>>>> >> >> >> >> speed mode */
>> >>>>> >> >> >> >> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5)
>> =A0/*
>> >>>>> card
>> >>>>> >> is
>> >>>>> >> >> in
>> >>>>> >> >> >> ultra
>> >>>>> >> >> >> >> high speed mode */
>> >>>>> >> >> >> >> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1<<6)
>> =A0/*
>> >>>>> card
>> >>>>> >> is
>> >>>>> >> >> >> SDXC */
>> >>>>> >> >> >> >> +#define MMC_STATE_HIGHSPEED_200 =A0 =A0 =A0(1<<7)=
 =A0/* card
>> is in
>> >>>>> >> HS200
>> >>>>> >> >> >> >> mode */
>> >>>>> >> >> >> >> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0qu=
irks; =A0 =A0 =A0 =A0 /* card
>> >>>>> quirks
>> >>>>> >> */
>> >>>>> >> >> >> >> =A0#define MMC_QUIRK_LENIENT_FN0 =A0 =A0 =A0 =A0(1=
<<0)
>> =A0/*
>> >>>>> allow
>> >>>>> >> >> SDIO
>> >>>>> >> >> >> FN0
>> >>>>> >> >> >> >> writes outside of the VS CCCR range */
>> >>>>> >> >> >> >> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) /*=
 use
>> func-
>> >>>>> >> >> >> >> >cur_blksize */
>> >>>>> >> >> >> >> @@ -365,6 +366,7 @@ static inline void __maybe_unu=
sed
>> >>>>> >> >> >> >> remove_quirk(struct mmc_card *card, int data)
>> >>>>> >> >> >> >> =A0#define mmc_card_present(c) =A0((c)->state &
>> >>>>> MMC_STATE_PRESENT)
>> >>>>> >> >> >> >> =A0#define mmc_card_readonly(c) ((c)->state &
>> >>>>> >> MMC_STATE_READONLY)
>> >>>>> >> >> >> >> =A0#define mmc_card_highspeed(c) =A0 =A0 =A0 =A0((=
c)->state &
>> >>>>> >> >> >> MMC_STATE_HIGHSPEED)
>> >>>>> >> >> >> >> +#define mmc_card_hs200(c) =A0 =A0((c)->state &
>> >>>>> >> >> MMC_STATE_HIGHSPEED_200)
>> >>>>> >> >> >> >> =A0#define mmc_card_blockaddr(c) =A0 =A0 =A0 =A0((=
c)->state &
>> >>>>> >> >> >> MMC_STATE_BLOCKADDR)
>> >>>>> >> >> >> >> =A0#define mmc_card_ddr_mode(c) ((c)->state &
>> >>>>> >> >> MMC_STATE_HIGHSPEED_DDR)
>> >>>>> >> >> >> >> =A0#define mmc_card_uhs(c) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0((c)->state &
>> >>>>> >> >> >> >> MMC_STATE_ULTRAHIGHSPEED)
>> >>>>> >> >> >> >> @@ -374,6 +376,7 @@ static inline void __maybe_unu=
sed
>> >>>>> >> >> >> >> remove_quirk(struct mmc_card *card, int data)
>> >>>>> >> >> >> >> =A0#define mmc_card_set_present(c) =A0 =A0 =A0((c)=
->state |=3D
>> >>>>> >> >> >> MMC_STATE_PRESENT)
>> >>>>> >> >> >> >> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D
>> >>>>> >> >> MMC_STATE_READONLY)
>> >>>>> >> >> >> >> =A0#define mmc_card_set_highspeed(c) ((c)->state |=
=3D
>> >>>>> >> >> >> MMC_STATE_HIGHSPEED)
>> >>>>> >> >> >> >> +#define mmc_card_set_hs200(c) =A0 =A0 =A0 =A0((c)=
->state |=3D
>> >>>>> >> >> >> >> MMC_STATE_HIGHSPEED_200)
>> >>>>> >> >> >> >> =A0#define mmc_card_set_blockaddr(c) ((c)->state |=
=3D
>> >>>>> >> >> >> MMC_STATE_BLOCKADDR)
>> >>>>> >> >> >> >> =A0#define mmc_card_set_ddr_mode(c) ((c)->state |=3D
>> >>>>> >> >> >> >> MMC_STATE_HIGHSPEED_DDR)
>> >>>>> >> >> >> >> =A0#define mmc_card_set_uhs(c) ((c)->state |=3D
>> >>>>> >> >> >> MMC_STATE_ULTRAHIGHSPEED)
>> >>>>> >> >> >> >> diff --git a/include/linux/mmc/host.h
>> >>>>> >> b/include/linux/mmc/host.h
>> >>>>> >> >> >> >> index 706f722..5eac57a 100644
>> >>>>> >> >> >> >> --- a/include/linux/mmc/host.h
>> >>>>> >> >> >> >> +++ b/include/linux/mmc/host.h
>> >>>>> >> >> >> >> @@ -50,6 +50,7 @@ struct mmc_ios {
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0#define MMC_TIMING_LEGACY =A0 =A00
>> >>>>> >> >> >> >> =A0#define MMC_TIMING_MMC_HS =A0 =A01
>> >>>>> >> >> >> >> +#define MMC_TIMING_MMC_HS200 2
>> >>>>> >> >> >> >> =A0#define MMC_TIMING_SD_HS =A0 =A0 2
>> >>>>> >> >> >> >> =A0#define MMC_TIMING_UHS_SDR12 MMC_TIMING_LEGACY
>> >>>>> >> >> >> >> =A0#define MMC_TIMING_UHS_SDR25 MMC_TIMING_SD_HS
>> >>>>> >> >> >> >> @@ -60,6 +61,8 @@ struct mmc_ios {
>> >>>>> >> >> >> >> =A0#define MMC_SDR_MODE =A0 =A0 =A0 =A0 0
>> >>>>> >> >> >> >> =A0#define MMC_1_2V_DDR_MODE =A0 =A01
>> >>>>> >> >> >> >> =A0#define MMC_1_8V_DDR_MODE =A0 =A02
>> >>>>> >> >> >> >> +#define MMC_1_2V_SDR_MODE =A0 =A03
>> >>>>> >> >> >> >> +#define MMC_1_8V_SDR_MODE =A0 =A04
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 unsigned char =A0 signal_voltage; =A0 =
=A0 =A0 =A0 /*
>> signalling
>> >>>>> >> >> voltage
>> >>>>> >> >> >> >> (1.8V or 3.3V) */
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> @@ -148,7 +151,9 @@ struct mmc_host_ops {
>> >>>>> >> >> >> >> =A0 =A0 =A0 void =A0 =A0(*init_card)(struct mmc_ho=
st *host,
>> struct
>> >>>>> >> mmc_card
>> >>>>> >> >> >> *card);
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 int =A0 =A0 (*start_signal_voltage_swi=
tch)(struct
>> >>>>> mmc_host
>> >>>>> >> >> *host,
>> >>>>> >> >> >> >> struct mmc_ios *ios);
>> >>>>> >> >> >> >> - =A0 =A0 int =A0 =A0 (*execute_tuning)(struct mmc=
_host
>> *host);
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> + =A0 =A0 /* The tuning command opcode value is di=
fferent
>> for
>> >>>>> SD
>> >>>>> >> and
>> >>>>> >> >> >> eMMC
>> >>>>> >> >> >> >> cards */
>> >>>>> >> >> >> >> + =A0 =A0 int =A0 =A0 (*execute_tuning)(struct mmc=
_host
>> *host, u32
>> >>>>> >> >> opcode);
>> >>>>> >> >> >> >> =A0 =A0 =A0 void =A0 =A0(*enable_preset_value)(str=
uct mmc_host
>> *host,
>> >>>>> >> bool
>> >>>>> >> >> >> enable);
>> >>>>> >> >> >> >> =A0 =A0 =A0 int =A0 =A0 (*select_drive_strength)(u=
nsigned int
>> >>>>> max_dtr,
>> >>>>> >> int
>> >>>>> >> >> >> >> host_drv, int card_drv);
>> >>>>> >> >> >> >> =A0 =A0 =A0 void =A0 =A0(*hw_reset)(struct mmc_hos=
t *host);
>> >>>>> >> >> >> >> @@ -242,6 +247,10 @@ struct mmc_host {
>> >>>>> >> >> >> >> =A0#define MMC_CAP2_CACHE_CTRL =A0(1 << 1) =A0 =A0=
 =A0 =A0/*
>> Allow
>> >>>>> cache
>> >>>>> >> >> control
>> >>>>> >> >> >> */
>> >>>>> >> >> >> >> =A0#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0=
/*
>> Notify
>> >>>>> >> poweroff
>> >>>>> >> >> >> >> supported */
>> >>>>> >> >> >> >> =A0#define MMC_CAP2_NO_MULTI_READ =A0 =A0 =A0 (1 <=
< 3)
>> =A0/*
>> >>>>> >> >> Multiblock
>> >>>>> >> >> >> reads
>> >>>>> >> >> >> >> don't work */
>> >>>>> >> >> >> >> +#define MMC_CAP2_HS200_1_8V_SDR =A0 =A0 =A0(1 << =
4)
>> =A0/*
>> >>>>> can
>> >>>>> >> >> support
>> >>>>> >> >> >> */
>> >>>>> >> >> >> >> +#define MMC_CAP2_HS200_1_2V_SDR =A0 =A0 =A0(1 << =
5)
>> =A0/*
>> >>>>> can
>> >>>>> >> >> support
>> >>>>> >> >> >> */
>> >>>>> >> >> >> >> +#define MMC_CAP2_HS200
>> >>>>> (MMC_CAP2_HS200_1_8V_SDR
>> >>>>> >> |
>> >>>>> >> >> \
>> >>>>> >> >> >> >> +
>> =A0MMC_CAP2_HS200_1_2V_SDR)
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_c=
aps; =A0 =A0 =A0 =A0/*
>> supported
>> >>>>> pm
>> >>>>> >> >> >> features */
>> >>>>> >> >> >> >> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_noti=
fy_type;
>> >>>>> >> >> >> >> diff --git a/include/linux/mmc/mmc.h
>> >>>>> b/include/linux/mmc/mmc.h
>> >>>>> >> >> >> >> index 0e71356..7996272 100644
>> >>>>> >> >> >> >> --- a/include/linux/mmc/mmc.h
>> >>>>> >> >> >> >> +++ b/include/linux/mmc/mmc.h
>> >>>>> >> >> >> >> @@ -51,6 +51,7 @@
>> >>>>> >> >> >> >> =A0#define MMC_READ_SINGLE_BLOCK =A0 =A017 =A0 /* =
adtc [31:0]
>> data
>> >>>>> >> addr
>> >>>>> >> >> R1
>> >>>>> >> >> >> >> */
>> >>>>> >> >> >> >> =A0#define MMC_READ_MULTIPLE_BLOCK =A018 =A0 /* ad=
tc [31:0]
>> data
>> >>>>> >> addr
>> >>>>> >> >> R1
>> >>>>> >> >> >> >> */
>> >>>>> >> >> >> >> =A0#define MMC_SEND_TUNING_BLOCK =A0 =A019 =A0 /* =
adtc
>> >>>>> >> >> =A0R1
>> >>>>> >> >> >> >> */
>> >>>>> >> >> >> >> +#define MMC_SEND_TUNING_BLOCK_HS200 =A021 =A0 =A0=
 =A0/* adtc
>> R1
>> >>>>> =A0*/
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0/* class 3 */
>> >>>>> >> >> >> >> =A0#define MMC_WRITE_DAT_UNTIL_STOP 20 =A0 /* adtc=
 [31:0]
>> data
>> >>>>> >> addr
>> >>>>> >> >> R1
>> >>>>> >> >> >> >> */
>> >>>>> >> >> >> >> @@ -333,13 +334,76 @@ struct _mmc_csd {
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0#define EXT_CSD_CARD_TYPE_26 (1<<0) =A0/* Card =
can run
>> at
>> >>>>> 26MHz
>> >>>>> >> */
>> >>>>> >> >> >> >> =A0#define EXT_CSD_CARD_TYPE_52 (1<<1) =A0/* Card =
can run
>> at
>> >>>>> 52MHz
>> >>>>> >> */
>> >>>>> >> >> >> >> -#define EXT_CSD_CARD_TYPE_MASK =A0 =A0 =A0 0xF =A0=
 =A0 /* Mask
>> out
>> >>>>> >> >> reserved
>> >>>>> >> >> >> bits */
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_MASK =A0 =A0 =A0 0x3F =A0=
 =A0/* Mask
>> out
>> >>>>> >> >> reserved
>> >>>>> >> >> >> bits */
>> >>>>> >> >> >> >> =A0#define EXT_CSD_CARD_TYPE_DDR_1_8V =A0(1<<2) =A0=
 /* Card
>> can
>> >>>>> run
>> >>>>> >> at
>> >>>>> >> >> >> 52MHz
>> >>>>> >> >> >> >> */
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DDR
>> mode
>> >>>>> @1.8V
>> >>>>> >> or
>> >>>>> >> >> 3V
>> >>>>> >> >> >> I/O */
>> >>>>> >> >> >> >> =A0#define EXT_CSD_CARD_TYPE_DDR_1_2V =A0(1<<3) =A0=
 /* Card
>> can
>> >>>>> run
>> >>>>> >> at
>> >>>>> >> >> >> 52MHz
>> >>>>> >> >> >> >> */
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DDR
>> mode
>> >>>>> @1.2V
>> >>>>> >> I/O
>> >>>>> >> >> */
>> >>>>> >> >> >> >> =A0#define EXT_CSD_CARD_TYPE_DDR_52
>> >>>>> >> >> (EXT_CSD_CARD_TYPE_DDR_1_8V
>> >>>>> >> >> >> =A0\
>> >>>>> >> >> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_DDR_1_2V)
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_1_8V =A0 (1<<4) =A0=
/* Card
>> can
>> >>>>> run
>> >>>>> >> at
>> >>>>> >> >> >> >> 200MHz */
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_1_2V =A0 (1<<5) =A0=
/* Card
>> can
>> >>>>> run
>> >>>>> >> at
>> >>>>> >> >> >> >> 200MHz */
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SDR
>> mode
>> >>>>> >> @1.2V
>> >>>>> >> >> I/O
>> >>>>> >> >> >> */
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_200
>> >>>>> >> =A0(EXT_CSD_CARD_TYPE_SDR_1_8V
>> >>>>> >> >> >> =A0 \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_SDR_1_2V)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_ALL
>> >>>>> >> =A0(EXT_CSD_CARD_TYPE_SDR_200
>> >>>>> >> >> >> =A0\
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> =A0\
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define =A0 =A0 =A0EXT_CSD_CARD_TYPE_SDR_1_2V_ALL
>> >>>>> >> >> >> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_2V =A0 =A0 \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> =A0\
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define =A0 =A0 =A0EXT_CSD_CARD_TYPE_SDR_1_8V_ALL
>> >>>>> >> >> >> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_8V =A0 =A0 \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> =A0\
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V
>> >>>>> >> >> >> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_2V =A0\
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_DDR_1_8V
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V
>> >>>>> >> >> >> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_8V =A0\
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_DDR_1_8V
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V
>> >>>>> >> >> >> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_2V =A0\
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_DDR_1_2V
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V
>> >>>>> >> >> >> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_8V =A0\
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_DDR_1_2V
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52
>> >>>>> >> >> >> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_2V =A0\
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_DDR_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52
>> >>>>> >> >> >> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_1_8V =A0\
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_DDR_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V
>> >>>>> >> >> >> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_200 =A0 \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_DDR_1_8V
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V
>> >>>>> >> >> >> >> =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_SDR_200 =A0 \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_DDR_1_2V
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >> +
>> >>>>> >> >> >> >> +#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52
>> >>>>> >> >> >> (EXT_CSD_CARD_TYPE_SDR_200
>> >>>>> >> >> >> >> \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_DDR_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> EXT_CSD_CARD_TYPE_52
>> >>>>> >> >> >> > \
>> >>>>> >> >> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
>> >>>>> >> >> >> EXT_CSD_CARD_TYPE_26)
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0#define EXT_CSD_BUS_WIDTH_1 =A00 =A0 =A0 =A0 /*=
 Card is in 1
>> bit
>> >>>>> mode
>> >>>>> >> */
>> >>>>> >> >> >> >> =A0#define EXT_CSD_BUS_WIDTH_4 =A01 =A0 =A0 =A0 /*=
 Card is in 4
>> bit
>> >>>>> mode
>> >>>>> >> */
>> >>>>> >> >> >> >> diff --git a/include/linux/mmc/sdhci.h
>> >>>>> >> >> b/include/linux/mmc/sdhci.h
>> >>>>> >> >> >> >> index e4b6935..d9a2222 100644
>> >>>>> >> >> >> >> --- a/include/linux/mmc/sdhci.h
>> >>>>> >> >> >> >> +++ b/include/linux/mmc/sdhci.h
>> >>>>> >> >> >> >> @@ -121,6 +121,7 @@ struct sdhci_host {
>> >>>>> >> >> >> >> =A0#define SDHCI_AUTO_CMD23 =A0 =A0 (1<<7) =A0/* A=
uto CMD23
>> support
>> >>>>> */
>> >>>>> >> >> >> >> =A0#define SDHCI_PV_ENABLED =A0 =A0 (1<<8) =A0/* P=
reset value
>> >>>>> enabled
>> >>>>> >> */
>> >>>>> >> >> >> >> =A0#define SDHCI_SDIO_IRQ_ENABLED =A0 =A0 =A0 (1<<=
9) =A0/* SDIO
>> irq
>> >>>>> >> enabled
>> >>>>> >> >> */
>> >>>>> >> >> >> >> +#define SDHCI_HS200_NEEDS_TUNING (1<<10) =A0 =A0 =
/*
>> HS200
>> >>>>> needs
>> >>>>> >> >> tuning
>> >>>>> >> >> >> */
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> =A0 =A0 =A0 unsigned int version; =A0 /* SDHCI spe=
c. version
>> */
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> --
>> >>>>> >> >> >> >> 1.7.1
>> >>>>> >> >> >> >>
>> >>>>> >> >> >> >> --
>> >>>>> >> >> >> >> To unsubscribe from this list: send the line
>> "unsubscribe
>> >>>>> >> linux-
>> >>>>> >> >> mmc"
>> >>>>> >> >> >> in
>> >>>>> >> >> >> >> the body of a message to majordomo@vger.kernel.org
>> >>>>> >> >> >> >> More majordomo info at
>> =A0http://vger.kernel.org/majordomo-
>> >>>>> >> >> info.html
>> >>>>> >> >> >> >
>> >>>>> >> >> >> > --
>> >>>>> >> >> >> > To unsubscribe from this list: send the line
>> "unsubscribe
>> >>>>> >> linux-
>> >>>>> >> >> mmc"
>> >>>>> >> >> >> in
>> >>>>> >> >> >> > the body of a message to majordomo@vger.kernel.org
>> >>>>> >> >> >> > More majordomo info at
>> =A0http://vger.kernel.org/majordomo-
>> >>>>> >> info.html
>> >>>>> >> >> >> >
>> >>>>> >> >> >> --
>> >>>>> >> >> >> To unsubscribe from this list: send the line
>> "unsubscribe
>> >>>>> linux-
>> >>>>> >> mmc"
>> >>>>> >> >> in
>> >>>>> >> >> >> the body of a message to majordomo@vger.kernel.org
>> >>>>> >> >> >> More majordomo info at
>> =A0http://vger.kernel.org/majordomo-
>> >>>>> >> info.html
>> >>>>> >> >> >
>> >>>>> >> >> --
>> >>>>> >> >> To unsubscribe from this list: send the line "unsubscrib=
e
>> linux-
>> >>>>> mmc"
>> >>>>> >> in
>> >>>>> >> >> the body of a message to majordomo@vger.kernel.org
>> >>>>> >> >> More majordomo info at =A0http://vger.kernel.org/majordo=
mo-
>> >>>>> info.html
>> >>>>> >> >
>> >>>>> >
>> >>>>
>> >>>> --
>> >>>> To unsubscribe from this list: send the line "unsubscribe linux=
-
>> mmc" in
>> >>>> the body of a message to majordomo@vger.kernel.org
>> >>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>
