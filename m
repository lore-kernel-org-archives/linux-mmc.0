From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: core: Add Poweroff Notify handling
Date: Tue, 6 Sep 2011 17:41:21 +0530
Message-ID: <CAGxe1ZH5EVgre3tjPYs_r-sqykqW-Q_UY4L16xr5EptpoqE9Ag@mail.gmail.com>
References: <1315306767-9549-1-git-send-email-girish.shivananjappa@linaro.org>
	<1315306767-9549-3-git-send-email-girish.shivananjappa@linaro.org>
	<000701cc6c8b$796afb50$6c40f1f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <000701cc6c8b$796afb50$6c40f1f0$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Jeon,
Thanks for the review.

On 6 September 2011 17:22, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi Girish,
>
> In case of system poweroff, mmc_power_off can be called indeed?
> And I added some comments.
>
> Best regards,
> Seungwon Jeon.
>
> Girish K S wrote:
>>
>> This patch adds the power off notification handling
>> during suspend and system poweroff.
>> For suspend mode short timeout is used, whereas for the
>> normal poweroff long timeout is used.
>>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> ---
>> =A0drivers/mmc/core/core.c =A0| =A0 33 +++++++++++++++++++++++++++++=
++++
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A04 +++-
>> =A0drivers/mmc/host/sdhci.c | =A0 10 ++++++++++
>> =A0include/linux/mmc/card.h | =A0 19 +++++++++++++++++++
>> =A0include/linux/mmc/host.h | =A0 =A04 ++++
>> =A05 files changed, 69 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index a65e1ca..16da927 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1130,9 +1130,38 @@ static void mmc_power_up(struct mmc_host *hos=
t)
>>
>> =A0static void mmc_power_off(struct mmc_host *host)
>> =A0{
>> + =A0 =A0 struct mmc_card *card =3D host->card;
>> + =A0 =A0 unsigned int notify_type;
>> + =A0 =A0 unsigned int timeout;
>> + =A0 =A0 int err;
>> +
>> =A0 =A0 =A0 host->ios.clock =3D 0;
>> =A0 =A0 =A0 host->ios.vdd =3D 0;
>>
>> + =A0 =A0 if (mmc_card_mmc(card) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_powernotify_on(card))) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MMC_HOS=
T_PW_NOTIFY_SHORT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_PO=
WER_OFF_SHORT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd.=
generic_cmd6_time;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotify_s=
hort(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_PO=
WER_OFF_LONG;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd.=
power_off_longtime;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotify_l=
ong(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_N=
ORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_PO=
WER_OFF_NOTIFICATION,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_typ=
e, timeout);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Device fa=
iled to respond "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "within %d poweroff time."
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "forcefully powering down"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "the device\n", timeout);
>> + =A0 =A0 }
>> +
> It'd be fine if one function take it above all.
I change the state to off after the host executes the poweroff function=
=2E
i.e. after complete device power off.
>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Reset ocr mask to be the highest possible voltage s=
upported for
>> =A0 =A0 =A0 =A0* this mmc host. This value will be used at next powe=
r up.
>> @@ -1147,6 +1176,8 @@ static void mmc_power_off(struct mmc_host *hos=
t)
>> =A0 =A0 =A0 host->ios.bus_width =3D MMC_BUS_WIDTH_1;
>> =A0 =A0 =A0 host->ios.timing =3D MMC_TIMING_LEGACY;
>> =A0 =A0 =A0 mmc_set_ios(host);
>> + =A0 =A0 /*Set the card state to no notification after the poweroff=
*/
>> + =A0 =A0 mmc_card_set_powernotify_off(card);
>> =A0}
>>
>> =A0/*
>> @@ -2026,6 +2057,7 @@ int mmc_pm_notify(struct notifier_block
>> *notify_block,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rescan_disable =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NO=
TIFY_SHORT;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flag=
s);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&host->detect);
>>
>> @@ -2048,6 +2080,7 @@ int mmc_pm_notify(struct notifier_block
>> *notify_block,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rescan_disable =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_NO=
TIFY_LONG;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flag=
s);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host, 0);
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 2f06b37..8868da8 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -715,13 +715,15 @@ static int mmc_init_card(struct mmc_host *host=
, u32
>> ocr,
>> =A0 =A0 =A0 =A0* If the host supports the power_off_notify capabilit=
y then
>> =A0 =A0 =A0 =A0* set the notification byte in the ext_csd register o=
f device
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 if (host->caps & MMC_CAP_POWER_OFF_NOTIFY) {
>> + =A0 =A0 if ((host->caps & MMC_CAP_POWER_OFF_NOTIFY) =A0 =A0 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_powernotify_off(card))) {
>
> Previous version seems to be good.
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET=
_NORMAL,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_=
POWER_OFF_NOTIFICATION,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_=
POWER_ON,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ex=
t_csd.generic_cmd6_time);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotify_on(card);
>
> If err is -EBADMSG, switching for 'POWERED_ON' is maybe failed.
> It is sure to be successful?
> So, your state flag should be changed to 'off'
If err is  -EBADMSG then the state remains off. it will change only if
successful.
>
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /*
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 0e02cc1..2ca427a 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2566,6 +2566,16 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_D)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DRIVER_TYPE_D;
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If Notify capability is enabled and
>> + =A0 =A0 =A0* notify type is not initialised by host, set default t=
o
>> + =A0 =A0 =A0* long power off notify timeout value
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (mmc->caps =3D=3D MMC_CAP_POWER_OFF_NOTIFY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_NOT=
IFY_SHORT;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_NOT=
IFY_NONE;
>> +
>> =A0 =A0 =A0 /* Initial value for re-tuning timer count */
>> =A0 =A0 =A0 host->tuning_count =3D (caps[1] & SDHCI_RETUNING_TIMER_C=
OUNT_MASK) >>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_RETUNI=
NG_TIMER_COUNT_SHIFT;
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 2bf2843..1d6a832 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -190,6 +190,11 @@ struct mmc_card {
>> =A0#define MMC_QUIRK_DISABLE_CD (1<<5) =A0 =A0 =A0 =A0 =A0/* disconn=
ect CD/DAT[3]
>> resistor */
>> =A0#define MMC_QUIRK_INAND_CMD38 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0=
 =A0/* iNAND devices have
>> broken CMD38 */
>> =A0#define MMC_QUIRK_BLK_NO_CMD23 =A0 =A0 =A0 (1<<7) =A0 =A0 =A0 =A0=
 =A0/* Avoid CMD23 for regular
>> multiblock */
>> + =A0 =A0 unsigned int =A0 =A0poweroff_notify_state;/*eMMC4.5 notify=
 feature =A0*/
>> +#define MMC_NO_POWER_NOTIFICATION =A00
>> +#define MMC_POWERED_ON =A0 =A0 1
>> +#define MMC_POWEROFF_SHORT 2
>> +#define MMC_POWEROFF_LONG =A03
>>
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0 =
/* erase size in sectors */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0 =A0=
/* if erase unit is power 2 */
>> @@ -325,6 +330,20 @@ static inline void __maybe_unused remove_quirk(=
struct
>> mmc_card *card, int data)
>> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHI=
GHSPEED)
>> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_SD=
XC)
>>
>> +#define mmc_card_powernotify_on(c) =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D=3D MMC_POW=
ERED_ON)
>> +#define mmc_card_powernotify_off(c) =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D=3D MMC_NO_=
POWER_NOTIFICATION)
>> +
>> +#define mmc_card_set_powernotify_off(c) =A0 =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC_NO_POW=
ER_NOTIFICATION)
>> +#define mmc_card_set_powernotify_on(c) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC_POWERE=
D_ON)
>> +#define mmc_card_set_powernotify_short(c) =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC_POWERO=
=46F_SHORT)
>> +#define mmc_card_set_powernotify_long(c) =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((c)->poweroff_notify_state =3D MMC_POWERO=
=46F_LONG)
>> +
>> =A0/*
>> =A0 * Quirk add/remove for MMC products.
>> =A0 */
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index cf2dadc..4f24702 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -232,6 +232,10 @@ struct mmc_host {
>> =A0#define MMC_CAP_POWER_OFF_NOTIFY =A0 =A0(1 << 31)/*Notify powerof=
f supported
>> */
>>
>> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0 =A0=
/* supported pm features */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
>> +#define MMC_HOST_PW_NOTIFY_NONE =A0 =A0 =A00
>> +#define MMC_HOST_PW_NOTIFY_SHORT =A0 =A0 1
>> +#define MMC_HOST_PW_NOTIFY_LONG =A0 =A0 =A02
>>
>> =A0#ifdef CONFIG_MMC_CLKGATE
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_requests=
; =A0 /* internal reference counter */
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
