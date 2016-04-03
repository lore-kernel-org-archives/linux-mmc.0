From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [bisect] Merge tag 'mmc-v4.6' of git://git.linaro.org/people/ulf.hansson/mmc
 (was [GIT PULL] MMC for v.4.6)
Date: Sun, 3 Apr 2016 06:54:08 -0500
Message-ID: <CA+55aFwjQP25NYfjPMTicO-M8yjm5c0aKFx-1saWmrro0c0NVQ@mail.gmail.com>
References: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
	<57008645.4070808@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34655 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbcDCLyJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Apr 2016 07:54:09 -0400
In-Reply-To: <57008645.4070808@hurleysoftware.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On Sat, Apr 2, 2016 at 9:56 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>
> Note how mmc1 => mmcblk0 and mmc0 => mmcblk1.
>
> This produces a failure to boot as the wrong partition is mounted as
> root (/dev/mmcblk0p2 is now on the wrong mmc).

It *looks* very much like somebody is doing asynchronous probing of
the bus, meaning that the devices get probed in random order.

And that "random order" is admittedly probably usually fairly static
on any particular hardware platform, but then something happens to
change timing, and...

This is why you should never probe the actual *bus* asynchronously,
just do the end-point setup async. For example, you'd enumerate ports
(and assign devices to the ports) synchronously, but then after device
assignment the actual device probing can be async.

> The bisect tried all the mmc tree patches which were all good.
> I double-checked by cloning the mmc tree and building both mmc-v4.6
> and v4.5-rc6, and both tested good.
>
> I interpret that to mean some change in mmc + some new behavior elsewhere
> for v4.6 is causing this. Any ideas?

Hmm. If it really is just timing, it could have been around forever,
and just hidden by the fact that normally mmc0 gets probed before
mmc1, but then some other probing thing slowed down or the exact
details of the async workqueue  scheduling changed, and now mmc1 just
*happens* to get probed first..

The thing that changed scheduling order could easily have come from
some non-mmc change.

NOTE! I have nothing to back this up except that (a) we've had
problems like this before and (b) it does look from your dmesg that
mmcX is simply probed in the "wrong" order. I didn't look at exactly
what mmc does or who does the probing.

Maybe Ulf can explain what it is that is _supposed_ to keep the mmc
probe order stable. Ulf?

             Linus
