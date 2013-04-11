From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: block: Enable runtime pm for mmc blkdevice
Date: Thu, 11 Apr 2013 16:17:43 +0200
Message-ID: <CAPDyKFrWVKnwtXwWiyD_K4t7CCEtePHs26ZFhCPDivqmwGusFw@mail.gmail.com>
References: <1365421497-4661-1-git-send-email-ulf.hansson@stericsson.com>
	<516674FC.60704@intel.com>
	<CAPDyKFq93uPy5tR+GnDf0PKGVooxMytFn46JMe8AVfavbFm3DA@mail.gmail.com>
	<51668955.7010204@intel.com>
	<CAPDyKFqf3Ruw8fBzNOiBRN2y8ONxa=W7=MAB-4+5q6c2og=yWQ@mail.gmail.com>
	<5166AC52.6090807@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:65312 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3DKORo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Apr 2013 10:17:44 -0400
Received: by mail-ve0-f178.google.com with SMTP id db10so1458082veb.37
        for <linux-mmc@vger.kernel.org>; Thu, 11 Apr 2013 07:17:43 -0700 (PDT)
In-Reply-To: <5166AC52.6090807@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 11 April 2013 14:28, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 11/04/13 13:14, Ulf Hansson wrote:
>> On 11 April 2013 11:58, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 11/04/13 12:40, Ulf Hansson wrote:
>>>> On 11 April 2013 10:31, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> On 08/04/13 14:44, Ulf Hansson wrote:
>>>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>
>>>>>> Once the mmc blkdevice is being probed, runtime pm will be enabled.
>>>>>> By using runtime autosuspend, the power save operations can be done
>>>>>> when request inactivity occurs for a certain time. Right now the
>>>>>> selected timeout value is set to 3 s.
>>>>>>
>>>>>> Moreover, when the blk device is being suspended, we make sure the device
>>>>>> will be runtime resumed. The reason for doing this is that we want the
>>>>>> host suspend sequence to be unaware of any runtime power save operations,
>>>>>> so it can just handle the suspend as the device is fully powered from a
>>>>>> runtime perspective.
>>>>>>
>>>>>> This patch is preparing to make it possible to move BKOPS handling into
>>>>>> the runtime callbacks for the mmc bus_ops. Thus IDLE BKOPS can be
>>>>>> accomplished.
>>>>>>
>>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>> Acked-by: Maya Erez <merez@codeaurora.org>
>>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>>>> Acked-by: Kevin Liu <kliu5@marvell.com>
>>>>>> ---
>>>>>>  drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
>>>>>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>>>>>
>>>>>
>>>>> There are debugfs uses of the card also (e.g.mmc_dbg_card_status_get)
>>>>> that will need get/put added.
>>>>
>>>> In the end it all depends on what kind of operations you decide to do
>>>> in the runtime_supend|resume callbacks.
>>>> Since the callbacks is not yet implemented for sd and mmc, this is not
>>>> required as of now.
>>>>
>>>> Nevertheless a most valid point that needs to be considered, while
>>>> implementing the callbacks. Thanks for pointing this out.
>>>>
>>>>>
>>>>> There might be others.  Please check.
>>>>
>>>> mmc_rescan needs to be considered at card removal and at resume. But,
>>>> again this does not need to be handled as of now.
>>>
>>> I disagree.  If you are adding runtime PM for SD/MMC cards, it must not be
>>> possible to access the card without going through runtime PM first.  That
>>> includes *all* code paths. We should not leave holes for others to fall in.
>>>
>>
>> This patchset shall not be considered as full blown common solution
>> for runtime pm for mmc/sd/sdio. It is an initial step that we can
>> start build upon.
>
> That does not justify leaving holes.
>
>> I took the approach of only adding, pm_runtime_get|put from the mmc
>> block layer, thus it will also _not_ affect the SDIO pm_runtime
>> implementation, which is already being used today. Adding what you
>> propose will affect SDIO as well, I think it is better to handle this
>> in the next steps instead.
>
> I disagree.  SDIO is easily avoided by coding for card->type.

Yes, it can be done, but on the other hand, I believe the runtime
support for SDIO does need additional improvement.

For example, the debugfs, which you pointed out, is as of today not
handled for sdio.

My, patch is not a fixup patch, it is adding a new feature to be able
to do additional power save. I don't want to mix a new feature with
fixups.

>
> Fix debugfs handling.

Will do it in a separate patch on top of this patch set.

>
> Don't enable runtime pm for removable cards. Document why i.e. rescan of
> removable cards needs special handling depending on the power-saving
> strategy e.g. if the power is off there is a risk of confusing a new card
> with an old card.

Removable cards can be power saved. We have been discussing the
"aggressive mmc_suspend_host" option here on the mmc list; certainly
it makes sense for removable cards as well.

Regarding documentation, I will add some information in header file
for the runtime_supend|resume callbacks.

>
> That covers two omissions that we know about.  Check for others -
> essentially check all mmc_claim_host() / __mmc_claim_host() /
> mmc_try_claim_host() calls.

Will handle this is a separate patch.

>
> SD-Combo cards also look like a problem, so don't enable runtime pm for them
> either.

Unfortunate I don't have an SD-combo card, so can't test these properly.

Anyway, there are problems with SD-combo cards before my patchset
around runtime PM. Using runtime pm for sdio (MMC_CAP_POWER_OFF_CARD),
will at runtime_suspend cut the power to the card. A block request for
the SD-combo card after this point will thus not be served
successfully.

This patchset will enable runtime pm for combo cards as you state.
That should actually fix the above problem, since the block layer will
do pm_runtime_get and thus make sure the card is properly powered when
needed. On the other hand, if MMC_CAP_POWER_OFF_CARD is not set and
thus we could expect the sdio client not doing runtime pm for the card
device, it will mean the exact opposite. Once the block layer decides
to power down the card due to request inactivity, the SDIO client will
suddenly not be able to access the SDIO interface.

The the new bug this patchset invents is probably worse than what it
fix. :-). I will adapt to you suggestion somehow.

>
> Document what works (i.e. non-removable SD and MMC cards) and what doesn't
> (removable and SD-Combo cards) and why.
>
>

Kind regards
Ulf Hansson
