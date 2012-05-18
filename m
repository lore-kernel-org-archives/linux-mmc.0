From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v3] MMC-4.5 Power OFF Notify Rework
Date: Fri, 18 May 2012 22:43:38 +0530
Message-ID: <CAKLKtzdkTG7kb=oUaK=s8_zYfLBXHgpDxwkGrtZTXeg2K4Lj5Q@mail.gmail.com>
References: <1337334413-25596-1-git-send-email-girish.shivananjappa@linaro.org>
	<4FB62B8F.60809@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:43714 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221Ab2ERRNk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 May 2012 13:13:40 -0400
Received: by qabj40 with SMTP id j40so503363qab.1
        for <linux-mmc@vger.kernel.org>; Fri, 18 May 2012 10:13:39 -0700 (PDT)
In-Reply-To: <4FB62B8F.60809@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, patches@linaro.org, ulf.hansson@stericsson.com, cjb@laptop.org

On 18 May 2012 16:29, Subhash Jadavani <subhashj@codeaurora.org> wrote:
> On 5/18/2012 3:16 PM, Girish K S wrote:
>>
>> From: Saugata Das<saugata.das@linaro.org>
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
>
>
> s/perviuos/previous
>
>> a device's bus operation.
>>
>> Signed-off-by: Saugata Das<saugata.das@linaro.org>
>> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
>>
>> changes in v4:
>> =A0 =A0 =A0 =A0As suggested in review,
>> =A0 =A0 =A0 =A0- Moved mmc_can_poweroff_notify to core.c
>> =A0 =A0 =A0 =A0- Moved mmc_claim_host, mmc_release_host outside
>> mmc_poweroff_notify
>> =A0 =A0 =A0 =A0- Added check for wrong initialization for poweroff_n=
otify_type
>> =A0 =A0 =A0 =A0- mmc_poweroff_notify is modified to take as 2nd para=
meter
>> changes in v3:
>> =A0 =A0 =A0 =A0This version addresses the review comments given by S=
ubhash and Ulf
>> changes in v2:
>> =A0 =A0 =A0 =A0This version addresses the changes suggested by Ulf
>> ---
>> =A0drivers/mmc/core/core.c =A0 | =A0106
>> ++++++++++++++++++---------------------------
>> =A0drivers/mmc/core/core.h =A0 | =A0 =A01 +
>> =A0drivers/mmc/core/mmc.c =A0 =A0| =A0 56 ++++++++++++++++++++---
>> =A0drivers/mmc/host/dw_mmc.c | =A0 =A05 --
>> =A0drivers/mmc/host/sdhci.c =A0| =A0 =A09 ----
>> =A0include/linux/mmc/card.h =A0| =A0 =A05 +-
>> =A0include/linux/mmc/core.h =A0| =A0 =A01 +
>> =A0include/linux/mmc/host.h =A0| =A0 =A05 +--
>> =A0include/linux/mmc/mmc.h =A0 | =A0 =A07 +++
>> =A09 files changed, 102 insertions(+), 93 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 0b6141d..3011122 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1101,48 +1101,6 @@ void mmc_set_driver_type(struct mmc_host *hos=
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
>> @@ -1202,8 +1160,6 @@ static void mmc_power_up(struct mmc_host *host=
)
>>
>> =A0void mmc_power_off(struct mmc_host *host)
>> =A0{
>> - =A0 =A0 =A0 int err =3D 0;
>> -
>> =A0 =A0 =A0 =A0if (host->ios.power_mode =3D=3D MMC_POWER_OFF)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>
>> @@ -1212,22 +1168,6 @@ void mmc_power_off(struct mmc_host *host)
>> =A0 =A0 =A0 =A0host->ios.clock =3D 0;
>> =A0 =A0 =A0 =A0host->ios.vdd =3D 0;
>>
>> - =A0 =A0 =A0 /*
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
>>
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * Reset ocr mask to be the highest possible voltage =
supported for
>> @@ -1725,6 +1665,13 @@ int mmc_can_secure_erase_trim(struct mmc_card
>> *card)
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>> =A0EXPORT_SYMBOL(mmc_can_secure_erase_trim);
>> +int mmc_can_poweroff_notify(const struct mmc_card *card)
>
> Have one line space before this function.
>>
>> +{
>> + =A0 =A0 =A0 return card&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_mmc(card)&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->bus_ops->poweroff_notify&&
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MM=
C_POWERED_ON);
>> +}
>
>
> EXPORT_SYMBOL(mmc_can_poweroff_notify) missing?
>
>>
>> =A0int mmc_erase_group_aligned(struct mmc_card *card, unsigned int f=
rom,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int =
nr)
>> @@ -2096,6 +2043,15 @@ void mmc_stop_host(struct mmc_host *host)
>>
>> =A0 =A0 =A0 =A0mmc_bus_get(host);
>> =A0 =A0 =A0 =A0if (host->bus_ops&& =A0!host->bus_dead) {
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_can_poweroff_notify(host->card=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D host->bus_=
ops->poweroff_notify(host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 MMC_PW_OFF_NOTIFY_LONG);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_inf=
o("%s: error [%d] in poweroff
>> notify\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(host), err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a c=
laimed host can
>> deadlock */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->bus_ops->remove=
(host);
>> @@ -2131,6 +2087,15 @@ int mmc_power_save_host(struct mmc_host *host=
)
>>
>> =A0 =A0 =A0 =A0if (host->bus_ops->power_save)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_save(hos=
t);
>> + =A0 =A0 =A0 mmc_claim_host(host);
>> + =A0 =A0 =A0 if (mmc_can_poweroff_notify(host->card)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D host->bus_ops->poweroff_no=
tify(host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 MMC_PW_OFF_NOTIFY_SHORT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: error [%d=
] in poweroff notify\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ho=
stname(host), err);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 mmc_release_host(host);
>>
>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>
>> @@ -2173,8 +2138,11 @@ int mmc_card_awake(struct mmc_host *host)
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
>> @@ -2191,8 +2159,11 @@ int mmc_card_sleep(struct mmc_host *host)
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
>> @@ -2385,12 +2356,20 @@ int mmc_pm_notify(struct notifier_block
>> *notify_block,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags)=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->rescan_disable =3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_P=
W_NOTIFY_SHORT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, f=
lags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cancel_delayed_work_sync(&host->detec=
t);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!host->bus_ops || host->bus_ops->=
suspend)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_can_poweroff_notify(host->card=
)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D host->bus_=
ops->poweroff_notify(host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 MMC_PW_OFF_NOTIFY_SHORT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_inf=
o("%s: error [%d] in poweroff
>> notify\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(host), err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a c=
laimed host can
>> deadlock */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
>> @@ -2409,7 +2388,6 @@ int mmc_pm_notify(struct notifier_block
>> *notify_block,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags)=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->rescan_disable =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_P=
W_NOTIFY_LONG;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, f=
lags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detect_change(host, 0);
>>
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index 3bdafbc..15b918d 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -25,6 +25,7 @@ struct mmc_bus_ops {
>> =A0 =A0 =A0 =A0int (*power_save)(struct mmc_host *);
>> =A0 =A0 =A0 =A0int (*power_restore)(struct mmc_host *);
>> =A0 =A0 =A0 =A0int (*alive)(struct mmc_host *);
>> + =A0 =A0 =A0 int (*poweroff_notify)(struct mmc_host *, int notify);
>> =A0};
>>
>> =A0void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_o=
ps
>> *ops);
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 2f0e11c..eecee6f 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1259,6 +1259,40 @@ err:
>> =A0 =A0 =A0 =A0return err;
>> =A0}
>>
>> +static int mmc_poweroff_notify(struct mmc_host *host, int notify)
>> +{
>> + =A0 =A0 =A0 struct mmc_card *card;
>> + =A0 =A0 =A0 unsigned int timeout;
>> + =A0 =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFICA=
TION;
>> + =A0 =A0 =A0 int err;
>> +
>> + =A0 =A0 =A0 card =3D host->card;
>> +
>> + =A0 =A0 =A0 if (notify =3D=3D MMC_PW_OFF_NOTIFY_SHORT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_POWER_OFF_SHOR=
T;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd.generic_cmd6=
_time;
>> + =A0 =A0 =A0 } else if (notify =3D=3D MMC_PW_OFF_NOTIFY_LONG) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_POWER_OFF_LONG=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd.power_off_lo=
ngtime;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: mmc_poweroff_notify calle=
d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"with notify type %d\n"=
, mmc_hostname(host),
>> notify);
>
> Formatting comment: start of "with .." can be aligned with "%s: ...".
> Also, in else part, it should be treated as error and error should be
> returned to the caller.
>
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_POWER_OFF_N=
OTIFICATION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0notify_type, timeou=
t);
>> +
>> + =A0 =A0 =A0 if (err&& =A0err !=3D -EBADMSG)
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Device failed to respond w=
ithin %d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"poweroff time. Forcefu=
lly powering down "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"the device\n", mmc_hos=
tname(host), timeout);
>
>
> what does "Forcefully powering down the device" mean here? If i see t=
he
> mmc_suspend(), if mmc_poweroff_notify() returns error then we are ret=
urning
> the error to mmc_suspend_host() as well which will not power off the
> card if mmc_suspend() returns error.
>

You are right. The pr_err here can just state that there has been a
failure in the power OFF notify and return the error. In case of no
error (including EBADMSG), it can set poweroff_notify_state to
MMC_NO_POWER_NOTIFICATION.

We will wait for any other comments before coming back with the next
version (taking care of your other comments as well).

>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 MMC_NO_POWER_NOTIFICATION;
>
> Do you still want the poweroff_notify_state to NO_POWER_NOTIFICATION =
if err
> =3D -EBADMSG ?
>>
>> +
>> + =A0 =A0 =A0 return err;
>> +}
>> =A0/*
>> =A0 * Host is being removed. Free up the current card.
>> =A0 */
>> @@ -1319,13 +1353,18 @@ static int mmc_suspend(struct mmc_host *host=
)
>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>> - =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(hos=
t->card);
>> - =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(host);
>> - =A0 =A0 =A0 host->card->state&=3D ~(MMC_STATE_HIGHSPEED |
>> MMC_STATE_HIGHSPEED_200);
>> + =A0 =A0 =A0 if (mmc_can_poweroff_notify(host->card)&&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2& =A0MMC_CAP2_POWER_OFF_VC=
CQ_DURING_SUSPEND)) {
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host, MMC_=
PW_OFF_NOTIFY_SHORT);
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_can_sleep(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep=
(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(hos=
t);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->card->state&=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(MMC_STATE_HIGHSPEED =
| MMC_STATE_HIGHSPEED_200);
>> =A0 =A0 =A0 =A0mmc_release_host(host);
>>
>> =A0 =A0 =A0 =A0return err;
>> @@ -1347,7 +1386,6 @@ static int mmc_resume(struct mmc_host *host)
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>> =A0 =A0 =A0 =A0if (mmc_card_is_sleep(host->card)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_card_awake(host);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
>> =A0 =A0 =A0 =A0} else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_init_card(host, host->ocr=
, host->card);
>> =A0 =A0 =A0 =A0mmc_release_host(host);
>> @@ -1407,6 +1445,7 @@ static const struct mmc_bus_ops mmc_ops =3D {
>> =A0 =A0 =A0 =A0.resume =3D NULL,
>> =A0 =A0 =A0 =A0.power_restore =3D mmc_power_restore,
>> =A0 =A0 =A0 =A0.alive =3D mmc_alive,
>> + =A0 =A0 =A0 .poweroff_notify =3D mmc_poweroff_notify,
>> =A0};
>>
>> =A0static const struct mmc_bus_ops mmc_ops_unsafe =3D {
>> @@ -1418,6 +1457,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe=
 =3D {
>> =A0 =A0 =A0 =A0.resume =3D mmc_resume,
>> =A0 =A0 =A0 =A0.power_restore =3D mmc_power_restore,
>> =A0 =A0 =A0 =A0.alive =3D mmc_alive,
>> + =A0 =A0 =A0 .poweroff_notify =3D mmc_poweroff_notify,
>> =A0};
>>
>> =A0static void mmc_attach_bus_ops(struct mmc_host *host)
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 1532357..463130f 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1788,11 +1788,6 @@ static int __init dw_mci_init_slot(struct dw_=
mci
>> *host, unsigned int id)
>> =A0 =A0 =A0 =A0if (host->pdata->quirks& =A0DW_MCI_QUIRK_HIGHSPEED)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SD_HIGHSPEED |=
 MMC_CAP_MMC_HIGHSPEED;
>>
>> - =A0 =A0 =A0 if (mmc->caps2& =A0MMC_CAP2_POWEROFF_NOTIFY)
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW=
_NOTIFY_SHORT;
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW=
_NOTIFY_NONE;
>> -
>> =A0 =A0 =A0 =A0if (host->pdata->blk_settings) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_segs =3D host->pdata->blk_se=
ttings->max_segs;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->max_blk_size =3D
>> host->pdata->blk_settings->max_blk_size;
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index e626732..c0a5a91 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2812,15 +2812,6 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 =A0if (caps[1]& =A0SDHCI_DRIVER_TYPE_D)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_DRIVER_TYPE_D;
>>
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* If Power Off Notify capability is enabled by the =
host,
>> - =A0 =A0 =A0 =A0* set notify to short power off notify timeout valu=
e.
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 if (mmc->caps2& =A0MMC_CAP2_POWEROFF_NOTIFY)
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW=
_NOTIFY_SHORT;
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW=
_NOTIFY_NONE;
>> -
>> =A0 =A0 =A0 =A0/* Initial value for re-tuning timer count */
>> =A0 =A0 =A0 =A0host->tuning_count =3D (caps[1]& =A0SDHCI_RETUNING_TI=
MER_COUNT_MASK)>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_RETUNING_TIMER_=
COUNT_SHIFT;
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index d76513b..040eec4 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -239,11 +239,10 @@ struct mmc_card {
>> =A0#define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8) /* Avoid sending 51=
2 bytes
>> in */
>> =A0#define MMC_QUIRK_LONG_READ_TIME (1<<9) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /* Data read time>
>> =A0CSD says */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0/* byte mode */
>> - =A0 =A0 =A0 unsigned int =A0 =A0poweroff_notify_state; =A0/* eMMC4=
=2E5 notify feature
>> */
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0poweroff_notify_st=
ate; /* MMC-4.5 poweroff
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify feature */
>> =A0#define MMC_NO_POWER_NOTIFICATION =A0 =A0 0
>> =A0#define MMC_POWERED_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A01
>> -#define MMC_POWEROFF_SHORT =A0 =A0 =A0 =A0 =A0 =A0 2
>> -#define MMC_POWEROFF_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A03
>>
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0=
 /* erase size in sectors */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0 =
=A0/* if erase unit is power 2
>> */
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index 1b431c7..54894d6 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -161,6 +161,7 @@ extern int mmc_can_trim(struct mmc_card *card);
>> =A0extern int mmc_can_discard(struct mmc_card *card);
>> =A0extern int mmc_can_sanitize(struct mmc_card *card);
>> =A0extern int mmc_can_secure_erase_trim(struct mmc_card *card);
>> +extern int mmc_can_poweroff_notify(const struct mmc_card *card);
>> =A0extern int mmc_erase_group_aligned(struct mmc_card *card, unsigne=
d int
>> from,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
unsigned int nr);
>> =A0extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 0707d22..0e9adac 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -238,12 +238,9 @@ struct mmc_host {
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
>> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
>> -#define MMC_HOST_PW_NOTIFY_NONE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> -#define MMC_HOST_PW_NOTIFY_SHORT =A0 =A0 =A0 1
>> -#define MMC_HOST_PW_NOTIFY_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
>>
>> =A0#ifdef CONFIG_MMC_CLKGATE
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_reque=
sts; =A0 /* internal reference
>> counter */
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index d425cab..b11876b 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -386,4 +386,11 @@ struct _mmc_csd {
>> =A0#define MMC_SWITCH_MODE_CLEAR_BITS =A0 =A00x02 =A0 =A0/* Clear bi=
ts which are 1
>> in value */
>> =A0#define MMC_SWITCH_MODE_WRITE_BYTE =A0 =A00x03 =A0 =A0/* Set targ=
et to value */
>>
>> +/*
>> + * MMC Poweroff Notify types
>> + */
>> +#define MMC_PW_OFF_NOTIFY_NONE =A0 =A0 =A0 =A0 0
>> +#define MMC_PW_OFF_NOTIFY_SHORT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
>> +#define MMC_PW_OFF_NOTIFY_LONG =A0 =A0 =A0 =A0 2
>> +
>> =A0#endif /* LINUX_MMC_MMC_H */
>
>
