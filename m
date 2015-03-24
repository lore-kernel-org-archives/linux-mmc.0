From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 11/15] mmc: sdhci: Change to new way of doing re-tuning
Date: Tue, 24 Mar 2015 22:12:40 +0100
Message-ID: <CAPDyKFqnqxiFrrg3S9=w_xqJha1=+fre5w4puEGw7Z=LJZ-T3w@mail.gmail.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
	<1422522030-17793-12-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFpTuttvhP91qNF_g_2sWV3NZmYMCnqFVGYEnb1L8kXVeg@mail.gmail.com>
	<54FD5BDD.9060004@intel.com>
	<CAPDyKFr9bpE3FXu0339q4ndOm_KSNpATBODecTWkkrLifvSing@mail.gmail.com>
	<54FEFDB0.5050104@intel.com>
	<CAPDyKFpvCz9kTaX=632hWGsWfLKC2aFJomFc1xECnNvQpNVU2A@mail.gmail.com>
	<5510227F.70605@intel.com>
	<CAPDyKFqJ3ahAPXec6LRmMtzucS3N=b5wOYGQcd0ELHZByeudJA@mail.gmail.com>
	<5510817D.2080807@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35465 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbbCXVMl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2015 17:12:41 -0400
Received: by qgh3 with SMTP id 3so722270qgh.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2015 14:12:40 -0700 (PDT)
In-Reply-To: <5510817D.2080807@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Neil Brown <neilb@suse.de>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 23 March 2015 at 22:11, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 23/03/2015 5:02 p.m., Ulf Hansson wrote:
>>
>> [...]
>>
>>>
>>> I have no locking issues, so I am not sure what you mean here.
>>
>>
>> Okay, I should have stated race conditions.
>
>
> Which I resolved using runtime get / put calls.

Yes, I noticed that and it works! Though, I would rather avoid to add
yet another pair of host ops callbacks for this.

What do you think if these options instead?
1) Do runtime PM get/put from the host ops ->enable|disable()
callbacks. As omap_hsmmc does.
2) Or even better, do runtime PM get/put directly of the host device
from mmc_claim|release_host().

>
> Returning -EBUSY from runtime suspend, on the other hand, seems
> less than ideal.

Agree, if we can avoid it, we certainly should!

>
> First, reading the hold count from runtime suspend is a new race.

I am not sure I understand, could you please elaborate why?

>
> Secondly, returning -EBUSY leaves the host controller active until the
> host controller driver is accessed again, which breaks runtime pm.

Returning -EBUSY is "allowed" for any runtime PM suspend callback and
it's supported by the runtime PM core. We won't be breaking anything.

Anyway, I suggest we put this idea on hold and try other options.

>
>>
>>>
>>>>
>>>>>
>>>>>> I think we need an generic approach to deal with the runtime PM
>>>>>> synchronization issue described above. More precisely in those
>>>>>> scenarios when mmc hosts needs to notify the mmc core to take some
>>>>>> specific actions, from a mmc host's runtime PM callback.
>>>>>
>>>>>
>>>>> For the re-tune case I did not want to assume what the host driver
>>>>> needed to do, so I added ->hold_tuning() and ->release_tuning()
>>>>> host operations.
>>>>
>>>>
>>>> I have thought a bit more on how I would like this to be implemented.
>>>> It's a bit closer to what Neil's suggests in his approach [1].
>>>
>>>
>>> I am not sure it is valuable to mix up the two issues.
>>>
>>> For Neil's problem I would do something quiet different:
>>>
>>> 1. The host driver already knows the bus width so can easily "get/put"
>>> runtime pm to prevent suspend when the bus width does not permit it.
>>
>>
>> To me the problem is the other way around.
>>
>> The host driver don't want prevent runtime PM suspend. Instead it want
>> to notify the core that it's ready to be runtime PM suspended.
>>
>> Due to restrictions by the SDIO spec, the mmc core first need to
>> switch to 1-bit data, before the host can do clock gating in runtime
>> PM suspend.
>
>
> That makes two things dependent instead of decoupling them.

Good point!

I don't like it either, let's try do better!

>
>>
>>>
>>> 2. The need to do things when the card is idle comes up a lot (e.g.
>>> bkops,
>>> sleep notification, cache flush etc etc). In Neil's case he wants to
>>> switch
>>> to 1-bit mode, but that just seems another of these "idle" operations. So
>>> I
>>> would investigate the requirements of supporting idle operations in
>>> general.
>>
>>
>> That won't work for the SDIO case, since runtime PM is being deployed
>> differently for SDIO than for MMC/SD.
>>
>> In the SDIO case it's the SDIO func drivers that handles the get/put.
>> For the MMC/SD case it's handled by the block device layer.
>
>
> It doesn't need to have anything to do with runtime pm. It just needs
> to be a way the block or SDIO function drivers can inform the core
> that other stuff can be done.

I have thought more about this since yesterday and I somewhat agree
with your suggestion. Especially in that sense that I think we should
consider Neil's issue as an "idle operation" for SDIO.

For "idle operations" for MMC/SD cards, runtime PM is already
deployed. So, I think it's just a matter of extending that support to
cover more "idle operations" besides the MMC_CAP_AGGRESSIVE_PM thing.

What we need to figure out is how to make this work for SDIO - and
that's when it becomes more complex. I really would like us to avoid
exporting new SDIO APIs, unless really needed.

Today runtime PM is deployed by the following SDIO func drivers:
drivers/net/wireless/libertas/if_sdio.c
drivers/net/wireless/ti/wl1251/sdio.c
drivers/net/wireless/ti/wlcore/sdio.c

We _could_ consider to convert above drivers to use something else
than runtime PM to control the power to the card. I think that would
be the ideal solution, since then we can deploy runtime PM for SDIO
fairly similar to how MMC/SDIO is done. That means doing runtime PM
get/put of the device for the struct mmc_card, inside the mmc core
while handling SDIO requests.

The above requires some work, both in the mmc core and in the SDIO
func drivers. The nice thing is that we don't need to export new APIs
to the SDIO func drivers and we can keep the complexity of dealing
with "idle operations" inside the mmc core.

Thoughts?

Kind regards
Uffe
