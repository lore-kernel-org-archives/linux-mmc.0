From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 08/15] mmc: mmc: Hold re-tuning if the card is put
 to sleep
Date: Wed, 22 Apr 2015 10:24:16 +0300
Message-ID: <55374CA0.70004@intel.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>	<1429531796-21987-9-git-send-email-adrian.hunter@intel.com>	<CAPDyKFq3nncR09=TJ0o3vGEdwEw5bYPCxu38OFPZyaiKTUcAzw@mail.gmail.com>	<55362DE0.1070302@intel.com> <CAPDyKFrYD=kqifhhcvPVcqCKtbZMng42vr+LmaCZYMPhPUhEjQ@mail.gmail.com> <5536420F.5050201@intel.com> <55369602.1010504@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54410 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331AbbDVH0b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Apr 2015 03:26:31 -0400
In-Reply-To: <55369602.1010504@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>

On 21/04/15 21:25, Arend van Spriel wrote:
> On 04/21/15 14:26, Adrian Hunter wrote:
>> On 21/04/15 14:53, Ulf Hansson wrote:
>>> On 21 April 2015 at 13:00, Adrian Hunter<adrian.hunter@intel.com>  wrote:
>>>> On 21/04/15 12:42, Ulf Hansson wrote:
>>>>> On 20 April 2015 at 14:09, Adrian Hunter<adrian.hunter@intel.com>  wrote:
>>>>>> Currently "mmc sleep" is used before power off and
>>>>>> is not paired with waking up. Nevertheless hold
>>>>>> re-tuning.
>>>>>>
>>>>>> Signed-off-by: Adrian Hunter<adrian.hunter@intel.com>
>>>>>> ---
>>>>>>   drivers/mmc/core/mmc.c | 14 +++++++++++---
>>>>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>>> index f36c76f..daf9954 100644
>>>>>> --- a/drivers/mmc/core/mmc.c
>>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>>> @@ -21,6 +21,7 @@
>>>>>>   #include<linux/mmc/mmc.h>
>>>>>>
>>>>>>   #include "core.h"
>>>>>> +#include "host.h"
>>>>>>   #include "bus.h"
>>>>>>   #include "mmc_ops.h"
>>>>>>   #include "sd_ops.h"
>>>>>> @@ -1504,6 +1505,7 @@ static int mmc_can_sleep(struct mmc_card *card)
>>>>>>          return (card&&  card->ext_csd.rev>= 3);
>>>>>>   }
>>>>>>
>>>>>> +/* If necessary, callers must hold re-tuning */
>>>>>>   static int mmc_sleep(struct mmc_host *host)
>>>>>>   {
>>>>>>          struct mmc_command cmd = {0};
>>>>>> @@ -1631,6 +1633,7 @@ static int _mmc_suspend(struct mmc_host *host,
>>>>>> bool is_suspend)
>>>>>>          int err = 0;
>>>>>>          unsigned int notify_type = is_suspend ?
>>>>>> EXT_CSD_POWER_OFF_SHORT :
>>>>>>                                          EXT_CSD_POWER_OFF_LONG;
>>>>>> +       bool retune_release = false;
>>>>>>
>>>>>>          BUG_ON(!host);
>>>>>>          BUG_ON(!host->card);
>>>>>> @@ -1651,17 +1654,22 @@ static int _mmc_suspend(struct mmc_host *host,
>>>>>> bool is_suspend)
>>>>>>                  goto out;
>>>>>>
>>>>>>          if (mmc_can_poweroff_notify(host->card)&&
>>>>>> -               ((host->caps2&  MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
>>>>>> +               ((host->caps2&  MMC_CAP2_FULL_PWR_CYCLE) ||
>>>>>> !is_suspend)) {
>>>>>>                  err = mmc_poweroff_notify(host->card, notify_type);
>>>>>> -       else if (mmc_can_sleep(host->card))
>>>>>> +       } else if (mmc_can_sleep(host->card)) {
>>>>>> +               mmc_retune_hold(host);
>>>>>>                  err = mmc_sleep(host);
>>>>>> -       else if (!mmc_host_is_spi(host))
>>>>>> +       } else if (!mmc_host_is_spi(host)) {
>>>>>>                  err = mmc_deselect_cards(host);
>>>>>> +       }
>>>>>>
>>>>>>          if (!err) {
>>>>>>                  mmc_power_off(host);
>>>>>>                  mmc_card_set_suspended(host->card);
>>>>>>          }
>>>>>> +
>>>>>> +       if (retune_release)
>>>>>> +               mmc_retune_release(host);
>>>>>>   out:
>>>>>>          mmc_release_host(host);
>>>>>>          return err;
>>>>>> -- 
>>>>>> 1.9.1
>>>>>>
>>>>>
>>>>> According to our previous discussions I have given this some more
>>>>> thinking.
>>>>>
>>>>> I don't think we can allow to hold/disable re-tune in this path at
>>>>> all. That's because we are claiming the host here and the sleep
>>>>> command might then be the first command we invoke during the system PM
>>>>> sequence.
>>>>>
>>>>> That means sdhci might have flagged need_retune, since it's been
>>>>> runtime PM suspended. And for those scenarios I guess we really need
>>>>> to do a re-tune prior sending the sleep command, right?
>>>>
>>>> Yes, although that is how it works.
>>>
>>> Ohh, you are one step ahead of me. Good! :-)
>>>
>>>>
>>>> Previously I had two functions mmc_retune_hold() and mmc_retune_and_hold()
>>>> but after one of the revisions I found that only one was needed. I stuck
>>>> with the mmc_retune_hold() name because it doesn't necessarily cause a
>>>> re-tune, but only if the hold count was zero and a retune is needed.
>>>>
>>>>>
>>>>> Earlier I only had the re-tune timer in mind, which is why I was less
>>>>> restrictive and suggesting you to add hold/disable. Sorry about that.
>>>>>
>>>>> Now, with the above in mind I believe you have similar issues with
>>>>> patch5 (mmc: core: Hold re-tuning during switch commands) and patch6
>>>>> (mmc: core: Hold re-tuning during erase commands). And that's because
>>>>> there are cases when the switch/erase commands are the first commands
>>>>> sent, after the sdhci host has been runtime PM suspended. I guess we
>>>>> need a way to make sure we don't hold re-tune for these cases.
>>>>>
>>>>> An option to deal with that is to use a separate flag set by host
>>>>> drivers, though the mmc_needs_retune() API and let that one override
>>>>> another.
>>>>>
>>>>> Forgive me for pushing you back and forth for how to do this, but it
>>>>
>>>> Not a problem. Thanks for persevering.
>>>>
>>>>> seems like we still have some outstanding issues to resolve.
>>>
>>> So that then more or less leaves us with one outstanding issue. The
>>> SDIO irq wakeup scenario.
>>>
>>> How will that work for sdhci?
>>>
>>> Your suggestion is to hold re-tune for the SDIO wakeup command. If I
>>> understand correct that could be overridden when the host flags
>>> need_retune from its runtime PM suspend callback, right?
>>>
>>> That then mean that the re-tuning will be done prior sending the
>>> wakeup command? That wouldn't work, unless the re-tune command also
>>> act as wakeup, which I doubt.
>>
>> The wakeup command has to come first.
>>
>>>
>>> If I _haven't_ understand correctly and you mean that the SDIO wakeup
>>> command shall be invoked prior re-tuning is done; that would mean that
>>> SDHCI will send a command to the card without first satisfying its
>>> need for a re-tune. And that wouldn't work either, right?
>>
>> My understanding is that the wakeup command will still work but there might
>> be a CRC error.
>>
>> Need Arend to comment on this since it is his driver we are talking about.
> 
> Are we?

At a guess, something that would have the effect of:

diff --git a/drivers/net/wireless/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
index ab0c898..4e5e97f 100644
--- a/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
@@ -774,8 +774,12 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
 
        wr_val = (on << SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT);
        /* 1st KSO write goes to AOS wake up core if device is asleep  */
+       if (on)
+               bus->sdiodev->func[SDIO_FUNC_1]->card->host->hold_retune += 1;
        brcmf_sdiod_regwb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR,
                          wr_val, &err);
+       if (on)
+               bus->sdiodev->func[SDIO_FUNC_1]->card->host->hold_retune -= 1;
 
        if (on) {
                /* device WAKEUP through KSO:


> 
>> So the plan would be:
>>     - re-tuning hold_count is incremented
>>     - wakeup command is issued (and no re-tuning is done)
>>     - errors are ignored
>>     - re-tuning hold_count is decremented
>>     - continue as normal, re-tuning before the next request as needed
>>
>>>
>>> So then the only solution for SDHCI would be to prevent it from being
>>> runtime PM suspended when configured for SDIO. Urgh, that's really
>>> bad.
>>
>> Yes that would defeat the point of sleeping.
> 
> I recently submitted a patch in brcmfmac to disable runtime pm for the SDIO
> host controller as it interfered with communication between driver and
> device, ie. driver send request to device but response is never received
> because runtime-pm kicked in. Our sdio func driver does not provide
> runtime-pm (yet) and figured using pm_runtime_forbid() was the only way to
> let the host controller know this fact.

We need to sort this out properly at some point.

