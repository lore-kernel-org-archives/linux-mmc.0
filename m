From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 08/15] mmc: mmc: Hold re-tuning if the card is put
 to sleep
Date: Wed, 06 May 2015 15:42:02 +0300
Message-ID: <554A0C1A.60000@intel.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>	<1429531796-21987-9-git-send-email-adrian.hunter@intel.com>	<CAPDyKFp0c5Gc9HpS+F_DV2-pxuKnWjqQ7UrGTFd5FcSSG9JT7Q@mail.gmail.com>	<5549D336.4040206@intel.com>	<CAPDyKFp4A4UzEUN8pDHpjNn0PX3HcmCA6khHCdRH5R0GsO1Lrw@mail.gmail.com>	<5549ECBD.3010608@intel.com> <CAPDyKFpUNaMHKuw06VmAQPbWt3hh5GZJYJ_ZEdB4TePZ31N+RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48492 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbbEFMoP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 May 2015 08:44:15 -0400
In-Reply-To: <CAPDyKFpUNaMHKuw06VmAQPbWt3hh5GZJYJ_ZEdB4TePZ31N+RA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 06/05/15 14:36, Ulf Hansson wrote:
> [...]
> 
>>>>> Instead of add mmc_retune_hold|release() to _mmc_suspend(), I would
>>>>> like you to move that handling into mmc_sleep(). The code should be
>>>>> easier and it becomes more clear that it's because of a command
>>>>> sequence.
>>>>>
>>>>> I think mmc_retune_hold() should be invoked before mmc_wait_for_cmd()
>>>>> and then mmc_retune_release() just after, in mmc_sleep(). That should
>>>>> work, right!?
>>>>
>>>> That would be the same as holding re-tuning for that request, which is
>>>> what already happens i.e. adding hold()/release() around mmc_wait_for_cmd()
>>>> is redundant.
>>>
>>> I don't understand your point, sorry.
>>
>> mmc_wait_for_cmd() calls mmc_wait_for_req() which calls __mmc_start_req()
>> which calls mmc_start_request() which calls mmc_retune_hold()
>>
>> Then mmc_wait_for_req() calls mmc_wait_for_req_done() which calls
>> mmc_retune_release().
>>
>> So
>>         mmc_wait_for_cmd() (with no retries)
>> has the same effect as
>>         mmc_retune_hold()
>>         mmc_wait_for_cmd()
>>         mmc_retune_release()
>>
> 
> Huh, you are right - again.
> 
> There have been a couple of iterations of this patchset, I don't
> recall why we need to hold retune for all requests? It seems awkward.
> Shouldn't we just hold retune for those requests that needs it?

For data requests (which also call __mmc_start_req()) there is the
possibility that a 'write' is not finished and is polled with CMD13.
So re-tuning is held to avoid conflicting with the busy state.
It also aids controlling when re-tuning happens in the recovery path
i.e. we have a go at getting the status first and if that doesn't
work first time, then re-tune if needed.

Also mmc_retune_hold() does not only hold retuning, it also causes
re-tuning to happen if the hold_count was zero, so it does
"make-retuning-happen-if-needed-and-not-already-held-and-then-hold-retuning"

> 
>>>
>>> Anyway, my proposal didn't quite work, which is due to that
>>> mmc_deselect_cards() (invoked from mmc_sleep()) deals with retries. If
>>> there had been only one try, I thought it could be okay to have that
>>> command to be preceded by a re-tune.
>>>
>>> Anyway, I would like you to move the mmc_retune_hold|release() calls
>>> into the mmc_sleep() function.
>>
>> That would have no effect as explained above.
> 
> Then why did you add it to the _mmc_suspend() function? What am I missing here?

It was added in response to our discussions. It was not in my original
patches. I can take it out.

> 
>>
>>>
>>>>
>>>> The options for the caller are:
>>>>
>>>> 1)
>>>>         hold re-tuning
>>>>         put emmc to sleep
>>>>         later wake up emmc
>>>>         release re-tuning
>>>>
>>>> 2)
>>>>         put emmc to sleep
>>>>         later increment hold_count
>>>>         wake up emmc ignoring CRC errors
>>>>         release re-tuning
>>>>
>>>> But there is no wake-up function and the suspend path is using an unbalanced
>>>> mmc_sleep i.e. no corresponding wake up.
>>>>
>>>> So that leaves what is happening now i.e. a comment plus explicit
>>>> hold()/release() in _mmc_suspend() so that future changes to _mmc_suspend()
>>>> know to take mmc_sleep re-tuning requirements into account.
>>>
>>> Why all this complexity?
>>>
>>> mmc_power_off() is called in _mmc_suspend(), that will eventually
>>> disable re-tune. Thus re-tuning will be prevented for
>>> commands/requests during the system PM resume sequence, until the card
>>> has been fully re-initialized (and a tuning sequence done). Isn't that
>>> sufficient?
>>
>> Yes my original patch did not have any of that complexity. I added it in
>> response to our discussions.
>>
>> As you wrote, _mmc_suspend() does not need to do anything with retuning
>> because mmc_sleep() is followed by mmc_power_off().
>>
>> The original patch added a comment to mmc_sleep() and that was all. That
>> would still be the best approach.
>>
> 
> What I had in mind was that the re-tune timer could time out in the
> middle of the _mmc_suspend() sequence.
> 
> If that happens in-between mmc_deselect_cards() and when the CMD5 is
> to be sent, in mmc_sleep() - we must not allow a re-tune sequence.
> Unless holding re-tune here, how is that prevented?

Oh yes, I have overlooked that re-tuning can't be done on a de-selected
card. So I will add mmc_retune_hold()/mmc_retune_release(). I will have to
think about the error handling. It looks broken now anyway since it doesn't
reselect the card in the error path.

