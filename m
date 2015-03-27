From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 11/15] mmc: sdhci: Change to new way of doing re-tuning
Date: Fri, 27 Mar 2015 11:54:37 +0200
Message-ID: <551528DD.4000101@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>	<1422522030-17793-12-git-send-email-adrian.hunter@intel.com>	<CAPDyKFpTuttvhP91qNF_g_2sWV3NZmYMCnqFVGYEnb1L8kXVeg@mail.gmail.com>	<54FD5BDD.9060004@intel.com>	<CAPDyKFr9bpE3FXu0339q4ndOm_KSNpATBODecTWkkrLifvSing@mail.gmail.com>	<54FEFDB0.5050104@intel.com>	<CAPDyKFpvCz9kTaX=632hWGsWfLKC2aFJomFc1xECnNvQpNVU2A@mail.gmail.com>	<5510227F.70605@intel.com>	<CAPDyKFqJ3ahAPXec6LRmMtzucS3N=b5wOYGQcd0ELHZByeudJA@mail.gmail.com>	<5510817D.2080807@intel.com>	<CAPDyKFqnqxiFrrg3S9=w_xqJha1=+fre5w4puEGw7Z=LJZ-T3w@mail.gmail.com>	<5512BCBA.3010905@intel.com> <CAPDyKFpzz6xUZM0p55eEE-EDNLDbxk9THTn0J5aOdw+Q+sZLBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16357 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622AbbC0J4r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Mar 2015 05:56:47 -0400
In-Reply-To: <CAPDyKFpzz6xUZM0p55eEE-EDNLDbxk9THTn0J5aOdw+Q+sZLBg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Neil Brown <neilb@suse.de>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 26/03/15 18:06, Ulf Hansson wrote:
> On 25 March 2015 at 14:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 24/03/15 23:12, Ulf Hansson wrote:
>>> On 23 March 2015 at 22:11, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 23/03/2015 5:02 p.m., Ulf Hansson wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>
>>>>>> I have no locking issues, so I am not sure what you mean here.
>>>>>
>>>>>
>>>>> Okay, I should have stated race conditions.
>>>>
>>>>
>>>> Which I resolved using runtime get / put calls.
>>>
>>> Yes, I noticed that and it works! Though, I would rather avoid to add
>>> yet another pair of host ops callbacks for this.
>>>
>>> What do you think if these options instead?
>>> 1) Do runtime PM get/put from the host ops ->enable|disable()
>>> callbacks. As omap_hsmmc does.
>>> 2) Or even better, do runtime PM get/put directly of the host device
>>> from mmc_claim|release_host().
>>
>> Claiming the host is not directly related to host controller runtime pm. It
>> is possible to imagine cases for claiming the host for synchronization
>> reasons that do not need the host controller powered up. And card drivers
>> could reasonably assume that they can claim the host for long periods
>> without affecting the runtime pm of the host controller.
> 
> 
> Yes, it _may_ power up the host controller sometimes when not needed.
> I don't think this will be an issue, mostly because it should be rare
> and not happening frequently - if ever.
> 
> The only users of mmc_claim_host() for SD/MMC is the core itself, so I
> don't see any issue with misbehaving "card drivers" here.
> 
> SDIO is again different, since it's up to the SDIO func drivers to
> behave - as you stated. But, if they don't they anyway need to be
> fixed, right!?

Be aware that that links the holding of re-tuning with claiming the host.
It will then not be allowed for re-tuning to be held when the host is
released. Will we have to add to mmc_release_host():

	WARN_ON(host->hold_count);

That could be a problem. Say you wanted to start bkops and then release the
host so that a different context could issue an HPI. That wouldn't be
allowed anymore.

Generally it is impossible to see all ends, which begs the question: why
link things if you don't have to?

> 
>>
>> Currently we have that the host controller driver is the exclusive owner of
>> runtime pm for the host controller. So the first thing is to decide if we
>> want to keep that or let the core be involved as well. I would argue for
>> sticking with the status quo. Let the host controller driver know what is
>> going on and leave it to do the right thing with its own power management.
> 
> The problem I see with the current solution, is that we will be
> scheduling a runtime PM suspend for each an every request towards the
> host.
> 
> It's ineffective, due to that we will unnecessary involve the runtime
> PM core, thus increasing CPU utilization - when we actually don't need
> to.
> 
> I will send a patch for this tomorrow, let's discuss it separately.

Yes please let's keep that separate.

> 
> [...]
> 
>>>
>>> I have thought more about this since yesterday and I somewhat agree
>>> with your suggestion. Especially in that sense that I think we should
>>> consider Neil's issue as an "idle operation" for SDIO.
>>>
>>> For "idle operations" for MMC/SD cards, runtime PM is already
>>> deployed. So, I think it's just a matter of extending that support to
>>> cover more "idle operations" besides the MMC_CAP_AGGRESSIVE_PM thing.
>>>
>>> What we need to figure out is how to make this work for SDIO - and
>>> that's when it becomes more complex. I really would like us to avoid
>>> exporting new SDIO APIs, unless really needed.
>>>
>>> Today runtime PM is deployed by the following SDIO func drivers:
>>> drivers/net/wireless/libertas/if_sdio.c
>>> drivers/net/wireless/ti/wl1251/sdio.c
>>> drivers/net/wireless/ti/wlcore/sdio.c
>>>
>>> We _could_ consider to convert above drivers to use something else
>>> than runtime PM to control the power to the card. I think that would
>>> be the ideal solution, since then we can deploy runtime PM for SDIO
>>> fairly similar to how MMC/SDIO is done. That means doing runtime PM
>>> get/put of the device for the struct mmc_card, inside the mmc core
>>> while handling SDIO requests.
>>>
>>> The above requires some work, both in the mmc core and in the SDIO
>>> func drivers. The nice thing is that we don't need to export new APIs
>>> to the SDIO func drivers and we can keep the complexity of dealing
>>> with "idle operations" inside the mmc core.
>>>
>>> Thoughts?
>>
>> There isn't necessarily any link between "idle operations" and runtime pm.
> 
> I think this is exactly what runtime PM is designed for so I don't
> want us to re-invent something that is specific for mmc.

Need to remember that PM can theoretically be configured out, which makes
using it for bkops seem inappropriate.

> 
>>
>> For example for eMMC background operations I would expect to see:
>>
>> - queue is empty so block driver enables "idle operations".
>> - core waits (delayed work?) a few milliseconds and then starts bkops.
>> - a new I/O request arrives, block driver wakes up and tells the core to
>> stop "idle operations" ASAP, and waits until it does.
>> - or, the core notifies (callback perhaps) the block driver that "idle
>> operations" are finished, so the block driver can runtime-put the card
>>
>> Also need to stop "idle operations" for system suspend, maybe other places.
> 
> Conceptual wise, I fully agree. Though, I want to make use of runtime PM.

So long as it is power management. I am not sure bkops falls into that category.

> 
> For the eMMC/SD case, the runtime PM suspend callbacks (specified per
> bus_ops) should be able to act as the "trigger" point to kick off
> "idle operations".
> 
> Now, the thing to figure out, is how to execute "idle operations" and
> at the same time being able to interrupt/abort them from another
> context. An option for how to deal with this, could be to schedule a
> "delayed work" from the runtime PM suspend callback. But if we can
> avoid it, I think we should.

Whatever the context that runs the idle operations, for the case where a
driver wants to stop the idle operations ASAP, it would be nice if it could
simply take over control - particularly if the idle operation is anyway
waiting for something. So the HPI or whatever is done in the driver context
directly and the idle operation context (if there even is one at that stage)
just exits.

> 
>>
>> Now in Neil's case there is a relation to runtime pm in that it would be
>> nice if the switch to 1-bit mode was delayed by the host controllers
>> autosuspend_delay. But potentially the host controller driver could
>> routinely set the delay so that it matches the autosuspend_delay anyway.
>>
>> Currently the SDIO function drivers all use sdio_claim_host(). So for Neil's
>> case I would see:
>>
>> - host controller driver sees the switch to 4-bit mode and does a runtime
>> "get" to prevent runtime suspend
>> - sdio_release_host enables "idle operations"
>> - the core sees that someone has requested a switch to 1-bit mode after a
>> certain delay, so it waits that delay (delayed work?) and does the switch
>> - host controller driver sees the switch to 1-bit mode and runtime suspends
>> via a pm_runtime_put
>> - sdio_claim_host tells the core to stop "idle operations" ASAP and waits
>> until it has
>> - host controller driver sees the switch to 4-bit mode and does a runtime
>> "get" to prevent runtime suspend
> 
> That seems like a way forward!
> 
> Still I rather would like the above mentioned SDIO func drivers to use
> something else than runtime PM to control the power to the cards, as I
> suggested. But that might be too much to fix!?

Let's keep that a separate issue.

