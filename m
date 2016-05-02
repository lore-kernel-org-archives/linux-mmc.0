From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC 3/3] mmc: block: Fix tuning (by avoiding it) for RPMB
Date: Mon, 2 May 2016 12:31:52 +0300
Message-ID: <57271E88.5000805@intel.com>
References: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
 <1461245314-6282-4-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFqpvZr3c8Skmc=pnE0m9EQFt=C98P-Vo5TKjONDHtxBaA@mail.gmail.com>
 <5721EDDD.6060902@intel.com>
 <CAPDyKFpm4qAqCiY6+RGNg53gTjVS4Kq13YbNLEeUUZNjw3GFpQ@mail.gmail.com>
 <572209CB.6080606@intel.com>
 <CAPDyKFrw1N+vScGiScp3_uxHiA6XD2gDSY3cdRuWV59wtDHXOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43420 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbcEBJfn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 May 2016 05:35:43 -0400
In-Reply-To: <CAPDyKFrw1N+vScGiScp3_uxHiA6XD2gDSY3cdRuWV59wtDHXOQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

On 02/05/16 11:24, Ulf Hansson wrote:
> On 28 April 2016 at 15:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 28/04/16 14:46, Ulf Hansson wrote:
>>> On 28 April 2016 at 13:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 28/04/16 13:34, Ulf Hansson wrote:
>>>>> On 21 April 2016 at 15:28, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>> The RPMB partition only allows certain commands.  In particular,
>>>>>> the tuning command (CMD21) is not allowed -  refer JEDEC eMMC
>>>>>> standard v5.1 section 6.2.2 Command restrictions.
>>>>>>
>>>>>> To avoid tuning for RPMB, switch to High Speed mode from HS200
>>>>>> or HS400 mode if re-tuning has been enabled.  And switch back
>>>>>> when leaving RPMB.
>>>>>
>>>>> I would rather just disable re-tuning during this period, instead of
>>>>> changing the speed mode.
>>>>> The primary reason to why, is because the latency it would introduce
>>>>> to first switch to HS speed then back to HS200/400.
>>>>
>>>> I wouldn't expect RPMB accesses to be frequent enough for the latency to matter.
>>>>
>>>>>
>>>>> My concern is not the throughput as I expect read/writes request to an
>>>>> RPMB partition is rather small.
>>>>>
>>>>> Of course I realize that we need to take care when disable re-tuning.
>>>>> Perhaps we can solve that by a re-try mechanism if the RPMB request
>>>>> fails, and thus perform the re-tuning as part of the re-try?
>>>>
>>>> The interdependent nature of RPMB commands suggests that re-trying is not
>>>> possible.  It seems to me that you would have to make up a new set of
>>>> commands and start again. i.e. return an error to the user so that they can
>>>> start again.
>>>
>>> Ok.
>>>
>>> So perhaps returning -EAGAIN could work!?
>>
>> I don't think existing code would expect that.  Doesn't seem like level of
>> service I would expect from the kernel.
>>
>> And the concern is, that being an error path, it gets overlooked.
> 
> I guess you are right.
> 
>>
>>>
>>>>
>>>> Another dependency is that we always need to re-tune after host runtime
>>>> suspend, which is why we always hit this problem when RPMB is accessed.  So
>>>
>>> Just to make sure I understand correctly; I would imagine you hit the
>>> problem *only* when the RPMB partition was already selected, right?
>>
>> Yes
>>
>>>
>>> Because that would then skip the switch command, and you will
>>> therefore try to re-tune after the partition has already been switched
>>> to?
>>
>> Yes
>>
>>>
>>>> to avoid errors you would either need to disable runtime PM when the RPMB
>>>> partition is selected (which might be a long time if we don't get an access
>>>> to another partition), or always switch back to the main partition (not sure
>>>> if that would mess up the RPMB command sequence though).
>>>
>>> I wouldn't mind that we switch back to the main partition when we have
>>> served an RPMB IOCTL request. Of course not in between every mmc
>>> request, in case of using the MULTI IOCTL.
>>>
>>> That would prevent the next regular mmc request on the main partition
>>> to not have to switch partition and thus get decreased latency.
>>
>> Doesn't stop us getting CRC errors because the eMMC needs tuning while in
>> the RPMB partition though.
> 
> That's true. My idea was that we should return -EAGAIN as error code
> to user space for these scenarios, but I guess it's not a good idea.
> 
> I have given your suggested approach some more thinking. Besides the
> latency impact, don't you think it's rather risky to switch speed
> modes back an forth?
> We don't know whether cards+controllers are really able to cope with
> that, even if they should?

Yes there is some risk, although that is what we already have to do for
re-tuning in the HS400 case.  Also I would expect it to fail straight away
if it was going to i.e. people testing their systems would know.  Given that
we don't have a solution at all at the moment, that seemed acceptable.

> 
> Perhaps we could instead force a re-tune to be done before switching
> to the RPMB partition and thus also before each RPMB request? That
> decreases/removes the probability of getting a CRC errors because of a
> needed re-tune, right?

Yes re-tuning beforehand should work.  I would suggest switching straight
back afterwards as well to avoid the possibility of going out of tune while
still switched to RPMB.

I am happy to implement that, if you agree.

