From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 2/2] mmc: block: Enable runtime pm for mmc blkdevice
Date: Thu, 11 Apr 2013 12:58:45 +0300
Message-ID: <51668955.7010204@intel.com>
References: <1365421497-4661-1-git-send-email-ulf.hansson@stericsson.com> <516674FC.60704@intel.com> <CAPDyKFq93uPy5tR+GnDf0PKGVooxMytFn46JMe8AVfavbFm3DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19999 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454Ab3DKJyX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Apr 2013 05:54:23 -0400
In-Reply-To: <CAPDyKFq93uPy5tR+GnDf0PKGVooxMytFn46JMe8AVfavbFm3DA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 11/04/13 12:40, Ulf Hansson wrote:
> On 11 April 2013 10:31, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 08/04/13 14:44, Ulf Hansson wrote:
>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>> Once the mmc blkdevice is being probed, runtime pm will be enabled.
>>> By using runtime autosuspend, the power save operations can be done
>>> when request inactivity occurs for a certain time. Right now the
>>> selected timeout value is set to 3 s.
>>>
>>> Moreover, when the blk device is being suspended, we make sure the device
>>> will be runtime resumed. The reason for doing this is that we want the
>>> host suspend sequence to be unaware of any runtime power save operations,
>>> so it can just handle the suspend as the device is fully powered from a
>>> runtime perspective.
>>>
>>> This patch is preparing to make it possible to move BKOPS handling into
>>> the runtime callbacks for the mmc bus_ops. Thus IDLE BKOPS can be
>>> accomplished.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Acked-by: Maya Erez <merez@codeaurora.org>
>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>> Acked-by: Kevin Liu <kliu5@marvell.com>
>>> ---
>>>  drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
>>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>>
>>
>> There are debugfs uses of the card also (e.g.mmc_dbg_card_status_get)
>> that will need get/put added.
> 
> In the end it all depends on what kind of operations you decide to do
> in the runtime_supend|resume callbacks.
> Since the callbacks is not yet implemented for sd and mmc, this is not
> required as of now.
> 
> Nevertheless a most valid point that needs to be considered, while
> implementing the callbacks. Thanks for pointing this out.
> 
>>
>> There might be others.  Please check.
> 
> mmc_rescan needs to be considered at card removal and at resume. But,
> again this does not need to be handled as of now.

I disagree.  If you are adding runtime PM for SD/MMC cards, it must not be
possible to access the card without going through runtime PM first.  That
includes *all* code paths.  We should not leave holes for others to fall in.

> 
>>
>> It might be worth adding helpers e.g. mmc_claim_card()/mmc_release_card
>> so that it is easy to see the places that the host is claimed but runtime pm
>> is not used.
> 
> I am not sure we gain more visibility adding helpers at this initial
> step. We already have three scenarios for get/claim.
> 1. mmc_claim_host and pm_runtime_get is done in conjuction.
> 2. only mmc_claim_host.
> 3. only pm_runtime_get.
> 
> For put, we have a similar situation, and we don't even use the same
> runtime put API for all cases.
> 
> I see your point, it could very well be wanted to add these helpers if
> we see that the callbacks force the pm_runtime API to be used from
> several more places.
> 
>>
>> void mmc_claim_card(card)
>> {
>>         pm_runtime_get_sync(&card->dev);
>>         mmc_claim_host(card->host);
>> }
>>
>> void mmc_release_card(card)
>> {
>>         mmc_release_host(card->host);
>>         pm_runtime_mark_last_busy(&card->dev);
>>         pm_runtime_put_autosuspend(&card->dev);
>> }
>>
>>
>>
> 
> Kind regards
> Ulf Hansson
> 
> 

