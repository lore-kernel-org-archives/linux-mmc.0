From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 5/5] mmc: add support for HS400 mode of eMMC5.0
Date: Tue, 25 Mar 2014 18:23:48 +0900
Message-ID: <001501cf480b$edb9f160$c92dd420$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006c01cf2a59$aeb38410$0c1a8c30$%jun@samsung.com>
 <003f01cf3f7f$46fb6230$d4f22690$%jun@samsung.com>
 <CAPDyKFryCNh_SL=f9qZnf1L1UeTW2fZvzTFbZ3zv13JV28FM+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18034 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbaCYJX6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Mar 2014 05:23:58 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2Z002ZTJFQ1M60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 25 Mar 2014 18:23:50 +0900 (KST)
In-reply-to: <CAPDyKFryCNh_SL=f9qZnf1L1UeTW2fZvzTFbZ3zv13JV28FM+A@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <chris@printf.net>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Jackey Shen' <jackey.shen@amd.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

Hi Ulf,

On Tue, March 25, 2014, Ulf Hansson wrote:
> On 14 March 2014 13:16, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > This patch adds HS400 mode support for eMMC5.0 device.
> > HS400 mode is high speed DDR interface timing from HS200.
> > Clock frequency is up to 200MHz and only 8-bit bus width is
> > supported. In addition, tuning process of HS200 is required
> > to synchronize the command response on the CMD line because
> > CMD input timing for HS400 mode is the same as HS200 mode.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > Reviewed-by: Jackey Shen <jackey.shen@amd.com>
> > Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
> > Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> > ---
> >  drivers/mmc/core/bus.c     |    1 +
> >  drivers/mmc/core/debugfs.c |    3 +
> >  drivers/mmc/core/mmc.c     |  115 ++++++++++++++++++++++++++++++++=
+++++++++--
> >  include/linux/mmc/card.h   |    1 +
> >  include/linux/mmc/host.h   |   15 +++++-
> >  include/linux/mmc/mmc.h    |    7 ++-
> >  6 files changed, 134 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> > index f37e9d6..d2dbf02 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -349,6 +349,7 @@ int mmc_add_card(struct mmc_card *card)
> >                         mmc_hostname(card->host),
> >                         mmc_card_uhs(card) ? "ultra high speed " :
> >                         (mmc_card_hs(card) ? "high speed " : ""),
> > +                       mmc_card_hs400(card) ? "HS400 " :
> >                         (mmc_card_hs200(card) ? "HS200 " : ""),
> >                         mmc_card_ddr52(card) ? "DDR " : "",
> >                         uhs_bus_speed_mode, type, card->rca);
> > diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.=
c
> > index 1f730db..91eb162 100644
> > --- a/drivers/mmc/core/debugfs.c
> > +++ b/drivers/mmc/core/debugfs.c
> > @@ -141,6 +141,9 @@ static int mmc_ios_show(struct seq_file *s, voi=
d *data)
> >         case MMC_TIMING_MMC_HS200:
> >                 str =3D "mmc HS200";
> >                 break;
> > +       case MMC_TIMING_MMC_HS400:
> > +               str =3D "mmc HS400";
> > +               break;
> >         default:
> >                 str =3D "invalid";
> >                 break;
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 6dd68e6..969d595 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -240,7 +240,7 @@ static int mmc_get_ext_csd(struct mmc_card *car=
d, u8 **new_ext_csd)
> >  static void mmc_select_card_type(struct mmc_card *card)
> >  {
> >         struct mmc_host *host =3D card->host;
> > -       u8 card_type =3D card->ext_csd.raw_card_type & EXT_CSD_CARD=
_TYPE_MASK;
> > +       u8 card_type =3D card->ext_csd.raw_card_type;
> >         u32 caps =3D host->caps, caps2 =3D host->caps2;
> >         unsigned int hs_max_dtr =3D 0, hs200_max_dtr =3D 0;
> >         unsigned int avail_type =3D 0;
> > @@ -281,6 +281,18 @@ static void mmc_select_card_type(struct mmc_ca=
rd *card)
> >                 avail_type |=3D EXT_CSD_CARD_TYPE_HS200_1_2V;
> >         }
> >
> > +       if (caps2 & MMC_CAP2_HS400_1_8V &&
> > +           card_type & EXT_CSD_CARD_TYPE_HS400_1_8V) {
> > +               hs200_max_dtr =3D MMC_HS200_MAX_DTR;
> > +               avail_type |=3D EXT_CSD_CARD_TYPE_HS400_1_8V;
> > +       }
> > +
> > +       if (caps2 & MMC_CAP2_HS400_1_2V &&
> > +           card_type & EXT_CSD_CARD_TYPE_HS400_1_2V) {
> > +               hs200_max_dtr =3D MMC_HS200_MAX_DTR;
> > +               avail_type |=3D EXT_CSD_CARD_TYPE_HS400_1_2V;
> > +       }
> > +
> >         card->ext_csd.hs_max_dtr =3D hs_max_dtr;
> >         card->ext_csd.hs200_max_dtr =3D hs200_max_dtr;
> >         card->mmc_avail_type =3D avail_type;
> > @@ -499,6 +511,8 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd, u8 *ext_csd)
> >                         ext_csd[EXT_CSD_PWR_CL_DDR_52_195];
> >                 card->ext_csd.raw_pwr_cl_ddr_52_360 =3D
> >                         ext_csd[EXT_CSD_PWR_CL_DDR_52_360];
> > +               card->ext_csd.raw_pwr_cl_ddr_200_360 =3D
> > +                       ext_csd[EXT_CSD_PWR_CL_DDR_200_360];
> >         }
> >
> >         if (card->ext_csd.rev >=3D 5) {
> > @@ -665,7 +679,10 @@ static int mmc_compare_ext_csds(struct mmc_car=
d *card, unsigned bus_width)
> >                 (card->ext_csd.raw_pwr_cl_ddr_52_195 =3D=3D
> >                         bw_ext_csd[EXT_CSD_PWR_CL_DDR_52_195]) &&
> >                 (card->ext_csd.raw_pwr_cl_ddr_52_360 =3D=3D
> > -                       bw_ext_csd[EXT_CSD_PWR_CL_DDR_52_360]));
> > +                       bw_ext_csd[EXT_CSD_PWR_CL_DDR_52_360]) &&
> > +               (card->ext_csd.raw_pwr_cl_ddr_200_360 =3D=3D
> > +                       bw_ext_csd[EXT_CSD_PWR_CL_DDR_200_360]));
> > +
> >         if (err)
> >                 err =3D -EINVAL;
> >
> > @@ -776,7 +793,9 @@ static int __mmc_select_powerclass(struct mmc_c=
ard *card,
> >                                 ext_csd->raw_pwr_cl_52_360 :
> >                                 ext_csd->raw_pwr_cl_ddr_52_360;
> >                 else if (host->ios.clock <=3D MMC_HS200_MAX_DTR)
> > -                       pwrclass_val =3D ext_csd->raw_pwr_cl_200_36=
0;
> > +                       pwrclass_val =3D (bus_width =3D=3D EXT_CSD_=
DDR_BUS_WIDTH_8) ?
> > +                               ext_csd->raw_pwr_cl_ddr_200_360 :
> > +                               ext_csd->raw_pwr_cl_200_360;
> >                 break;
> >         default:
> >                 pr_warning("%s: Voltage range not supported "
> > @@ -840,7 +859,8 @@ static void mmc_set_bus_speed(struct mmc_card *=
card)
> >  {
> >         unsigned int max_dtr =3D (unsigned int)-1;
> >
> > -       if (mmc_card_hs200(card) && max_dtr > card->ext_csd.hs200_m=
ax_dtr)
> > +       if ((mmc_card_hs200(card) || mmc_card_hs400(card)) &&
> > +            max_dtr > card->ext_csd.hs200_max_dtr)
> >                 max_dtr =3D card->ext_csd.hs200_max_dtr;
> >         else if (mmc_card_hs(card) && max_dtr > card->ext_csd.hs_ma=
x_dtr)
> >                 max_dtr =3D card->ext_csd.hs_max_dtr;
> > @@ -939,6 +959,28 @@ static int mmc_select_hs(struct mmc_card *card=
)
> >  }
> >
> >  /*
> > + * Revert to the high-speed mode from above speed
> > + */
> > +static int mmc_revert_to_hs(struct mmc_card *card)
> > +{
> > +       /*
> > +        * CMD13, which is used to confirm the completion of timing
> > +        * change, will be issued at higher speed timing condtion
> > +        * rather than high-speed. If device has completed the chan=
ge
> > +        * to high-speed mode, it may not be proper timing to issue
> > +        * command. Low speed supplies better timing margin than hi=
gh
> > +        * speed. Accordingly clock rate & timging should be chagne=
d
> > +        * ahead before actual switch.
>=20
> I have some problem to understand this comment. I guess you are tryin=
g
> to provide the arguments to why it makes sense to perform the revert
> to lower speed mode!?
>=20
> This makes me wonder if this is not part of the spec? Could you try t=
o clarify?
But specification says that "HS_TIMING must be set to =930x1=94 before =
setting BUS_WIDTH for dual data rate operation".
I think this sequence is not graceful.
I also commented why speed mode should be changed to high-speed mode fr=
om HS200 mode in the function-called part.
Because it is not possible to set 8-bit data bus for dual rate on HS200=
 mode, revert to high-speed from HS200 is needed.
If the above-commented point makes it confused, it could be removed.
Please let me know your opinion.

>=20
> > +        */
> > +       mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> > +       mmc_set_bus_speed(card);
> > +
> > +       return mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +                         EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
> > +                         card->ext_csd.generic_cmd6_time);
> > +}
> > +
> > +/*
> >   * Activate wide bus and DDR if supported.
> >   */
> >  static int mmc_select_hs_ddr(struct mmc_card *card)
> > @@ -993,6 +1035,54 @@ static int mmc_select_hs_ddr(struct mmc_card =
*card)
> >         return err;
> >  }
> >
> > +static int mmc_select_hs400(struct mmc_card *card)
> > +{
> > +       struct mmc_host *host =3D card->host;
> > +       int err =3D 0;
> > +
> > +       /*
> > +        * The bus width is set to only 8 DDR in HS400 mode
>=20
> Please rephrase the comment to something like:
> "HS400 mode requires 8-bit bus width."
As it is, it was from spec's description.
But I think yours would be more clearable.

>=20
> > +        */
> > +       if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
> > +             host->ios.bus_width =3D=3D MMC_BUS_WIDTH_8))
> > +               return 0;
> > +
> > +       /*
> > +        * Before setting BUS_WIDTH for dual data rate operation,
> > +        * HS_TIMING must be set to High Speed(0x1)
> > +        */
>=20
> Please rephrase comment:
>=20
> "Before switching to dual data rate operation for HS400, we need
> revert from HS200 timing to regular HS timing."
Ok.

>=20
> > +       err =3D mmc_revert_to_hs(card);
>=20
> I don't think we need a separate function to handle the revert.
> Please, just add the code here instead. While you do that, I suppose
> we should combine the comment in that function into one comment here.
OK, I don't oppose that.

>=20
> > +       if (err) {
> > +               pr_warn("%s: switch to high-speed from hs200 failed=
, err:%d\n",
> > +                       mmc_hostname(host), err);
> > +               return err;
> > +       }
> > +
> > +       err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +                        EXT_CSD_BUS_WIDTH,
> > +                        EXT_CSD_DDR_BUS_WIDTH_8,
> > +                        card->ext_csd.generic_cmd6_time);
> > +       if (err) {
> > +               pr_warn("%s: switch to bus width for hs400 failed, =
err:%d\n",
> > +                       mmc_hostname(host), err);
> > +               return err;
> > +       }
> > +
> > +       err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +                        EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS400,
> > +                        card->ext_csd.generic_cmd6_time);
> > +       if (err) {
> > +               pr_warn("%s: switch to hs400 failed, err:%d\n",
> > +                        mmc_hostname(host), err);
> > +               return err;
> > +       }
> > +
> > +       mmc_set_timing(host, MMC_TIMING_MMC_HS400);
> > +       mmc_set_bus_speed(card);
> > +
> > +       return 0;
> > +}
> > +
> >  /*
> >   * For device supporting HS200 mode, the following sequence
> >   * should be done before executing the tuning process.
> > @@ -1025,7 +1115,16 @@ static int mmc_select_hs200(struct mmc_card =
*card)
> >                                    EXT_CSD_HS_TIMING, EXT_CSD_TIMIN=
G_HS200,
> >                                    card->ext_csd.generic_cmd6_time,
> >                                    true, true, true);
> > -               if (!err)
> > +               if (err)
> > +                       goto err;
> > +
> > +               if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400)
> > +                       /*
> > +                        * Timing should be adjusted to the HS400 t=
arget
> > +                        * operation frequency for tuning process
> > +                        */
> > +                       mmc_set_timing(host, MMC_TIMING_MMC_HS400_T=
UNING);
>=20
> This seems strange. Do we really need a separate
> MMC_TIMING_MMC_HS400_TUNING value?
Spec. describes the HS400 selection sequence like below.
<Quot>
=2E..
6) Perform the Tuning Process at the HS400 target operating frequency
(Note: tuning process in HS200 mode is required to synchronize the comm=
and response on the CMD line to CLK for HS400 operation).
=2E..
</Quot>
That means target clock rate for tuning sequence can be different with =
HS200.
Considering for that, it needs to distinguish.

>=20
> > +               else
> >                         mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> >         }
> >  err:
> > @@ -1070,7 +1169,7 @@ bus_speed:
> >
> >  /*
> >   * Execute tuning sequence to seek the proper bus operating
> > - * conditions for HS200, which sends CMD21 to the device.
> > + * conditions for HS200 and HS400, which sends CMD21 to the device=
=2E
> >   */
> >  static int mmc_hs200_tuning(struct mmc_card *card)
> >  {
> > @@ -1304,6 +1403,10 @@ static int mmc_init_card(struct mmc_host *ho=
st, u32 ocr,
> >                 err =3D mmc_hs200_tuning(card);
> >                 if (err)
> >                         goto err;
> > +
> > +               err =3D mmc_select_hs400(card);
> > +               if (err)
> > +                       goto err;
> >         } else if (mmc_card_hs(card)) {
> >                 /* Select the desired bus width optionally */
> >                 err =3D mmc_select_bus_width(card);
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index def6814..2b24c36 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -110,6 +110,7 @@ struct mmc_ext_csd {
> >         u8                      raw_pwr_cl_200_360;     /* 237 */
> >         u8                      raw_pwr_cl_ddr_52_195;  /* 238 */
> >         u8                      raw_pwr_cl_ddr_52_360;  /* 239 */
> > +       u8                      raw_pwr_cl_ddr_200_360; /* 253 */
> >         u8                      raw_bkops_status;       /* 246 */
> >         u8                      raw_sectors[4];         /* 212 - 4 =
bytes */
> >
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 1ee3c10..cc716e4 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -61,6 +61,8 @@ struct mmc_ios {
> >  #define MMC_TIMING_UHS_DDR50   7
> >  #define MMC_TIMING_MMC_DDR52   8
> >  #define MMC_TIMING_MMC_HS200   9
> > +#define MMC_TIMING_MMC_HS400   10
> > +#define MMC_TIMING_MMC_HS400_TUNING 11
>=20
> MMC_TIMING_MMC_HS400_TUNING ?
>=20
> >
> >         unsigned char   signal_voltage;         /* signalling volta=
ge (1.8V or 3.3V) */
> >
> > @@ -274,6 +276,10 @@ struct mmc_host {
> >  #define MMC_CAP2_PACKED_CMD    (MMC_CAP2_PACKED_RD | \
> >                                  MMC_CAP2_PACKED_WR)
> >  #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)  /* Don't power up b=
efore scan */
> > +#define MMC_CAP2_HS400_1_8V    (1 << 15)       /* Can support HS40=
0 1.8V */
> > +#define MMC_CAP2_HS400_1_2V    (1 << 16)       /* Can support HS40=
0 1.2V */
> > +#define MMC_CAP2_HS400         (MMC_CAP2_HS400_1_8V | \
> > +                                MMC_CAP2_HS400_1_2V)
> >
> >         mmc_pm_flag_t           pm_caps;        /* supported pm fea=
tures */
> >
> > @@ -486,11 +492,18 @@ static inline int mmc_card_uhs(struct mmc_car=
d *card)
> >
> >  static inline bool mmc_card_hs200(struct mmc_card *card)
> >  {
> > -       return card->host->ios.timing =3D=3D MMC_TIMING_MMC_HS200;
> > +       return card->host->ios.timing =3D=3D MMC_TIMING_MMC_HS200 |=
|
> > +               card->host->ios.timing =3D=3D MMC_TIMING_MMC_HS400_=
TUNING;
>=20
> MMC_TIMING_MMC_HS400_TUNING ?
It also indicates that card is currently in HS200 mode with the result =
of setting HS_TIMING'.

Thanks,
Seungwon Jeon

>=20
> >  }
> >
> >  static inline bool mmc_card_ddr52(struct mmc_card *card)
> >  {
> >         return card->host->ios.timing =3D=3D MMC_TIMING_MMC_DDR52;
> >  }
> > +
> > +static inline bool mmc_card_hs400(struct mmc_card *card)
> > +{
> > +       return card->host->ios.timing =3D=3D MMC_TIMING_MMC_HS400;
> > +}
> > +
> >  #endif /* LINUX_MMC_HOST_H */
> > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> > index f429f13..64ec963 100644
> > --- a/include/linux/mmc/mmc.h
> > +++ b/include/linux/mmc/mmc.h
> > @@ -325,6 +325,7 @@ struct _mmc_csd {
> >  #define EXT_CSD_POWER_OFF_LONG_TIME    247     /* RO */
> >  #define EXT_CSD_GENERIC_CMD6_TIME      248     /* RO */
> >  #define EXT_CSD_CACHE_SIZE             249     /* RO, 4 bytes */
> > +#define EXT_CSD_PWR_CL_DDR_200_360     253     /* RO */
> >  #define EXT_CSD_TAG_UNIT_SIZE          498     /* RO */
> >  #define EXT_CSD_DATA_TAG_SUPPORT       499     /* RO */
> >  #define EXT_CSD_MAX_PACKED_WRITES      500     /* RO */
> > @@ -354,7 +355,6 @@ struct _mmc_csd {
> >  #define EXT_CSD_CMD_SET_SECURE         (1<<1)
> >  #define EXT_CSD_CMD_SET_CPSECURE       (1<<2)
> >
> > -#define EXT_CSD_CARD_TYPE_MASK 0x3F    /* Mask out reserved bits *=
/
> >  #define EXT_CSD_CARD_TYPE_HS_26        (1<<0)  /* Card can run at =
26MHz */
> >  #define EXT_CSD_CARD_TYPE_HS_52        (1<<1)  /* Card can run at =
52MHz */
> >  #define EXT_CSD_CARD_TYPE_HS   (EXT_CSD_CARD_TYPE_HS_26 | \
> > @@ -370,6 +370,10 @@ struct _mmc_csd {
> >                                                 /* SDR mode @1.2V I=
/O */
> >  #define EXT_CSD_CARD_TYPE_HS200                (EXT_CSD_CARD_TYPE_=
HS200_1_8V | \
> >                                          EXT_CSD_CARD_TYPE_HS200_1_=
2V)
> > +#define EXT_CSD_CARD_TYPE_HS400_1_8V   (1<<6)  /* Card can run at =
200MHz DDR, 1.8V */
> > +#define EXT_CSD_CARD_TYPE_HS400_1_2V   (1<<7)  /* Card can run at =
200MHz DDR, 1.2V */
> > +#define EXT_CSD_CARD_TYPE_HS400                (EXT_CSD_CARD_TYPE_=
HS400_1_8V | \
> > +                                        EXT_CSD_CARD_TYPE_HS400_1_=
2V)
> >
> >  #define EXT_CSD_BUS_WIDTH_1    0       /* Card is in 1 bit mode */
> >  #define EXT_CSD_BUS_WIDTH_4    1       /* Card is in 4 bit mode */
> > @@ -380,6 +384,7 @@ struct _mmc_csd {
> >  #define EXT_CSD_TIMING_BC      0       /* Backwards compatility */
> >  #define EXT_CSD_TIMING_HS      1       /* High speed */
> >  #define EXT_CSD_TIMING_HS200   2       /* HS200 */
> > +#define EXT_CSD_TIMING_HS400   3       /* HS400 */
> >
> >  #define EXT_CSD_SEC_ER_EN      BIT(0)
> >  #define EXT_CSD_SEC_BD_BLK_EN  BIT(2)
> > --
> > 1.7.0.4
> >
> >
>=20
> Kind regards
> Ulf Hansson
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

