From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH V2] MMC-4.5 Power OFF Notify rework
Date: Tue, 1 May 2012 12:31:30 +0530
Message-ID: <000401cd2768$3e416e90$bac44bb0$@codeaurora.org>
References: <1335766496-15966-1-git-send-email-girish.shivananjappa@linaro.org>	<4F9E4FC1.3010505@stericsson.com> <CAKLKtzeDb9Un2nqYVuB76jyOAJNbve5qrWgZ7HCTASCpWXUt=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:56457 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2EAHBf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 May 2012 03:01:35 -0400
In-Reply-To: <CAKLKtzeDb9Un2nqYVuB76jyOAJNbve5qrWgZ7HCTASCpWXUt=w@mail.gmail.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Saugata Das' <saugata.das@linaro.org>, 'Ulf Hansson' <ulf.hansson@stericsson.com>
Cc: 'Girish K S' <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, patches@linaro.org



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Saugata Das
> Sent: Monday, April 30, 2012 11:17 PM
> To: Ulf Hansson
> Cc: Girish K S; linux-mmc@vger.kernel.org; patches@linaro.org
> Subject: Re: [PATCH V2] MMC-4.5 Power OFF Notify rework
>=20
> On 30 April 2012 14:09, Ulf Hansson <ulf.hansson@stericsson.com> wrot=
e:
> > On 04/30/2012 08:14 AM, Girish K S wrote:
> >>
> >> This is a rework of the existing POWER OFF NOTIFY patch. The curre=
nt
> >> problem with the patch comes from the ambiguity on the usage of PO=
WER
> >> OFF NOTIFY together with SLEEP and misunderstanding on the usage o=
f
> >> MMC_POWER_OFF power_mode from mmc_set_ios in different host
> >> controller drivers.
> >>
> >> This new patch works around this problem by adding a new host CAP,
> >> MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which when set sends
> a POWER
> >> OFF NOTIFY from mmc_suspend instead of SLEEP. It is expected that
> >> host controller drivers will set this CAP, if they switch off both
> >> Vcc and Vccq from MMC_POWER_OFF condition within mmc_set_ios.
> >> However, note that there is no harm in sending MMC_POWER_NOTIFY ev=
en
> >> if Vccq is not switched off.
> >>
> >> This patch also sends POWER OFF NOTIFY from power management
> routines
> >> (e.g.
> >> mmc_power_save_host, mmc_pm_notify/PM_SUSPEND_PREPARE,
> >> mmc_stop_host), which does reinitialization of the eMMC on the ret=
urn
> >> path of the power management routines (e.g. mmc_power_restore_host=
,
> >> mmc_pm_notify/PM_POST_RESTORE, mmc_start_host).
> >>
> >> This patch sets POWER_OFF_NOTIFICATION to POWER_OFF_SHORT if it is
> >> sent from the suspend sequence. If it is sent from shutdown sequen=
ce
> >> then it is set to POWER_OFF_LONG.
> >>
> >> Previuos implementation of PowerOff Notify as a core function is
> >> replaced as a device's bus operation.
> >>
> >> Signed-off-by: Saugata Das<saugata.das@linaro.org>
> >> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
> >> ---
> >> =A0drivers/mmc/core/core.c =A0| =A0 95
> >> +++++++++++++++------------------------------
> >> =A0drivers/mmc/core/core.h =A0| =A0 =A01 +
> >> =A0drivers/mmc/core/mmc.c =A0 | =A0 76
> >> +++++++++++++++++++++++++++++++------
> >> =A0include/linux/mmc/host.h | =A0 =A01 +
> >> =A04 files changed, 98 insertions(+), 75 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c ind=
ex
> >> ba821fe..7f5461e 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -1100,48 +1100,6 @@ void mmc_set_driver_type(struct mmc_host
> >> *host, unsigned int drv_type)
> >> =A0 =A0 =A0 =A0mmc_host_clk_release(host);
> >> =A0}
> >>
> >> -static void mmc_poweroff_notify(struct mmc_host *host) -{
> >> - =A0 =A0 =A0 struct mmc_card *card;
> >> - =A0 =A0 =A0 unsigned int timeout;
> >> - =A0 =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFI=
CATION;
> >> - =A0 =A0 =A0 int err =3D 0;
> >> -
> >> - =A0 =A0 =A0 card =3D host->card;
> >> - =A0 =A0 =A0 mmc_claim_host(host);
> >> -
> >> - =A0 =A0 =A0 /*
> >> - =A0 =A0 =A0 =A0* Send power notify command only if card
> >> - =A0 =A0 =A0 =A0* is mmc and notify state is powered ON
> >> - =A0 =A0 =A0 =A0*/
> >> - =A0 =A0 =A0 if (card&& =A0mmc_card_mmc(card)&&
> >> - =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWE=
RED_ON)) {
> >> -
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D
> >> MMC_HOST_PW_NOTIFY_SHORT) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_=
CSD_POWER_OFF_SHORT;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ex=
t_csd.generic_cmd6_time;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notif=
y_state =3D
> >> MMC_POWEROFF_SHORT;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_=
CSD_POWER_OFF_LONG;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ex=
t_csd.power_off_longtime;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notif=
y_state =3D
> >> MMC_POWEROFF_LONG;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> -
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD=
_SET_NORMAL,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0E=
XT_CSD_POWER_OFF_NOTIFICATION,
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n=
otify_type, timeout);
> >> -
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err&& =A0err !=3D -EBADMSG)
> >>
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Device faile=
d to respond within %d
> >> poweroff "
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"time=
=2E Forcefully powering down the
> >> device\n",
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeo=
ut);
> >> -
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notifica=
tion after the
> >> poweroff */
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D
> >> MMC_NO_POWER_NOTIFICATION;
> >> - =A0 =A0 =A0 }
> >> - =A0 =A0 =A0 mmc_release_host(host);
> >> -}
> >> -
> >> =A0/*
> >> =A0 * Apply power to the MMC stack. =A0This is a two-stage process=
=2E
> >> =A0 * First, we enable power to the card without the clock running=
=2E
> >> @@ -1198,30 +1156,12 @@ static void mmc_power_up(struct mmc_host
> >> *host)
> >>
> >> =A0void mmc_power_off(struct mmc_host *host)
> >> =A0{
> >> - =A0 =A0 =A0 int err =3D 0;
> >> =A0 =A0 =A0 =A0mmc_host_clk_hold(host);
> >>
> >> =A0 =A0 =A0 =A0host->ios.clock =3D 0;
> >> =A0 =A0 =A0 =A0host->ios.vdd =3D 0;
> >>
> >> =A0 =A0 =A0 =A0/*
> >> - =A0 =A0 =A0 =A0* For eMMC 4.5 device send AWAKE command before
> >> - =A0 =A0 =A0 =A0* POWER_OFF_NOTIFY command, because in sleep stat=
e
> >> - =A0 =A0 =A0 =A0* eMMC 4.5 devices respond to only RESET and AWAK=
E cmd
> >> - =A0 =A0 =A0 =A0*/
> >> - =A0 =A0 =A0 if (host->card&& =A0mmc_card_is_sleep(host->card)&&
> >> - =A0 =A0 =A0 =A0 =A0 host->bus_ops->resume) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->bus_ops->resume(host);
> >> -
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_poweroff_notify(=
host);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: erro=
r %d during resume "
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0"(continue with poweroff
> >> sequence)\n",
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0mmc_hostname(host), err);
> >> - =A0 =A0 =A0 }
> >> -
> >> - =A0 =A0 =A0 /*
> >> =A0 =A0 =A0 =A0 * Reset ocr mask to be the highest possible voltag=
e supported
> >> for
> >> =A0 =A0 =A0 =A0 * this mmc host. This value will be used at next p=
ower up.
> >> =A0 =A0 =A0 =A0 */
> >> @@ -2084,6 +2024,14 @@ void mmc_stop_host(struct mmc_host *host)
> >>
> >> =A0 =A0 =A0 =A0mmc_bus_get(host);
> >> =A0 =A0 =A0 =A0if (host->bus_ops&& =A0!host->bus_dead) {
> >>
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->poweroff_notify) =
{
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D
> >> + host->bus_ops->poweroff_notify(host);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_i=
nfo("%s: error [%x] in poweroff
> >> notify\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 mmc_hostname(host), err);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> +
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a=
 claimed host can
> >> deadlock */
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->bus_ops->remo=
ve(host); @@ -2093,6
> >> +2041,7 @@ void mmc_stop_host(struct mmc_host *host)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_power_off(host);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
> >> +
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> >> =A0 =A0 =A0 =A0}
> >> =A0 =A0 =A0 =A0mmc_bus_put(host);
> >> @@ -2119,6 +2068,13 @@ int mmc_power_save_host(struct mmc_host
> *host)
> >>
> >> =A0 =A0 =A0 =A0if (host->bus_ops->power_save)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_save(h=
ost);
> >> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_SHORT=
;
> >> + =A0 =A0 =A0 if (host->bus_ops->poweroff_notify) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D host->bus_ops->poweroff_=
notify(host);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: error [=
%x] in poweroff
> >> + notify\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_=
hostname(host), err);
> >> + =A0 =A0 =A0 }
> >>
> >> =A0 =A0 =A0 =A0mmc_bus_put(host);
> >>
> >> @@ -2142,7 +2098,7 @@ int mmc_power_restore_host(struct mmc_host
> >> *host)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> >> =A0 =A0 =A0 =A0}
> >> -
> >> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_LONG;
> >> =A0 =A0 =A0 =A0mmc_power_up(host);
> >> =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_restore(host);
> >>
> >> @@ -2161,8 +2117,11 @@ int mmc_card_awake(struct mmc_host *host)
> >>
> >> =A0 =A0 =A0 =A0mmc_bus_get(host);
> >>
> >> - =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bu=
s_ops->awake)
> >> + =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bu=
s_ops->awake)
> >> + {
> >>
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->awake(host);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(h=
ost->card);
> >> + =A0 =A0 =A0 }
> >>
> >> =A0 =A0 =A0 =A0mmc_bus_put(host);
> >>
> >> @@ -2179,8 +2138,11 @@ int mmc_card_sleep(struct mmc_host *host)
> >>
> >> =A0 =A0 =A0 =A0mmc_bus_get(host);
> >>
> >> - =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bu=
s_ops->sleep)
> >> + =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bu=
s_ops->sleep)
> >> + {
> >>
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->sleep(host);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(h=
ost->card);
> >> + =A0 =A0 =A0 }
> >>
> >> =A0 =A0 =A0 =A0mmc_bus_put(host);
> >>
> >> @@ -2379,6 +2341,12 @@ int mmc_pm_notify(struct notifier_block
> >> *notify_block,
> >>
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!host->bus_ops || host->bus_ops=
->suspend)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->poweroff_notify) =
{
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D
> >> + host->bus_ops->poweroff_notify(host);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_i=
nfo("%s: error [%x] in poweroff
> >> notify\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 mmc_hostname(host), err);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >>
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a=
 claimed host can
> >> deadlock */
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove) @@ -2388=
,6 +2356,7 @@ int
> >> mmc_pm_notify(struct notifier_block *notify_block,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detach_bus(host);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_power_off(host);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host);
> >> +
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->pm_flags =3D 0;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> >>
> >> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h ind=
ex
> >> 3bdafbc..351cbbe 100644
> >> --- a/drivers/mmc/core/core.h
> >> +++ b/drivers/mmc/core/core.h
> >> @@ -25,6 +25,7 @@ struct mmc_bus_ops {
> >> =A0 =A0 =A0 =A0int (*power_save)(struct mmc_host *);
> >> =A0 =A0 =A0 =A0int (*power_restore)(struct mmc_host *);
> >> =A0 =A0 =A0 =A0int (*alive)(struct mmc_host *);
> >> + =A0 =A0 =A0 int (*poweroff_notify)(struct mmc_host *);
> >> =A0};
> >>
> >> =A0void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus=
_ops
> >> *ops); diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.=
c
> >> index 54df5ad..11ab536 100644
> >> --- a/drivers/mmc/core/mmc.c
> >> +++ b/drivers/mmc/core/mmc.c
> >> @@ -1282,6 +1282,50 @@ err:
> >> =A0 =A0 =A0 =A0return err;
> >> =A0}
> >>
> >> +static int mmc_poweroff_notify(struct mmc_host *host) {
> >> + =A0 =A0 =A0 struct mmc_card *card;
> >> + =A0 =A0 =A0 unsigned int timeout;
> >> + =A0 =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFI=
CATION;
> >> + =A0 =A0 =A0 int err =3D -EOPNOTSUPP;
> >> +
> >> + =A0 =A0 =A0 card =3D host->card;
> >> + =A0 =A0 =A0 mmc_claim_host(host);
> >> +
> >> + =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0* Send power notify command only if card
> >> + =A0 =A0 =A0 =A0* is mmc and notify state is powered ON
> >> + =A0 =A0 =A0 =A0*/
> >> + =A0 =A0 =A0 if (card&& =A0mmc_card_mmc(card)&&
> >> + =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWE=
RED_ON)) {
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D
> >> + MMC_HOST_PW_NOTIFY_SHORT) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_=
CSD_POWER_OFF_SHORT;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ex=
t_csd.generic_cmd6_time;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notif=
y_state =3D
> >> + MMC_POWEROFF_SHORT;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_=
CSD_POWER_OFF_LONG;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ex=
t_csd.power_off_longtime;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notif=
y_state =3D
> >> + MMC_POWEROFF_LONG;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD=
_SET_NORMAL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0E=
XT_CSD_POWER_OFF_NOTIFICATION,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n=
otify_type, timeout);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err&& =A0err !=3D -EBADMSG)
> >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Device f=
ailed to respond within %d
"
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"powe=
roff time. Forcefully powering down
"
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"the =
device\n", mmc_hostname(host),
> >> timeout);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notifica=
tion after the
> >> poweroff */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D
> >> + MMC_NO_POWER_NOTIFICATION;
> >> + =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 mmc_release_host(host);
> >> +
> >> + =A0 =A0 =A0 return err;
> >> +}
> >> +
> >> =A0/*
> >> =A0 * Host is being removed. Free up the current card.
> >> =A0 */
> >> @@ -1341,15 +1385,21 @@ static int mmc_suspend(struct mmc_host
> *host)
> >> =A0 =A0 =A0 =A0BUG_ON(!host);
> >> =A0 =A0 =A0 =A0BUG_ON(!host->card);
> >>
> >> - =A0 =A0 =A0 mmc_claim_host(host);
> >> - =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(h=
ost->card);
> >> - =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(host);
> >> - =A0 =A0 =A0 host->card->state&=3D ~(MMC_STATE_HIGHSPEED |
> >> MMC_STATE_HIGHSPEED_200);
> >>
> >> - =A0 =A0 =A0 mmc_release_host(host);
> >> + =A0 =A0 =A0 if ((host->card)&& =A0mmc_card_mmc(host->card)&&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2&
> >> + MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host);
> >
> > This still wont work. What if the card supports sleep but not
> > poweroff_notify. At the same time the host is able to cut VCCQ.
> > Then the poweroff_notify will be issued and fail. Instead sleep sho=
uld
> > be issued.
> >
> > Again, a "mmc_card_can_poweroff_notify" would be useful here.
> >
>=20
> The host needs to set =A0MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND
> only if it is MMC-4.5 card (power Off notify is mandatory feature) an=
d
host can
> switch off VCCQ during suspend.

How would host driver know whether it's eMMC 4.5 card or not? It doesn'=
t
know that. Host driver just needs to set this cap during probe and then
based on which card is detected, core layer will check this patch befor=
e
sending the power off notify during suspend.


>=20
>=20
> >
> >> + =A0 =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(host);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_can_sleep(host))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sle=
ep(host);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(h=
ost);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
> >> + =A0 =A0 =A0 }
> >> +
> >> + =A0 =A0 =A0 if (!err)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->card->state&=3D
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(MMC_STATE_HIGHSPEE=
D |
> >> + MMC_STATE_HIGHSPEED_200);
> >>
> >> =A0 =A0 =A0 =A0return err;
> >> =A0}
> >> @@ -1368,11 +1418,11 @@ static int mmc_resume(struct mmc_host *hos=
t)
> >> =A0 =A0 =A0 =A0BUG_ON(!host->card);
> >>
> >> =A0 =A0 =A0 =A0mmc_claim_host(host);
> >> - =A0 =A0 =A0 if (mmc_card_is_sleep(host->card)) {
> >> + =A0 =A0 =A0 if (mmc_card_is_sleep(host->card))
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_card_awake(host);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
> >> - =A0 =A0 =A0 } else
> >> + =A0 =A0 =A0 else
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_init_card(host, host->o=
cr, host->card);
> >> +
> >> =A0 =A0 =A0 =A0mmc_release_host(host);
> >>
> >> =A0 =A0 =A0 =A0return err;
> >> @@ -1430,6 +1480,7 @@ static const struct mmc_bus_ops mmc_ops =3D =
{
> >> =A0 =A0 =A0 =A0.resume =3D NULL,
> >> =A0 =A0 =A0 =A0.power_restore =3D mmc_power_restore,
> >> =A0 =A0 =A0 =A0.alive =3D mmc_alive,
> >> + =A0 =A0 =A0 .poweroff_notify =3D mmc_poweroff_notify,
> >> =A0};
> >>
> >> =A0static const struct mmc_bus_ops mmc_ops_unsafe =3D { @@ -1441,6
> >> +1492,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe =3D {
> >> =A0 =A0 =A0 =A0.resume =3D mmc_resume,
> >> =A0 =A0 =A0 =A0.power_restore =3D mmc_power_restore,
> >> =A0 =A0 =A0 =A0.alive =3D mmc_alive,
> >> + =A0 =A0 =A0 .poweroff_notify =3D mmc_poweroff_notify,
> >> =A0};
> >>
> >> =A0static void mmc_attach_bus_ops(struct mmc_host *host) diff --gi=
t
> >> a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> >> 0707d22..986e22b 100644
> >> --- a/include/linux/mmc/host.h
> >> +++ b/include/linux/mmc/host.h
> >> @@ -238,6 +238,7 @@ struct mmc_host {
> >> =A0#define MMC_CAP2_BROKEN_VOLTAGE =A0 =A0 =A0 (1<< =A07) =A0 =A0 =
=A0 =A0/* Use the
> >> broken voltage */
> >> =A0#define MMC_CAP2_DETECT_ON_ERR =A0 =A0 =A0 =A0(1<< =A08) =A0 =A0=
 =A0 =A0/* On I/O err
> >> check card removal */
> >> =A0#define MMC_CAP2_HC_ERASE_SZ =A0(1<< =A09) =A0 =A0 =A0 =A0/* Hi=
gh-capacity erase
> >> size */
> >> +#define MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND (1<< =A010)
> >>
> >> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =
=A0 =A0/* supported pm
> >> features */
> >> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
> >
> >
> > Kind regards
> > Ulf Hansson
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

