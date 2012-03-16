From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: core: Fix PowerOff Notify suspend/resume
Date: Fri, 16 Mar 2012 10:03:22 +0100
Message-ID: <4F6301DA.2080705@stericsson.com>
References: <1328004843-16094-1-git-send-email-girish.shivananjappa@linaro.org>	<4F60B808.4010803@stericsson.com> <CAGxe1ZGrCULDFuXoaoM5_hmuZhBSJvJpJ_F-jCLAEAgmiK2Aww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAGxe1ZGrCULDFuXoaoM5_hmuZhBSJvJpJ_F-jCLAEAgmiK2Aww@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "saugata.das@linaro.org" <saugata.das@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Girish,

On 03/16/2012 04:49 AM, Girish K S wrote:
> On 14 March 2012 20:53, Ulf Hansson<ulf.hansson@stericsson.com>  wrote:
>> Hi Girish and Chris,
>>
>> I noticed that this has been pushed for 3.3, I think we need to make a
>> revert of it asap if possible.
>>
>> I were unfortunately not able to review this patch earlier but it has issues
>> I believe. It will break suspend/resume for eMMC devices supporting the
>> SLEEP command and not the "poweroff notify" from eMMC 4.5.
>
> By break do you mean compilation break or system crash. can you please
> post the log that caused the break.
> I re checked it on eMMC 4.5, 4.41, high speed mmc card and normal mmc
> card. I can compile successfully and
> could test the suspend/ resume functionality without carsh.
> If you provide the log, i can check more.

For eMMC devices supporting SLEEP, the SLEEP cmd must be issued before 
powering down the VCC to the card. Otherwise we are violating the eMMC 
spec. (Some eMMC device accept the above condition anyway, so that might 
be why your devices were able to resumed without any problem).

>
>>
>> Please see my comments below.
>>
>>
>> On 01/31/2012 11:14 AM, Girish K S wrote:
>>>
>>> Modified the mmc_poweroff to resume before sending the
>>> poweroff notification command. In sleep mode only AWAKE
>>> and RESET commands are allowed, so before sending the
>>> poweroff notification command resume from sleep mode and
>>> then send the notification command.
>>>
>>> POwerOff Notify is tested on a Synopsis Designware Host
>>> Controller(eMMC 4.5). The suspend to RAM and resume works fine.
>>>
>>> This patch is successfully applied on the Chris's mmc-next
>>> branch
>>>
>>> cc: Chris Ball<cjb@laptop.org>
>>> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
>>> Tested-by: Girish K S<girish.shivananjappa@linaro.org>
>>> ---
>>>   drivers/mmc/core/core.c  |   28 ++++++++++++++++++++--------
>>>   drivers/mmc/core/mmc.c   |   17 ++++++++++++-----
>>>   include/linux/mmc/card.h |    4 ++++
>>>   3 files changed, 36 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index bec0bf2..14ec575 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1239,7 +1239,8 @@ static void mmc_poweroff_notify(struct mmc_host
>>> *host)
>>>         int err = 0;
>>>
>>>         card = host->card;
>>> -
>>> +       mmc_claim_host(host);
>>> +
>>>         /*
>>>          * Send power notify command only if card
>>>          * is mmc and notify state is powered ON
>>> @@ -1269,6 +1270,7 @@ static void mmc_poweroff_notify(struct mmc_host
>>> *host)
>>>                 /* Set the card state to no notification after the poweroff
>>> */
>>>                 card->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION;
>>>         }
>>> +       mmc_release_host(host);
>>>   }
>>>
>>>   /*
>>> @@ -1327,12 +1329,28 @@ static void mmc_power_up(struct mmc_host *host)
>>>
>>>   void mmc_power_off(struct mmc_host *host)
>>>   {
>>> +       int err = 0;
>>>         mmc_host_clk_hold(host);
>>>
>>>         host->ios.clock = 0;
>>>         host->ios.vdd = 0;
>>>
>>> -       mmc_poweroff_notify(host);
>>> +       /*
>>> +        * For eMMC 4.5 device send AWAKE command before
>>> +        * POWER_OFF_NOTIFY command, because in sleep state
>>> +        * eMMC 4.5 devices respond to only RESET and AWAKE cmd
>>> +        */
>>> +       if (host->card&&    mmc_card_is_sleep(host->card)&&
>>> +           host->bus_ops->resume) {
>>> +               err = host->bus_ops->resume(host);
>>
>>
>> This is just plain wrong. First we may have suspended the host from
>> mmc_suspend_host then we enter this funtion (mmc_power_off) to cut the power
>> to the card. Why do we even want to resume if we just did suspend?
> for 4.5 case, cards wont respond to any command other than awake and
> reset. so we resume before executing a switch
> for poweroff notify. for non 4.5 card, it will resume and wont
> continue in resume state because of the poweroff executed in the end.

I understand, but I think we should never have put the card into 
suspend/sleep state if we now that the card support poweroff notify 
feature. The poweroff notify shall be handled similar how sleep is 
handled from within the suspend function, I think.

>>
>> Moreover, this will actually mean that for mmc devices which are supporting
>> SLEEP but not the new eMMC 4.5 feature poweroff_notify will leave this
>> function in a resumed state (in other words, not in SLEEP state) which is
>> not OK.
> non 4.5 devices will not remain in resume state. Because mmc_set_ios
> will power down the device.

Yes, and thus violating the eMMC spec for devices supporting SLEEP.

>>
>>
>>> +
>>> +               if (!err)
>>> +                       mmc_poweroff_notify(host);
>>> +               else
>>> +                       pr_warning("%s: error %d during resume "
>>> +                                  "(continue with poweroff sequence)\n",
>>> +                                  mmc_hostname(host), err);
>>> +       }
>>>
>>>         /*
>>>          * Reset ocr mask to be the highest possible voltage supported for
>>> @@ -2386,12 +2404,6 @@ int mmc_suspend_host(struct mmc_host *host)
>>>                  */
>>>                 if (mmc_try_claim_host(host)) {
>>>                         if (host->bus_ops->suspend) {
>>> -                               /*
>>> -                                * For eMMC 4.5 device send notify command
>>> -                                * before sleep, because in sleep state
>>> eMMC 4.5
>>> -                                * devices respond to only RESET and AWAKE
>>> cmd
>>> -                                */
>>> -                               mmc_poweroff_notify(host);
>>>                                 err = host->bus_ops->suspend(host);
>>>                         }
>>>                         mmc_do_release_host(host);
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 2bc586b..c3f09a2 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1330,11 +1330,13 @@ static int mmc_suspend(struct mmc_host *host)
>>>         BUG_ON(!host->card);
>>>
>>>         mmc_claim_host(host);
>>> -       if (mmc_card_can_sleep(host))
>>> +       if (mmc_card_can_sleep(host)) {
>>>                 err = mmc_card_sleep(host);
>>> -       else if (!mmc_host_is_spi(host))
>>> +               if (!err)
>>> +                       mmc_card_set_sleep(host->card);
>>
>>
>> I suggest to move this inside the mmc_card_sleep function instead.
> sure will do that as a additional patch
>>
>>
>>> +       } else if (!mmc_host_is_spi(host))
>>>                 mmc_deselect_cards(host);
>>> -       host->card->state&= ~MMC_STATE_HIGHSPEED;
>>> +       host->card->state&= ~(MMC_STATE_HIGHSPEED |
>>> MMC_STATE_HIGHSPEED_200);
>>
>>
>> What has MMC_STATE_HIGHSPEED_200 with this patch to do?
> same as high_speed. on suspend high speed state is reset.

I am not saying that this should not be done, just saying that should 
this been done within this patch. It has nothing to do with poweroff notify.

>>
>>
>>>         mmc_release_host(host);
>>>
>>>         return err;
>>> @@ -1354,7 +1356,11 @@ static int mmc_resume(struct mmc_host *host)
>>>         BUG_ON(!host->card);
>>>
>>>         mmc_claim_host(host);
>>> -       err = mmc_init_card(host, host->ocr, host->card);
>>> +       if (mmc_card_is_sleep(host->card)) {
>>> +               err = mmc_card_awake(host);
>>> +               mmc_card_clr_sleep(host->card);
>>
>>
>> I suggest to move this inside the mmc_card_sleep function instead.
> sure will do it.
>>
>>
>>> +       } else
>>> +               err = mmc_init_card(host, host->ocr, host->card);
>>>         mmc_release_host(host);
>>>
>>>         return err;
>>> @@ -1364,7 +1370,8 @@ static int mmc_power_restore(struct mmc_host *host)
>>>   {
>>>         int ret;
>>>
>>> -       host->card->state&= ~MMC_STATE_HIGHSPEED;
>>> +       host->card->state&= ~(MMC_STATE_HIGHSPEED |
>>> MMC_STATE_HIGHSPEED_200);
>>
>>
>> What has MMC_STATE_HIGHSPEED_200 with this patch to do?
>>
>>> +       mmc_card_clr_sleep(host->card);
>>
>>
>> Why do we have clear the sleep state here?
> currently it is of no use. coz init_card will initialize the card data
> structure. If power_save / power_restore function is modified to put
> the card in sleep state and only wake up (no complete card
> initialization), then above setting is required.
>>
>>>         mmc_claim_host(host);
>>>         ret = mmc_init_card(host, host->ocr, host->card);
>>>         mmc_release_host(host);
>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>> index f9a0663..1a1ca71 100644
>>> --- a/include/linux/mmc/card.h
>>> +++ b/include/linux/mmc/card.h
>>> @@ -219,6 +219,7 @@ struct mmc_card {
>>>   #define MMC_CARD_SDXC         (1<<6)          /* card is SDXC */
>>>   #define MMC_CARD_REMOVED      (1<<7)          /* card has been removed */
>>>   #define MMC_STATE_HIGHSPEED_200       (1<<8)          /* card is in HS200
>>> mode */
>>> +#define MMC_STATE_SLEEP                (1<<9)          /* card is in
>>> sleep state */
>>>         unsigned int            quirks;         /* card quirks */
>>>   #define MMC_QUIRK_LENIENT_FN0 (1<<0)          /* allow SDIO FN0 writes
>>> outside of the VS CCCR range */
>>>   #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)  /* use func->cur_blksize */
>>> @@ -384,6 +385,7 @@ static inline void __maybe_unused remove_quirk(struct
>>> mmc_card *card, int data)
>>>   #define mmc_sd_card_uhs(c)    ((c)->state&    MMC_STATE_ULTRAHIGHSPEED)
>>>   #define mmc_card_ext_capacity(c) ((c)->state&    MMC_CARD_SDXC)
>>>   #define mmc_card_removed(c)   ((c)&&    ((c)->state&    MMC_CARD_REMOVED))
>>> +#define mmc_card_is_sleep(c)   ((c)->state&    MMC_STATE_SLEEP)
>>>
>>>
>>>   #define mmc_card_set_present(c)       ((c)->state |= MMC_STATE_PRESENT)
>>>   #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
>>> @@ -395,7 +397,9 @@ static inline void __maybe_unused remove_quirk(struct
>>> mmc_card *card, int data)
>>>   #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
>>>   #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
>>>   #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
>>> +#define mmc_card_set_sleep(c)  ((c)->state |= MMC_STATE_SLEEP)
>>>
>>> +#define mmc_card_clr_sleep(c)  ((c)->state&= ~MMC_STATE_SLEEP)
>>>
>>>   /*
>>>    * Quirk add/remove for MMC products.
>>>    */
>>
>>
>> Best regards
>> Ulf Hansson
>

Kind regards
Ulf Hansson
