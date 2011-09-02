From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] mmc: core: Add power off notify feature(eMMC 4.5)
Date: Fri, 2 Sep 2011 17:18:55 +0900
Message-ID: <CAH9JG2XA7xa2vH8w9r00NWECir4Dye_fki1w0aGQpcrhvW7CgQ@mail.gmail.com>
References: <1314948349-15856-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1314948349-15856-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

Good job on eMMC v4.5. but this patch is incomplete for power off
notification feature.
Now you just enable the Power off notification, and don't handle the
reaming one.
As you read the spec, it takes more time the sleep & wake-up and next
booting time if no proper power off notification

Please also consider it.

Thank you,
Kyungmin Park

On Fri, Sep 2, 2011 at 4:25 PM, Girish K S
<girish.shivananjappa@linaro.org> wrote:
> This patch adds the support for power off notify feature
> available in eMMC 4.5 devices.
> =A0 =A0 =A0 =A0If the the host has support for this feature, then the
> mmc core will notify it to the device by setting the
> POWER_OFF_NOTIFICATION byte in the extended csd register
> with a value 1(POWER_ON).
> =A0 =A0 =A0 =A0This patch should be applied after Seungwon Jeon's
> patch for cmd6 timeout.
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> =A0drivers/mmc/core/mmc.c =A0 | =A0 19 +++++++++++++++++--
> =A0include/linux/mmc/card.h | =A0 =A01 +
> =A0include/linux/mmc/host.h | =A0 =A01 +
> =A0include/linux/mmc/mmc.h =A0| =A0 =A08 +++++++-
> =A04 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 68eb368..2f06b37 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -410,10 +410,12 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd, u8 *ext_csd)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->erased_byte =3D 0x0;
>
> - =A0 =A0 =A0 if (card->ext_csd.rev >=3D 6)
> + =A0 =A0 =A0 if (card->ext_csd.rev >=3D 6) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.generic_cmd6_time =3D 10=
 *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_GENERI=
C_CMD6_TIME];
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.power_off_longtime =3D 10=
 *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_POWER_O=
=46F_LONG_TIME];
> + =A0 =A0 =A0 }
> =A0out:
> =A0 =A0 =A0 =A0return err;
> =A0}
> @@ -710,6 +712,19 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* If the host supports the power_off_notify capabili=
ty then
> + =A0 =A0 =A0 =A0* set the notification byte in the ext_csd register =
of device
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->caps & MMC_CAP_POWER_OFF_NOTIFY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_POWER_OFF_NOTIFICATION,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_POWER_ON,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.generic_cmd6_time);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Activate high speed (if supported)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if ((card->ext_csd.hs_max_dtr !=3D 0) &&
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index e992fe3..2bf2843 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -53,6 +53,7 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0part_time; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* Units: ms */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =A0=
 =A0 =A0 =A0 =A0 /* Units: 100ns */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0generic_cmd6_time;=
 =A0 =A0 =A0/* Units: ms */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0power_off_longtime;=
 =A0 =A0 /* Units: ms */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sectors;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0card_type;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 1d09562..21c85e1 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -229,6 +229,7 @@ struct mmc_host {
> =A0#define MMC_CAP_MAX_CURRENT_600 =A0 =A0 =A0 =A0(1 << 28) =A0 =A0 =A0=
 /* Host max current limit is 600mA */
> =A0#define MMC_CAP_MAX_CURRENT_800 =A0 =A0 =A0 =A0(1 << 29) =A0 =A0 =A0=
 /* Host max current limit is 800mA */
> =A0#define MMC_CAP_CMD23 =A0 =A0 =A0 =A0 =A0(1 << 30) =A0 =A0 =A0 /* =
CMD23 supported. */
> +#define MMC_CAP_POWER_OFF_NOTIFY =A0 =A0(1 << 31)/*NOtify poweroff s=
upported */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index e869f00..8e86d77 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -269,7 +269,7 @@ struct _mmc_csd {
> =A0/*
> =A0* EXT_CSD fields
> =A0*/
> -
> +#define EXT_CSD_POWER_OFF_NOTIFICATION 34 /* R/W */
> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0 =A0160 =A0 =A0 /* RO */
> =A0#define EXT_CSD_WR_REL_PARAM =A0 =A0 =A0 =A0 =A0 166 =A0 =A0 /* RO=
 */
> @@ -293,6 +293,7 @@ struct _mmc_csd {
> =A0#define EXT_CSD_SEC_ERASE_MULT =A0 =A0 =A0 =A0 230 =A0 =A0 /* RO *=
/
> =A0#define EXT_CSD_SEC_FEATURE_SUPPORT =A0 =A0231 =A0 =A0 /* RO */
> =A0#define EXT_CSD_TRIM_MULT =A0 =A0 =A0 =A0 =A0 =A0 =A0232 =A0 =A0 /=
* RO */
> +#define EXT_CSD_POWER_OFF_LONG_TIME =A0 =A0247 /*RO*/
> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0 =A0248 =A0 =A0 /* RO */
>
> =A0/*
> @@ -329,6 +330,11 @@ struct _mmc_csd {
> =A0#define EXT_CSD_SEC_BD_BLK_EN =A0BIT(2)
> =A0#define EXT_CSD_SEC_GB_CL_EN =A0 BIT(4)
>
> +#define EXT_CSD_NO_POWER_NOTIFICATION =A00
> +#define EXT_CSD_POWER_ON =A0 =A0 =A0 1
> +#define EXT_CSD_POWER_OFF_SHORT =A0 =A0 =A0 =A02
> +#define EXT_CSD_POWER_OFF_LONG 3
> +
> =A0/*
> =A0* MMC_SWITCH access modes
> =A0*/
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
