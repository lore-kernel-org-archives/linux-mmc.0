From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: core: Force a "detect" to handle non-properly removed
 cards
Date: Fri, 13 Jan 2012 12:31:42 +0100
Message-ID: <4F10161E.2080107@stericsson.com>
References: <1325586798-16276-1-git-send-email-ulf.hansson@stericsson.com> <4F04C412.1030604@intel.com> <4F0AC942.4060404@stericsson.com> <4F0AD879.10801@intel.com> <4F0AE82C.10000@stericsson.com> <4F0AF157.7090101@intel.com> <4F0AF96B.4050500@stericsson.com> <4F0C035D.7070705@intel.com> <4F0C1A1C.8070007@stericsson.com> <4F0C2ACD.4090002@intel.com> <4F100196.8010104@stericsson.com> <4F100AE5.3040304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:40722 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757859Ab2AMLc0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 06:32:26 -0500
In-Reply-To: <4F100AE5.3040304@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Adrian Hunter wrote:
> On 13/01/12 12:04, Ulf Hansson wrote:
>> Adrian Hunter wrote:
>>> On 10/01/12 12:59, Ulf Hansson wrote:
>>>> Adrian Hunter wrote:
>>>>> On 09/01/12 16:27, Ulf Hansson wrote:
>>>>>> Adrian Hunter wrote:
>>>>>>> On 09/01/12 15:14, Ulf Hansson wrote:
>>>>>>>>>> My concern is more about what we actually can trust; either the
>>>>>>>>>> GPIO irq
>>>>>>>>>> which likely is giving more than one irq when inserting/removing a
>>>>>>>>>> card
>>>>>>>>>> since the slot is probably not glitch free, or that a "rescan" runs to
>>>>>>>>>> make
>>>>>>>>>> sure a CMD13 is accepted from the previously inserted card.
>>>>>>>>> Yes, I guess you would need to debounce the GPIO if you wanted to rely
>>>>>>>>> on it.
>>>>>>>>>
>>>>>>>>>> Moreover, the issue this patch tries to solve can not be solved
>>>>>>>>>> without
>>>>>>>>>> doing a "rescan" which must be triggered from the the block layer some
>>>>>>>>>> how.
>>>>>>>>>> I thought this new function that you previously added
>>>>>>>>>> "mmc_detect_card_remove" was the proper place to do this.
>>>>>>>>>>
>>>>>>>>>>>> Let the mmc_detect_card_removed function trigger a new detect
>>>>>>>>>>>> work immediately when it discovers that a card has been removed.
>>>>>>>>>>> This is changing some long-standing functionality i.e. the card is
>>>>>>>>>>> not
>>>>>>>>>>> removed
>>>>>>>>>>> without a card detect event.  It is difficult to know whether that
>>>>>>>>>>> will be
>>>>>>>>>>> very
>>>>>>>>>>> bad for poor quality cards,
>>>>>>>>>> Doing a mmc_detect (rescan) will in the end just issue a CMD13 to the
>>>>>>>>>> card
>>>>>>>>>> to make sure it is still present, that is already done from the block
>>>>>>>>>> layer
>>>>>>>>>> after each read/write request. So I can not see that "poor quality
>>>>>>>>>> cards"
>>>>>>>>>> will have any further problem with this patch, but I might miss
>>>>>>>>>> something!?
>>>>>>>>> The block driver has never caused a card to be removed before.  That
>>>>>>>>> is new
>>>>>>>>> and it is designed to preserve existing behaviour i.e. do not remove a
>>>>>>>>> card
>>>>>>>>> without a card detect event.
>>>>>>>> True, but is this a problem!?
>>>>>>> Better not to find out.
>>>>>> :-)
>>>>>>
>>>>>> Then there is lot of other things around mmc we also should not change.
>>>>> Can you give an example of a change in existing functionality?  Isn't
>>>>> everything either a bug fix or new functionality?
>>>>>
>>>>>>>> Anyway, this is the actual issue this patch is trying to solve. If you
>>>>>>>> remove a card "slowly", a "rescan" work, which the GPIO irq has
>>>>>>>> triggered to
>>>>>>>> run will run the CMD13 to verify that the card is still there. Since it
>>>>>>>> has
>>>>>>>> not completely been removed the CMD13 will succeed and the card will
>>>>>>>> not be
>>>>>>>> removed.
>>>>>>>>
>>>>>>>> Moreover every other new block request will soon start to fail and
>>>>>>>> always
>>>>>>>> do; until a new rescan is triggered (which is when you insert a new
>>>>>>>> card or
>>>>>>>> do a suspend-resume cycle). In practice I think it is more preferred
>>>>>>>> that
>>>>>>>> the card gets removed and it's corresponding block device.
>>>>>>> There are other ways to solve that problem.  Apart from my previous
>>>>>>> suggestion, there is also the possibility to make use of ->get_cd
>>>>>>> instead of CMD13, someone already posted a patch for that
>>>>>>> "[PATCH 2/4 v4] MMC/SD: Add callback function to detect card"
>>>>>>> but it should probably be selected on a per driver basis (i.e. add a
>>>>>>> MMC_CAP2 for it).  I guess you would still need to debounce the GPIO
>>>>>>> though.
>>>>>>>
>>>>>> Unfortunately that wont help to solve this issue either. That patch will
>>>>>> only prevent you from executing a CMD13 if the get_cd function says the
>>>>>> card
>>>>>> is still there. I kind of micro optimization I think, unless you very
>>>>>> often
>>>>>> encounters errors in the block layer.
>>>>> No, the rescan calls that code, so if get_cd() returns 0 the card will be
>>>>> removed irrespective of whether it has been pulled out slowly or not.
>>>> That is not correct. The rescan uses the get_cd function to find out if
>>>> it really make sense to try to initialize a new card. It is not used for
>>>> removing existing cards.
>>> mmc_rescan() first calls host->bus_ops->detect() to see if the card is still
>>> there.  If the card does not respond then it is removed.  Then mmc_rescan
>>> attempts to initialize a new card. host->bus_ops->detect() is not used for
>>> that.
>>>
>>>> You were referring to "[PATCH 2/4 v4] MMC/SD: Add callback function to
>>>> detect card". This patch will prevent the bus_ops->alive function to be
>>>> called if the get_cd function indicates that the card is still there. I
>>>> can not see how this on it's own will help out to solve the issue my
>>>> patch is trying to solve.
>>> Yes it will because it is called by mmc_rescan() and used to remove the card
>>> via host->bus_ops->detect()
>>>
>> In principles this means the following sequence:
>>
>> We will rely on that the get_cd function will return 0 (indicating card is
>> removed) when the card is "slowly" removed at the point when the rescan
>> function is calling it through the bus_ops->detect -->
>> _mmc_detect_card_removed function.
>>
>> This then becomes a race, meaning that the rescan function must be executing
>> at the same time the get_cd function will returns 0. Otherwise the rescan
>> function will not remove the card.
>>
>> Thus my conclusion is that "[PATCH 2/4 v4] MMC/SD: Add callback function to
>> detect card" will likely improve behavior but is not the safe solution to
>> handle "slowly" removed cards.
>>
>> Again, to be sure, we must let the mmc_detect_card_remove function trigger a
>> rescan when _mmc_detect_card_removed has detected that the card is removed.
>> This should be safe in all circumstances.
> 
> sdhci has no problem because it does this:
> 
> 	- the host controller debounces the card detect line
> 	- the host controller records whether or not the card is present
> 	- the sdhci driver prevents (errors out) requests when the card is
> 	not present

Debouncing will just be a way of triggering the problem more seldom. Or 
in worst case, state the card has been removed even if it has not.

Just because you get a GPIO irq on the detect line does not mean the 
card is removed, debouncing or not. I consider this as pure mechanical 
switch which likely has glitches and I don't see that we should trust it 
fully. We only want to trigger a detect work, which is exactly what is 
done in the patch from Guennadi Liakhovetski "mmc: add a generic GPIO 
card-detect helper".

If each host driver that supports GPIO card detect makes use of the 
card-detect helper and if we accept a version of this patch, I think the 
situation should be safe in all cases. Moreover GPIO debouncing will 
never be needed for GPIO card detect for your sdhci driver either.

> 
> So it should work if you:
> 
> 	- debounce the gpio line
> 	- record whether or not the card is present based on the debounced
> 	gpio line
> 	- either error out requests when the card is not present
> 	or
> 	- use the get_cd patch (still ought to be driver selected)
> 	and implement get_cd based on whether you have recorded the card
> 	present or not
> 
> 
