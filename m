From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] MMC-4.5 Power OFF Notify rework
Date: Fri, 27 Apr 2012 10:10:08 +0530
Message-ID: <CAGxe1ZEED6W3hiQwQHPYNkQO7-pFHLYKuhAzVhYfdW0EeYD7Bw@mail.gmail.com>
References: <1334839289-22620-1-git-send-email-girish.shivananjappa@linaro.org>
	<CAGxe1ZH=NpTWNY_MxTF6iDAqJBtP-PsR9EO_nvWFCU6kLGGwvQ@mail.gmail.com>
	<4F95631F.5040000@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:50494 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab2D0EkJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Apr 2012 00:40:09 -0400
Received: by qadc11 with SMTP id c11so105393qad.19
        for <linux-mmc@vger.kernel.org>; Thu, 26 Apr 2012 21:40:08 -0700 (PDT)
In-Reply-To: <4F95631F.5040000@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "saugata.das@linaro.org" <saugata.das@linaro.org>

On 23 April 2012 19:41, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> Hi Girish,
>
> Please see some comments below...
>
>
> On 04/20/2012 01:33 PM, Girish K S wrote:
>>
>> On 19 April 2012 18:11, Girish K S<girish.shivananjappa@linaro.org>
>> =A0wrote:
>>>
>>> This is a rework of the existing POWER OFF NOTIFY patch. The curren=
t
>>> problem
>>> with the patch comes from the ambiguity on the usage of POWER OFF N=
OTIFY
>>> together with SLEEP and misunderstanding on the usage of MMC_POWER_=
OFF
>>> power_mode from mmc_set_ios in different host controller drivers.
>>>
>>> This new patch works around this problem by adding a new host CAP,
>>> MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which when set sends a
>>> POWER OFF NOTIFY from mmc_suspend instead of SLEEP. It is expected =
that
>>> host
>>> controller drivers will set this CAP, if they switch off both Vcc a=
nd
>>> Vccq
>>> from MMC_POWER_OFF condition within mmc_set_ios. However, note that=
 there
>>> is no harm in sending MMC_POWER_NOTIFY even if Vccq is not switched=
 off.
>>>
>>> This patch also sends POWER OFF NOTIFY from power management routin=
es
>>> (e.g.
>>> mmc_power_save_host, mmc_pm_notify/PM_SUSPEND_PREPARE, mmc_stop_hos=
t),
>>> which
>>> does reinitialization of the eMMC on the return path of the power
>>> management
>>> routines (e.g. mmc_power_restore_host, mmc_pm_notify/PM_POST_RESTOR=
E,
>>> mmc_start_host).
>>>
>>> This patch sets POWER_OFF_NOTIFICATION to POWER_OFF_SHORT if it is =
sent
>>> from
>>> the suspend sequence. If it is sent from shutdown sequence then it =
is set
>>> to
>>> POWER_OFF_LONG.
>>>
>>> Previuos implementation of PowerOff Notify as a core function is re=
placed
>>> as
>>> a device's bus operation.
>
> Great, I like this! :-)
>
>>>
>>> Signed-off-by: Saugata Das<saugata.das@linaro.org>
>>> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
>>> ---
>>> =A0drivers/mmc/core/core.c =A0| =A0 83
>>> ++++++++++-----------------------------------
>>> =A0drivers/mmc/core/core.h =A0| =A0 =A01 +
>>> =A0drivers/mmc/core/mmc.c =A0 | =A0 75
>>> +++++++++++++++++++++++++++++++++++-------
>>> =A0include/linux/mmc/host.h | =A0 =A01 +
>>> =A04 files changed, 84 insertions(+), 76 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index e541efb..4b8b2c1 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1100,48 +1100,6 @@ void mmc_set_driver_type(struct mmc_host *ho=
st,
>>> unsigned int drv_type)
>>> =A0 =A0 =A0 =A0mmc_host_clk_release(host);
>>> =A0}
>>>
>>> -static void mmc_poweroff_notify(struct mmc_host *host)
>>> -{
>>> - =A0 =A0 =A0 struct mmc_card *card;
>>> - =A0 =A0 =A0 unsigned int timeout;
>>> - =A0 =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFIC=
ATION;
>>> - =A0 =A0 =A0 int err =3D 0;
>>> -
>>> - =A0 =A0 =A0 card =3D host->card;
>>> - =A0 =A0 =A0 mmc_claim_host(host);
>>> -
>>> - =A0 =A0 =A0 /*
>>> - =A0 =A0 =A0 =A0* Send power notify command only if card
>>> - =A0 =A0 =A0 =A0* is mmc and notify state is powered ON
>>> - =A0 =A0 =A0 =A0*/
>>> - =A0 =A0 =A0 if (card&& =A0mmc_card_mmc(card)&&
>>> - =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWER=
ED_ON)) {
>>> -
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MM=
C_HOST_PW_NOTIFY_SHORT)
>>> {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_C=
SD_POWER_OFF_SHORT;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext=
_csd.generic_cmd6_time;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify=
_state =3D MMC_POWEROFF_SHORT;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_C=
SD_POWER_OFF_LONG;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext=
_csd.power_off_longtime;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify=
_state =3D MMC_POWEROFF_LONG;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> -
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_=
SET_NORMAL,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EX=
T_CSD_POWER_OFF_NOTIFICATION,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0no=
tify_type, timeout);
>>> -
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err&& =A0err !=3D -EBADMSG)
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Device failed=
 to respond within %d
>>> poweroff "
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"time.=
 Forcefully powering down the
>>> device\n",
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeou=
t);
>>> -
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notificat=
ion after the
>>> poweroff */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D MMC_N=
O_POWER_NOTIFICATION;
>>> - =A0 =A0 =A0 }
>>> - =A0 =A0 =A0 mmc_release_host(host);
>>> -}
>>> -
>>> =A0/*
>>> =A0* Apply power to the MMC stack. =A0This is a two-stage process.
>>> =A0* First, we enable power to the card without the clock running.
>>> @@ -1198,30 +1156,12 @@ static void mmc_power_up(struct mmc_host *h=
ost)
>>>
>>> =A0void mmc_power_off(struct mmc_host *host)
>>> =A0{
>>> - =A0 =A0 =A0 int err =3D 0;
>>> =A0 =A0 =A0 =A0mmc_host_clk_hold(host);
>>>
>>> =A0 =A0 =A0 =A0host->ios.clock =3D 0;
>>> =A0 =A0 =A0 =A0host->ios.vdd =3D 0;
>>>
>>> =A0 =A0 =A0 =A0/*
>>> - =A0 =A0 =A0 =A0* For eMMC 4.5 device send AWAKE command before
>>> - =A0 =A0 =A0 =A0* POWER_OFF_NOTIFY command, because in sleep state
>>> - =A0 =A0 =A0 =A0* eMMC 4.5 devices respond to only RESET and AWAKE=
 cmd
>>> - =A0 =A0 =A0 =A0*/
>>> - =A0 =A0 =A0 if (host->card&& =A0mmc_card_is_sleep(host->card)&&
>>> - =A0 =A0 =A0 =A0 =A0 host->bus_ops->resume) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->bus_ops->resume(host);
>>> -
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_poweroff_notify(h=
ost);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: error=
 %d during resume "
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"(continue with poweroff sequence)\n",
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mmc_hostname(host), err);
>>> - =A0 =A0 =A0 }
>>> -
>>> - =A0 =A0 =A0 /*
>>> =A0 =A0 =A0 =A0 * Reset ocr mask to be the highest possible voltage=
 supported for
>>> =A0 =A0 =A0 =A0 * this mmc host. This value will be used at next po=
wer up.
>>> =A0 =A0 =A0 =A0 */
>>> @@ -2084,6 +2024,9 @@ void mmc_stop_host(struct mmc_host *host)
>>>
>>> =A0 =A0 =A0 =A0mmc_bus_get(host);
>>> =A0 =A0 =A0 =A0if (host->bus_ops&& =A0!host->bus_dead) {
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->poweroff_notify)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_ops->powero=
ff_notify(host);
>>> +
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a =
claimed host can
>>> deadlock */
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->bus_ops->remov=
e(host);
>>> @@ -2093,6 +2036,7 @@ void mmc_stop_host(struct mmc_host *host)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_power_off(host);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
>>> +
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>> =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>> @@ -2119,7 +2063,9 @@ int mmc_power_save_host(struct mmc_host *host=
)
>>>
>>> =A0 =A0 =A0 =A0if (host->bus_ops->power_save)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_save(ho=
st);
>>> -
>>> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_SHORT;
>>> + =A0 =A0 =A0 if (host->bus_ops->poweroff_notify)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_ops->poweroff_notify(host);
>>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>>
>>> =A0 =A0 =A0 =A0mmc_power_off(host);
>>> @@ -2142,7 +2088,7 @@ int mmc_power_restore_host(struct mmc_host *h=
ost)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>> =A0 =A0 =A0 =A0}
>>> -
>>> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_LONG;
>>> =A0 =A0 =A0 =A0mmc_power_up(host);
>>> =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_restore(host);
>>>
>>> @@ -2161,8 +2107,11 @@ int mmc_card_awake(struct mmc_host *host)
>>>
>>> =A0 =A0 =A0 =A0mmc_bus_get(host);
>>>
>>> - =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bus=
_ops->awake)
>>> + =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bus=
_ops->awake) {
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->awake(host);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(ho=
st->card);
>>> + =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>>
>>> @@ -2179,8 +2128,11 @@ int mmc_card_sleep(struct mmc_host *host)
>>>
>>> =A0 =A0 =A0 =A0mmc_bus_get(host);
>>>
>>> - =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bus=
_ops->sleep)
>>> + =A0 =A0 =A0 if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bus=
_ops->sleep) {
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->sleep(host);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(ho=
st->card);
>>> + =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>>
>>> @@ -2394,6 +2346,8 @@ int mmc_pm_notify(struct notifier_block
>>> *notify_block,
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!host->bus_ops || host->bus_ops-=
>suspend)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->poweroff_notify)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_ops->powero=
ff_notify(host);
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a =
claimed host can
>>> deadlock */
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
>>> @@ -2403,6 +2357,7 @@ int mmc_pm_notify(struct notifier_block
>>> *notify_block,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detach_bus(host);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_power_off(host);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host);
>>> +
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->pm_flags =3D 0;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>>
>>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>>> index 3bdafbc..351cbbe 100644
>>> --- a/drivers/mmc/core/core.h
>>> +++ b/drivers/mmc/core/core.h
>>> @@ -25,6 +25,7 @@ struct mmc_bus_ops {
>>> =A0 =A0 =A0 =A0int (*power_save)(struct mmc_host *);
>>> =A0 =A0 =A0 =A0int (*power_restore)(struct mmc_host *);
>>> =A0 =A0 =A0 =A0int (*alive)(struct mmc_host *);
>>> + =A0 =A0 =A0 int (*poweroff_notify)(struct mmc_host *);
>>> =A0};
>>>
>>> =A0void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_=
ops
>>> *ops);
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 54df5ad..62bdee6 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1282,6 +1282,50 @@ err:
>>> =A0 =A0 =A0 =A0return err;
>>> =A0}
>>>
>>> +static int mmc_poweroff_notify(struct mmc_host *host)
>>> +{
>>> + =A0 =A0 =A0 struct mmc_card *card;
>>> + =A0 =A0 =A0 unsigned int timeout;
>>> + =A0 =A0 =A0 unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFIC=
ATION;
>>> + =A0 =A0 =A0 int err =3D -EINVAL;
>
> Should we consider it an error if the card does not support poweroff
> notification?
To make it more meaningful I will change the error value to -EOPNOTSUPP=
=2E
>
> Moreover, this function returns an error code which is good. Although
> everywhere you call this function you do not consider the error. Plea=
se look
> into changing this.
Also will consider the return value from the places it is called to
display the info "card doesnt support po notify"
>
>
>>> +
>>> + =A0 =A0 =A0 card =3D host->card;
>>> + =A0 =A0 =A0 mmc_claim_host(host);
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* Send power notify command only if card
>>> + =A0 =A0 =A0 =A0* is mmc and notify state is powered ON
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (card&& =A0mmc_card_mmc(card)&&
>
> Some white spaces..
will rum cleanpatch
>
>
>>> + =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWER=
ED_ON)) {
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MM=
C_HOST_PW_NOTIFY_SHORT)
>>> {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_C=
SD_POWER_OFF_SHORT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext=
_csd.generic_cmd6_time;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify=
_state =3D MMC_POWEROFF_SHORT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_C=
SD_POWER_OFF_LONG;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext=
_csd.power_off_longtime;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify=
_state =3D MMC_POWEROFF_LONG;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_=
SET_NORMAL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EX=
T_CSD_POWER_OFF_NOTIFICATION,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0no=
tify_type, timeout);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err&& =A0err !=3D -EBADMSG)
>
> Some white spaces..
>
>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Device fa=
iled to respond within %d "
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"power=
off time. Forcefully powering down "
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"the d=
evice\n", mmc_hostname(host),
>>> timeout);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notificat=
ion after the
>>> poweroff */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D MMC_N=
O_POWER_NOTIFICATION;
>>> + =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 mmc_release_host(host);
>>> +
>>> + =A0 =A0 =A0 return err;
>>> +}
>>> +
>>> =A0/*
>>> =A0* Host is being removed. Free up the current card.
>>> =A0*/
>>> @@ -1341,15 +1385,20 @@ static int mmc_suspend(struct mmc_host *hos=
t)
>>> =A0 =A0 =A0 =A0BUG_ON(!host);
>>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>>
>>> - =A0 =A0 =A0 mmc_claim_host(host);
>
> nested claims is OK, so you can keep this if the code becomes easier =
to
> read!? The corresponding mmc_release_host then as well of course...
>
>>> - =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(ho=
st->card);
>>> - =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(host);
>>> - =A0 =A0 =A0 host->card->state&=3D ~(MMC_STATE_HIGHSPEED |
>>> MMC_STATE_HIGHSPEED_200);
>>>
>>> - =A0 =A0 =A0 mmc_release_host(host);
>>> + =A0 =A0 =A0 if (host->caps2& =A0MMC_CAP2_POWER_OFF_VCCQ_DURING_SU=
SPEND) {
>
> Some white spaces..
>
> This will not work. If the card does not support "poweroff_notify", b=
ut
> sleep, then the card will not be put to sleep. The cap should not be =
used to
> determine what the card supports, only the host.
I will remove th host caps option. and directly call the power off
notify function. This function will execute the switch command only if
the card supports the power off notify.
so comparison with host caps can be omitted.
>
> Maybe an new function "mmc_card_can_poweroff_notify" can help out in =
taking
> the right decision here. The you also might be able to get rid of the
> host->poweroff_notify_state variable, don't know.
not necessary to add a new function as said above the notify function
takes care of card support
>
>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host);
>>> + =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(host);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_can_sleep(host))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_slee=
p(host);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_deselect_cards(ho=
st);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 if (!err)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->card->state&=3D
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ~(MMC_STATE_HIGHSPEED=
 | MMC_STATE_HIGHSPEED_200);
>>>
>>> =A0 =A0 =A0 =A0return err;
>>> =A0}
>>> @@ -1368,11 +1417,11 @@ static int mmc_resume(struct mmc_host *host=
)
>>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>>
>>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>>> - =A0 =A0 =A0 if (mmc_card_is_sleep(host->card)) {
>>> + =A0 =A0 =A0 if (mmc_card_is_sleep(host->card))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_card_awake(host);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
>>> - =A0 =A0 =A0 } else
>>> + =A0 =A0 =A0 else
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_init_card(host, host->oc=
r, host->card);
>>> +
>>> =A0 =A0 =A0 =A0mmc_release_host(host);
>>>
>>> =A0 =A0 =A0 =A0return err;
>>> @@ -1430,6 +1479,7 @@ static const struct mmc_bus_ops mmc_ops =3D {
>>> =A0 =A0 =A0 =A0.resume =3D NULL,
>>> =A0 =A0 =A0 =A0.power_restore =3D mmc_power_restore,
>>> =A0 =A0 =A0 =A0.alive =3D mmc_alive,
>>> + =A0 =A0 =A0 .poweroff_notify =3D NULL,
>
> Is there any problems with adding the function here? Even if an eMMC =
always
> should be considered non-removable, and thus the unsafe bus_ops shoul=
d be
> used. I don't know the reason to why sleep/awake has been added to th=
is
> bus_ops, but I think poweroff_notify should be handled similarly...
No problem in adding. The only reason for not adding is that none of
the removable cards support poweroff notify. this feature is supported
above 4.5 version. If you have come across any 4.5 removable device,
it would more convinient to add here.
>
>
>>> =A0};
>>>
>>> =A0static const struct mmc_bus_ops mmc_ops_unsafe =3D {
>>> @@ -1441,6 +1491,7 @@ static const struct mmc_bus_ops mmc_ops_unsaf=
e =3D {
>>> =A0 =A0 =A0 =A0.resume =3D mmc_resume,
>>> =A0 =A0 =A0 =A0.power_restore =3D mmc_power_restore,
>>> =A0 =A0 =A0 =A0.alive =3D mmc_alive,
>>> + =A0 =A0 =A0 .poweroff_notify =3D mmc_poweroff_notify,
>>> =A0};
>>>
>>> =A0static void mmc_attach_bus_ops(struct mmc_host *host)
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index cbde4b7..cf44a6f 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -238,6 +238,7 @@ struct mmc_host {
>>> =A0#define MMC_CAP2_BROKEN_VOLTAGE =A0 =A0 =A0 =A0(1<< =A07) =A0 =A0=
 =A0 =A0/* Use the broken
>>> voltage */
>>> =A0#define MMC_CAP2_DETECT_ON_ERR (1<< =A08) =A0 =A0 =A0 =A0/* On I=
/O err check card
>>> removal */
>>> =A0#define MMC_CAP2_HC_ERASE_SZ =A0 (1<< =A09) =A0 =A0 =A0 =A0/* Hi=
gh-capacity erase
>>> size */
>>> +#define MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND (1<< =A010)
>
> Don't know if we would like to use the old caps(1) bit 7, since
> MMC_CAP_DISABLE has been removed and thus this bit is now available..=
=2E
I am planning to remove this caps.
>
>
>>>
>>> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features
>>> */
>>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
>>
>>
>> Hi Ulf,
>> need your comment on the above.
>>>
>>> --
>>> 1.7.1
>>>
>
> Overall, I like this patch, we are getting close to a final version I=
 think.
>
> Kind regards
> Ulf Hansson
