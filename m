From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Force a "detect" to handle non-properly removed
 cards
Date: Mon, 16 Jan 2012 09:45:31 +0200
Message-ID: <4F13D59B.2060607@intel.com>
References: <1325586798-16276-1-git-send-email-ulf.hansson@stericsson.com> <4F04C412.1030604@intel.com> <4F0AC942.4060404@stericsson.com> <4F0AD879.10801@intel.com> <4F0AE82C.10000@stericsson.com> <4F0AF157.7090101@intel.com> <4F0AF96B.4050500@stericsson.com> <4F0C035D.7070705@intel.com> <4F0C1A1C.8070007@stericsson.com> <4F0C2ACD.4090002@intel.com> <4F100196.8010104@stericsson.com> <4F100AE5.3040304@intel.com> <4F10161E.2080107@stericsson.com> <4F101ED5.9090007@intel.com> <4F102E34.6030704@stericsson.com> <4F1034F5.1020305@intel.com> <4F104130.8030906@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:27707 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864Ab2APHpb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 Jan 2012 02:45:31 -0500
In-Reply-To: <4F104130.8030906@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 13/01/12 16:35, Ulf Hansson wrote:
> Adrian Hunter wrote:
>> On 13/01/12 15:14, Ulf Hansson wrote:
>>>>>>> In principles this means the following sequence:
>>>>>>>
>>>>>>> We will rely on that the get_cd function will return 0 (indicating
>>>>>>> card is
>>>>>>> removed) when the card is "slowly" removed at the point when the rescan
>>>>>>> function is calling it through the bus_ops->detect -->
>>>>>>> _mmc_detect_card_removed function.
>>>>>>>
>>>>>>> This then becomes a race, meaning that the rescan function must be
>>>>>>> executing
>>>>>>> at the same time the get_cd function will returns 0. Otherwise the
>>>>>>> rescan
>>>>>>> function will not remove the card.
>>>>>>>
>>>>>>> Thus my conclusion is that "[PATCH 2/4 v4] MMC/SD: Add callback
>>>>>>> function to
>>>>>>> detect card" will likely improve behavior but is not the safe
>>>>>>> solution to
>>>>>>> handle "slowly" removed cards.
>>>>>>>
>>>>>>> Again, to be sure, we must let the mmc_detect_card_remove function
>>>>>>> trigger a
>>>>>>> rescan when _mmc_detect_card_removed has detected that the card is
>>>>>>> removed.
>>>>>>> This should be safe in all circumstances.
>>>>>> sdhci has no problem because it does this:
>>>>>>
>>>>>>     - the host controller debounces the card detect line
>>>>>>     - the host controller records whether or not the card is present
>>>>>>     - the sdhci driver prevents (errors out) requests when the card is
>>>>>>     not present
>>>>> Debouncing will just be a way of triggering the problem more seldom. Or in
>>>>> worst case, state the card has been removed even if it has not.
>>>> If a delay is used with mmc_detect_change, debouncing is not necessary.
>>>>
>>>>> Just because you get a GPIO irq on the detect line does not mean the
>>>>> card is
>>>>> removed, debouncing or not. I consider this as pure mechanical switch
>>>>> which
>>>>> likely has glitches and I don't see that we should trust it fully. We only
>>>>> want to trigger a detect work, which is exactly what is done in the patch
>>>>> from Guennadi Liakhovetski "mmc: add a generic GPIO card-detect helper".
>>>> The original problem was "slow card removal".  "Unreliable card detect"
>>>> is a separate problem.  Currently there is polling (MMC_CAP_NEEDS_POLL)
>>>> for that.  Alternatively there is MMC_CAP2_RESCAN_ON_ERROR as we have
>>>> discussed.
>>> I do not understand why you mention "Unreliable card detect"? That has
>>> nothing to do with this patch.
>>>
>>> So to conclude the discussion, do you believe that this patch is acceptable
>>> as long as we add a CAPS2 option "MMC_CAP2_RESCAN_ON_ERROR", which if not
>>> set will prevent the detect work from being scheduled from
>>> mmc_detect_card_removed?
>>
>> Yes
>>
> 
> OK, but.. :-)
> 
> I were just about to update the patch according to your recommendation when
> I realized the following:
> 
> Once _mmc_detect_card_removed has set the card state as removed
> ("mmc_card_set_removed"), the card will never be accessible for I/O requests
> any more, all I/O will "silently" be thrown away in the block layer. This
> leads to that there should definitely be no reason for _not_ letting a
> scheduled rescan remove the card as soon as possible. In other words the
> CAP2 should not be needed.
> 
> Did I miss something?
> 
> Agree?

No.  mmc_detect_card_removed() will not check/set the card removed
unless there has been a call to mmc_detect_change() to set the
host->detect_change flag.

MMC_CAP2_RESCAN_ON_ERROR is definitely needed.

Do not confuse mmc_detect_card_removed() with _mmc_detect_card_removed().
The former is called by block.c.  The latter is only called by mmc_rescan()
via the ->detect method.
