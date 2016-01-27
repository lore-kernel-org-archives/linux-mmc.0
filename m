From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 0/21] Totally remove SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk
Date: Wed, 27 Jan 2016 16:07:37 +0100
Message-ID: <CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
	<56A8BF22.8010509@intel.com>
	<20160127132348.GY10826@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33301 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933086AbcA0PHh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 10:07:37 -0500
Received: by mail-yk0-f175.google.com with SMTP id k129so13162968yke.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jan 2016 07:07:37 -0800 (PST)
In-Reply-To: <20160127132348.GY10826@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 27 January 2016 at 14:23, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 27, 2016 at 02:59:14PM +0200, Adrian Hunter wrote:
>> In my view Ulf needs to explain how the SDHCI library is going to work,
>> particularly in the absence of new callbacks.
>
> We need to add new callbacks as part of the conversion to a library,
> otherwise we're very much into a total rewrite from scratch (which
> I think is far too much work, and prone to errors) or a big flag day
> to switch everything over (which will require a moritorium on sdhci
> patches while the effort to switch everything is ongoing.)
>
> Both of those approaches suffer from one huge drawback: there is no
> way to bisect between them to locate the cause of a regression.
>
> A piece-meal approach, where the driver is gradually converted is a
> far saner approach, because it means that each conversion in the step
> can be done as a series of transformations, which not only can be
> properly reviewed, but also bisected - and that is _hugely_ important
> for the existing state of SDHCI.
>
> The chances of some hardware behavioural quirk being missed while
> trying to convert SDHCI to a library are _extremely_ high, and the
> only sane approach to this is one which allows a progressive
> transformation of the driver.
>
> Also, the last thing we want is for drivers to end up duplicating
> entire functions from sdhci.c just because they have one thing
> different (eg, because they need to do something in the middle of
> a set_ios() call which no other SDHCI driver needs.)  Having such
> code duplication will just make maintanence even more of a
> nightmare.
>
> set_ios() is probably one of the worst functions in sdhci right now,
> and there's no obvious way to split it up into several stand-alone
> functions which drivers could chain together.
>
> I think what needs to happen here is that Ulf needs to leave such
> decisions about what is acceptable or unacceptable to those who are
> trying to convert sdhci to a library, otherwise the conversion will
> probably never happen... unless Ulf wants to get directly involved
> in the conversion effort, producing patches to make it happen.
>

I don't intend to contribute much with actual patches. I am willing to
help review and also help with expertise around the PM related parts.

I do realize that some callbacks may still be needed, even in the end
when sdhci has become a pure library. Although, those should be far
less then those we have today.

Currently I am more or less unable to properly maintain sdhci because
of it's bad code structure. Therefore I have taken a quite simple
approach by rejecting new callbacks and quirks, in a way to prevent it
from being worse. To me, the best way forward would be if some of you
experienced sdhci developers stepped in as a maintainer for it. In
that way, I can trust the development moving in the "library
direction" so I can pull back from nacking potential interim sdhci
callbacks/quirks.

Does it make sense?

Kind regards
Uffe
