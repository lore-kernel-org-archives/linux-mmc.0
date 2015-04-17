From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 02/15] mmc: core: Enable / disable re-tuning
Date: Fri, 17 Apr 2015 14:52:10 +0300
Message-ID: <5530F3EA.7000803@intel.com>
References: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>	<1429017146-15981-3-git-send-email-adrian.hunter@intel.com>	<CAPDyKFpsBA+B3NbopfYQRgo+KKJpWsseo3bCJx-ToR5bOzJYUg@mail.gmail.com>	<552F805B.9080003@intel.com>	<CAPDyKFr_7giwZt76z3TnoqqJbQPBUJqRj1cepFR888FiseraGg@mail.gmail.com>	<552FB81D.9060709@intel.com>	<CAPDyKFpoyDKOF5guaQfzHpkhoU8qesNY=D_c-dKfHtZHKK51MA@mail.gmail.com>	<5530B112.30004@intel.com> <CAPDyKFrvFz2KjxYLaJZ1bXvWF9bY6O82Bk1Fph2egUFoF2JkAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46578 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbbDQLyT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Apr 2015 07:54:19 -0400
In-Reply-To: <CAPDyKFrvFz2KjxYLaJZ1bXvWF9bY6O82Bk1Fph2egUFoF2JkAQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 17/04/15 11:56, Ulf Hansson wrote:
> On 17 April 2015 at 09:06, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 16/04/15 18:19, Ulf Hansson wrote:
>>> [...]
>>>
>>>>>>> 1) Card removal/detect (hold/release?)
>>>>>>
>>>>>> Re-tuning will be done if needed before detect (because it is done before a
>>>>>> request), which is necessary because detect can fail if tuning is needed.
>>>>>>
>>>>>> Re-tuning is done before a request. Requests aren't started if the card has
>>>>>> been removed i.e. mmc_start_request() calls mmc_card_removed()
>>>>>>
>>>>>> If tuning is executed while a card is being removed, then the tuning will
>>>>>> fail and the request will be errored out.
>>>>>
>>>>> So you are saying that we instead of relying on the CMD13 (for SD/MMC)
>>>>> to check whether the card is still alive, it's fine to trigger a
>>>>> re-tuning instead.
>>>>
>>>> (Oops forgot to answer this one, sorry)
>>>>
>>>> Yes, why not?
>>>>
>>>>>
>>>>> I don't think that is an effective way to remove a card.
>>>>
>>>> Generally we know the card is removed from card-detect so no commands are
>>>> sent in either case.
>>>
>>> Not sure what you mean here.
>>
>> The sdhci driver won't issue commands if card-detect shows no card. It just
>> sets the error to -ENOMEDIUM.
> 
> That's sdhci, but we have have a lot more drivers than sdhci to care about.
> 
>>
>>>
>>> In case when the card is "idle" and the host sees a GPIO CD irq, it
>>> will trigger a detect work to run mmc_rescan().
>>>
>>> In this case, it's the responsibility of mmc_rescan() to find out if
>>> the card is being removed. It does so by invoking the
>>> bus_ops->detect() callback, which eventually will send a CMD13 for
>>> mmc/sd.
>>>
>>> In this scenario, I can't see why we want to allow re-tuning to happen
>>> in front of the CMD13 command.
>>
>> If re-tuning is needed and can be done, it is done. It doesn't need to be
>> more complicated than that.
>>
>>>
>>>>
>>>>>
>>>>> Moreover, I find it quite unreasonable to say the check for an alive
>>>>> card, would fail because of that a re-tuning is needed. That would in
>>>>> principle mean that we never should be able to hold re-tune for any
>>>>> commands sequences.
>>>>
>>>> Re-tuning must work if the card is alive. CMD13 might get a CRC error if
>>>> re-tuning is needed.
>>>
>>> And that then applies to all commands which we hold re-tuning for. So
>>> then we can't _ever_  hold re-tuning for any command, since we might
>>> get CRC errors.
>>
>> Periodic re-tuning and re-tuning after pm-runtime-resume should ensure no
>> CRC errors while re-tuning is held.
>>
> 
> When re-tune is being held, there's no guarantee the re-tune timer
> will not timeout. So that means every time you decide to hold re-tune
> for a command (or sequence of commands) you will risk getting CRC
> errors.
> 
> The hole idea with the periodic re-tuning timer is to _minimize_ the
> probability of getting CRC errors, it's not to remove them completely,
> right!?

Yes I shouldn't have asserted there will be no CRC errors. As you say, there
could be. Currently there is no attempt to recover from such errors and
AFAIK there is also no indication that that has been a problem yet. In my
patches I have added recovery for mmc block data transfers. So that is at
least a step forward.

> 
> So from that reasoning, I don't see why the mmc core shouldn't be
> holding/disabling re-tuning under those circumstances when it make
> sense. As for those I suggested.

To reduce the chance of CRC errors when re-tuning is held, we should hold
re-tuning only when absolutely necessary. Wouldn't that mean not in the
extra places you suggested?

