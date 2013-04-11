From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: block: Enable runtime pm for mmc blkdevice
Date: Thu, 11 Apr 2013 12:14:16 +0200
Message-ID: <CAPDyKFqf3Ruw8fBzNOiBRN2y8ONxa=W7=MAB-4+5q6c2og=yWQ@mail.gmail.com>
References: <1365421497-4661-1-git-send-email-ulf.hansson@stericsson.com>
	<516674FC.60704@intel.com>
	<CAPDyKFq93uPy5tR+GnDf0PKGVooxMytFn46JMe8AVfavbFm3DA@mail.gmail.com>
	<51668955.7010204@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:38694 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab3DKKOR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Apr 2013 06:14:17 -0400
Received: by mail-vc0-f177.google.com with SMTP id hr11so1141920vcb.36
        for <linux-mmc@vger.kernel.org>; Thu, 11 Apr 2013 03:14:17 -0700 (PDT)
In-Reply-To: <51668955.7010204@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 11 April 2013 11:58, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 11/04/13 12:40, Ulf Hansson wrote:
>> On 11 April 2013 10:31, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 08/04/13 14:44, Ulf Hansson wrote:
>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>
>>>> Once the mmc blkdevice is being probed, runtime pm will be enabled.
>>>> By using runtime autosuspend, the power save operations can be done
>>>> when request inactivity occurs for a certain time. Right now the
>>>> selected timeout value is set to 3 s.
>>>>
>>>> Moreover, when the blk device is being suspended, we make sure the device
>>>> will be runtime resumed. The reason for doing this is that we want the
>>>> host suspend sequence to be unaware of any runtime power save operations,
>>>> so it can just handle the suspend as the device is fully powered from a
>>>> runtime perspective.
>>>>
>>>> This patch is preparing to make it possible to move BKOPS handling into
>>>> the runtime callbacks for the mmc bus_ops. Thus IDLE BKOPS can be
>>>> accomplished.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Acked-by: Maya Erez <merez@codeaurora.org>
>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>> Acked-by: Kevin Liu <kliu5@marvell.com>
>>>> ---
>>>>  drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++--
>>>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>>>
>>>
>>> There are debugfs uses of the card also (e.g.mmc_dbg_card_status_get)
>>> that will need get/put added.
>>
>> In the end it all depends on what kind of operations you decide to do
>> in the runtime_supend|resume callbacks.
>> Since the callbacks is not yet implemented for sd and mmc, this is not
>> required as of now.
>>
>> Nevertheless a most valid point that needs to be considered, while
>> implementing the callbacks. Thanks for pointing this out.
>>
>>>
>>> There might be others.  Please check.
>>
>> mmc_rescan needs to be considered at card removal and at resume. But,
>> again this does not need to be handled as of now.
>
> I disagree.  If you are adding runtime PM for SD/MMC cards, it must not be
> possible to access the card without going through runtime PM first.  That
> includes *all* code paths. We should not leave holes for others to fall in.
>

This patchset shall not be considered as full blown common solution
for runtime pm for mmc/sd/sdio. It is an initial step that we can
start build upon.

I took the approach of only adding, pm_runtime_get|put from the mmc
block layer, thus it will also _not_ affect the SDIO pm_runtime
implementation, which is already being used today. Adding what you
propose will affect SDIO as well, I think it is better to handle this
in the next steps instead.

Kind regards
Ulf Hansson
