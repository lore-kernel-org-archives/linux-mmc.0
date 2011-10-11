From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V4] mmc: core: HS200 mode support for eMMC 4.5
Date: Tue, 11 Oct 2011 11:19:21 +0530
Message-ID: <CAGxe1ZFSbgYJO5FwQLvD3S+mprLFCuT8Cy52S5XgV+D235brug@mail.gmail.com>
References: <1317738095-17324-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1317738095-17324-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 4 October 2011 19:51, Girish K S <girish.shivananjappa@linaro.org> w=
rote:
> This patch adds the support of the HS200 bus speed for
> eMMC 4.5 devices.
> The eMMC 4.5 devices have support for 200MHz bus speed.
> The mmc core and host modules have been touched to add support
> for this module.
> It is necessary to know the card type in the sdhci.c file to
> add support for eMMC tuning function. So card.h file is included
> to import the card data structure.
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> Changes in v1:
> =A0 =A0 =A0 =A0Case statements in switch that produce same result hav=
e
> =A0 =A0 =A0 =A0been combined to reduce repeated assignments.
> =A0 =A0 =A0 =A0patch recreated after rebase to chris balls mmc-next b=
ranch.
> Changes in v2:
> =A0 =A0 =A0 =A0Rebased to latest chris-mmc/mmc-next branch. Resolved =
indentation
> =A0 =A0 =A0 =A0problems identified in review. This patch has to be ap=
plied before
> =A0 =A0 =A0 =A0the patch released for modifying the printk messages.
> Changes in v3:
> =A0 =A0 =A0 =A0In the previous commits of chris-mmc/mmc-next branch, =
the patch with
> =A0 =A0 =A0 =A0commit id (c0f22a2c92e357e7cb3988b0b13034d70b7461f9) d=
efines caps2 for
> =A0 =A0 =A0 =A0more capabilities. This patch version deletes the memb=
er ext_caps(created
> =A0 =A0 =A0 =A0in my earlier patch) from struct mmc_host and reuses a=
lready accepted
> =A0 =A0 =A0 =A0caps2 member.
> Changes in v4:
> =A0 =A0 =A0 =A0This patch is based on commit id d762b9bedaa1a5c720ecb=
4d56ba41f8cfc10d8e7
> =A0 =A0 =A0 =A0of Jaehoon Chung's repository at
> =A0 =A0 =A0 =A0git://git.infradead.org/users/kmpark/linux-2.6-samsung=
 emmc4.5
> =A0drivers/mmc/core/bus.c =A0 =A0| =A0 =A03 +-
> =A0drivers/mmc/core/mmc.c =A0 =A0| =A0 92 +++++++++++++++++++++++++++=
+++++++++++++----
> =A0drivers/mmc/host/sdhci.c =A0| =A0 36 +++++++++++++++---
> =A0include/linux/mmc/card.h =A0| =A0 =A03 +
> =A0include/linux/mmc/host.h =A0| =A0 =A06 +++
> =A0include/linux/mmc/mmc.h =A0 | =A0 =A08 +++-
> =A0include/linux/mmc/sdhci.h | =A0 =A01 +
> =A07 files changed, 132 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 393d817..a0aa7ab 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -301,10 +301,11 @@ int mmc_add_card(struct mmc_card *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_ddr_mode(card=
) ? "DDR " : "",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s: new %s%s%s card a=
t address %04x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_INFO "%s: new %s%s%s%s card=
 at address %04x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->hos=
t),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_sd_card_uhs(card) =
? "ultra high speed " :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(mmc_card_highspeed(ca=
rd) ? "high speed " : ""),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_hs200(card) ?=
 "HS200 " : ""),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_ddr_mode(card=
) ? "DDR " : "",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type, card->rca);
> =A0 =A0 =A0 =A0}
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 297bbff..36aa662 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -283,6 +283,39 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0card->ext_csd.raw_card_type =3D ext_csd[EXT_CSD_CARD_T=
YPE];
> =A0 =A0 =A0 =A0switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE=
_MASK) {
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_200 |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_=
1_8V |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_=
1_2V |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_=
52 |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CAR=
D_TYPE_SDR_200;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR=
_1_8V |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR=
_1_2V |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR=
_52 |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CAR=
D_TYPE_SDR_1_2V;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR=
_1_8V |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR=
_1_2V |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR=
_52 |
> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 200000000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CAR=
D_TYPE_SDR_1_8V;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
> =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_CARD_TYPE_26:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.hs_max_dtr =3D 52000000;
> @@ -657,6 +690,7 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0{
> =A0 =A0 =A0 =A0struct mmc_card *card;
> =A0 =A0 =A0 =A0int err, ddr =3D 0;
> + =A0 =A0 =A0 int hs_sdr =3D 0;
> =A0 =A0 =A0 =A0u32 cid[4];
> =A0 =A0 =A0 =A0unsigned int max_dtr;
> =A0 =A0 =A0 =A0u32 rocr;
> @@ -848,11 +882,15 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Activate high speed (if supported)
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if ((card->ext_csd.hs_max_dtr !=3D 0) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps & MMC_CAP_MMC_HIGHSPEED)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_=
CSD_HS_TIMING, 1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card=
->ext_csd.generic_cmd6_time);
> + =A0 =A0 =A0 if (card->ext_csd.hs_max_dtr !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hs_max_dtr > 5200000=
0) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 & MMC_CAP2_HIGHSPE=
ED_200))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card=
, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0EXT_CSD_HS_TIMING, 2, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (host->caps & MMC_CAP_MMC_HIGHS=
PEED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card=
, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0EXT_CSD_HS_TIMING, 1, 0);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err && err !=3D -EBADMSG)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
>
> @@ -861,7 +899,10 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostn=
ame(card->host));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_highspeed(=
card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.hs_ma=
x_dtr > 52000000)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_car=
d_set_hs200(card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_car=
d_set_highspeed(card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_set_timing(card->h=
ost, MMC_TIMING_MMC_HS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> @@ -888,7 +929,7 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0max_dtr =3D (unsigned int)-1;
>
> - =A0 =A0 =A0 if (mmc_card_highspeed(card)) {
> + =A0 =A0 =A0 if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (max_dtr > card->ext_csd.hs_max_dtr=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_dtr =3D card->ext_=
csd.hs_max_dtr;
> =A0 =A0 =A0 =A0} else if (max_dtr > card->csd.max_dtr) {
> @@ -914,6 +955,22 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* Indicate HS200 SDR mode (if supported).
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (mmc_card_hs200(card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.card_type & EXT_CSD_=
CARD_TYPE_SDR_1_8V)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && ((host->caps2 & (MMC=
_CAP2_HS200_1_8V_SDR |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP2_HS2=
00))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D =
(MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS200)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hs_sdr =
=3D MMC_1_8V_SDR_MODE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if ((card->ext_csd.card_type & EXT=
_CSD_CARD_TYPE_SDR_1_2V)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& ((host->caps2 & (=
MMC_CAP2_HS200_1_2V_SDR |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP2_HS=
200))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D =
(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS200)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hs_sdr =
=3D MMC_1_2V_SDR_MODE;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Activate wide bus and DDR (if supported).
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
> @@ -953,16 +1010,24 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_se=
t_bus_width(card->host, bus_width);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ho=
st->caps2 & MMC_CAP2_HS200) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 card->host->ops->execute_tuning)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 err =3D card->host->ops-> \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 execute_tuning(card->host);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * If =
controller can't handle bus width test,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * com=
pare ext_csd previously read in 1 bit mode
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * aga=
inst ext_csd at new bus width
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(h=
ost->caps & MMC_CAP_BUS_WIDTH_TEST))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(h=
ost->caps & MMC_CAP_BUS_WIDTH_TEST) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 !err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0err =3D mmc_compare_ext_csds(card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0bus_width);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if=
 (!err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0err =3D mmc_bus_test(card, bus_width);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pr_warning("tuning execution failed\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!e=
rr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -1011,6 +1076,15 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_set_ddr_mode(=
card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_set_timing(card->h=
ost, MMC_TIMING_UHS_DDR50);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_set_bus_width(card=
->host, bus_width);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (hs_sdr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hs_sdr =3D=3D EXT_C=
SD_CARD_TYPE_SDR_1_2V) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D=
 mmc_set_signal_voltage(host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 MMC_SIGNAL_VOLTAGE_120, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->ho=
st, MMC_TIMING_MMC_HS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card-=
>host, bus_width);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1a06dd4..1bb4989 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -25,6 +25,7 @@
>
> =A0#include <linux/mmc/mmc.h>
> =A0#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
>
> =A0#include "sdhci.h"
>
> @@ -993,7 +994,8 @@ static void sdhci_send_command(struct sdhci_host =
*host, struct mmc_command *cmd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flags |=3D SDHCI_CMD_INDEX;
>
> =A0 =A0 =A0 =A0/* CMD19 is special in that the Data Present Select sh=
ould be set */
> - =A0 =A0 =A0 if (cmd->data || (cmd->opcode =3D=3D MMC_SEND_TUNING_BL=
OCK))
> + =A0 =A0 =A0 if (cmd->data || (cmd->opcode =3D=3D MMC_SEND_TUNING_BL=
OCK) ||
> + =A0 =A0 =A0 =A0 =A0 (cmd->opcode =3D=3D MMC_SEND_TUNING_BLOCK_HS200=
))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flags |=3D SDHCI_CMD_DATA;
>
> =A0 =A0 =A0 =A0sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),=
 SDHCI_COMMAND);
> @@ -1623,10 +1625,13 @@ static int sdhci_execute_tuning(struct mmc_ho=
st *mmc)
> =A0 =A0 =A0 =A0 * Host Controller needs tuning only in case of SDR104=
 mode
> =A0 =A0 =A0 =A0 * and for SDR50 mode when Use Tuning for SDR50 is set=
 in
> =A0 =A0 =A0 =A0 * Capabilities register.
> + =A0 =A0 =A0 =A0* If the Host Controller supports the HS200 mode the=
n tuning
> + =A0 =A0 =A0 =A0* function has to be executed.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D SDHCI_CTRL_UH=
S_SDR104) ||
> =A0 =A0 =A0 =A0 =A0 =A0(((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D SDHCI_CT=
RL_UHS_SDR50) &&
> - =A0 =A0 =A0 =A0 =A0 (host->flags & SDHCI_SDR50_NEEDS_TUNING)))
> + =A0 =A0 =A0 =A0 =A0 (host->flags & SDHCI_SDR50_NEEDS_TUNING)) ||
> + =A0 =A0 =A0 =A0 =A0 (host->flags & SDHCI_HS200_NEEDS_TUNING))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_EXEC_TUNING;
> =A0 =A0 =A0 =A0else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&host->lock);
> @@ -1661,7 +1666,10 @@ static int sdhci_execute_tuning(struct mmc_hos=
t *mmc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!tuning_loop_counter && !timeout)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_SEND_TUNING_BLOCK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->card->type =3D=3D MMC_TYPE_MMC=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_SEND=
_TUNING_BLOCK_HS200;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_SEND=
_TUNING_BLOCK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd.arg =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADT=
C;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd.retries =3D 0;
> @@ -1676,7 +1684,17 @@ static int sdhci_execute_tuning(struct mmc_hos=
t *mmc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * block to the Host Controller. So we=
 set the block size
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * to 64 here.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, =
64), SDHCI_BLOCK_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->card->type =3D=3D MMC_TYPE_MMC=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->ios.bus_width =
=3D=3D MMC_BUS_WIDTH_8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_w=
ritew(host, SDHCI_MAKE_BLKSZ(7, 128),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0SDHCI_BLOCK_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (mmc->ios.bus_w=
idth =3D=3D MMC_BUS_WIDTH_4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_w=
ritew(host, SDHCI_MAKE_BLKSZ(7, 64),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0SDHCI_BLOCK_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, SDHC=
I_MAKE_BLKSZ(7, 64),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0SDHCI_BLOCK_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * The tuning block is sent by the car=
d to the host controller.
> @@ -2047,12 +2065,14 @@ static void sdhci_show_adma_error(struct sdhc=
i_host *host) { }
>
> =A0static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
> =A0{
> + =A0 =A0 =A0 u32 command;
> =A0 =A0 =A0 =A0BUG_ON(intmask =3D=3D 0);
>
> =A0 =A0 =A0 =A0/* CMD19 generates _only_ Buffer Read Ready interrupt =
*/
> =A0 =A0 =A0 =A0if (intmask & SDHCI_INT_DATA_AVAIL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (SDHCI_GET_CMD(sdhci_readw(host, SDH=
CI_COMMAND)) =3D=3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEND_TUNING_BLOCK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 command =3D SDHCI_GET_CMD(sdhci_readw(h=
ost, SDHCI_COMMAND));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((command =3D=3D MMC_SEND_TUNING_BLO=
CK) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (command =3D=3D MMC_SEND_TUNING=
_BLOCK_HS200)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->tuning_done =3D =
1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wake_up(&host->buf_rea=
dy_int);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> @@ -2567,6 +2587,10 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (caps[1] & SDHCI_USE_SDR50_TUNING)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_SDR50_NEEDS_TUN=
ING;
>
> + =A0 =A0 =A0 /* Does the host needs tuning for HS200? */
> + =A0 =A0 =A0 if (mmc->caps2 & MMC_CAP2_HS200)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_HS200_NEEDS_TUNI=
NG;
> +
> =A0 =A0 =A0 =A0/* Driver Type(s) (A, C, D) supported by the host */
> =A0 =A0 =A0 =A0if (caps[1] & SDHCI_DRIVER_TYPE_A)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_DRIVER_TYPE_A;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 096ccdc..7bd0635 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -189,6 +189,7 @@ struct mmc_card {
> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 /* card is =
in high speed mode */
> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* card is in ultra high speed mode */
> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0 =A0=
/* card is SDXC */
> +#define MMC_STATE_HIGHSPEED_200 =A0 =A0 =A0 =A0(1<<7) =A0 =A0 =A0 =A0=
 =A0/* card is in HS200 mode */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
> =A0#define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* allo=
w SDIO FN0 writes outside of the VS CCCR range */
> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func->cur_=
blksize */
> @@ -329,6 +330,7 @@ static inline void __maybe_unused remove_quirk(st=
ruct mmc_card *card, int data)
> =A0#define mmc_card_present(c) =A0 =A0((c)->state & MMC_STATE_PRESENT=
)
> =A0#define mmc_card_readonly(c) =A0 ((c)->state & MMC_STATE_READONLY)
> =A0#define mmc_card_highspeed(c) =A0((c)->state & MMC_STATE_HIGHSPEED=
)
> +#define mmc_card_hs200(c) =A0 =A0 =A0((c)->state & MMC_STATE_HIGHSPE=
ED_200)
> =A0#define mmc_card_blockaddr(c) =A0((c)->state & MMC_STATE_BLOCKADDR=
)
> =A0#define mmc_card_ddr_mode(c) =A0 ((c)->state & MMC_STATE_HIGHSPEED=
_DDR)
> =A0#define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
> @@ -337,6 +339,7 @@ static inline void __maybe_unused remove_quirk(st=
ruct mmc_card *card, int data)
> =A0#define mmc_card_set_present(c) =A0 =A0 =A0 =A0((c)->state |=3D MM=
C_STATE_PRESENT)
> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READON=
LY)
> =A0#define mmc_card_set_highspeed(c) ((c)->state |=3D MMC_STATE_HIGHS=
PEED)
> +#define mmc_card_set_hs200(c) =A0((c)->state |=3D MMC_STATE_HIGHSPEE=
D_200)
> =A0#define mmc_card_set_blockaddr(c) ((c)->state |=3D MMC_STATE_BLOCK=
ADDR)
> =A0#define mmc_card_set_ddr_mode(c) ((c)->state |=3D MMC_STATE_HIGHSP=
EED_DDR)
> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHIG=
HSPEED)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4915741..6f2fb00 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -60,6 +60,8 @@ struct mmc_ios {
> =A0#define MMC_SDR_MODE =A0 =A0 =A0 =A0 =A0 0
> =A0#define MMC_1_2V_DDR_MODE =A0 =A0 =A01
> =A0#define MMC_1_8V_DDR_MODE =A0 =A0 =A02
> +#define MMC_1_2V_SDR_MODE =A0 =A0 =A03
> +#define MMC_1_8V_SDR_MODE =A0 =A0 =A04
>
> =A0 =A0 =A0 =A0unsigned char =A0 signal_voltage; =A0 =A0 =A0 =A0 /* s=
ignalling voltage (1.8V or 3.3V) */
>
> @@ -241,6 +243,10 @@ struct mmc_host {
> =A0#define MMC_CAP2_BOOTPART_NOACC =A0 =A0 =A0 =A0(1 << 0) =A0 =A0 =A0=
 =A0/* Boot partition no access */
> =A0#define MMC_CAP2_CACHE_CTRL =A0 =A0(1 << 1) =A0 =A0 =A0 =A0/* Allo=
w cache control. */
> =A0#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0 =A0/* Notify pow=
eroff supported */
> +#define MMC_CAP2_HS200 =A0 =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0/* Ho=
st supports HS200 mode */
> +#define MMC_CAP2_HS200_1_8V_SDR =A0 =A0 =A0 =A0(1 << 4) =A0 =A0 =A0 =
=A0/* can support */
> +#define MMC_CAP2_HS200_1_2V_SDR =A0 =A0 =A0 =A0(1 << 5) =A0 =A0 =A0 =
=A0/* can support */
> +#define MMC_CAP2_HIGHSPEED_200 (1 << 6) =A0 =A0 =A0 =A0/* Can do MMC=
 HS200 timing */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index ecf39ff..bb0567b 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -51,6 +51,7 @@
> =A0#define MMC_READ_SINGLE_BLOCK =A0 =A017 =A0 /* adtc [31:0] data ad=
dr =A0 R1 =A0*/
> =A0#define MMC_READ_MULTIPLE_BLOCK =A018 =A0 /* adtc [31:0] data addr=
 =A0 R1 =A0*/
> =A0#define MMC_SEND_TUNING_BLOCK =A0 =A019 =A0 /* adtc =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0R1 =A0*/
> +#define MMC_SEND_TUNING_BLOCK_HS200 =A0 =A021 =A0 =A0 =A0/* adtc R1 =
=A0*/
>
> =A0 /* class 3 */
> =A0#define MMC_WRITE_DAT_UNTIL_STOP 20 =A0 /* adtc [31:0] data addr =A0=
 R1 =A0*/
> @@ -330,13 +331,18 @@ struct _mmc_csd {
>
> =A0#define EXT_CSD_CARD_TYPE_26 =A0 (1<<0) =A0/* Card can run at 26MH=
z */
> =A0#define EXT_CSD_CARD_TYPE_52 =A0 (1<<1) =A0/* Card can run at 52MH=
z */
> -#define EXT_CSD_CARD_TYPE_MASK 0xF =A0 =A0 /* Mask out reserved bits=
 */
> +#define EXT_CSD_CARD_TYPE_MASK 0x3F =A0 =A0/* Mask out reserved bits=
 */
> =A0#define EXT_CSD_CARD_TYPE_DDR_1_8V =A0(1<<2) =A0 /* Card can run a=
t 52MHz */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 /* DDR mode @1.8V or 3V I/O */
> =A0#define EXT_CSD_CARD_TYPE_DDR_1_2V =A0(1<<3) =A0 /* Card can run a=
t 52MHz */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 /* DDR mode @1.2V I/O */
> =A0#define EXT_CSD_CARD_TYPE_DDR_52 =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_DD=
R_1_8V =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| EXT_CSD_CARD_TYPE_DDR_1_2V)
> +#define EXT_CSD_CARD_TYPE_SDR_1_8V =A0 =A0 (1<<4) =A0/* Card can run=
 at 200MHz */
> +#define EXT_CSD_CARD_TYPE_SDR_1_2V =A0 =A0 (1<<5) =A0/* Card can run=
 at 200MHz */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* SDR mode @1.2V I/O */
> +#define EXT_CSD_CARD_TYPE_SDR_200 =A0 =A0 =A0(EXT_CSD_CARD_TYPE_SDR_=
1_8V =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | EXT_CSD_CARD_TYPE_SDR_1_2V)
>
> =A0#define EXT_CSD_BUS_WIDTH_1 =A0 =A00 =A0 =A0 =A0 /* Card is in 1 b=
it mode */
> =A0#define EXT_CSD_BUS_WIDTH_4 =A0 =A01 =A0 =A0 =A0 /* Card is in 4 b=
it mode */
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 5666f3a..b6e81bd 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -115,6 +115,7 @@ struct sdhci_host {
> =A0#define SDHCI_NEEDS_RETUNING =A0 (1<<5) =A0/* Host needs retuning =
*/
> =A0#define SDHCI_AUTO_CMD12 =A0 =A0 =A0 (1<<6) =A0/* Auto CMD12 suppo=
rt */
> =A0#define SDHCI_AUTO_CMD23 =A0 =A0 =A0 (1<<7) =A0/* Auto CMD23 suppo=
rt */
> +#define SDHCI_HS200_NEEDS_TUNING (1<<8) =A0 =A0 =A0 =A0/* HS200 need=
s tuning */
>
> =A0 =A0 =A0 =A0unsigned int version; =A0 /* SDHCI spec. version */
>
Hi Chris,
please Ignore this patch
> --
> 1.7.1
>
>
