From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V9] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Tue, 18 Oct 2011 10:55:06 +0530
Message-ID: <CAGxe1ZGgyd+URx4CjgVGqarKaYx-X2U025Q75Qo540bF=2C0QA@mail.gmail.com>
References: <1318914301-30339-1-git-send-email-girish.shivananjappa@linaro.org>
	<4E9D0B9F.1060303@samsung.com>
	<CAGxe1ZHnhL8V-XpPjyoGX6P9zSAYP0OkTygZtp6=bH8oRNQvTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAGxe1ZHnhL8V-XpPjyoGX6P9zSAYP0OkTygZtp6=bH8oRNQvTg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 18 October 2011 10:49, Girish K S <girish.shivananjappa@linaro.org> =
wrote:
> On 18 October 2011 10:46, Jaehoon Chung <jh80.chung@samsung.com> wrot=
e:
>> Hi Girish.
>>
>> This patch is merged on mmc-next..did you know that?
>> And if deleted commit id bd3151f6c55c553bed2c0df72792841457b75bb5,
>> I will re-work for eMMC feature4.5.
>> git://git.infradead.org/users/kmpark/linux-2.6-samsung emmc4.5
>>
>> To Chris.
>> If you re-commit this patch, i also change "git pull request".
>> there are duplicated code in Notify patch, so i didn't add to cache =
patch.
>>HI Jaehoon,
> =A0I have already bought it to the notice of Chris. After discussing
> with Chris i am resending the complete patch.
>> Regards,
>> Jaehoon Chung
>>Adding to it. In your mail with subject "[GIT PULL v2] Add eMMC4.5 fe=
ature for v3.2", for version 2 changes it is mentioned
that power notify feature is removed. Thats the reason i rebased my
patch to Chris's mmc-next branch and resent.
>> On 10/18/2011 02:05 PM, Girish K S wrote:
>>
>>> This patch adds the support for power off notify feature, available=
 in
>>> eMMC 4.5 devices. If the the host has support for this feature, the=
n the
>>> mmc core will notify it to the device by setting the POWER_OFF_NOTI=
=46ICATION
>>> byte in the extended csd register with a value 1(POWER_ON).
>>>
>>> For suspend mode short timeout is used, whereas for the normal powe=
roff long
>>> timeout is used.
>>>
>>> cc: Chris Ball <cjb@laptop.org>
>>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> ---
>>> Changes in V9:
>>> =A0 =A0 =A0 Removed the macros not related with the PowerOff notify=
 feature.
>>> =A0 =A0 =A0 The previous patch with commit id
>>> =A0 =A0 =A0 bd3151f6c55c553bed2c0df72792841457b75bb5 should be dele=
ted before
>>> =A0 =A0 =A0 applying this patch.
>>> Changes in V8:
>>> =A0 =A0 =A0 Updated with review comments of Chris Ball and rebased =
to
>>> =A0 =A0 =A0 chris-mmc/mmc-next branch.
>>> Changes in V7:
>>> =A0 =A0 =A0 Rebased to chris-mmc/mmc-next branch. merged to patches=
 to single
>>> =A0 =A0 =A0 patch.
>>> Changes in V6:
>>> =A0 =A0 =A0 Fixes checkpatch errors. The patches are generated afte=
r rebasing to
>>> =A0 =A0 =A0 =A0chris's mmc-next branch.
>>> Changes in V5:
>>> =A0 =A0 =A0 This patch version fixes the problem with power off not=
ify function,
>>> =A0 =A0 =A0 =A0when called for the first time and card is not yet i=
nitialised.
>>> Changes in V4:
>>> =A0 =A0 =A0 Updated with review comments of Jeon
>>> Changes in V2:
>>> =A0 =A0 =A0 Adds poweroff notification handling in suspend/normal.
>>>
>>> =A0drivers/mmc/core/core.c =A0| =A0 34 ++++++++++++++++++++++++++++=
++++++
>>> =A0drivers/mmc/core/mmc.c =A0 | =A0 23 +++++++++++++++++++++--
>>> =A0drivers/mmc/host/sdhci.c | =A0 =A09 +++++++++
>>> =A0include/linux/mmc/card.h | =A0 =A06 ++++++
>>> =A0include/linux/mmc/host.h | =A0 =A05 +++++
>>> =A0include/linux/mmc/mmc.h =A0| =A0 =A06 ++++++
>>> =A06 files changed, 81 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 61d7730..b1eca96 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1212,11 +1212,43 @@ static void mmc_power_up(struct mmc_host *h=
ost)
>>>
>>> =A0void mmc_power_off(struct mmc_host *host)
>>> =A0{
>>> + =A0 =A0 struct mmc_card *card;
>>> + =A0 =A0 unsigned int notify_type;
>>> + =A0 =A0 unsigned int timeout;
>>> + =A0 =A0 int err;
>>> +
>>> =A0 =A0 =A0 mmc_host_clk_hold(host);
>>>
>>> + =A0 =A0 card =3D host->card;
>>> =A0 =A0 =A0 host->ios.clock =3D 0;
>>> =A0 =A0 =A0 host->ios.vdd =3D 0;
>>>
>>> + =A0 =A0 if (card && mmc_card_mmc(card) &&
>>> + =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D=3D MMC_POWERED_ON=
) {
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D MMC_HO=
ST_PW_NOTIFY_SHORT) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_P=
OWER_OFF_SHORT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd=
=2Egeneric_cmd6_time;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_sta=
te =3D MMC_POWEROFF_SHORT;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_CSD_P=
OWER_OFF_LONG;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ext_csd=
=2Epower_off_longtime;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_sta=
te =3D MMC_POWEROFF_LONG;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_=
NORMAL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CS=
D_POWER_OFF_NOTIFICATION,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0notify=
_type, timeout);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Device failed to =
respond within %d poweroff "
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"time. For=
cefully powering down the device\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0timeout);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notification =
after the poweroff */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D MMC_NO_PO=
WER_NOTIFICATION;
>>> + =A0 =A0 }
>>> +
>>> =A0 =A0 =A0 /*
>>> =A0 =A0 =A0 =A0* Reset ocr mask to be the highest possible voltage =
supported for
>>> =A0 =A0 =A0 =A0* this mmc host. This value will be used at next pow=
er up.
>>> @@ -2208,6 +2240,7 @@ int mmc_pm_notify(struct notifier_block *noti=
fy_block,
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rescan_disable =3D 1;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_N=
OTIFY_SHORT;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, fla=
gs);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&host->detect)=
;
>>>
>>> @@ -2231,6 +2264,7 @@ int mmc_pm_notify(struct notifier_block *noti=
fy_block,
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rescan_disable =3D 0;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST_PW_N=
OTIFY_LONG;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, fla=
gs);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host, 0);
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 4e869d3..f8ea938 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -458,10 +458,12 @@ static int mmc_read_ext_csd(struct mmc_card *=
card, u8 *ext_csd)
>>> =A0 =A0 =A0 else
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0x0;
>>>
>>> - =A0 =A0 if (card->ext_csd.rev >=3D 6)
>>> + =A0 =A0 if (card->ext_csd.rev >=3D 6) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.generic_cmd6_time =3D 10 =
*
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_GENERIC=
_CMD6_TIME];
>>> - =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.power_off_longtime =3D 10 *
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_POWER_OFF=
_LONG_TIME];
>>> + =A0 =A0 } else
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.generic_cmd6_time =3D 0;
>>>
>>> =A0out:
>>> @@ -846,6 +848,23 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>>> =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0* If the host supports the power_off_notify capability=
 then
>>> + =A0 =A0 =A0* set the notification byte in the ext_csd register of=
 device
>>> + =A0 =A0 =A0*/
>>> + =A0 =A0 if ((host->caps2 & MMC_CAP2_POWEROFF_NOTIFY) &&
>>> + =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_NO_POWER_=
NOTIFICATION)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_=
NORMAL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CS=
D_POWER_OFF_NOTIFICATION,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CS=
D_POWER_ON,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->=
ext_csd.generic_cmd6_time);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
>>> + =A0 =A0 }
>>> +
>>> + =A0 =A0 if (!err)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D MMC_POWER=
ED_ON;
>>> +
>>> + =A0 =A0 /*
>>> =A0 =A0 =A0 =A0* Activate high speed (if supported)
>>> =A0 =A0 =A0 =A0*/
>>> =A0 =A0 =A0 if ((card->ext_csd.hs_max_dtr !=3D 0) &&
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 2cc3ffa..91fdaed 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2739,6 +2739,15 @@ int sdhci_add_host(struct sdhci_host *host)
>>> =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_D)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DRIVER_TYPE_D;
>>>
>>> + =A0 =A0 /*
>>> + =A0 =A0 =A0* If Notify capability is enabled by the host, set not=
ify to
>>> + =A0 =A0 =A0* short power off notify timeout value.
>>> + =A0 =A0 =A0*/
>>> + =A0 =A0 if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_NO=
TIFY_SHORT;
>>> + =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_PW_NO=
TIFY_NONE;
>>> +
>>> =A0 =A0 =A0 /* Initial value for re-tuning timer count */
>>> =A0 =A0 =A0 host->tuning_count =3D (caps[1] & SDHCI_RETUNING_TIMER_=
COUNT_MASK) >>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_RETUN=
ING_TIMER_COUNT_SHIFT;
>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>> index 30d493c..fce88b3 100644
>>> --- a/include/linux/mmc/card.h
>>> +++ b/include/linux/mmc/card.h
>>> @@ -54,6 +54,7 @@ struct mmc_ext_csd {
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0part_time; =A0 =A0 =
=A0 =A0 =A0 =A0 =A0/* Units: ms */
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =A0=
 =A0 =A0 =A0 =A0 /* Units: 100ns */
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0generic_cmd6_time; =
=A0 =A0 =A0/* Units: 10ms */
>>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0power_off_longtime; =A0=
 =A0 /* Units: ms */
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sectors;
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0card_type;
>>> @@ -209,6 +210,11 @@ struct mmc_card {
>>> =A0#define MMC_QUIRK_BLK_NO_CMD23 =A0 =A0 =A0 (1<<7) =A0 =A0 =A0 =A0=
 =A0/* Avoid CMD23 for regular multiblock */
>>> =A0#define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8) =A0 =A0 =A0 =A0/* =
Avoid sending 512 bytes in */
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* byte mode */
>>> + =A0 =A0 unsigned int =A0 =A0poweroff_notify_state; =A0/* eMMC4.5 =
notify feature */
>>> +#define MMC_NO_POWER_NOTIFICATION =A0 =A00
>>> +#define MMC_POWERED_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 1
>>> +#define MMC_POWEROFF_SHORT =A0 =A0 =A0 =A0 =A0 2
>>> +#define MMC_POWEROFF_LONG =A0 =A0 =A0 =A0 =A0 =A03
>>>
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0=
 /* erase size in sectors */
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0 =A0=
/* if erase unit is power 2 */
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index aed5bc7..07c0abf 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -239,8 +239,13 @@ struct mmc_host {
>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0caps2; =A0 =A0 =A0 =
=A0 =A0/* More host capabilities */
>>>
>>> =A0#define MMC_CAP2_BOOTPART_NOACC =A0 =A0 =A0(1 << 0) =A0 =A0 =A0 =
=A0/* Boot partition no access */
>>> +#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0/* Notify powerof=
f supported */
>>>
>>> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0 =
=A0/* supported pm features */
>>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0power_notify_type;
>>> +#define MMC_HOST_PW_NOTIFY_NONE =A0 =A0 =A0 =A0 =A0 =A0 =A00
>>> +#define MMC_HOST_PW_NOTIFY_SHORT =A0 =A0 1
>>> +#define MMC_HOST_PW_NOTIFY_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A02
>>>
>>> =A0#ifdef CONFIG_MMC_CLKGATE
>>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_request=
s; =A0 /* internal reference counter */
>>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>>> index cd63c2d..8b0e0a7 100644
>>> --- a/include/linux/mmc/mmc.h
>>> +++ b/include/linux/mmc/mmc.h
>>> @@ -271,6 +271,7 @@ struct _mmc_csd {
>>> =A0 */
>>>
>>> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 143 =A0 =A0 /* R/W =
*/
>>> +#define EXT_CSD_POWER_OFF_NOTIFICATION =A0 =A0 =A0 34 =A0 =A0 =A0/=
* R/W */
>>> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0156 =A0 =A0 /* R/W */
>>> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0160 =A0 =A0 /* RO */
>>> =A0#define EXT_CSD_RST_N_FUNCTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 162 =A0=
 =A0 /* R/W */
>>> @@ -346,6 +347,11 @@ struct _mmc_csd {
>>> =A0#define EXT_CSD_RST_N_EN_MASK =A0 =A0 =A0 =A00x3
>>> =A0#define EXT_CSD_RST_N_ENABLED =A0 =A0 =A0 =A01 =A0 =A0 =A0 /* RS=
T_n is enabled on card */
>>>
>>> +#define EXT_CSD_NO_POWER_NOTIFICATION =A0 =A0 =A0 =A00
>>> +#define EXT_CSD_POWER_ON =A0 =A0 =A0 =A0 =A0 =A0 1
>>> +#define EXT_CSD_POWER_OFF_SHORT =A0 =A0 =A0 =A0 =A0 =A0 =A02
>>> +#define EXT_CSD_POWER_OFF_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A0 3
>>> +
>>> =A0#define EXT_CSD_PWR_CL_8BIT_MASK =A0 =A0 0xF0 =A0 =A0/* 8 bit PW=
R CLS */
>>> =A0#define EXT_CSD_PWR_CL_4BIT_MASK =A0 =A0 0x0F =A0 =A0/* 8 bit PW=
R CLS */
>>> =A0#define EXT_CSD_PWR_CL_8BIT_SHIFT =A0 =A04
>>
>>
>>
>
