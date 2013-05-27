From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3 3/4] mmc: block: Enable runtime pm for mmc blkdevice
Date: Mon, 27 May 2013 09:52:23 +0200
Message-ID: <CAPDyKFokFQ1r4Xrh8Lk_hLUzgxR6EX2kxN0Yrj_mOHyyH9FHsw@mail.gmail.com>
References: <1366106437-18004-1-git-send-email-ulf.hansson@stericsson.com>
	<1366106437-18004-4-git-send-email-ulf.hansson@stericsson.com>
	<CAMj5BkiOmh8sz-=b0z1VF9owGPX0KpbZeNfPzETemCb=C2odGQ@mail.gmail.com>
	<CAPDyKFqDU1Dh1Ya+pQzAmzh=Nk5dPZ2-k2Nu8osfo+Fi=DYP8Q@mail.gmail.com>
	<CAMj5Bki+1=DSzQWYyEC1L=Pa6LpSFQKF3YvoUkkuq62wHuMWow@mail.gmail.com>
	<CAPDyKFoOFBo4=etE=D0sHzZdp6ft32Bd0dM4JmzGO3kQ-kicrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:53983 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab3E0HwX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 May 2013 03:52:23 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so4417935vbf.38
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2013 00:52:23 -0700 (PDT)
In-Reply-To: <CAPDyKFoOFBo4=etE=D0sHzZdp6ft32Bd0dM4JmzGO3kQ-kicrg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Liu <kliu5@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Drake <dsd@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

On 27 May 2013 09:51, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 26 May 2013 03:50, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>>
>>
>>
>> On Fri, May 24, 2013 at 4:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>>
>>> >> Moreover, when the blk device is being suspended, we make sure the
>>> >> device
>>> >> will be runtime resumed. The reason for doing this is that we want the
>>> >> host suspend sequence to be unaware of any runtime power save
>>> >> operations
>>> >> done for the card in this phase. Thus it can just handle the suspend as
>>> >> the card is fully powered from a runtime perspective.
>>> >>
>>> >
>>> > If sd card is removed during system suspend, NULL pointer error would
>>> > happen
>>> > since card is removed.
>>>
>>> Why, where? Have you tested this patch, then maybe you can share a log?
>>>
>>> Myself has of course tested above scenario without observing any
>>> issues, though my environment could be different from yours.
>>>
>>> > mmc_detect_change would be called even CONFIG_MMC_UNSAFE_RESUME, so no
>>> > issue
>>> > without these patch.
>>>
>>> You need to elaborate why you see a concern here, I can not follow.
>>>
>>
>> Maybe I make misunderstood, or do some mistake.
>> since CONFIG_MMC_UNSAFE_RESUME has to be set, is that mean sd card can not
>> be unpluged with the feature enabled.
>> It can be reproduced here if unplug card in suspend or not.
>>
>> static void mmc_sd_detect(struct mmc_host *host)
>> {
>>  err = _mmc_detect_card_removed(host);
>>
>> if (err) {
>>                 mmc_sd_remove(host);
>>                 /* host -> card is NULL now */
>>                 mmc_get_card(host->card);
>> }
>>
>
> I have no idea how you applied and tested this patch, but it seems
> like you have screwed it up. The above code is aligned with this
> patch.

Sorry, the above code is NOT aligned with the code in this patch.

>
> mmc_get_card is called before "err = _mmc_detect_card_removed(host)".
> And mmc_put_card, immediately after "err =
> _mmc_detect_card_removed(host)".
>
> Please consider re-applying the patch and re-test.
>
>
>> The log like:
>> [   19.422655] mmc0: error -123 during resume (card was removed?)
>> [   19.437750] PM: resume of devices complete after 100.698 msecs
>> [   19.448780] mmc0: error -123 doing aggessive suspend
>> [   19.559505] Unable to handle kernel NULL pointer dereference at virtual
>> address 00000000
>> [   19.574547] pgd = c0004000
>> [   19.579576] [00000000] *pgd=00000000
>> [   19.586249] Internal error: Oops: 17 [#1] SMP ARM
>> [   19.594971] CPU: 2    Not tainted  (3.9.0-rc7-01026-g794b888-dirty #194)
>> [   19.607400] PC is at mmc_get_card+0x44/0x6c
>> [   19.615137] LR is at mmc_get_card+0x40/0x6c
>>
>> Thanks
>>
>
> Kind regards
> Ulf Hansson
