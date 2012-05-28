From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v5] MMC-4.5 Power OFF Notify Rework
Date: Mon, 28 May 2012 20:37:53 +0530
Message-ID: <CAKLKtze7etHH1W4xeQ0oFf7JWKkoAnsCY6S2Qhjc1fZdgsO6mQ@mail.gmail.com>
References: <1337687104-19376-1-git-send-email-girish.shivananjappa@linaro.org>
	<001101cd3cc1$89cb5010$9d61f030$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47140 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab2E1PHy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 May 2012 11:07:54 -0400
Received: by qcro28 with SMTP id o28so1486271qcr.19
        for <linux-mmc@vger.kernel.org>; Mon, 28 May 2012 08:07:53 -0700 (PDT)
In-Reply-To: <001101cd3cc1$89cb5010$9d61f030$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org, ulf.hansson@stericsson.com, asutoshd@codeaurora.org

On 28 May 2012 16:33, Subhash Jadavani <subhashj@codeaurora.org> wrote:
> Hi Girish, Saugata,
>
> There is an issue with this patch during resume. Please find comments=
 inline
> below:
>
>> -----Original Message-----
>> From: Girish K S [mailto:girish.shivananjappa@linaro.org]
>> Sent: Tuesday, May 22, 2012 5:15 PM
>> To: linux-mmc@vger.kernel.org
>> Cc: cjb@laptop.org; patches@linaro.org; ulf.hansson@stericsson.com;
>> saugata.das@linaro.org; subhashj@codeaurora.org; Girish K S
>> Subject: [PATCH v5] MMC-4.5 Power OFF Notify Rework
>>
>> From: Saugata Das <saugata.das@linaro.org>
>>
>> This is a rework of the existing POWER OFF NOTIFY patch. The current
> problem
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
>> host controller drivers will set this CAP, if they switch off both V=
cc and
> Vccq
>> from MMC_POWER_OFF condition within mmc_set_ios. However, note that
>> there is no harm in sending MMC_POWER_NOTIFY even if Vccq is not swi=
tched
>> off.
>>
>> This patch also sends POWER OFF NOTIFY from power management routine=
s
>> (e.g.
>> mmc_power_save_host, mmc_pm_notify/PM_SUSPEND_PREPARE,
>> mmc_stop_host), which does reinitialization of the eMMC on the retur=
n path
> of
>> the power management routines (e.g. mmc_power_restore_host,
>> mmc_pm_notify/PM_POST_RESTORE, mmc_start_host).
>>
>> This patch sets POWER_OFF_NOTIFICATION to POWER_OFF_SHORT if it is s=
ent
>> from the suspend sequence. If it is sent from shutdown sequence then=
 it is
> set
>> to POWER_OFF_LONG.
>>
>> Earlier implementation of PowerOff Notify as a core function is repl=
aced
> as a
>> device's bus operation.
>>
>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>>
>> changes in v5:
>> =A0 =A0 =A0 modified the the handling of return value in mmc_powerof=
f_notify.
>> changes in v4:
>> =A0 =A0 =A0 As suggested in review,
>> =A0 =A0 =A0 - Moved mmc_can_poweroff_notify to core.c
>> =A0 =A0 =A0 - Moved mmc_claim_host, mmc_release_host outside
>> mmc_poweroff_notify
>> =A0 =A0 =A0 - Added check for wrong initialization for poweroff_noti=
fy_type
>> =A0 =A0 =A0 - mmc_poweroff_notify is modified to take as 2nd paramet=
er changes
>> in v3:
>> =A0 =A0 =A0 This version addresses the review comments given by Subh=
ash and Ulf
>> changes in v2:
>> =A0 =A0 =A0 This version addresses the changes suggested by Ulf
>> ---
>> =A0drivers/mmc/core/core.c =A0 | =A0108
> ++++++++++++++++++--------------------------
>> =A0drivers/mmc/core/core.h =A0 | =A0 =A01 +
>> =A0drivers/mmc/core/mmc.c =A0 =A0| =A0 56 ++++++++++++++++++++---
>> =A0drivers/mmc/host/dw_mmc.c | =A0 =A05 --
>> =A0drivers/mmc/host/sdhci.c =A0| =A0 =A09 ----
>> =A0include/linux/mmc/card.h =A0| =A0 =A05 +-
>> =A0include/linux/mmc/core.h =A0| =A0 =A01 +
>> =A0include/linux/mmc/host.h =A0| =A0 =A05 +--
>> =A0include/linux/mmc/mmc.h =A0 | =A0 =A07 +++
>> =A09 files changed, 104 insertions(+), 93 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>> 0b6141d..fe616b9 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1101,48 +1101,6 @@ void mmc_set_driver_type(struct mmc_host *hos=
t,
>> unsigned int drv_type)
>> =A0 =A0 =A0 mmc_host_clk_release(host);
>> =A0}
>>
>> -static void mmc_poweroff_notify(struct mmc_host *host) -{
>> - =A0 =A0 struct mmc_card *card;
>> - =A0 =A0 unsigned int timeout;
>> - =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFICATION=
;
>> - =A0 =A0 int err =3D 0;
>> -
>> - =A0 =A0 card =3D host->card;
>> - =A0 =A0 mmc_claim_host(host);
>> -
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* Send power notify command only if card
>> - =A0 =A0 =A0* is mmc and notify state is powered ON
>> - =A0 =A0 =A0*/
>> - =A0 =A0 if (card && mmc_card_mmc(card) &&
>> - =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWERED_ON=
)) {
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D
>> MMC_HOST_PW_NOTIFY_SHORT) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_PO=
WER_OFF_SHORT;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd.=
generic_cmd6_time;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_stat=
e =3D
>> MMC_POWEROFF_SHORT;
>> - =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_PO=
WER_OFF_LONG;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd.=
power_off_longtime;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_stat=
e =3D
>> MMC_POWEROFF_LONG;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_N=
ORMAL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD=
_POWER_OFF_NOTIFICATION,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0notify_=
type, timeout);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Device failed to r=
espond within %d poweroff
> "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"time. Forc=
efully powering down the
> device\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notification a=
fter the poweroff
> */
>> - =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D
>> MMC_NO_POWER_NOTIFICATION;
>> - =A0 =A0 }
>> - =A0 =A0 mmc_release_host(host);
>> -}
>> -
>> =A0/*
>> =A0 * Apply power to the MMC stack. =A0This is a two-stage process.
>> =A0 * First, we enable power to the card without the clock running.
>> @@ -1202,8 +1160,6 @@ static void mmc_power_up(struct mmc_host *host=
)
>>
>> =A0void mmc_power_off(struct mmc_host *host) =A0{
>> - =A0 =A0 int err =3D 0;
>> -
>> =A0 =A0 =A0 if (host->ios.power_mode =3D=3D MMC_POWER_OFF)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> @@ -1212,22 +1168,6 @@ void mmc_power_off(struct mmc_host *host)
>> =A0 =A0 =A0 host->ios.clock =3D 0;
>> =A0 =A0 =A0 host->ios.vdd =3D 0;
>>
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* For eMMC 4.5 device send AWAKE command before
>> - =A0 =A0 =A0* POWER_OFF_NOTIFY command, because in sleep state
>> - =A0 =A0 =A0* eMMC 4.5 devices respond to only RESET and AWAKE cmd
>> - =A0 =A0 =A0*/
>> - =A0 =A0 if (host->card && mmc_card_is_sleep(host->card) &&
>> - =A0 =A0 =A0 =A0 host->bus_ops->resume) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->bus_ops->resume(host);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_poweroff_notify(host);
>> - =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: error %d d=
uring resume "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"(c=
ontinue with poweroff sequence)\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc=
_hostname(host), err);
>> - =A0 =A0 }
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Reset ocr mask to be the highest possible voltage s=
upported for
> @@
>> -1726,6 +1666,15 @@ int mmc_can_secure_erase_trim(struct mmc_card
>> *card) =A0} =A0EXPORT_SYMBOL(mmc_can_secure_erase_trim);
>>
>> +int mmc_can_poweroff_notify(const struct mmc_card *card) {
>> + =A0 =A0 return card &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_mmc(card) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->host->bus_ops->poweroff_notify &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_PO=
WERED_ON); }
>> +EXPORT_SYMBOL(mmc_can_poweroff_notify);
>> +
>> =A0int mmc_erase_group_aligned(struct mmc_card *card, unsigned int f=
rom,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int nr)
>> =A0{
>> @@ -2096,6 +2045,15 @@ void mmc_stop_host(struct mmc_host *host)
>>
>> =A0 =A0 =A0 mmc_bus_get(host);
>> =A0 =A0 =A0 if (host->bus_ops && !host->bus_dead) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_can_poweroff_notify(host->card)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D host->bus_ops-=
>poweroff_notify(host,
>> +
>> =A0 =A0 =A0 MMC_PW_OFF_NOTIFY_LONG);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%=
s: error [%d] in poweroff
> notify\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc_hostname(host), err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Calling bus_ops->remove() with a clai=
med host can
> deadlock
>> */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->remove)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_ops->remove(ho=
st);
>> @@ -2131,6 +2089,15 @@ int mmc_power_save_host(struct mmc_host *host=
)
>>
>> =A0 =A0 =A0 if (host->bus_ops->power_save)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D host->bus_ops->power_save(host);
>> + =A0 =A0 mmc_claim_host(host);
>> + =A0 =A0 if (mmc_can_poweroff_notify(host->card)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int err =3D host->bus_ops->poweroff_notify=
(host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 MMC_PW_OFF_NOTIFY_SHORT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: error [%d] in=
 poweroff notify\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostna=
me(host), err);
>> + =A0 =A0 }
>> + =A0 =A0 mmc_release_host(host);
>>
>> =A0 =A0 =A0 mmc_bus_put(host);
>>
>> @@ -2173,8 +2140,11 @@ int mmc_card_awake(struct mmc_host *host)
>>
>> =A0 =A0 =A0 mmc_bus_get(host);
>>
>> - =A0 =A0 if (host->bus_ops && !host->bus_dead && host->bus_ops->awa=
ke)
>> + =A0 =A0 if (host->bus_ops && !host->bus_dead && host->bus_ops->awa=
ke) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->bus_ops->awake(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->c=
ard);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 mmc_bus_put(host);
>>
>> @@ -2191,8 +2161,11 @@ int mmc_card_sleep(struct mmc_host *host)
>>
>> =A0 =A0 =A0 mmc_bus_get(host);
>>
>> - =A0 =A0 if (host->bus_ops && !host->bus_dead && host->bus_ops->sle=
ep)
>> + =A0 =A0 if (host->bus_ops && !host->bus_dead && host->bus_ops->sle=
ep) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->bus_ops->sleep(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(host->c=
ard);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 mmc_bus_put(host);
>>
>> @@ -2385,12 +2358,20 @@ int mmc_pm_notify(struct notifier_block
>> *notify_block,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rescan_disable =3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NO=
TIFY_SHORT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flag=
s);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&host->detect);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->bus_ops || host->bus_ops->sus=
pend)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_can_poweroff_notify(host->card)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err =3D host->bus_ops-=
>poweroff_notify(host,
>> +
>> =A0 =A0 =A0 MMC_PW_OFF_NOTIFY_SHORT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%=
s: error [%d] in poweroff
> notify\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 mmc_hostname(host), err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Calling bus_ops->remove() with a clai=
med host can
> deadlock
>> */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->remove)
>> @@ -2409,7 +2390,6 @@ int mmc_pm_notify(struct notifier_block
>> *notify_block,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rescan_disable =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NO=
TIFY_LONG;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flag=
s);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host, 0);
>>
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h index
>> 3bdafbc..15b918d 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -25,6 +25,7 @@ struct mmc_bus_ops {
>> =A0 =A0 =A0 int (*power_save)(struct mmc_host *);
>> =A0 =A0 =A0 int (*power_restore)(struct mmc_host *);
>> =A0 =A0 =A0 int (*alive)(struct mmc_host *);
>> + =A0 =A0 int (*poweroff_notify)(struct mmc_host *, int notify);
>> =A0};
>>
>> =A0void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_o=
ps
>> *ops); diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c =
index
>> 2f0e11c..042dbdc 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1259,6 +1259,40 @@ err:
>> =A0 =A0 =A0 return err;
>> =A0}
>>
>> +static int mmc_poweroff_notify(struct mmc_host *host, int notify) {
>> + =A0 =A0 struct mmc_card *card;
>> + =A0 =A0 unsigned int timeout;
>> + =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFICATION=
;
>> + =A0 =A0 int err;
>> +
>> + =A0 =A0 card =3D host->card;
>> +
>> + =A0 =A0 if (notify =3D=3D MMC_PW_OFF_NOTIFY_SHORT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_POWER_OFF_SHORT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd.generic_cmd6_tim=
e;
>> + =A0 =A0 } else if (notify =3D=3D MMC_PW_OFF_NOTIFY_LONG) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_POWER_OFF_LONG;
>> + =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd.power_off_longti=
me;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: mmc_poweroff_notify called "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "with notify type %d\n", m=
mc_hostname(host),
> notify);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_POWER_OFF_NOTIF=
ICATION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0notify_type, timeout);
>> +
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Device failed to respond withi=
n %d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"poweroff timeout.\n", mmc_=
hostname(host), timeout);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 MMC_NO_POWER_NOTIFICATION;
>> +
>> + =A0 =A0 return err;
>> +}
>> =A0/*
>> =A0 * Host is being removed. Free up the current card.
>> =A0 */
>> @@ -1319,13 +1353,18 @@ static int mmc_suspend(struct mmc_host *host=
)
>> =A0 =A0 =A0 BUG_ON(!host->card);
>>
>> =A0 =A0 =A0 mmc_claim_host(host);
>> - =A0 =A0 if (mmc_card_can_sleep(host)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(host->c=
ard);
>> - =A0 =A0 } else if (!mmc_host_is_spi(host))
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(host);
>> - =A0 =A0 host->card->state &=3D ~(MMC_STATE_HIGHSPEED |
>> MMC_STATE_HIGHSPEED_200);
>> + =A0 =A0 if (mmc_can_poweroff_notify(host->card) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (host->caps2 &
>> MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host,
>> MMC_PW_OFF_NOTIFY_SHORT);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_can_sleep(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(hos=
t);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(host);
>> + =A0 =A0 }
>> + =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->card->state &=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(MMC_STATE_HIGHSPEED |
>> MMC_STATE_HIGHSPEED_200);
>> =A0 =A0 =A0 mmc_release_host(host);
>>
>> =A0 =A0 =A0 return err;
>> @@ -1347,7 +1386,6 @@ static int mmc_resume(struct mmc_host *host)
>> =A0 =A0 =A0 mmc_claim_host(host);
>> =A0 =A0 =A0 if (mmc_card_is_sleep(host->card)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_awake(host);
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
>
> Without this patch, this was the suspend sequence/resume sequence for=
 MMC
> cards:
> mmc_suspend_host()
> =A0 =A0 =A0 =A0-> host->bus_ops->suspend()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_suspend()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_card_can_sleep(=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_card_sleep()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_card_set_sleep(=
)
> =A0 =A0 =A0 =A0-> mmc_power_off()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_card_is_sleep(host->card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> host->bus_ops->resume()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_resume()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc=
_card_is_sleep()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc=
_card_awake()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc=
_card_clr_sleep()
>
>
> mmc_resume_host()
> =A0 =A0 =A0 =A0-> mmc_power_up()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> This sets the buswidth=3D1, timing=3D=
legacy and clock=3Df_init
> =A0 =A0 =A0 =A0-> host->bus_ops->resume()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_resume()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_card_is_sleep()=
 -> this would return false
> because in mmc_suspend_host(), host->bus_ops->resume() call had clear=
ed the
> sleep flag.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_init_card() -> As card sleep st=
ate is cleared,
> init_card() will be done which sets up the card again.
>
>
> But with this patch, you have removed the "host->bus_ops->resume()" c=
all
> from mmc_power_off() which would mean card sleep state would be set t=
o
> MMC_STATE_SLEEP during mmc_resume_host().
> Following is the sequence with this patch:
>
> mmc_suspend_host()
> =A0 =A0 =A0 =A0-> host->bus_ops->suspend()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_suspend()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_card_can_sleep(=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_card_sleep()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_card_set_sleep(=
)
> =A0 =A0 =A0 =A0-> mmc_power_off()
>
> mmc_resume_host()
> =A0 =A0 =A0 =A0-> mmc_power_up()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> This sets the bus_width=3D1, timing=
=3Dlegacy and clock=3Df_init
> =A0 =A0 =A0 =A0-> host->bus_ops->resume()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_resume()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_card_is_sleep()=
 -> this would return true
> because card sleep flag is set.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> mmc_card_awake()
>
> Block read/write operation:
> =A0 =A0 =A0 =A0-> mmc_blk_issue_rw_rq
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> send CMD25
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> But at this point, =
bus_width=3D1, timing=3Dlegacy and
> clock=3Df_init. Which is causing card not to respond back to data blo=
cks sent
> from card and we are seeing the data timeout errors.
>
> So basically to fix this, in mmc_resume() either you have to call
> mmc_init_card() instead of mmc_card_awake() or if we still want to ju=
st call
> the mmc_card_awake() from resume, we need to save the state of host->=
ios
> before the sleep command issue so during resume, before calling mmc_a=
wake(),
> we need to restore the saved host->ios state back and call mmc_set_io=
s() to
> restore the original parameters.

Since the idea was not to go through a costly mmc_init_card during
resume, we will do the second approach, i.e. we will save "ios" into a
new mmc_host member "saved_ios" in mmc_power_off and restore this
"saved_ios" in mmc_power_up, if mmc_card_is_sleep is TRUE.

>
> Also, I couple of other concerns here: In mmc_suspend_host(), after w=
e put
> the card into suspend (host->bus_ops_suspend()), we call mmc_power_of=
f()
> which asks the host controller to switch off the eMMC power. Now assu=
me that
> a particular host controller driver turns off both VCC and VCCQ rails=
 when
> ios.power_mode =3D MMC_POWER_OFF.
> Now in mmc_resume_host(), we call mmc_power_up() which would switch O=
N the
> power back which would mean eMMC card have seen power down and power =
up
> sequence and that means card is no longer in sleep state. And now aft=
er
> mmc_power_up(), when we call the mmc_card_awake() from mmc_resume(), =
card
> may not even respond to CMD5 awake. So in this scenario, we should ac=
tually
> call mmc_init_card() to bring the card back to proper state.

=46or this case, where host driver turns off both VCC and VCCQ, we adde=
d
the cap MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND. This should handle the
case  you mentioned above, i.e. call mmc_init_card from mmc_resume

>
> Regards,
> Subhash
>
>> =A0 =A0 =A0 } else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_init_card(host, host->ocr, h=
ost->card);
>> =A0 =A0 =A0 mmc_release_host(host);
>> @@ -1407,6 +1445,7 @@ static const struct mmc_bus_ops mmc_ops =3D {
>> =A0 =A0 =A0 .resume =3D NULL,
>> =A0 =A0 =A0 .power_restore =3D mmc_power_restore,
>> =A0 =A0 =A0 .alive =3D mmc_alive,
>> + =A0 =A0 .poweroff_notify =3D mmc_poweroff_notify,
>> =A0};
>>
>> =A0static const struct mmc_bus_ops mmc_ops_unsafe =3D { @@ -1418,6 +=
1457,7
>> @@ static const struct mmc_bus_ops mmc_ops_unsafe =3D {
>> =A0 =A0 =A0 .resume =3D mmc_resume,
>> =A0 =A0 =A0 .power_restore =3D mmc_power_restore,
>> =A0 =A0 =A0 .alive =3D mmc_alive,
>> + =A0 =A0 .poweroff_notify =3D mmc_poweroff_notify,
>> =A0};
>>
>> =A0static void mmc_attach_bus_ops(struct mmc_host *host) diff --git
>> a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c index
>> 1532357..463130f 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1788,11 +1788,6 @@ static int __init dw_mci_init_slot(struct dw_=
mci
>> *host, unsigned int id)
>> =A0 =A0 =A0 if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED |
>> MMC_CAP_MMC_HIGHSPEED;
>>
>> - =A0 =A0 if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_NOT=
IFY_SHORT;
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_NOT=
IFY_NONE;
>> -
>> =A0 =A0 =A0 if (host->pdata->blk_settings) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_segs =3D host->pdata->blk_setti=
ngs->max_segs;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_size =3D host->pdata->blk_s=
ettings-
>> >max_blk_size;
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c ind=
ex
>> e626732..c0a5a91 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2812,15 +2812,6 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_D)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DRIVER_TYPE_D;
>>
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* If Power Off Notify capability is enabled by the host=
,
>> - =A0 =A0 =A0* set notify to short power off notify timeout value.
>> - =A0 =A0 =A0*/
>> - =A0 =A0 if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_NOT=
IFY_SHORT;
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_NOT=
IFY_NONE;
>> -
>> =A0 =A0 =A0 /* Initial value for re-tuning timer count */
>> =A0 =A0 =A0 host->tuning_count =3D (caps[1] &
>> SDHCI_RETUNING_TIMER_COUNT_MASK) >>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_RETUNI=
NG_TIMER_COUNT_SHIFT; diff --git
>> a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
>> d76513b..040eec4 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -239,11 +239,10 @@ struct mmc_card {
>> =A0#define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8) =A0 =A0 =A0 =A0/* A=
void
>> sending 512 bytes in */
>> =A0#define MMC_QUIRK_LONG_READ_TIME (1<<9) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
/* Data read
>> time > CSD says */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 /* byte mode */
>> - =A0 =A0 unsigned int =A0 =A0poweroff_notify_state; =A0/* eMMC4.5 n=
otify feature */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0poweroff_notify_state;=
 /* MMC-4.5 poweroff
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify feature */
>> =A0#define MMC_NO_POWER_NOTIFICATION =A0 =A00
>> =A0#define MMC_POWERED_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 1
>> -#define MMC_POWEROFF_SHORT =A0 =A0 =A0 =A0 =A0 2
>> -#define MMC_POWEROFF_LONG =A0 =A0 =A0 =A0 =A0 =A03
>>
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0 =
/* erase size in sectors */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0 =A0=
/* if erase unit is power 2
> */
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h ind=
ex
>> 1b431c7..54894d6 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -161,6 +161,7 @@ extern int mmc_can_trim(struct mmc_card *card);
>> extern int mmc_can_discard(struct mmc_card *card); =A0extern int
>> mmc_can_sanitize(struct mmc_card *card); =A0extern int
>> mmc_can_secure_erase_trim(struct mmc_card *card);
>> +extern int mmc_can_poweroff_notify(const struct mmc_card *card);
>> =A0extern int mmc_erase_group_aligned(struct mmc_card *card, unsigne=
d int
>> from,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u=
nsigned int nr);
>> =A0extern unsigned int mmc_calc_max_discard(struct mmc_card *card); =
diff
> --git
>> a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
>> 0707d22..0e9adac 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -238,12 +238,9 @@ struct mmc_host {
>> =A0#define MMC_CAP2_BROKEN_VOLTAGE =A0 =A0 =A0(1 << 7) =A0 =A0 =A0 =A0=
/* Use the broken
>> voltage */
>> =A0#define MMC_CAP2_DETECT_ON_ERR =A0 =A0 =A0 (1 << 8) =A0 =A0 =A0 =A0=
/* On I/O err check
> card
>> removal */
>> =A0#define MMC_CAP2_HC_ERASE_SZ (1 << 9) =A0 =A0 =A0 =A0/* High-capa=
city erase size
> */
>> +#define MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND =A0 =A0 =A0 (1 << 10=
)
>>
>> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0 =A0=
/* supported pm
>> features */
>> - =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
>> -#define MMC_HOST_PW_NOTIFY_NONE =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> -#define MMC_HOST_PW_NOTIFY_SHORT =A0 =A0 1
>> -#define MMC_HOST_PW_NOTIFY_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A02
>>
>> =A0#ifdef CONFIG_MMC_CLKGATE
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_requests=
; =A0 /* internal reference
> counter
>> */
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index
>> d425cab..b11876b 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -386,4 +386,11 @@ struct _mmc_csd {
>> =A0#define MMC_SWITCH_MODE_CLEAR_BITS =A0 0x02 =A0 =A0/* Clear bits =
which are
>> 1 in value */
>> =A0#define MMC_SWITCH_MODE_WRITE_BYTE =A0 0x03 =A0 =A0/* Set target =
to value
>> */
>>
>> +/*
>> + * MMC Poweroff Notify types
>> + */
>> +#define MMC_PW_OFF_NOTIFY_NONE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>> +#define MMC_PW_OFF_NOTIFY_SHORT =A0 =A0 =A0 =A0 =A0 =A0 =A01
>> +#define MMC_PW_OFF_NOTIFY_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A0 2
>> +
>> =A0#endif /* LINUX_MMC_MMC_H */
>> --
>> 1.7.4.1
>
>
