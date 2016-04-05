From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [bisect] Merge tag 'mmc-v4.6' of git://git.linaro.org/people/ulf.hansson/mmc
 (was [GIT PULL] MMC for v.4.6)
Date: Tue, 5 Apr 2016 10:59:28 +0200
Message-ID: <CAPDyKFqFoJybrr4dBt8xO7iHt9CAbET=i-v9ZLht7J6K091Phw@mail.gmail.com>
References: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
	<57008645.4070808@hurleysoftware.com>
	<CA+55aFwjQP25NYfjPMTicO-M8yjm5c0aKFx-1saWmrro0c0NVQ@mail.gmail.com>
	<CAPDyKFr6zCm4wBS97bUCwq4qhsM8u3mEpyBf4uicJ_UQ7L-q5w@mail.gmail.com>
	<CA+55aFwFVBg5joDd0QYjmSA6t8TM7tmZvmcArZu3Ar8u4vDecw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34603 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757733AbcDEI7a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2016 04:59:30 -0400
Received: by mail-wm0-f51.google.com with SMTP id l6so13882519wml.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2016 01:59:29 -0700 (PDT)
In-Reply-To: <CA+55aFwFVBg5joDd0QYjmSA6t8TM7tmZvmcArZu3Ar8u4vDecw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 4 April 2016 at 20:59, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, Apr 4, 2016 at 4:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> The commit that's likely to cause the regression is:
>> 520bd7a8b415 ("mmc: core: Optimize boot time by detecting cards
>> simultaneously").
>
> Peter, mind testing if you can revert that and get the old behavior
> back? It seems to still revert cleanly, although I didn't check if the
> revert actually then builds..

I have checked, the revert should be a safe option. There is nothing
added on top that relies on it.

Moreover, I have no problem dealing with the revert, as it me
personally that screwed this up.

>
>> This commit further enables asynchronous detection of (e)MMC/SD/SDIO
>> cards, by converting from an *ordered* work-queue to a *non-ordered*
>> work-queue for card detection.
>>
>> Although, one should know that there have *never* been any guarantees
>> to get a fixed mmcblk id for a card. I expect that's what has been
>> assumed here.
>
> So quite frankly, for the whole "no regressions" issue, "documented
> behavior" simply isn't an issue. It doesn't matter one whit or not if
> something has been documented: if it has worked and people have
> depended on it, it's what we in the industry call "reality".
>
> And reality trumps documentation. Every time.

I totally agree.

Although, what puzzles me around this particular issue, is how an SoC
configuration can rely on this fragile behaviour.
All you have to do to break the assumption of fixed mmcblk ids, is to
boot with an SD card inserted and then without. Perhaps these SoCs
just doesn't support this use case!?

>
> So it sounds like either that just needs to be reverted, or some other
> way to get reliable device naming needs to happen.
>
> So the *simple* model is to just scan the devices minimally serially,
> and allocate the names at that point (so the names are reliable
> between boots for the same hardware configuration). And then do the
> more expensive device setup asynchronously (ie querying device
> information, spinning up disks, whatever - things that can take
> anything from milliseonds to several seconds, because they are doing
> actual IO). So you'd do some very basic (and _often_ fairly quick)
> operations serially, but then try to do the expensive parts
> concurrently.
>
> The SCSI layer actually goes a bit further than that: it has a fairly
> asynchronous scanning thing, but it does allocate the actual host
> device nodes serially, and then it even has an ordered list of
> "scanning_hosts" that is used to complete the scanning in-order, so
> that the sysfs devices show up in the right order even if things
> actually got scanned out-of-order. So scans that finished early will
> wait for other scans that are for "earlier" devices, and you end up
> with what *looks* ordered to the outside, even if internally it was
> all done out-of-order.
>
> So there are multiple approaches to handling this, while still
> allowing fairly asynchronous IO.

Thanks for sharing this information!

I will give it a try and see if I can come up with something that
restores the behaviour, but without having to do the revert. If it
turns out to be too complicated, I can post the revert in a couple of
rcs.

Kind regards
Uffe
