From: Daniel Lenski <dlenski@gmail.com>
Subject: Fwd: [BUG] mfd: rtsx_usb data corruption with SDCX microsd
Date: Tue, 8 Dec 2015 09:28:32 -0800
Message-ID: <CAOw_LSH+EKSSir7uh3-ksR9fcg4yd-kO_i5WNR7HXbdt1e0tRw@mail.gmail.com>
References: <CAOw_LSFRskOLSPW31DUpbYv8wsrH68wkmW=F7s2jCLsRvSLfsg@mail.gmail.com>
 <CAOw_LSFCY6mTKykBNpjdVoFu5B33nD2hdf9-4NigOXz22UZK-w@mail.gmail.com>
 <CAPDyKFpJ_3zuiYnP=QcDvd-6CCOUU=jjUdXK0qbeDTQnv+Jrfg@mail.gmail.com> <CAOw_LSFhEuDLNfF4HCBhqx_-DmCgiV0oCYn61C7Ahr-x+LPLPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36383 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbbLHR3N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2015 12:29:13 -0500
Received: by wmww144 with SMTP id w144so190034363wmw.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Dec 2015 09:29:12 -0800 (PST)
In-Reply-To: <CAOw_LSFhEuDLNfF4HCBhqx_-DmCgiV0oCYn61C7Ahr-x+LPLPw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: marcus.overhagen@gmail.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Dec 8, 2015 6:11 AM, "Ulf Hansson" <ulf.hansson@linaro.org> wrote:
>
> On 4 December 2015 at 21:34, Daniel Lenski <dlenski@gmail.com> wrote:
> > In conclusion... it seems that the kernel is attempting to drive this
> > card faster than it can actually work. What I'm trying to figure out
> > now:
> > - How does the kernel attempt to figure out the capability of a given
> > SD card? Where is that in the kernel source tree?
>
> drivers/mmc/core/*
>
> It's kind of complicated, but please go ahead and have a look.

Will do.

> > - Is it possible to make the list of supported caps a module
> > parameter, to more easily throttle high-speed modes that don't work
> > with a particular card?
>
> Maybe a sysfs/debugfs interface would be better, but I like the idea!
>
> Currently there is no way for userspace to disable some of these
> "speed mode" caps, which would be very useful in cases like yours.
>
> I don't know if I ever will get time to hack on such code, so feel
> free to have a try yourself!

Ideally, would it be better to have a userspace control at the level
of the individual host control drivers, or for the entire mmc/SD
subsystem?

> Regarding how to fix this problem right now, I guess we should remove
> the caps which the host driver wrongly claims to support. Do you want
> to send a patch for that?

I can do that, but am unsure whether it is truly an issue with the
host driver, or the card itself, in my case.

Is there any information which I can use to clearly rule one or the
other case out?

If I understood Marcus Overhagen's original post correctly, he was
successful with a UHS SDHC card and this same controller.

Thanks,
Dan
