From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V7] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Tue, 4 Oct 2011 18:13:15 +0530
Message-ID: <CAGxe1ZHW3LKstDz5V2Q5cdoq=e1YYqVhFP7grrGnqd9a6MgGNw@mail.gmail.com>
References: <1317293169-16677-1-git-send-email-girish.shivananjappa@linaro.org>
	<1317293169-16677-2-git-send-email-girish.shivananjappa@linaro.org>
	<4E8AE55A.2030808@samsung.com>
	<CAGxe1ZGktJhouA18kC7wyVbihyb44ZHn7uU+ae4WwnCp0RGsFA@mail.gmail.com>
	<4E8AEAF9.6080206@samsung.com>
	<CAGxe1ZGF2=NVQSPhc=1apyf1PAL6nT2FwzdKwa2E4v0c5qJ9GA@mail.gmail.com>
	<CAGxe1ZFCp3UcwRJ7G+D9f6+BJxPagp9P8qwQuZ-D6cddsJUNSg@mail.gmail.com>
	<CAGxe1ZHHDyHo0kqnjYDnG70-VYE7CMLL02PaxG+nWWn=Y+HnMQ@mail.gmail.com>
	<4E8AF9B9.5080707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4E8AF9B9.5080707@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Mr Chung,

So u mean i dont have to re-do the patch for powerNotify.
One more question. Will you add my HS200 patch also to your eMMC4.5 bra=
nch.
In case yes then i will rebase my branch to ur emmc 4.5 branch and
resend my hs200 patch

regards
Girish K S

On 4 October 2011 17:49, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Girish.
>
> I just modified the MMC_CAP2_POWEROFF_NOTIFY instead of
> MMC_CAP_POWEROFF_NOTIFY.
>
> Regards,
> Jaehoon Chung
>
> On 10/04/2011 09:12 PM, Girish K S wrote:
>
>> Dear Mr Chung,
>>
>> i saw your pull request with poweroff notify feature. did you modify
>> anything in the Power Notify feature.
>>
>> I am preparing the patch with your review comment.
>>
>> regards
>> Girish K S
>>
>> On 4 October 2011 17:11, Girish K S <girish.shivananjappa@linaro.org=
> wrote:
>>> Hello Mr Chung,
>>>
>>> Since my both patches are dependent on each other. i will generate =
a
>>> patch series of HS200 and Power notify. So that they can be applied
>>> sequentially.
>>>
>>> Will update with your mentioned comment. kindly review it after my =
release.
>>>
>>> regards
>>> Girish K S
>>>
>>> On 4 October 2011 16:50, Girish K S <girish.shivananjappa@linaro.or=
g> wrote:
>>>> Hello Mr Chung,
>>>> I got your point. My reply was for your comment on "cannot apply t=
his
>>>> patch on mmc-next branch".
>>>>
>>>> regards
>>>> Girish K S
>>>>
>>>> On 4 October 2011 16:46, Jaehoon Chung <jh80.chung@samsung.com> wr=
ote:
>>>>> Hi Girish..
>>>>>
>>>>> My means if you use host->caps2, i think right that should be def=
ine
>>>>> MMC_CAP2_XXX.
>>>>> Am i wrong?
>>>>>
>>>>> Best regards,
>>>>> Jaehoon Chung
>>>>>
>>>>> On 10/04/2011 08:03 PM, Girish K S wrote:
>>>>>
>>>>>> Hello Mr Chung,
>>>>>>
>>>>>> Kindly apply my HS200 feature patch before this patch. then it w=
ill work fine.
>>>>>> can you check and let me know if it applies after HS200 patch.
>>>>>>
>>>>>> If it can be applied i will modify and resend
>>>>>> regards
>>>>>> Girish K S
>>>>>>
>>>>>> On 4 October 2011 16:22, Jaehoon Chung <jh80.chung@samsung.com> =
wrote:
>>>>>>> Hi Girish..
>>>>>>>
>>>>>>> i think this patch didn't base on latest for mmc-next..
>>>>>>> i commented the below.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Jaehoon Chung
>>>>>>>
>>>>>>> On 09/29/2011 07:46 PM, Girish K S wrote:
>>>>>>>
>>>>>>>> This patch adds the support for power off notify feature
>>>>>>>> available in eMMC 4.5 devices.
>>>>>>>> =A0 =A0 =A0 =A0 If the the host has support for this feature, =
then the
>>>>>>>> mmc core will notify it to the device by setting the
>>>>>>>> POWER_OFF_NOTIFICATION byte in the extended csd register
>>>>>>>> with a value 1(POWER_ON).
>>>>>>>> =A0 =A0 =A0 For suspend mode short timeout is used, whereas fo=
r the
>>>>>>>> normal poweroff long timeout is used.
>>>>>>>> =A0 =A0 =A0 =A0 This patch is dependent on Seungwon Jeon's pat=
ch for
>>>>>>>> CMD6 timeout.
>>>>>>>>
>>>>>>>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>>>>>>>> ---
>>>>>>>> Changes in V2:
>>>>>>>> =A0 =A0 =A0 Adds poweroff notification handling in suspend/nor=
mal
>>>>>>>> Changes in V4:
>>>>>>>> =A0 =A0 =A0 Updated with review comments of Jeon
>>>>>>>> Changes in V5:
>>>>>>>> =A0 =A0 =A0 This patch version fixes the problem with power of=
f
>>>>>>>> =A0 =A0 =A0 notify function, when called for the first time an=
d
>>>>>>>> =A0 =A0 =A0 card is not yet initialised.
>>>>>>>> Changes in V6:
>>>>>>>> =A0 =A0 =A0 Fixes checkpatch errors. The patches are generated=
 after
>>>>>>>> =A0 =A0 =A0 rebasing to chris's mmc-next branch.
>>>>>>>> Changes in V7:
>>>>>>>> =A0 =A0 =A0 Rebased to chris-mmc/mmc-next branch. merged to pa=
tches
>>>>>>>> =A0 =A0 =A0 to single patch.
>>>>>>>> =A0drivers/mmc/core/core.c =A0| =A0 37 +++++++++++++++++++++++=
++++++++++++++
>>>>>>>> =A0drivers/mmc/core/mmc.c =A0 | =A0 22 ++++++++++++++++++++++
>>>>>>>> =A0drivers/mmc/host/sdhci.c | =A0 10 ++++++++++
>>>>>>>> =A0include/linux/mmc/card.h | =A0 21 +++++++++++++++++++++
>>>>>>>> =A0include/linux/mmc/host.h | =A0 =A05 +++++
>>>>>>>> =A0include/linux/mmc/mmc.h =A0| =A0 =A06 ++++++
>>>>>>>> =A06 files changed, 101 insertions(+), 0 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>>>>> index 9698d8a..5fb2120 100644
>>>>>>>> --- a/drivers/mmc/core/core.c
>>>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>>>> @@ -1198,11 +1198,46 @@ static void mmc_power_up(struct mmc_ho=
st *host)
>>>>>>>>
>>>>>>>> =A0void mmc_power_off(struct mmc_host *host)
>>>>>>>> =A0{
>>>>>>>> + =A0 =A0 struct mmc_card *card;
>>>>>>>> + =A0 =A0 unsigned int notify_type;
>>>>>>>> + =A0 =A0 unsigned int timeout;
>>>>>>>> + =A0 =A0 int err;
>>>>>>>> +
>>>>>>>> + =A0 =A0 BUG_ON(!host);
>>>>>>>> +
>>>>>>>> =A0 =A0 =A0 mmc_host_clk_hold(host);
>>>>>>>>
>>>>>>>> + =A0 =A0 card =3D host->card;
>>>>>>>> =A0 =A0 =A0 host->ios.clock =3D 0;
>>>>>>>> =A0 =A0 =A0 host->ios.vdd =3D 0;
>>>>>>>>
>>>>>>>> + =A0 =A0 if (card !=3D NULL && mmc_card_mmc(card) &&
>>>>>>>> + =A0 =A0 =A0 =A0 (mmc_card_powernotify_on(card))) {
>>>>>>>> +
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->power_notify_type =3D=3D M=
MC_HOST_PW_NOTIFY_SHORT) {
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_=
CSD_POWER_OFF_SHORT;
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ex=
t_csd.generic_cmd6_time;
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powerno=
tify_short(card);
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_type =3D EXT_=
CSD_POWER_OFF_LONG;
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D card->ex=
t_csd.power_off_longtime;
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powerno=
tify_long(card);
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>>>>> +
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD=
_SET_NORMAL,
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0E=
XT_CSD_POWER_OFF_NOTIFICATION,
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n=
otify_type, timeout);
>>>>>>>> +
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Device faile=
d to respond "
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"with=
in %d poweroff time."
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"forc=
efully powering down"
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"the =
device\n", timeout);
>>>>>>>> +
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Set the card state to no notifica=
tion after the poweroff */
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotify_off(card);
>>>>>>>> + =A0 =A0 }
>>>>>>>> +
>>>>>>>> =A0 =A0 =A0 /*
>>>>>>>> =A0 =A0 =A0 =A0* Reset ocr mask to be the highest possible vol=
tage supported for
>>>>>>>> =A0 =A0 =A0 =A0* this mmc host. This value will be used at nex=
t power up.
>>>>>>>> @@ -2194,6 +2230,7 @@ int mmc_pm_notify(struct notifier_block =
*notify_block,
>>>>>>>>
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, fla=
gs);
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rescan_disable =3D 1;
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST=
_PW_NOTIFY_SHORT;
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock=
, flags);
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&host->de=
tect);
>>>>>>>>
>>>>>>>> @@ -2217,6 +2254,7 @@ int mmc_pm_notify(struct notifier_block =
*notify_block,
>>>>>>>>
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, fla=
gs);
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->rescan_disable =3D 0;
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 host->power_notify_type =3D MMC_HOST=
_PW_NOTIFY_LONG;
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock=
, flags);
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host, 0);
>>>>>>>>
>>>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>>>>> index f28aa4f..25ba7f5 100644
>>>>>>>> --- a/drivers/mmc/core/mmc.c
>>>>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>>>>> @@ -447,6 +447,11 @@ static int mmc_read_ext_csd(struct mmc_ca=
rd *card, u8 *ext_csd)
>>>>>>>> =A0 =A0 =A0 else
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->erased_byte =3D 0x0;
>>>>>>>>
>>>>>>>> + =A0 =A0 if (card->ext_csd.rev >=3D 6) {
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.power_off_longtime =3D=
 10 *
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_POWE=
R_OFF_LONG_TIME];
>>>>>>>> + =A0 =A0 }
>>>>>>>> +
>>>>>>>> =A0out:
>>>>>>>> =A0 =A0 =A0 return err;
>>>>>>>> =A0}
>>>>>>>> @@ -829,6 +834,23 @@ static int mmc_init_card(struct mmc_host =
*host, u32 ocr,
>>>>>>>> =A0 =A0 =A0 }
>>>>>>>>
>>>>>>>> =A0 =A0 =A0 /*
>>>>>>>> + =A0 =A0 =A0* If the host supports the power_off_notify capab=
ility then
>>>>>>>> + =A0 =A0 =A0* set the notification byte in the ext_csd regist=
er of device
>>>>>>>> + =A0 =A0 =A0*/
>>>>>>>> + =A0 =A0 if (host->caps2 & MMC_CAP_POWEROFF_NOTIFY &&
>>>>>>>> + =A0 =A0 =A0 =A0 (mmc_card_powernotify_off(card))) {
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD=
_SET_NORMAL,
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0E=
XT_CSD_POWER_OFF_NOTIFICATION,
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0E=
XT_CSD_POWER_ON,
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c=
ard->ext_csd.generic_cmd6_time);
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
>>>>>>>> + =A0 =A0 }
>>>>>>>> +
>>>>>>>
>>>>>>>
>>>>>>> you used host->caps2, i think right that should be use
>>>>>>> MMC_CAP2_POWEROFF_NOTIFY.
>>>>>>>
>>>>>>>> + =A0 =A0 if (!err)
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_powernotify_on(card);
>>>>>>>> +
>>>>>>>> + =A0 =A0 /*
>>>>>>>> =A0 =A0 =A0 =A0* Activate high speed (if supported)
>>>>>>>> =A0 =A0 =A0 =A0*/
>>>>>>>> =A0 =A0 =A0 if (card->ext_csd.hs_max_dtr !=3D 0) {
>>>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci=
=2Ec
>>>>>>>> index 4220133..2818238 100644
>>>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>>>> @@ -2599,6 +2599,16 @@ int sdhci_add_host(struct sdhci_host *h=
ost)
>>>>>>>> =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_D)
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DRIVER_TYPE=
_D;
>>>>>>>>
>>>>>>>> + =A0 =A0 /*
>>>>>>>> + =A0 =A0 =A0* If Notify capability is enabled and
>>>>>>>> + =A0 =A0 =A0* notify type is not initialised by host, set def=
ault to
>>>>>>>> + =A0 =A0 =A0* long power off notify timeout value
>>>>>>>> + =A0 =A0 =A0*/
>>>>>>>> + =A0 =A0 if (mmc->caps2 & MMC_CAP_POWEROFF_NOTIFY)
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_=
PW_NOTIFY_SHORT;
>>>>>>>> + =A0 =A0 else
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->power_notify_type =3D MMC_HOST_=
PW_NOTIFY_NONE;
>>>>>>>> +
>>>>>>>
>>>>>>>
>>>>>>> also here...
>>>>>>>
>>>>>>>> =A0 =A0 =A0 /* Initial value for re-tuning timer count */
>>>>>>>> =A0 =A0 =A0 host->tuning_count =3D (caps[1] & SDHCI_RETUNING_T=
IMER_COUNT_MASK) >>
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_=
RETUNING_TIMER_COUNT_SHIFT;
>>>>>>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card=
=2Eh
>>>>>>>> index 15e5ce2..d6f8c85 100644
>>>>>>>> --- a/include/linux/mmc/card.h
>>>>>>>> +++ b/include/linux/mmc/card.h
>>>>>>>> @@ -53,6 +53,8 @@ struct mmc_ext_csd {
>>>>>>>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rst_=
n_function;
>>>>>>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0part_time; =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* Units: ms */
>>>>>>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0=
 =A0 =A0 =A0 =A0 =A0 /* Units: 100ns */
>>>>>>>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0generic_cmd6_tim=
e; =A0 =A0 =A0/* Units: ms */
>>>>>>>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0power_off_longti=
me; =A0 =A0 /* Units: ms */
>>>>>>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
>>>>>>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sectors;
>>>>>>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0card_type;
>>>>>>>> @@ -192,6 +194,11 @@ struct mmc_card {
>>>>>>>> =A0#define MMC_QUIRK_BLK_NO_CMD23 =A0 =A0 =A0 (1<<7) =A0 =A0 =A0=
 =A0 =A0/* Avoid CMD23 for regular multiblock */
>>>>>>>> =A0#define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8) =A0 =A0 =A0 =A0=
/* Avoid sending 512 bytes in */
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* byte mode */
>>>>>>>> + =A0 =A0 unsigned int =A0 =A0poweroff_notify_state; =A0/* eMM=
C4.5 notify feature */
>>>>>>>> +#define MMC_NO_POWER_NOTIFICATION =A0 =A00
>>>>>>>> +#define MMC_POWERED_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 1
>>>>>>>> +#define MMC_POWEROFF_SHORT =A0 =A0 =A0 =A0 =A0 2
>>>>>>>> +#define MMC_POWEROFF_LONG =A0 =A0 =A0 =A0 =A0 =A03
>>>>>>>>
>>>>>>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0=
 =A0 /* erase size in sectors */
>>>>>>>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0=
 =A0/* if erase unit is power 2 */
>>>>>>>> @@ -329,6 +336,20 @@ static inline void __maybe_unused remove_=
quirk(struct mmc_card *card, int data)
>>>>>>>> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_U=
LTRAHIGHSPEED)
>>>>>>>> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_C=
ARD_SDXC)
>>>>>>>>
>>>>>>>> +#define mmc_card_powernotify_on(c) =A0 =A0 \
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->poweroff_notify_state =3D=3D=
 MMC_POWERED_ON)
>>>>>>>> +#define mmc_card_powernotify_off(c) =A0 =A0\
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->poweroff_notify_state =3D=3D=
 MMC_NO_POWER_NOTIFICATION)
>>>>>>>> +
>>>>>>>> +#define mmc_card_set_powernotify_off(c) =A0 =A0\
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->poweroff_notify_state =3D M=
MC_NO_POWER_NOTIFICATION)
>>>>>>>> +#define mmc_card_set_powernotify_on(c) \
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->poweroff_notify_state =3D M=
MC_POWERED_ON)
>>>>>>>> +#define mmc_card_set_powernotify_short(c) =A0\
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->poweroff_notify_state =3D M=
MC_POWEROFF_SHORT)
>>>>>>>> +#define mmc_card_set_powernotify_long(c) =A0 \
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->poweroff_notify_state =3D M=
MC_POWEROFF_LONG)
>>>>>>>> +
>>>>>>>> =A0/*
>>>>>>>> =A0 * Quirk add/remove for MMC products.
>>>>>>>> =A0 */
>>>>>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host=
=2Eh
>>>>>>>> index f62ffa2..b711a00 100644
>>>>>>>> --- a/include/linux/mmc/host.h
>>>>>>>> +++ b/include/linux/mmc/host.h
>>>>>>>> @@ -245,8 +245,13 @@ struct mmc_host {
>>>>>>>> =A0#define MMC_CAP_HS200_1_8V_SDR =A0 =A0 =A0 (1 << 2) =A0 =A0=
 =A0 =A0/* can support */
>>>>>>>> =A0#define MMC_CAP_HS200_1_2V_SDR =A0 =A0 =A0 (1 << 3) =A0 =A0=
 =A0 =A0/* can support */
>>>>>>>> =A0#define MMC_CAP_HIGHSPEED_200 =A0 =A0 =A0 =A0(1 << 4) =A0 =A0=
 =A0 =A0/* Can do MMC HS200 timing */
>>>>>>>> +#define MMC_CAP_POWEROFF_NOTIFY =A0 =A0 =A0(1 << 31) =A0 =A0 =
=A0 /* Notify poweroff supported */
>>>>>>>>
>>>>>>>> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0=
 =A0 =A0/* supported pm features */
>>>>>>>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
>>>>>>>> +#define MMC_HOST_PW_NOTIFY_NONE =A0 =A0 =A0 =A0 =A0 =A0 =A00
>>>>>>>> +#define MMC_HOST_PW_NOTIFY_SHORT =A0 =A0 1
>>>>>>>> +#define MMC_HOST_PW_NOTIFY_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A02
>>>>>>>>
>>>>>>>> =A0#ifdef CONFIG_MMC_CLKGATE
>>>>>>>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_re=
quests; =A0 /* internal reference counter */
>>>>>>>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>>>>>>>> index 3f2e210..944c99b 100644
>>>>>>>> --- a/include/linux/mmc/mmc.h
>>>>>>>> +++ b/include/linux/mmc/mmc.h
>>>>>>>> @@ -271,6 +271,7 @@ struct _mmc_csd {
>>>>>>>> =A0 * EXT_CSD fields
>>>>>>>> =A0 */
>>>>>>>>
>>>>>>>> +#define EXT_CSD_POWER_OFF_NOTIFICATION =A0 =A0 =A0 34 =A0 =A0=
 =A0/* R/W */
>>>>>>>> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0156 =A0 =A0 /* R/W *=
/
>>>>>>>> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0160 =A0 =A0 /* RO =
*/
>>>>>>>> =A0#define EXT_CSD_RST_N_FUNCTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
162 =A0 =A0 /* R/W */
>>>>>>>> @@ -348,6 +349,11 @@ struct _mmc_csd {
>>>>>>>> =A0#define EXT_CSD_RST_N_EN_MASK =A0 =A0 =A0 =A00x3
>>>>>>>> =A0#define EXT_CSD_RST_N_ENABLED =A0 =A0 =A0 =A01 =A0 =A0 =A0 =
/* RST_n is enabled on card */
>>>>>>>>
>>>>>>>> +#define EXT_CSD_NO_POWER_NOTIFICATION =A0 =A0 =A0 =A00
>>>>>>>> +#define EXT_CSD_POWER_ON =A0 =A0 =A0 =A0 =A0 =A0 1
>>>>>>>> +#define EXT_CSD_POWER_OFF_SHORT =A0 =A0 =A0 =A0 =A0 =A0 =A02
>>>>>>>> +#define EXT_CSD_POWER_OFF_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A0 3
>>>>>>>> +
>>>>>>>> =A0#define EXT_CSD_PWR_CL_8BIT_MASK =A0 =A0 0xF0 =A0 =A0/* 8 b=
it PWR CLS */
>>>>>>>> =A0#define EXT_CSD_PWR_CL_4BIT_MASK =A0 =A0 0x0F =A0 =A0/* 8 b=
it PWR CLS */
>>>>>>>> =A0#define EXT_CSD_PWR_CL_8BIT_SHIFT =A0 =A04
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-=
mmc" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
