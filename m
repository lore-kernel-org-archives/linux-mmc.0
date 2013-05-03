From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 0/4] mmc: Use runtime pm for blkdevice
Date: Fri, 03 May 2013 16:10:44 +0300
Message-ID: <5183B754.3060203@intel.com>
References: <1367496159-7090-1-git-send-email-ulf.hansson@stericsson.com> <CAPDyKFoFXdvB1fQoYM4VH89zZThQxk7QJ9x_G7E+hzR+17s-Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50377 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761934Ab3ECNFc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 May 2013 09:05:32 -0400
In-Reply-To: <CAPDyKFoFXdvB1fQoYM4VH89zZThQxk7QJ9x_G7E+hzR+17s-Ug@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On 03/05/13 14:11, Ulf Hansson wrote:
> On 2 May 2013 14:02, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> SDIO has been using runtime pm for a while to handle runtime power save
>> operations. This patchset is enabling the option to make the sd/mmc
>> blockdevices to use runtime pm as well.
>>
>> The runtime pm implementation for the block device will make use of
>> autosuspend to defer power save operation to after request inactivty for
>> a certain time.
>>
>> Corresponding pm_runtime_get|put calls has been added at those places that
>> do requires the card to be fully powered to communicate.
>>
>> Patch 4 can be considered as a proof of concept patch. It implements
>> aggressive power management for (e)MMC/SD. This feature has also been
>> discussed on the mmc mailing list previously.
>>
>> Next step would be to implement the IDLE BKOPS on top of the runtime pm
>> callbacks.
>>
>> Changes in v4:
>>         - Updated patch 4 according to review comments from Adrian.
>>
>> Changes in v3:
>>         - Make sure the card device is powered from a runtime perspective
>>         when needed. This is also the indirect reason to why the new patch 1
>>         has been added to this patchset.
>>         - Added a proof of concept patch, in patch 4.
>>         - Replace acks with cc, since quite some changes has been done.
>>
>> Changes in v2:
>>         - Removed the stated patch below from this patchset. It can be handled
>>         separately. "mmc: core: Remove power_restore bus_ops for mmc and sd"
>>         - Rebased patches on latest mmc-next.
>>         - Added Acks.
>>
>> Ulf Hansson (4):
>>   mmc: core: Stop bkops for eMMC only from mmc suspend
>>   mmc: core: Add bus_ops for runtime pm callbacks
>>   mmc: block: Enable runtime pm for mmc blkdevice
>>   mmc: core: Support aggressive power management for (e)MMC/SD
>>
>>  drivers/mmc/card/block.c   |   32 ++++++++++++++++++-----
>>  drivers/mmc/core/bus.c     |   14 +++++++++--
>>  drivers/mmc/core/core.c    |   47 ++++++++++++++++++----------------
>>  drivers/mmc/core/core.h    |    3 +++
>>  drivers/mmc/core/debugfs.c |    8 +++---
>>  drivers/mmc/core/mmc.c     |   60 ++++++++++++++++++++++++++++++++++++++++++--
>>  drivers/mmc/core/sd.c      |   53 ++++++++++++++++++++++++++++++++++++--
>>  drivers/mmc/core/sdio.c    |   16 ++++++++++++
>>  include/linux/mmc/core.h   |    3 +++
>>  include/linux/mmc/host.h   |    2 +-
>>  10 files changed, 199 insertions(+), 39 deletions(-)
>>
>> --
>> 1.7.10
>>
> 
> Thanks for reviewing this patchset Adrian. I suppose we have sorted
> out all the issues now and I would like to advise Chris to merge it
> from 3.10, unless you have any other opinions.

It is OK by me

> 
> Not sure if it is still possible for Chris to merge it for 3.10, but let's see.
> 
> Kind regards
> Ulf Hansson
> 
> 

