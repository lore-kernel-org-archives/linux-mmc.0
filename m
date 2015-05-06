From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 08/15] mmc: mmc: Hold re-tuning if the card is put
 to sleep
Date: Wed, 06 May 2015 13:28:13 +0300
Message-ID: <5549ECBD.3010608@intel.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>	<1429531796-21987-9-git-send-email-adrian.hunter@intel.com>	<CAPDyKFp0c5Gc9HpS+F_DV2-pxuKnWjqQ7UrGTFd5FcSSG9JT7Q@mail.gmail.com>	<5549D336.4040206@intel.com> <CAPDyKFp4A4UzEUN8pDHpjNn0PX3HcmCA6khHCdRH5R0GsO1Lrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63378 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbbEFKaq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 May 2015 06:30:46 -0400
In-Reply-To: <CAPDyKFp4A4UzEUN8pDHpjNn0PX3HcmCA6khHCdRH5R0GsO1Lrw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 06/05/15 12:32, Ulf Hansson wrote:
> On 6 May 2015 at 10:39, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 04/05/15 16:44, Ulf Hansson wrote:
>>> On 20 April 2015 at 14:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> Currently "mmc sleep" is used before power off and
>>>> is not paired with waking up. Nevertheless hold
>>>> re-tuning.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  drivers/mmc/core/mmc.c | 14 +++++++++++---
>>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index f36c76f..daf9954 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -21,6 +21,7 @@
>>>>  #include <linux/mmc/mmc.h>
>>>>
>>>>  #include "core.h"
>>>> +#include "host.h"
>>>>  #include "bus.h"
>>>>  #include "mmc_ops.h"
>>>>  #include "sd_ops.h"
>>>> @@ -1504,6 +1505,7 @@ static int mmc_can_sleep(struct mmc_card *card)
>>>>         return (card && card->ext_csd.rev >= 3);
>>>>  }
>>>>
>>>> +/* If necessary, callers must hold re-tuning */
>>>
>>> Remove this comment.
>>>
>>>>  static int mmc_sleep(struct mmc_host *host)
>>>>  {
>>>>         struct mmc_command cmd = {0};
>>>> @@ -1631,6 +1633,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>>>>         int err = 0;
>>>>         unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
>>>>                                         EXT_CSD_POWER_OFF_LONG;
>>>> +       bool retune_release = false;
>>>>
>>>>         BUG_ON(!host);
>>>>         BUG_ON(!host->card);
>>>> @@ -1651,17 +1654,22 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>>>>                 goto out;
>>>>
>>>>         if (mmc_can_poweroff_notify(host->card) &&
>>>> -               ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
>>>> +               ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend)) {
>>>>                 err = mmc_poweroff_notify(host->card, notify_type);
>>>> -       else if (mmc_can_sleep(host->card))
>>>> +       } else if (mmc_can_sleep(host->card)) {
>>>> +               mmc_retune_hold(host);
>>>>                 err = mmc_sleep(host);
>>>> -       else if (!mmc_host_is_spi(host))
>>>> +       } else if (!mmc_host_is_spi(host)) {
>>>>                 err = mmc_deselect_cards(host);
>>>> +       }
>>>>
>>>>         if (!err) {
>>>>                 mmc_power_off(host);
>>>>                 mmc_card_set_suspended(host->card);
>>>>         }
>>>> +
>>>> +       if (retune_release)
>>>> +               mmc_retune_release(host);
>>>>  out:
>>>>         mmc_release_host(host);
>>>>         return err;
>>>
>>> Instead of add mmc_retune_hold|release() to _mmc_suspend(), I would
>>> like you to move that handling into mmc_sleep(). The code should be
>>> easier and it becomes more clear that it's because of a command
>>> sequence.
>>>
>>> I think mmc_retune_hold() should be invoked before mmc_wait_for_cmd()
>>> and then mmc_retune_release() just after, in mmc_sleep(). That should
>>> work, right!?
>>
>> That would be the same as holding re-tuning for that request, which is
>> what already happens i.e. adding hold()/release() around mmc_wait_for_cmd()
>> is redundant.
> 
> I don't understand your point, sorry.

mmc_wait_for_cmd() calls mmc_wait_for_req() which calls __mmc_start_req()
which calls mmc_start_request() which calls mmc_retune_hold()

Then mmc_wait_for_req() calls mmc_wait_for_req_done() which calls
mmc_retune_release().

So
	mmc_wait_for_cmd() (with no retries)
has the same effect as
	mmc_retune_hold()
	mmc_wait_for_cmd()
	mmc_retune_release()

> 
> Anyway, my proposal didn't quite work, which is due to that
> mmc_deselect_cards() (invoked from mmc_sleep()) deals with retries. If
> there had been only one try, I thought it could be okay to have that
> command to be preceded by a re-tune.
> 
> Anyway, I would like you to move the mmc_retune_hold|release() calls
> into the mmc_sleep() function.

That would have no effect as explained above.

> 
>>
>> The options for the caller are:
>>
>> 1)
>>         hold re-tuning
>>         put emmc to sleep
>>         later wake up emmc
>>         release re-tuning
>>
>> 2)
>>         put emmc to sleep
>>         later increment hold_count
>>         wake up emmc ignoring CRC errors
>>         release re-tuning
>>
>> But there is no wake-up function and the suspend path is using an unbalanced
>> mmc_sleep i.e. no corresponding wake up.
>>
>> So that leaves what is happening now i.e. a comment plus explicit
>> hold()/release() in _mmc_suspend() so that future changes to _mmc_suspend()
>> know to take mmc_sleep re-tuning requirements into account.
> 
> Why all this complexity?
> 
> mmc_power_off() is called in _mmc_suspend(), that will eventually
> disable re-tune. Thus re-tuning will be prevented for
> commands/requests during the system PM resume sequence, until the card
> has been fully re-initialized (and a tuning sequence done). Isn't that
> sufficient?

Yes my original patch did not have any of that complexity. I added it in
response to our discussions.

As you wrote, _mmc_suspend() does not need to do anything with retuning
because mmc_sleep() is followed by mmc_power_off().

The original patch added a comment to mmc_sleep() and that was all. That
would still be the best approach.

