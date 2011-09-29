From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Add default timeout value for CMD6.
Date: Thu, 29 Sep 2011 10:23:48 +0530
Message-ID: <CAGxe1ZFMwdVtNf-XKKwVXPR3FteMrXk+_3reRdF-=Y8FrBUvCg@mail.gmail.com>
References: <1315462202-28032-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1315462202-28032-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi Jeon,

I tried to apply your patch to the latest Chris-mmc/mmc-next branch.
but the patch fails. can you please check
err message.

error: patch failed: include/linux/mmc/card.h:52
error: include/linux/mmc/card.h: patch does not apply
error: patch failed: include/linux/mmc/mmc.h:293
error: include/linux/mmc/mmc.h: patch does not apply
Patch failed at 0001 mmc: core: Add default timeout value for CMD6.

regards
Girish K S
> EXT_CSD[248] includes the default maximum timeout for CMD6.
> This field is added at eMMC4.5 Spec. And it can be used for default
> timeout except for some operations which don't define the timeout(i.e=
=2E
> background operation, sanitize, flush cache) in eMMC4.5 Spec.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> v2 : apply default maximum timeout of CMD6 which specific timeout is =
not defined.
>
> =A0drivers/mmc/core/mmc.c =A0 | =A0 14 ++++++++++----
> =A0include/linux/mmc/card.h | =A0 =A01 +
> =A0include/linux/mmc/mmc.h =A0| =A0 =A01 +
> =A03 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5700b1c..b148bb1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -410,6 +410,10 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->erased_byte =3D 0x0;
>
> + =A0 =A0 =A0 if (card->ext_csd.rev >=3D 6)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.generic_cmd6_time =3D 10 =
*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_GENERIC=
_CMD6_TIME];
> +
> =A0out:
> =A0 =A0 =A0 =A0return err;
> =A0}
> @@ -668,7 +672,8 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (card->ext_csd.enhanced_area_en) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_=
CSD_ERASE_GROUP_DEF, 1, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_=
CSD_ERASE_GROUP_DEF, 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card=
->ext_csd.generic_cmd6_time);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err && err !=3D -EBADMSG)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
> @@ -711,7 +716,8 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0if ((card->ext_csd.hs_max_dtr !=3D 0) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(host->caps & MMC_CAP_MMC_HIGHSPEED)) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_=
CSD_HS_TIMING, 1, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_=
CSD_HS_TIMING, 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card=
->ext_csd.generic_cmd6_time);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err && err !=3D -EBADMSG)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
>
> @@ -783,7 +789,7 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BUS_WIDTH,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ext_csd_bits[idx][0],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0card->ext_csd.generic_cmd6_time);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_se=
t_bus_width(card->host, bus_width);
>
> @@ -806,7 +812,7 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BUS_WIDTH,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ext_csd_bits[idx][1],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0card->ext_csd.generic_cmd6_time);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WARNING "%=
s: switch to bus width %d ddr %d "
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index b460fc2..e992fe3 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -52,6 +52,7 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0part_con=
fig;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0part_time; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* Units: ms */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =A0=
 =A0 =A0 =A0 =A0 /* Units: 100ns */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0generic_cmd6_time; =
=A0 =A0 =A0/* Units: ms */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sectors;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0card_type;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 5a794cb..e869f00 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -293,6 +293,7 @@ struct _mmc_csd {
> =A0#define EXT_CSD_SEC_ERASE_MULT =A0 =A0 =A0 =A0 230 =A0 =A0 /* RO *=
/
> =A0#define EXT_CSD_SEC_FEATURE_SUPPORT =A0 =A0231 =A0 =A0 /* RO */
> =A0#define EXT_CSD_TRIM_MULT =A0 =A0 =A0 =A0 =A0 =A0 =A0232 =A0 =A0 /=
* RO */
> +#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0 =A0248 =A0 =A0 /* RO */
>
> =A0/*
> =A0* EXT_CSD field definitions
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
