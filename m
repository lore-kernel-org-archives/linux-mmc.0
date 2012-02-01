From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH] mmc: core: Fix PowerOff Notify suspend/resume
Date: Wed, 1 Feb 2012 23:03:15 +0530
Message-ID: <CAKLKtzeptbvnJ2Kt2w2zy7mBZ-xUJtzUzPjkBz8bJE5MNjRRjw@mail.gmail.com>
References: <1328004843-16094-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1328004843-16094-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On 31 January 2012 15:44, Girish K S <girish.shivananjappa@linaro.org> =
wrote:
> Modified the mmc_poweroff to resume before sending the
> poweroff notification command. In sleep mode only AWAKE
> and RESET commands are allowed, so before sending the
> poweroff notification command resume from sleep mode and
> then send the notification command.
>
> POwerOff Notify is tested on a Synopsis Designware Host
> Controller(eMMC 4.5). The suspend to RAM and resume works fine.
>
> This patch is successfully applied on the Chris's mmc-next
> branch
>
> cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> Tested-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> =A0drivers/mmc/core/core.c =A0| =A0 28 ++++++++++++++++++++--------
> =A0drivers/mmc/core/mmc.c =A0 | =A0 17 ++++++++++++-----
> =A0include/linux/mmc/card.h | =A0 =A04 ++++
> =A03 files changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index bec0bf2..14ec575 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1239,7 +1239,8 @@ static void mmc_poweroff_notify(struct mmc_host=
 *host)
> =A0 =A0 =A0 =A0int err =3D 0;
>
> =A0 =A0 =A0 =A0card =3D host->card;
> -
> + =A0 =A0 =A0 mmc_claim_host(host);
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Send power notify command only if card
> =A0 =A0 =A0 =A0 * is mmc and notify state is powered ON
> @@ -1269,6 +1270,7 @@ static void mmc_poweroff_notify(struct mmc_host=
 *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Set the card state to no notificati=
on after the poweroff */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->poweroff_notify_state =3D MMC_NO=
_POWER_NOTIFICATION;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 mmc_release_host(host);
> =A0}
>
> =A0/*
> @@ -1327,12 +1329,28 @@ static void mmc_power_up(struct mmc_host *hos=
t)
>
> =A0void mmc_power_off(struct mmc_host *host)
> =A0{
> + =A0 =A0 =A0 int err =3D 0;
> =A0 =A0 =A0 =A0mmc_host_clk_hold(host);
>
> =A0 =A0 =A0 =A0host->ios.clock =3D 0;
> =A0 =A0 =A0 =A0host->ios.vdd =3D 0;
>
> - =A0 =A0 =A0 mmc_poweroff_notify(host);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* For eMMC 4.5 device send AWAKE command before
> + =A0 =A0 =A0 =A0* POWER_OFF_NOTIFY command, because in sleep state
> + =A0 =A0 =A0 =A0* eMMC 4.5 devices respond to only RESET and AWAKE c=
md
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->card && mmc_card_is_sleep(host->card) &&
> + =A0 =A0 =A0 =A0 =A0 host->bus_ops->resume) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->bus_ops->resume(host);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_poweroff_notify(hos=
t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: error %=
d during resume "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"(continue with poweroff sequence)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mmc_hostname(host), err);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Reset ocr mask to be the highest possible voltage s=
upported for
> @@ -2386,12 +2404,6 @@ int mmc_suspend_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mmc_try_claim_host(host)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->sus=
pend) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Fo=
r eMMC 4.5 device send notify command
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* be=
fore sleep, because in sleep state eMMC 4.5
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* de=
vices respond to only RESET and AWAKE cmd
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_pow=
eroff_notify(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D=
 host->bus_ops->suspend(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_do_release_host(ho=
st);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 2bc586b..c3f09a2 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1330,11 +1330,13 @@ static int mmc_suspend(struct mmc_host *host)
> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> - =A0 =A0 =A0 if (mmc_card_can_sleep(host))
> + =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_card_sleep(host);
> - =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(host=
->card);
> + =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_deselect_cards(host);
> - =A0 =A0 =A0 host->card->state &=3D ~MMC_STATE_HIGHSPEED;
> + =A0 =A0 =A0 host->card->state &=3D ~(MMC_STATE_HIGHSPEED | MMC_STAT=
E_HIGHSPEED_200);
> =A0 =A0 =A0 =A0mmc_release_host(host);
>
> =A0 =A0 =A0 =A0return err;
> @@ -1354,7 +1356,11 @@ static int mmc_resume(struct mmc_host *host)
> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> - =A0 =A0 =A0 err =3D mmc_init_card(host, host->ocr, host->card);
> + =A0 =A0 =A0 if (mmc_card_is_sleep(host->card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_awake(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_init_card(host, host->ocr, =
host->card);
> =A0 =A0 =A0 =A0mmc_release_host(host);
>
> =A0 =A0 =A0 =A0return err;
> @@ -1364,7 +1370,8 @@ static int mmc_power_restore(struct mmc_host *h=
ost)
> =A0{
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 host->card->state &=3D ~MMC_STATE_HIGHSPEED;
> + =A0 =A0 =A0 host->card->state &=3D ~(MMC_STATE_HIGHSPEED | MMC_STAT=
E_HIGHSPEED_200);
> + =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> =A0 =A0 =A0 =A0ret =3D mmc_init_card(host, host->ocr, host->card);
> =A0 =A0 =A0 =A0mmc_release_host(host);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f9a0663..1a1ca71 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -219,6 +219,7 @@ struct mmc_card {
> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0 =A0=
/* card is SDXC */
> =A0#define MMC_CARD_REMOVED =A0 =A0 =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* =
card has been removed */
> =A0#define MMC_STATE_HIGHSPEED_200 =A0 =A0 =A0 =A0(1<<8) =A0 =A0 =A0 =
=A0 =A0/* card is in HS200 mode */
> +#define MMC_STATE_SLEEP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<9) =A0 =A0=
 =A0 =A0 =A0/* card is in sleep state */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
> =A0#define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* allo=
w SDIO FN0 writes outside of the VS CCCR range */
> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func->cur_=
blksize */
> @@ -384,6 +385,7 @@ static inline void __maybe_unused remove_quirk(st=
ruct mmc_card *card, int data)
> =A0#define mmc_sd_card_uhs(c) =A0 =A0 ((c)->state & MMC_STATE_ULTRAHI=
GHSPEED)
> =A0#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
> =A0#define mmc_card_removed(c) =A0 =A0((c) && ((c)->state & MMC_CARD_=
REMOVED))
> +#define mmc_card_is_sleep(c) =A0 ((c)->state & MMC_STATE_SLEEP)
>
> =A0#define mmc_card_set_present(c) =A0 =A0 =A0 =A0((c)->state |=3D MM=
C_STATE_PRESENT)
> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READON=
LY)
> @@ -395,7 +397,9 @@ static inline void __maybe_unused remove_quirk(st=
ruct mmc_card *card, int data)
> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHIG=
HSPEED)
> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_SDX=
C)
> =A0#define mmc_card_set_removed(c) ((c)->state |=3D MMC_CARD_REMOVED)
> +#define mmc_card_set_sleep(c) =A0((c)->state |=3D MMC_STATE_SLEEP)
>
> +#define mmc_card_clr_sleep(c) =A0((c)->state &=3D ~MMC_STATE_SLEEP)
> =A0/*
> =A0* Quirk add/remove for MMC products.
> =A0*/
> --
> 1.7.1
>

Thanks for the changes.
Reviewed-by: Saugata Das <saugata.das@linaro.org>
