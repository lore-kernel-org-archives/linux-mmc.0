From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH V2] MMC-4.5 Power OFF Notify rework
Date: Mon, 30 Apr 2012 23:16:56 +0530
Message-ID: <CAKLKtzeDb9Un2nqYVuB76jyOAJNbve5qrWgZ7HCTASCpWXUt=w@mail.gmail.com>
References: <1335766496-15966-1-git-send-email-girish.shivananjappa@linaro.org>
	<4F9E4FC1.3010505@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54017 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab2D3Rq5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Apr 2012 13:46:57 -0400
Received: by yhmm54 with SMTP id m54so1568758yhm.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 Apr 2012 10:46:56 -0700 (PDT)
In-Reply-To: <4F9E4FC1.3010505@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>

On 30 April 2012 14:09, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> On 04/30/2012 08:14 AM, Girish K S wrote:
>>
>> This is a rework of the existing POWER OFF NOTIFY patch. The current
>> problem
>> with the patch comes from the ambiguity on the usage of POWER OFF NO=
TIFY
>> together with SLEEP and misunderstanding on the usage of MMC_POWER_O=
=46F
>> power_mode from mmc_set_ios in different host controller drivers.
>>
>> This new patch works around this problem by adding a new host CAP,
>> MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which when set sends a
>> POWER OFF NOTIFY from mmc_suspend instead of SLEEP. It is expected t=
hat
>> host
>> controller drivers will set this CAP, if they switch off both Vcc an=
d Vccq
>> from MMC_POWER_OFF condition within mmc_set_ios. However, note that =
there
>> is no harm in sending MMC_POWER_NOTIFY even if Vccq is not switched =
off.
>>
>> This patch also sends POWER OFF NOTIFY from power management routine=
s
>> (e.g.
>> mmc_power_save_host, mmc_pm_notify/PM_SUSPEND_PREPARE, mmc_stop_host=
),
>> which
>> does reinitialization of the eMMC on the return path of the power
>> management
>> routines (e.g. mmc_power_restore_host, mmc_pm_notify/PM_POST_RESTORE=
,
>> mmc_start_host).
>>
>> This patch sets POWER_OFF_NOTIFICATION to POWER_OFF_SHORT if it is s=
ent
>> from
>> the suspend sequence. If it is sent from shutdown sequence then it i=
s set
>> to
>> POWER_OFF_LONG.
>>
>> Previuos implementation of PowerOff Notify as a core function is rep=
laced
>> as
>> a device's bus operation.
>>
>> Signed-off-by: Saugata Das<saugata.das@linaro.org>
>> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
>> ---
>> =A0drivers/mmc/core/core.c =A0| =A0 95
>> +++++++++++++++------------------------------
>> =A0drivers/mmc/core/core.h =A0| =A0 =A01 +
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 76 +++++++++++++++++++++++++++++=
++------
>> =A0include/linux/mmc/host.h | =A0 =A01 +
>> =A04 files changed, 98 insertions(+), 75 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index ba821fe..7f5461e 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1100,48 +1100,6 @@ void mmc_set_driver_type(struct mmc_host *hos=
t,
>> unsigned int drv_type)
>> =A0 =A0 =A0 =A0mmc_host_clk_release(host);
>> =A0}
>>
>> -static void mmc_poweroff_notify(struct mmc_host *host)
>> -{
>> - =A0 =A0 =A0 struct mmc_card *card;
>> - =A0 =A0 =A0 unsigned int timeout;
>> - =A0 =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFICA=
TION;
>> - =A0 =A0 =A0 int err =3D 0;
>> -
>> - =A0 =A0 =A0 card =3D host->card;
>> - =A0 =A0 =A0 mmc_claim_host(host);
>> -
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* Send power notify command only if card
>> - =A0 =A0 =A0 =A0* is mmc and notify state is powered ON
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 if (card&& =A0mmc_card_mmc(card)&&
>> - =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWERE=
D_ON)) {
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MMC=
_HOST_PW_NOTIFY_SHORT) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CS=
D_POWER_OFF_SHORT;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_=
csd.generic_cmd6_time;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_=
state =3D MMC_POWEROFF_SHORT;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CS=
D_POWER_OFF_LONG;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_=
csd.power_off_longtime;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_=
state =3D MMC_POWEROFF_LONG;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_POWER_OFF_NOTIFICATION,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0not=
ify_type, timeout);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err&& =A0err !=3D -EBADMSG)
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Device failed =
to respond within %d
>> poweroff "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"time. =
=46orcefully powering down the
>> device\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout=
);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notificati=
on after the
>> poweroff */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D MMC_NO=
_POWER_NOTIFICATION;
>> - =A0 =A0 =A0 }
>> - =A0 =A0 =A0 mmc_release_host(host);
>> -}
>> -
>> =A0/*
>> =A0 * Apply power to the MMC stack. =A0This is a two-stage process.
>> =A0 * First, we enable power to the card without the clock running.
>> @@ -1198,30 +1156,12 @@ static void mmc_power_up(struct mmc_host *ho=
st)
>>
>> =A0void mmc_power_off(struct mmc_host *host)
>> =A0{
>> - =A0 =A0 =A0 int err =3D 0;
>> =A0 =A0 =A0 =A0mmc_host_clk_hold(host);
>>
>> =A0 =A0 =A0 =A0host->ios.clock =3D 0;
>> =A0 =A0 =A0 =A0host->ios.vdd =3D 0;
>>
>> =A0 =A0 =A0 =A0/*
>> - =A0 =A0 =A0 =A0* For eMMC 4.5 device send AWAKE command before
>> - =A0 =A0 =A0 =A0* POWER_OFF_NOTIFY command, because in sleep state
>> - =A0 =A0 =A0 =A0* eMMC 4.5 devices respond to only RESET and AWAKE =
cmd
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 if (host->card&& =A0mmc_card_is_sleep(host->card)&&
>> - =A0 =A0 =A0 =A0 =A0 host->bus_ops->resume) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->bus_ops->resume(host);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_poweroff_notify(ho=
st);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: error =
%d during resume "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"(continue with poweroff sequence)\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mmc_hostname(host), err);
>> - =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 * Reset ocr mask to be the highest possible voltage =
supported for
>> =A0 =A0 =A0 =A0 * this mmc host. This value will be used at next pow=
er up.
>> =A0 =A0 =A0 =A0 */
>> @@ -2084,6 +2024,14 @@ void mmc_stop_host(struct mmc_host *host)
>>
>> =A0 =A0 =A0 =A0mmc_bus_get(host);
>> =A0 =A0 =A0 =A0if (host->bus_ops&& =A0!host->bus_dead) {
>>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->poweroff_notify) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D host->bus_=
ops->poweroff_notify(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_inf=
o("%s: error [%x] in poweroff
>> notify\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(host), err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a c=
laimed host can
>> deadlock */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->bus_ops->remove=
(host);
>> @@ -2093,6 +2041,7 @@ void mmc_stop_host(struct mmc_host *host)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_power_off(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>> @@ -2119,6 +2068,13 @@ int mmc_power_save_host(struct mmc_host *host=
)
>>
>> =A0 =A0 =A0 =A0if (host->bus_ops->power_save)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_save(hos=
t);
>> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_SHORT;
>> + =A0 =A0 =A0 if (host->bus_ops->poweroff_notify) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D host->bus_ops->poweroff_no=
tify(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: error [%x=
] in poweroff notify\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ho=
stname(host), err);
>> + =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>
>> @@ -2142,7 +2098,7 @@ int mmc_power_restore_host(struct mmc_host *ho=
st)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0 =A0 =A0 =A0}
>> -
>> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_LONG;
>> =A0 =A0 =A0 =A0mmc_power_up(host);
>> =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_restore(host);
>>
>> @@ -2161,8 +2117,11 @@ int mmc_card_awake(struct mmc_host *host)
>>
>> =A0 =A0 =A0 =A0mmc_bus_get(host);
>>
>> - =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bus_=
ops->awake)
>> + =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bus_=
ops->awake) {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->awake(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(hos=
t->card);
>> + =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>
>> @@ -2179,8 +2138,11 @@ int mmc_card_sleep(struct mmc_host *host)
>>
>> =A0 =A0 =A0 =A0mmc_bus_get(host);
>>
>> - =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bus_=
ops->sleep)
>> + =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bus_=
ops->sleep) {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->sleep(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(hos=
t->card);
>> + =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>
>> @@ -2379,6 +2341,12 @@ int mmc_pm_notify(struct notifier_block
>> *notify_block,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!host->bus_ops || host->bus_ops->=
suspend)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->poweroff_notify) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D host->bus_=
ops->poweroff_notify(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_inf=
o("%s: error [%x] in poweroff
>> notify\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(host), err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a c=
laimed host can
>> deadlock */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
>> @@ -2388,6 +2356,7 @@ int mmc_pm_notify(struct notifier_block
>> *notify_block,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detach_bus(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_power_off(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->pm_flags =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index 3bdafbc..351cbbe 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -25,6 +25,7 @@ struct mmc_bus_ops {
>> =A0 =A0 =A0 =A0int (*power_save)(struct mmc_host *);
>> =A0 =A0 =A0 =A0int (*power_restore)(struct mmc_host *);
>> =A0 =A0 =A0 =A0int (*alive)(struct mmc_host *);
>> + =A0 =A0 =A0 int (*poweroff_notify)(struct mmc_host *);
>> =A0};
>>
>> =A0void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_o=
ps
>> *ops);
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 54df5ad..11ab536 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1282,6 +1282,50 @@ err:
>> =A0 =A0 =A0 =A0return err;
>> =A0}
>>
>> +static int mmc_poweroff_notify(struct mmc_host *host)
>> +{
>> + =A0 =A0 =A0 struct mmc_card *card;
>> + =A0 =A0 =A0 unsigned int timeout;
>> + =A0 =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFICA=
TION;
>> + =A0 =A0 =A0 int err =3D -EOPNOTSUPP;
>> +
>> + =A0 =A0 =A0 card =3D host->card;
>> + =A0 =A0 =A0 mmc_claim_host(host);
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Send power notify command only if card
>> + =A0 =A0 =A0 =A0* is mmc and notify state is powered ON
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (card&& =A0mmc_card_mmc(card)&&
>> + =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWERE=
D_ON)) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MMC=
_HOST_PW_NOTIFY_SHORT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CS=
D_POWER_OFF_SHORT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_=
csd.generic_cmd6_time;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_=
state =3D MMC_POWEROFF_SHORT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CS=
D_POWER_OFF_LONG;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_=
csd.power_off_longtime;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_=
state =3D MMC_POWEROFF_LONG;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT=
_CSD_POWER_OFF_NOTIFICATION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0not=
ify_type, timeout);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err&& =A0err !=3D -EBADMSG)
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Device fai=
led to respond within %d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"powero=
ff time. Forcefully powering down "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"the de=
vice\n", mmc_hostname(host),
>> timeout);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notificati=
on after the
>> poweroff */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D MMC_NO=
_POWER_NOTIFICATION;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 mmc_release_host(host);
>> +
>> + =A0 =A0 =A0 return err;
>> +}
>> +
>> =A0/*
>> =A0 * Host is being removed. Free up the current card.
>> =A0 */
>> @@ -1341,15 +1385,21 @@ static int mmc_suspend(struct mmc_host *host=
)
>> =A0 =A0 =A0 =A0BUG_ON(!host);
>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>
>> - =A0 =A0 =A0 mmc_claim_host(host);
>> - =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(hos=
t->card);
>> - =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(host);
>> - =A0 =A0 =A0 host->card->state&=3D ~(MMC_STATE_HIGHSPEED |
>> MMC_STATE_HIGHSPEED_200);
>>
>> - =A0 =A0 =A0 mmc_release_host(host);
>> + =A0 =A0 =A0 if ((host->card)&& =A0mmc_card_mmc(host->card)&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2& =A0MMC_CAP2_POWER_OFF_VC=
CQ_DURING_SUSPEND)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host);
>
> This still wont work. What if the card supports sleep but not
> poweroff_notify. At the same time the host is able to cut VCCQ.
> Then the poweroff_notify will be issued and fail. Instead sleep shoul=
d be
> issued.
>
> Again, a "mmc_card_can_poweroff_notify" would be useful here.
>

The host needs to set =A0MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND only if
it is MMC-4.5 card (power Off notify is mandatory feature) and host
can switch off VCCQ during suspend.


>
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_can_sleep(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep=
(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(hos=
t);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->card->state&=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(MMC_STATE_HIGHSPEED =
| MMC_STATE_HIGHSPEED_200);
>>
>> =A0 =A0 =A0 =A0return err;
>> =A0}
>> @@ -1368,11 +1418,11 @@ static int mmc_resume(struct mmc_host *host)
>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>> - =A0 =A0 =A0 if (mmc_card_is_sleep(host->card)) {
>> + =A0 =A0 =A0 if (mmc_card_is_sleep(host->card))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_card_awake(host);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
>> - =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_init_card(host, host->ocr=
, host->card);
>> +
>> =A0 =A0 =A0 =A0mmc_release_host(host);
>>
>> =A0 =A0 =A0 =A0return err;
>> @@ -1430,6 +1480,7 @@ static const struct mmc_bus_ops mmc_ops =3D {
>> =A0 =A0 =A0 =A0.resume =3D NULL,
>> =A0 =A0 =A0 =A0.power_restore =3D mmc_power_restore,
>> =A0 =A0 =A0 =A0.alive =3D mmc_alive,
>> + =A0 =A0 =A0 .poweroff_notify =3D mmc_poweroff_notify,
>> =A0};
>>
>> =A0static const struct mmc_bus_ops mmc_ops_unsafe =3D {
>> @@ -1441,6 +1492,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe=
 =3D {
>> =A0 =A0 =A0 =A0.resume =3D mmc_resume,
>> =A0 =A0 =A0 =A0.power_restore =3D mmc_power_restore,
>> =A0 =A0 =A0 =A0.alive =3D mmc_alive,
>> + =A0 =A0 =A0 .poweroff_notify =3D mmc_poweroff_notify,
>> =A0};
>>
>> =A0static void mmc_attach_bus_ops(struct mmc_host *host)
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 0707d22..986e22b 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -238,6 +238,7 @@ struct mmc_host {
>> =A0#define MMC_CAP2_BROKEN_VOLTAGE =A0 =A0 =A0 (1<< =A07) =A0 =A0 =A0=
 =A0/* Use the broken
>> voltage */
>> =A0#define MMC_CAP2_DETECT_ON_ERR =A0 =A0 =A0 =A0(1<< =A08) =A0 =A0 =
=A0 =A0/* On I/O err check
>> card removal */
>> =A0#define MMC_CAP2_HC_ERASE_SZ =A0(1<< =A09) =A0 =A0 =A0 =A0/* High=
-capacity erase size
>> */
>> +#define MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND (1<< =A010)
>>
>> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
>
>
> Kind regards
> Ulf Hansson
