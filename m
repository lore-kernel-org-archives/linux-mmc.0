From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [RFC] MMC-4.5 Power OFF Notify rework
Date: Fri, 30 Mar 2012 15:27:13 +0530
Message-ID: <CAGxe1ZGbvBBn5ZOo3oE3uaa4gK7net=11yVX7XUCqZ8UFQYHqQ@mail.gmail.com>
References: <1333098857-30305-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:37075 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab2C3J5O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Mar 2012 05:57:14 -0400
Received: by qcqw6 with SMTP id w6so243211qcq.19
        for <linux-mmc@vger.kernel.org>; Fri, 30 Mar 2012 02:57:13 -0700 (PDT)
In-Reply-To: <1333098857-30305-1-git-send-email-saugata.das@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@stericsson.com>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, saugata.das@linaro.org

On 30 March 2012 14:44, Saugata Das <saugata.das@stericsson.com> wrote:
> From: Saugata Das <saugata.das@linaro.org>
>
> This is a rework of the existing POWER OFF NOTIFY patch. The problem =
with
> the existing patch comes from the ambiguity on the usage of POWER OFF=
 NOTIFY
> together with SLEEP and misunderstanding on the usage of MMC_POWER_OF=
=46
> power_mode from mmc_set_ios in different host controller drivers.
>
> This new patch works around this problem by adding a new host CAP,
> MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which when set sends a
> POWER OFF NOTIFY from mmc_suspend instead of SLEEP. It is expected th=
at host
> controller drivers will set this CAP, if they switch off both Vcc and=
 Vccq
> from MMC_POWER_OFF condition within mmc_set_ios. However, note that t=
here
> is no harm in sending MMC_POWER_NOTIFY even if Vccq is not switched o=
ff.
>
> This patch also sends POWER OFF NOTIFY from power management routines=
 (e.g.
> mmc_power_save_host, mmc_pm_notify/PM_SUSPEND_PREPARE, mmc_stop_host)=
, which
> does reinitialization of the eMMC on the return path of the power man=
agement
> routines (e.g. mmc_power_restore_host, mmc_pm_notify/PM_POST_RESTORE,
> mmc_start_host).
>
> Signed-off-by: Saugata Das <saugata.das@linaro.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> =A0drivers/mmc/core/core.c =A0| =A0 36 ++++++++++++++----------------=
------
> =A0drivers/mmc/core/core.h =A0| =A0 =A01 +
> =A0drivers/mmc/core/mmc.c =A0 | =A0 18 +++++++++++-------
> =A0include/linux/mmc/host.h | =A0 =A01 +
> =A04 files changed, 27 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 14f262e..dc85ee1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1096,12 +1096,12 @@ void mmc_set_driver_type(struct mmc_host *hos=
t, unsigned int drv_type)
> =A0 =A0 =A0 =A0mmc_host_clk_release(host);
> =A0}
>
> -static void mmc_poweroff_notify(struct mmc_host *host)
> +int mmc_poweroff_notify(struct mmc_host *host)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_card *card;
> =A0 =A0 =A0 =A0unsigned int timeout;
> =A0 =A0 =A0 =A0unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFICA=
TION;
> - =A0 =A0 =A0 int err =3D 0;
> + =A0 =A0 =A0 int err =3D -EINVAL;
>
> =A0 =A0 =A0 =A0card =3D host->card;
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> @@ -1136,6 +1136,7 @@ static void mmc_poweroff_notify(struct mmc_host=
 *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->poweroff_notify_state =3D MMC_NO=
_POWER_NOTIFICATION;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mmc_release_host(host);
> + =A0 =A0 =A0 return err;
> =A0}
>
> =A0/*
> @@ -1194,30 +1195,12 @@ static void mmc_power_up(struct mmc_host *hos=
t)
>
> =A0void mmc_power_off(struct mmc_host *host)
> =A0{
> - =A0 =A0 =A0 int err =3D 0;
> =A0 =A0 =A0 =A0mmc_host_clk_hold(host);
>
> =A0 =A0 =A0 =A0host->ios.clock =3D 0;
> =A0 =A0 =A0 =A0host->ios.vdd =3D 0;
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* For eMMC 4.5 device send AWAKE command before
> - =A0 =A0 =A0 =A0* POWER_OFF_NOTIFY command, because in sleep state
> - =A0 =A0 =A0 =A0* eMMC 4.5 devices respond to only RESET and AWAKE c=
md
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (host->card && mmc_card_is_sleep(host->card) &&
> - =A0 =A0 =A0 =A0 =A0 host->bus_ops->resume) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->bus_ops->resume(host);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_poweroff_notify(hos=
t);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: error %=
d during resume "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"(continue with poweroff sequence)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mmc_hostname(host), err);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Reset ocr mask to be the highest possible voltage s=
upported for
> =A0 =A0 =A0 =A0 * this mmc host. This value will be used at next powe=
r up.
> =A0 =A0 =A0 =A0 */
> @@ -2076,6 +2059,7 @@ void mmc_stop_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0host->pm_flags =3D 0;
>
> =A0 =A0 =A0 =A0mmc_bus_get(host);
> + =A0 =A0 =A0 mmc_poweroff_notify(host);
> =A0 =A0 =A0 =A0if (host->bus_ops && !host->bus_dead) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a cl=
aimed host can deadlock */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
> @@ -2112,7 +2096,8 @@ int mmc_power_save_host(struct mmc_host *host)
>
> =A0 =A0 =A0 =A0if (host->bus_ops->power_save)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_save(host=
);
> -
> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_SHORT;
> + =A0 =A0 =A0 mmc_poweroff_notify(host);
> =A0 =A0 =A0 =A0mmc_bus_put(host);
>
> =A0 =A0 =A0 =A0mmc_power_off(host);
> @@ -2135,7 +2120,7 @@ int mmc_power_restore_host(struct mmc_host *hos=
t)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> -
> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_LONG;
> =A0 =A0 =A0 =A0mmc_power_up(host);
> =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_restore(host);
>
> @@ -2157,6 +2142,9 @@ int mmc_card_awake(struct mmc_host *host)
> =A0 =A0 =A0 =A0if (host->bus_ops && !host->bus_dead && host->bus_ops-=
>awake)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->awake(host);
>
> + =A0 =A0 =A0 if (!err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
> +
> =A0 =A0 =A0 =A0mmc_bus_put(host);
>
> =A0 =A0 =A0 =A0return err;
> @@ -2175,6 +2163,9 @@ int mmc_card_sleep(struct mmc_host *host)
> =A0 =A0 =A0 =A0if (host->bus_ops && !host->bus_dead && host->bus_ops-=
>sleep)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->sleep(host);
>
> + =A0 =A0 =A0 if (!err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(host->card);
> +
> =A0 =A0 =A0 =A0mmc_bus_put(host);
>
> =A0 =A0 =A0 =A0return err;
> @@ -2393,6 +2384,7 @@ int mmc_pm_notify(struct notifier_block *notify=
_block,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->bus_ops->remove(=
host);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_claim_host(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_poweroff_notify(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detach_bus(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_power_off(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host);
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 3bdafbc..0bdc0fd 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -45,6 +45,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, i=
nt signal_voltage,
> =A0void mmc_set_timing(struct mmc_host *host, unsigned int timing);
> =A0void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_t=
ype);
> =A0void mmc_power_off(struct mmc_host *host);
> +int mmc_poweroff_notify(struct mmc_host *host);
>
> =A0static inline void mmc_delay(unsigned int ms)
> =A0{
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 02914d6..3e67480 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1338,11 +1338,15 @@ static int mmc_suspend(struct mmc_host *host)
> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> - =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
> + =A0 =A0 =A0 if (host->caps2 & MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEN=
D) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(host=
->card);
> - =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (mmc_card_can_sleep(host))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
> + =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_deselect_cards(host);
> =A0 =A0 =A0 =A0host->card->state &=3D ~(MMC_STATE_HIGHSPEED | MMC_STA=
TE_HIGHSPEED_200);
> =A0 =A0 =A0 =A0mmc_release_host(host);
> @@ -1364,11 +1368,11 @@ static int mmc_resume(struct mmc_host *host)
> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> - =A0 =A0 =A0 if (mmc_card_is_sleep(host->card)) {
> + =A0 =A0 =A0 if (mmc_card_is_sleep(host->card))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_card_awake(host);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
> - =A0 =A0 =A0 } else
> + =A0 =A0 =A0 else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_init_card(host, host->ocr,=
 host->card);
> +
> =A0 =A0 =A0 =A0mmc_release_host(host);
>
> =A0 =A0 =A0 =A0return err;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 33a4d08..0e843c7 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -237,6 +237,7 @@ struct mmc_host {
> =A0#define MMC_CAP2_BROKEN_VOLTAGE =A0 =A0 =A0 =A0(1 << 7) =A0 =A0 =A0=
 =A0/* Use the broken voltage */
> =A0#define MMC_CAP2_DETECT_ON_ERR (1 << 8) =A0 =A0 =A0 =A0/* On I/O e=
rr check card removal */
> =A0#define MMC_CAP2_HC_ERASE_SZ =A0 (1 << 9) =A0 =A0 =A0 =A0/* High-c=
apacity erase size */
> +#define MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND (1 << 10)
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
Kindly ignore this patch
I will resend the same. Sorry saugata its my mistake.
i will resend

> --
> 1.7.4.3
>
