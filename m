From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 11/15] mmc: sdhci: Change to new way of doing re-tuning
Date: Wed, 25 Mar 2015 15:48:42 +0200
Message-ID: <5512BCBA.3010905@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>	<1422522030-17793-12-git-send-email-adrian.hunter@intel.com>	<CAPDyKFpTuttvhP91qNF_g_2sWV3NZmYMCnqFVGYEnb1L8kXVeg@mail.gmail.com>	<54FD5BDD.9060004@intel.com>	<CAPDyKFr9bpE3FXu0339q4ndOm_KSNpATBODecTWkkrLifvSing@mail.gmail.com>	<54FEFDB0.5050104@intel.com>	<CAPDyKFpvCz9kTaX=632hWGsWfLKC2aFJomFc1xECnNvQpNVU2A@mail.gmail.com>	<5510227F.70605@intel.com>	<CAPDyKFqJ3ahAPXec6LRmMtzucS3N=b5wOYGQcd0ELHZByeudJA@mail.gmail.com>	<5510817D.2080807@intel.com> <CAPDyKFqnqxiFrrg3S9=w_xqJha1=+fre5w4puEGw7Z=LJZ-T3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37248 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbbCYNup (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Mar 2015 09:50:45 -0400
In-Reply-To: <CAPDyKFqnqxiFrrg3S9=w_xqJha1=+fre5w4puEGw7Z=LJZ-T3w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Neil Brown <neilb@suse.de>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 24/03/15 23:12, Ulf Hansson wrote:
> On 23 March 2015 at 22:11, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 23/03/2015 5:02 p.m., Ulf Hansson wrote:
>>>
>>> [...]
>>>
>>>>
>>>> I have no locking issues, so I am not sure what you mean here.
>>>
>>>
>>> Okay, I should have stated race conditions.
>>
>>
>> Which I resolved using runtime get / put calls.
> 
> Yes, I noticed that and it works! Though, I would rather avoid to add
> yet another pair of host ops callbacks for this.
> 
> What do you think if these options instead?
> 1) Do runtime PM get/put from the host ops ->enable|disable()
> callbacks. As omap_hsmmc does.
> 2) Or even better, do runtime PM get/put directly of the host device
> from mmc_claim|release_host().

Claiming the host is not directly related to host controller runtime pm. It
is possible to imagine cases for claiming the host for synchronization
reasons that do not need the host controller powered up. And card drivers
could reasonably assume that they can claim the host for long periods
without affecting the runtime pm of the host controller.

Currently we have that the host controller driver is the exclusive owner of
runtime pm for the host controller. So the first thing is to decide if we
want to keep that or let the core be involved as well. I would argue for
sticking with the status quo. Let the host controller driver know what is
going on and leave it to do the right thing with its own power management.

That means the callbacks, which are

> 
>>
>> Returning -EBUSY from runtime suspend, on the other hand, seems
>> less than ideal.
> 
> Agree, if we can avoid it, we certainly should!
> 
>>
>> First, reading the hold count from runtime suspend is a new race.
> 
> I am not sure I understand, could you please elaborate why?

Just in the sense that there is no synchronization between the suspend
callback and updating the hold count. So the upper layers could finish a
request and become idle but the suspend callback might have seen the hold
count before it was reduced to zero, leaving the host controller active when
it should be runtime suspended.

> 
>>
>> Secondly, returning -EBUSY leaves the host controller active until the
>> host controller driver is accessed again, which breaks runtime pm.
> 
> Returning -EBUSY is "allowed" for any runtime PM suspend callback and
> it's supported by the runtime PM core. We won't be breaking anything.

Yes, I agree it is not a violation of the API.

I just meant that if the host controller remains active when it should be
runtime suspended then power management is, in a sense, "broken".

> 
> Anyway, I suggest we put this idea on hold and try other options.
> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> I think we need an generic approach to deal with the runtime PM
>>>>>>> synchronization issue described above. More precisely in those
>>>>>>> scenarios when mmc hosts needs to notify the mmc core to take some
>>>>>>> specific actions, from a mmc host's runtime PM callback.
>>>>>>
>>>>>>
>>>>>> For the re-tune case I did not want to assume what the host driver
>>>>>> needed to do, so I added ->hold_tuning() and ->release_tuning()
>>>>>> host operations.
>>>>>
>>>>>
>>>>> I have thought a bit more on how I would like this to be implemented.
>>>>> It's a bit closer to what Neil's suggests in his approach [1].
>>>>
>>>>
>>>> I am not sure it is valuable to mix up the two issues.
>>>>
>>>> For Neil's problem I would do something quiet different:
>>>>
>>>> 1. The host driver already knows the bus width so can easily "get/put"
>>>> runtime pm to prevent suspend when the bus width does not permit it.
>>>
>>>
>>> To me the problem is the other way around.
>>>
>>> The host driver don't want prevent runtime PM suspend. Instead it want
>>> to notify the core that it's ready to be runtime PM suspended.
>>>
>>> Due to restrictions by the SDIO spec, the mmc core first need to
>>> switch to 1-bit data, before the host can do clock gating in runtime
>>> PM suspend.
>>
>>
>> That makes two things dependent instead of decoupling them.
> 
> Good point!
> 
> I don't like it either, let's try do better!
> 
>>
>>>
>>>>
>>>> 2. The need to do things when the card is idle comes up a lot (e.g.
>>>> bkops,
>>>> sleep notification, cache flush etc etc). In Neil's case he wants to
>>>> switch
>>>> to 1-bit mode, but that just seems another of these "idle" operations. So
>>>> I
>>>> would investigate the requirements of supporting idle operations in
>>>> general.
>>>
>>>
>>> That won't work for the SDIO case, since runtime PM is being deployed
>>> differently for SDIO than for MMC/SD.
>>>
>>> In the SDIO case it's the SDIO func drivers that handles the get/put.
>>> For the MMC/SD case it's handled by the block device layer.
>>
>>
>> It doesn't need to have anything to do with runtime pm. It just needs
>> to be a way the block or SDIO function drivers can inform the core
>> that other stuff can be done.
> 
> I have thought more about this since yesterday and I somewhat agree
> with your suggestion. Especially in that sense that I think we should
> consider Neil's issue as an "idle operation" for SDIO.
> 
> For "idle operations" for MMC/SD cards, runtime PM is already
> deployed. So, I think it's just a matter of extending that support to
> cover more "idle operations" besides the MMC_CAP_AGGRESSIVE_PM thing.
> 
> What we need to figure out is how to make this work for SDIO - and
> that's when it becomes more complex. I really would like us to avoid
> exporting new SDIO APIs, unless really needed.
> 
> Today runtime PM is deployed by the following SDIO func drivers:
> drivers/net/wireless/libertas/if_sdio.c
> drivers/net/wireless/ti/wl1251/sdio.c
> drivers/net/wireless/ti/wlcore/sdio.c
> 
> We _could_ consider to convert above drivers to use something else
> than runtime PM to control the power to the card. I think that would
> be the ideal solution, since then we can deploy runtime PM for SDIO
> fairly similar to how MMC/SDIO is done. That means doing runtime PM
> get/put of the device for the struct mmc_card, inside the mmc core
> while handling SDIO requests.
> 
> The above requires some work, both in the mmc core and in the SDIO
> func drivers. The nice thing is that we don't need to export new APIs
> to the SDIO func drivers and we can keep the complexity of dealing
> with "idle operations" inside the mmc core.
> 
> Thoughts?

There isn't necessarily any link between "idle operations" and runtime pm.

For example for eMMC background operations I would expect to see:

- queue is empty so block driver enables "idle operations".
- core waits (delayed work?) a few milliseconds and then starts bkops.
- a new I/O request arrives, block driver wakes up and tells the core to
stop "idle operations" ASAP, and waits until it does.
- or, the core notifies (callback perhaps) the block driver that "idle
operations" are finished, so the block driver can runtime-put the card

Also need to stop "idle operations" for system suspend, maybe other places.

Now in Neil's case there is a relation to runtime pm in that it would be
nice if the switch to 1-bit mode was delayed by the host controllers
autosuspend_delay. But potentially the host controller driver could
routinely set the delay so that it matches the autosuspend_delay anyway.

Currently the SDIO function drivers all use sdio_claim_host(). So for Neil's
case I would see:

- host controller driver sees the switch to 4-bit mode and does a runtime
"get" to prevent runtime suspend
- sdio_release_host enables "idle operations"
- the core sees that someone has requested a switch to 1-bit mode after a
certain delay, so it waits that delay (delayed work?) and does the switch
- host controller driver sees the switch to 1-bit mode and runtime suspends
via a pm_runtime_put
- sdio_claim_host tells the core to stop "idle operations" ASAP and waits
until it has
- host controller driver sees the switch to 4-bit mode and does a runtime
"get" to prevent runtime suspend

