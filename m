From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [bisect] Merge tag 'mmc-v4.6' of git://git.linaro.org/people/ulf.hansson/mmc
 (was [GIT PULL] MMC for v.4.6)
Date: Mon, 4 Apr 2016 11:59:32 -0700
Message-ID: <CA+55aFwFVBg5joDd0QYjmSA6t8TM7tmZvmcArZu3Ar8u4vDecw@mail.gmail.com>
References: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
	<57008645.4070808@hurleysoftware.com>
	<CA+55aFwjQP25NYfjPMTicO-M8yjm5c0aKFx-1saWmrro0c0NVQ@mail.gmail.com>
	<CAPDyKFr6zCm4wBS97bUCwq4qhsM8u3mEpyBf4uicJ_UQ7L-q5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37974 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbcDDS7e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 14:59:34 -0400
In-Reply-To: <CAPDyKFr6zCm4wBS97bUCwq4qhsM8u3mEpyBf4uicJ_UQ7L-q5w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On Mon, Apr 4, 2016 at 4:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The commit that's likely to cause the regression is:
> 520bd7a8b415 ("mmc: core: Optimize boot time by detecting cards
> simultaneously").

Peter, mind testing if you can revert that and get the old behavior
back? It seems to still revert cleanly, although I didn't check if the
revert actually then builds..

> This commit further enables asynchronous detection of (e)MMC/SD/SDIO
> cards, by converting from an *ordered* work-queue to a *non-ordered*
> work-queue for card detection.
>
> Although, one should know that there have *never* been any guarantees
> to get a fixed mmcblk id for a card. I expect that's what has been
> assumed here.

So quite frankly, for the whole "no regressions" issue, "documented
behavior" simply isn't an issue. It doesn't matter one whit or not if
something has been documented: if it has worked and people have
depended on it, it's what we in the industry call "reality".

And reality trumps documentation. Every time.

So it sounds like either that just needs to be reverted, or some other
way to get reliable device naming needs to happen.

So the *simple* model is to just scan the devices minimally serially,
and allocate the names at that point (so the names are reliable
between boots for the same hardware configuration). And then do the
more expensive device setup asynchronously (ie querying device
information, spinning up disks, whatever - things that can take
anything from milliseonds to several seconds, because they are doing
actual IO). So you'd do some very basic (and _often_ fairly quick)
operations serially, but then try to do the expensive parts
concurrently.

The SCSI layer actually goes a bit further than that: it has a fairly
asynchronous scanning thing, but it does allocate the actual host
device nodes serially, and then it even has an ordered list of
"scanning_hosts" that is used to complete the scanning in-order, so
that the sysfs devices show up in the right order even if things
actually got scanned out-of-order. So scans that finished early will
wait for other scans that are for "earlier" devices, and you end up
with what *looks* ordered to the outside, even if internally it was
all done out-of-order.

So there are multiple approaches to handling this, while still
allowing fairly asynchronous IO.

                 Linus
