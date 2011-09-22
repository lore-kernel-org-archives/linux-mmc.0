From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re:
Date: Thu, 22 Sep 2011 16:45:18 +0530
Message-ID: <CAGxe1ZGK3LrXadhySxjETNVfkXct5UhaK7p7kT0W2qisprZXOw@mail.gmail.com>
References: <1316689844-8663-1-git-send-email-girish.shivananjappa@linaro.org>
	<1316689844-8663-2-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1316689844-8663-2-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Ignore this mail
Sorry for no subject

On 22 September 2011 16:40, Girish K S <girish.shivananjappa@linaro.org=
> wrote:
> This patch adds the power off notification handling
> during suspend and system poweroff.
> For suspend mode short timeout is used, whereas for the
> normal poweroff long timeout is used.
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> =A0v2:
> =A0adds poweroff notification handling in suspend/normal
> =A0v4:
> =A0updated with review comments of Jeon
> =A0v5:
> =A0This patch version fixes the problem with power off
> =A0notify function, when called for the first time and
> =A0card is not yet initialised.
> =A0v6:
> =A0fixes checkpatch errors. The patches are generated after
> =A0rebasing to chris's mmc-next branch.
>
> =A0drivers/mmc/core/core.c =A0| =A0 35 ++++++++++++++++++++++++++++++=
++++-
> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A05 ++++-
> =A0drivers/mmc/host/sdhci.c | =A0 10 ++++++++++
> =A0include/linux/mmc/card.h | =A0 19 +++++++++++++++++++
> =A0include/linux/mmc/host.h | =A0 =A04 ++++
> =A05 files changed, 71 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f22b774..17841a8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1198,11 +1198,42 @@ static void mmc_power_up(struct mmc_host *hos=
t)
>
> =A0void mmc_power_off(struct mmc_host *host)
> =A0{
> - =A0 =A0 =A0 mmc_host_clk_hold(host);
> + =A0 =A0 =A0 struct mmc_card *card =3D host->card;
> + =A0 =A0 =A0 unsigned int notify_type;
> + =A0 =A0 =A0 unsigned int timeout;
> + =A0 =A0 =A0 int err;
>
> + =A0 =A0 =A0 mmc_host_clk_hold(host);
> =A0 =A0 =A0 =A0host->ios.clock =3D 0;
> =A0 =A0 =A0 =A0host->ios.vdd =3D 0;
>
> + =A0 =A0 =A0 if (card !=3D NULL && mmc_card_mmc(card) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_powernotify_on(card))) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MMC_=
HOST_PW_NOTIFY_SHORT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD=
_POWER_OFF_SHORT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_c=
sd.generic_cmd6_time;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotif=
y_short(card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD=
_POWER_OFF_LONG;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_c=
sd.power_off_longtime;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotif=
y_long(card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_POWER_OFF_NOTIFICATION,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_=
type, timeout);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Device=
 failed to respond "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "within %d poweroff time."
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "forcefully powering down"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "the device\n", timeout);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*Set the card state to no notification=
 after the poweroff*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotify_off(card);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Reset ocr mask to be the highest possible voltage s=
upported for
> =A0 =A0 =A0 =A0 * this mmc host. This value will be used at next powe=
r up.
> @@ -2195,6 +2226,7 @@ int mmc_pm_notify(struct notifier_block *notify=
_block,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->rescan_disable =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW=
_NOTIFY_SHORT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, fl=
ags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cancel_delayed_work_sync(&host->detect=
);
>
> @@ -2218,6 +2250,7 @@ int mmc_pm_notify(struct notifier_block *notify=
_block,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->rescan_disable =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW=
_NOTIFY_LONG;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, fl=
ags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detect_change(host, 0);
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index a547f49..e3695a0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -720,7 +720,8 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 * If the host supports the power_off_notify capabilit=
y then
> =A0 =A0 =A0 =A0 * set the notification byte in the ext_csd register o=
f device
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (host->caps & MMC_CAP_POWER_OFF_NOTIFY) {
> + =A0 =A0 =A0 if ((host->caps & MMC_CAP_POWER_OFF_NOTIFY) =A0 =A0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_powernotify_off(card))) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CS=
D_POWER_OFF_NOTIFICATION,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CS=
D_POWER_ON,
> @@ -729,6 +730,8 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (!err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotify_on(card);
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Activate high speed (if supported)
> =A0 =A0 =A0 =A0 */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d66a7a1..04abd45 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2575,6 +2575,16 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (caps[1] & SDHCI_DRIVER_TYPE_D)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_DRIVER_TYPE_D;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If Notify capability is enabled and
> + =A0 =A0 =A0 =A0* notify type is not initialised by host, set defaul=
t to
> + =A0 =A0 =A0 =A0* long power off notify timeout value
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (mmc->caps & MMC_CAP_POWER_OFF_NOTIFY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_=
NOTIFY_SHORT;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_=
NOTIFY_NONE;
> +
> =A0 =A0 =A0 =A0/* Initial value for re-tuning timer count */
> =A0 =A0 =A0 =A0host->tuning_count =3D (caps[1] & SDHCI_RETUNING_TIMER=
_COUNT_MASK) >>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_RETU=
NING_TIMER_COUNT_SHIFT;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 0f9dbd6..3bc1995 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -192,6 +192,11 @@ struct mmc_card {
> =A0#define MMC_QUIRK_BLK_NO_CMD23 (1<<7) =A0 =A0 =A0 =A0 =A0/* Avoid =
CMD23 for regular multiblock */
> =A0#define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8) =A0/* Avoid sending =
512 bytes in */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* byte mode */
> + =A0 =A0 =A0 unsigned int =A0 =A0poweroff_notify_state;/*eMMC4.5 not=
ify feature =A0*/
> +#define MMC_NO_POWER_NOTIFICATION =A00
> +#define MMC_POWERED_ON =A0 =A0 1
> +#define MMC_POWEROFF_SHORT 2
> +#define MMC_POWEROFF_LONG =A03
>
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0=
 /* erase size in sectors */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0 =A0=
/* if erase unit is power 2 */
> @@ -327,6 +332,20 @@ static inline void __maybe_unused remove_quirk(s=
truct mmc_card *card, int data)
> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHIG=
HSPEED)
> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_SDX=
C)
>
> +#define mmc_card_powernotify_on(c) =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D=3D MMC_=
POWERED_ON)
> +#define mmc_card_powernotify_off(c) =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D=3D MMC_=
NO_POWER_NOTIFICATION)
> +
> +#define mmc_card_set_powernotify_off(c) =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC_NO_=
POWER_NOTIFICATION)
> +#define mmc_card_set_powernotify_on(c) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC_POW=
ERED_ON)
> +#define mmc_card_set_powernotify_short(c) =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC_POW=
EROFF_SHORT)
> +#define mmc_card_set_powernotify_long(c) =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC_POW=
EROFF_LONG)
> +
> =A0/*
> =A0* Quirk add/remove for MMC products.
> =A0*/
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ed49e88..d8a3a72 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -238,6 +238,10 @@ struct mmc_host {
> =A0#define MMC_CAP_POWER_OFF_NOTIFY =A0 =A0(1 << 31)/*Notify poweroff=
 supported */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
> +#define MMC_HOST_PW_NOTIFY_NONE =A0 =A0 =A0 =A00
> +#define MMC_HOST_PW_NOTIFY_SHORT =A0 =A0 =A0 1
> +#define MMC_HOST_PW_NOTIFY_LONG =A0 =A0 =A0 =A02
>
> =A0#ifdef CONFIG_MMC_CLKGATE
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_reques=
ts; =A0 /* internal reference counter */
> --
> 1.7.1
>
>
