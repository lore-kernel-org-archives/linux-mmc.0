From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] MMC-4.5 Power OFF Notify rework
Date: Fri, 20 Apr 2012 17:03:42 +0530
Message-ID: <CAGxe1ZH=NpTWNY_MxTF6iDAqJBtP-PsR9EO_nvWFCU6kLGGwvQ@mail.gmail.com>
References: <1334839289-22620-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39736 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999Ab2DTLdo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Apr 2012 07:33:44 -0400
Received: by qcro28 with SMTP id o28so5772250qcr.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Apr 2012 04:33:43 -0700 (PDT)
In-Reply-To: <1334839289-22620-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, ulf.hansson@stericsson.com, saugata.das@linaro.org, girish.shivananjappa@linaro.org

On 19 April 2012 18:11, Girish K S <girish.shivananjappa@linaro.org> wr=
ote:
> This is a rework of the existing POWER OFF NOTIFY patch. The current =
problem
> with the patch comes from the ambiguity on the usage of POWER OFF NOT=
IFY
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
> This patch sets POWER_OFF_NOTIFICATION to POWER_OFF_SHORT if it is se=
nt from
> the suspend sequence. If it is sent from shutdown sequence then it is=
 set to
> POWER_OFF_LONG.
>
> Previuos implementation of PowerOff Notify as a core function is repl=
aced as
> a device's bus operation.
>
> Signed-off-by: Saugata Das <saugata.das@linaro.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> =A0drivers/mmc/core/core.c =A0| =A0 83 ++++++++++--------------------=
---------------
> =A0drivers/mmc/core/core.h =A0| =A0 =A01 +
> =A0drivers/mmc/core/mmc.c =A0 | =A0 75 ++++++++++++++++++++++++++++++=
+++++-------
> =A0include/linux/mmc/host.h | =A0 =A01 +
> =A04 files changed, 84 insertions(+), 76 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e541efb..4b8b2c1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1100,48 +1100,6 @@ void mmc_set_driver_type(struct mmc_host *host=
, unsigned int drv_type)
> =A0 =A0 =A0 =A0mmc_host_clk_release(host);
> =A0}
>
> -static void mmc_poweroff_notify(struct mmc_host *host)
> -{
> - =A0 =A0 =A0 struct mmc_card *card;
> - =A0 =A0 =A0 unsigned int timeout;
> - =A0 =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFICAT=
ION;
> - =A0 =A0 =A0 int err =3D 0;
> -
> - =A0 =A0 =A0 card =3D host->card;
> - =A0 =A0 =A0 mmc_claim_host(host);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Send power notify command only if card
> - =A0 =A0 =A0 =A0* is mmc and notify state is powered ON
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (card && mmc_card_mmc(card) &&
> - =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWERED=
_ON)) {
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MMC_=
HOST_PW_NOTIFY_SHORT) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD=
_POWER_OFF_SHORT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_c=
sd.generic_cmd6_time;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_s=
tate =3D MMC_POWEROFF_SHORT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD=
_POWER_OFF_LONG;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_c=
sd.power_off_longtime;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_s=
tate =3D MMC_POWEROFF_LONG;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_=
CSD_POWER_OFF_NOTIFICATION,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0noti=
fy_type, timeout);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Device failed t=
o respond within %d poweroff "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"time. F=
orcefully powering down the device\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout)=
;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notificatio=
n after the poweroff */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D MMC_NO_=
POWER_NOTIFICATION;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 mmc_release_host(host);
> -}
> -
> =A0/*
> =A0* Apply power to the MMC stack. =A0This is a two-stage process.
> =A0* First, we enable power to the card without the clock running.
> @@ -1198,30 +1156,12 @@ static void mmc_power_up(struct mmc_host *hos=
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
> @@ -2084,6 +2024,9 @@ void mmc_stop_host(struct mmc_host *host)
>
> =A0 =A0 =A0 =A0mmc_bus_get(host);
> =A0 =A0 =A0 =A0if (host->bus_ops && !host->bus_dead) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->poweroff_notify)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_ops->poweroff=
_notify(host);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a cl=
aimed host can deadlock */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->bus_ops->remove(=
host);
> @@ -2093,6 +2036,7 @@ void mmc_stop_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_power_off(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mmc_bus_put(host);
> @@ -2119,7 +2063,9 @@ int mmc_power_save_host(struct mmc_host *host)
>
> =A0 =A0 =A0 =A0if (host->bus_ops->power_save)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_save(host=
);
> -
> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_SHORT;
> + =A0 =A0 =A0 if (host->bus_ops->poweroff_notify)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_ops->poweroff_notify(host);
> =A0 =A0 =A0 =A0mmc_bus_put(host);
>
> =A0 =A0 =A0 =A0mmc_power_off(host);
> @@ -2142,7 +2088,7 @@ int mmc_power_restore_host(struct mmc_host *hos=
t)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> -
> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_LONG;
> =A0 =A0 =A0 =A0mmc_power_up(host);
> =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_restore(host);
>
> @@ -2161,8 +2107,11 @@ int mmc_card_awake(struct mmc_host *host)
>
> =A0 =A0 =A0 =A0mmc_bus_get(host);
>
> - =A0 =A0 =A0 if (host->bus_ops && !host->bus_dead && host->bus_ops->=
awake)
> + =A0 =A0 =A0 if (host->bus_ops && !host->bus_dead && host->bus_ops->=
awake) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->awake(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host=
->card);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0mmc_bus_put(host);
>
> @@ -2179,8 +2128,11 @@ int mmc_card_sleep(struct mmc_host *host)
>
> =A0 =A0 =A0 =A0mmc_bus_get(host);
>
> - =A0 =A0 =A0 if (host->bus_ops && !host->bus_dead && host->bus_ops->=
sleep)
> + =A0 =A0 =A0 if (host->bus_ops && !host->bus_dead && host->bus_ops->=
sleep) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->sleep(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(host=
->card);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0mmc_bus_put(host);
>
> @@ -2394,6 +2346,8 @@ int mmc_pm_notify(struct notifier_block *notify=
_block,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!host->bus_ops || host->bus_ops->s=
uspend)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->poweroff_notify)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_ops->poweroff=
_notify(host);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a cl=
aimed host can deadlock */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
> @@ -2403,6 +2357,7 @@ int mmc_pm_notify(struct notifier_block *notify=
_block,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detach_bus(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_power_off(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->pm_flags =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 3bdafbc..351cbbe 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -25,6 +25,7 @@ struct mmc_bus_ops {
> =A0 =A0 =A0 =A0int (*power_save)(struct mmc_host *);
> =A0 =A0 =A0 =A0int (*power_restore)(struct mmc_host *);
> =A0 =A0 =A0 =A0int (*alive)(struct mmc_host *);
> + =A0 =A0 =A0 int (*poweroff_notify)(struct mmc_host *);
> =A0};
>
> =A0void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_op=
s *ops);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 54df5ad..62bdee6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1282,6 +1282,50 @@ err:
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> +static int mmc_poweroff_notify(struct mmc_host *host)
> +{
> + =A0 =A0 =A0 struct mmc_card *card;
> + =A0 =A0 =A0 unsigned int timeout;
> + =A0 =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFICAT=
ION;
> + =A0 =A0 =A0 int err =3D -EINVAL;
> +
> + =A0 =A0 =A0 card =3D host->card;
> + =A0 =A0 =A0 mmc_claim_host(host);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Send power notify command only if card
> + =A0 =A0 =A0 =A0* is mmc and notify state is powered ON
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card && mmc_card_mmc(card) &&
> + =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWERED=
_ON)) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MMC_=
HOST_PW_NOTIFY_SHORT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD=
_POWER_OFF_SHORT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_c=
sd.generic_cmd6_time;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_s=
tate =3D MMC_POWEROFF_SHORT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD=
_POWER_OFF_LONG;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_c=
sd.power_off_longtime;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_s=
tate =3D MMC_POWEROFF_LONG;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_=
CSD_POWER_OFF_NOTIFICATION,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0noti=
fy_type, timeout);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Device fail=
ed to respond within %d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"powerof=
f time. Forcefully powering down "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"the dev=
ice\n", mmc_hostname(host), timeout);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notificatio=
n after the poweroff */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D MMC_NO_=
POWER_NOTIFICATION;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 mmc_release_host(host);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> =A0/*
> =A0* Host is being removed. Free up the current card.
> =A0*/
> @@ -1341,15 +1385,20 @@ static int mmc_suspend(struct mmc_host *host)
> =A0 =A0 =A0 =A0BUG_ON(!host);
> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>
> - =A0 =A0 =A0 mmc_claim_host(host);
> - =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(host=
->card);
> - =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(host);
> - =A0 =A0 =A0 host->card->state &=3D ~(MMC_STATE_HIGHSPEED | MMC_STAT=
E_HIGHSPEED_200);
> - =A0 =A0 =A0 mmc_release_host(host);
> + =A0 =A0 =A0 if (host->caps2 & MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEN=
D) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_can_sleep(host))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(=
host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(host=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->card->state &=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(MMC_STATE_HIGHSPEED |=
 MMC_STATE_HIGHSPEED_200);
>
> =A0 =A0 =A0 =A0return err;
> =A0}
> @@ -1368,11 +1417,11 @@ static int mmc_resume(struct mmc_host *host)
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
> @@ -1430,6 +1479,7 @@ static const struct mmc_bus_ops mmc_ops =3D {
> =A0 =A0 =A0 =A0.resume =3D NULL,
> =A0 =A0 =A0 =A0.power_restore =3D mmc_power_restore,
> =A0 =A0 =A0 =A0.alive =3D mmc_alive,
> + =A0 =A0 =A0 .poweroff_notify =3D NULL,
> =A0};
>
> =A0static const struct mmc_bus_ops mmc_ops_unsafe =3D {
> @@ -1441,6 +1491,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe =
=3D {
> =A0 =A0 =A0 =A0.resume =3D mmc_resume,
> =A0 =A0 =A0 =A0.power_restore =3D mmc_power_restore,
> =A0 =A0 =A0 =A0.alive =3D mmc_alive,
> + =A0 =A0 =A0 .poweroff_notify =3D mmc_poweroff_notify,
> =A0};
>
> =A0static void mmc_attach_bus_ops(struct mmc_host *host)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index cbde4b7..cf44a6f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -238,6 +238,7 @@ struct mmc_host {
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

Hi Ulf,
need your comment on the above.
> --
> 1.7.1
>
