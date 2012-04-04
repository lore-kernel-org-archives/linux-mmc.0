From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [RFC] MMC-4.5 Power OFF Notify rework
Date: Wed, 4 Apr 2012 19:57:42 +0530
Message-ID: <CAGxe1ZHmfG9RiRAZ0yeds2huUg1qcZEQCJwbPGYX-4zJOGhLXQ@mail.gmail.com>
References: <1333101747-3200-1-git-send-email-girish.shivananjappa@linaro.org>
	<4F7C317C.1040203@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51214 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409Ab2DDO1o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Apr 2012 10:27:44 -0400
Received: by wibhj6 with SMTP id hj6so649704wib.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 Apr 2012 07:27:42 -0700 (PDT)
In-Reply-To: <4F7C317C.1040203@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "saugata.das@linaro.org" <saugata.das@linaro.org>

On 4 April 2012 17:03, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> On 03/30/2012 12:02 PM, Girish K S wrote:
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
>> Signed-off-by: Saugata Das<saugata.das@linaro.org>
>> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
>> ---
>> =A0drivers/mmc/core/core.c =A0| =A0 36 ++++++++++++++---------------=
-------
>> =A0drivers/mmc/core/core.h =A0| =A0 =A01 +
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 20 +++++++++++++-------
>> =A0include/linux/mmc/host.h | =A0 =A01 +
>> =A04 files changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 14f262e..dc85ee1 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1096,12 +1096,12 @@ void mmc_set_driver_type(struct mmc_host *ho=
st,
>> unsigned int drv_type)
>> =A0 =A0 =A0 =A0mmc_host_clk_release(host);
>> =A0}
>>
>> -static void mmc_poweroff_notify(struct mmc_host *host)
>> +int mmc_poweroff_notify(struct mmc_host *host)
>
>
> A more generic comment; why is not this function implemented as a bus=
_ops
> function, similar how sleep for mmc is done? That would be more prefe=
rred I
> think.
>
>
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_card *card;
>> =A0 =A0 =A0 =A0unsigned int timeout;
>> =A0 =A0 =A0 =A0unsigned int notify_type =3D EXT_CSD_NO_POWER_NOTIFIC=
ATION;
>> - =A0 =A0 =A0 int err =3D 0;
>> + =A0 =A0 =A0 int err =3D -EINVAL;
>>
>> =A0 =A0 =A0 =A0card =3D host->card;
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>> @@ -1136,6 +1136,7 @@ static void mmc_poweroff_notify(struct mmc_hos=
t
>> *host)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->poweroff_notify_state =3D MMC_N=
O_POWER_NOTIFICATION;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0mmc_release_host(host);
>> + =A0 =A0 =A0 return err;
>> =A0}
>>
>> =A0/*
>> @@ -1194,30 +1195,12 @@ static void mmc_power_up(struct mmc_host *ho=
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
>> @@ -2076,6 +2059,7 @@ void mmc_stop_host(struct mmc_host *host)
>> =A0 =A0 =A0 =A0host->pm_flags =3D 0;
>>
>> =A0 =A0 =A0 =A0mmc_bus_get(host);
>> + =A0 =A0 =A0 mmc_poweroff_notify(host);
>
>
> We must not do mmc_poweroff_notify, without knowing we have a card at=
tached
> through the bus_ops.
>
>> =A0 =A0 =A0 =A0if (host->bus_ops&& =A0!host->bus_dead) {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Calling bus_ops->remove() with a c=
laimed host can
>> deadlock */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->remove)
>> @@ -2112,7 +2096,8 @@ int mmc_power_save_host(struct mmc_host *host)
>>
>> =A0 =A0 =A0 =A0if (host->bus_ops->power_save)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_save(hos=
t);
>> -
>> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_SHORT;
>> + =A0 =A0 =A0 mmc_poweroff_notify(host);
>
>
> Same comment as above.
>
> Moreover, mmc_power_save_host is not working for eMMC cards supportin=
g the
> SLEEP command (violating the eMMC spec for how VCC is cut). So, I am =
not
> sure we should introduce the poweroff_notify for the mmc_power_save_h=
ost
> right now. Better to fix SLEEP first, if needed at all.
>
> Additionally, this function is only used for SDIO if runtime PM is en=
abled
> at the moment.
>
>
>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>
>> =A0 =A0 =A0 =A0mmc_power_off(host);
>> @@ -2135,7 +2120,7 @@ int mmc_power_restore_host(struct mmc_host *ho=
st)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_bus_put(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> =A0 =A0 =A0 =A0}
>> -
>> + =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NOTIFY_LONG;
>
>
> Similar comments as for mmc_power_save_host
>
>> =A0 =A0 =A0 =A0mmc_power_up(host);
>> =A0 =A0 =A0 =A0ret =3D host->bus_ops->power_restore(host);
>>
>> @@ -2157,6 +2142,9 @@ int mmc_card_awake(struct mmc_host *host)
>> =A0 =A0 =A0 =A0if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bus=
_ops->awake)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->awake(host);
>>
>> + =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_sleep(host->card);
>> +
>
>
> This code must be handled from withing the bus_ops function instead, =
or you
> need to move it inside the "if" above, since the awake bus_ops only e=
xist
> for (e)MMC. Moreover, you do not want to set the sleep state unless t=
he
> sleep cmd really has been executed.
>
>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>
>> =A0 =A0 =A0 =A0return err;
>> @@ -2175,6 +2163,9 @@ int mmc_card_sleep(struct mmc_host *host)
>> =A0 =A0 =A0 =A0if (host->bus_ops&& =A0!host->bus_dead&& =A0host->bus=
_ops->sleep)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops->sleep(host);
>>
>> + =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(host->card);
>> +
>
>
> I think this code should be handled from withing the bus_ops function
> instead, or you need to move it inside the "if" above, since the awak=
e
> bus_ops only exist for (e)MMC.
>
>
>> =A0 =A0 =A0 =A0mmc_bus_put(host);
>>
>> =A0 =A0 =A0 =A0return err;
>> @@ -2393,6 +2384,7 @@ int mmc_pm_notify(struct notifier_block
>> *notify_block,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->bus_ops->remove=
(host);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_claim_host(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_poweroff_notify(host);
>
>
> This wont work if the card has been removed from the bus_ops->remove =
above.
>
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detach_bus(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_power_off(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host);
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index 3bdafbc..0bdc0fd 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -45,6 +45,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, =
int
>> signal_voltage,
>> =A0void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>> =A0void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_=
type);
>> =A0void mmc_power_off(struct mmc_host *host);
>> +int mmc_poweroff_notify(struct mmc_host *host);
>>
>> =A0static inline void mmc_delay(unsigned int ms)
>> =A0{
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 02914d6..885ad61 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1338,12 +1338,18 @@ static int mmc_suspend(struct mmc_host *host=
)
>> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>>
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>> - =A0 =A0 =A0 if (mmc_card_can_sleep(host)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>> + =A0 =A0 =A0 if (host->caps2& =A0MMC_CAP2_POWER_OFF_VCCQ_DURING_SUS=
PEND) {
>
> 1. missing whitespace after caps2
> 2. Can't we have an mmc_card_can_poweroff_notify to check instead, wh=
ich
> also considering this new cap together with the card features.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_poweroff_notify(host);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_sleep(hos=
t->card);
>> - =A0 =A0 =A0 } else if (!mmc_host_is_spi(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> Suggest to remove the goto and just have another if-else, as we alrea=
dy have
> for sleep.
>>
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (mmc_card_can_sleep(host))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
>> + =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_deselect_cards(host);
>> +
>> +out:
>> =A0 =A0 =A0 =A0host->card->state&=3D ~(MMC_STATE_HIGHSPEED |
>> MMC_STATE_HIGHSPEED_200);
>>
>> =A0 =A0 =A0 =A0mmc_release_host(host);
>>
>> @@ -1364,11 +1370,11 @@ static int mmc_resume(struct mmc_host *host)
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
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 33a4d08..3749a42 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -237,6 +237,7 @@ struct mmc_host {
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
I will check  it once i am back from business trip.
> Kind regards
> Ulf Hansson
