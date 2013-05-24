From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 3/4] mmc: block: Enable runtime pm for mmc blkdevice
Date: Fri, 24 May 2013 10:27:44 +0200
Message-ID: <CAPDyKFqDU1Dh1Ya+pQzAmzh=Nk5dPZ2-k2Nu8osfo+Fi=DYP8Q@mail.gmail.com>
References: <1366106437-18004-1-git-send-email-ulf.hansson@stericsson.com>
	<1366106437-18004-4-git-send-email-ulf.hansson@stericsson.com>
	<CAMj5BkiOmh8sz-=b0z1VF9owGPX0KpbZeNfPzETemCb=C2odGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:46441 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab3EXI1p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 May 2013 04:27:45 -0400
Received: by mail-vc0-f171.google.com with SMTP id m17so2903857vca.2
        for <linux-mmc@vger.kernel.org>; Fri, 24 May 2013 01:27:44 -0700 (PDT)
In-Reply-To: <CAMj5BkiOmh8sz-=b0z1VF9owGPX0KpbZeNfPzETemCb=C2odGQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

On 24 May 2013 08:06, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>
>
>
> On Tue, Apr 16, 2013 at 6:00 PM, Ulf Hansson <ulf.hansson@stericsson.com>
> wrote:
>>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Once the mmc blkdevice is being probed, runtime pm will be enabled.
>> By using runtime autosuspend, the power save operations can be done
>> when request inactivity occurs for a certain time. Right now the
>> selected timeout value is set to 3 s. Obviously this value will likely
>> need to be configurable somehow since it needs to be trimmed depending
>> on the power save algorithm.
>>
>> For SD-combo cards, we are still leaving the enablement of runtime PM
>> to the SDIO init sequence since it depends on the capabilities of the
>> SDIO func driver.
>>
>> Moreover, when the blk device is being suspended, we make sure the device
>> will be runtime resumed. The reason for doing this is that we want the
>> host suspend sequence to be unaware of any runtime power save operations
>> done for the card in this phase. Thus it can just handle the suspend as
>> the card is fully powered from a runtime perspective.
>>
>
> If sd card is removed during system suspend, NULL pointer error would happen
> since card is removed.

Why, where? Have you tested this patch, then maybe you can share a log?

Myself has of course tested above scenario without observing any
issues, though my environment could be different from yours.

> mmc_detect_change would be called even CONFIG_MMC_UNSAFE_RESUME, so no issue
> without these patch.

You need to elaborate why you see a concern here, I can not follow.

>
> Besides, any chance to not call suspend if runtime suspended, such as flag?
> Otherwise, suspend -> runtime_resume -> resume -> suspend.
> Looks much repetition.

The above sequence can only be present while using
MMC_CAP_AGGRESSIVE_PM so your comment is not valid for this patch as
such.

For the MMC_CAP_AGGRESSIVE_PM patch; in this phase I decided to keep
this simple. You may want to optimize for the above sequence in future
patches.

>
> Thanks

Thanks for reviewing!

Kind regards
Ulf Hansson
