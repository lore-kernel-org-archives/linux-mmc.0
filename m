From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH V3] ARM: dts: Add dwmmc DT nodes for exynos5420 SOC
Date: Fri, 23 Aug 2013 20:48:21 -0700
Message-ID: <CAD=FV=VRJceienPHcq3U2MCuYXjO-HaH1jHxyaz7JiAHcJTU1A@mail.gmail.com>
References: <1377172278-15161-1-git-send-email-yuvaraj.cd@samsung.com>
	<CAD=FV=W1LBYSQdLT7N6tTu6rGvUOFuPdFBNP2BRGDCXOH1hT9g@mail.gmail.com>
	<CA+NduCBhD1aKe1G+P1k8P9pEDrHy2U50VzANi6_90P1wOB69Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:54585 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219Ab3HXDsW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 23:48:22 -0400
Received: by mail-ie0-f175.google.com with SMTP id u16so2141499iet.34
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 20:48:22 -0700 (PDT)
In-Reply-To: <CA+NduCBhD1aKe1G+P1k8P9pEDrHy2U50VzANi6_90P1wOB69Vg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Cd <yuvaraj.lkml@gmail.com>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, ks.giri@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Yuvaraj,

On Thu, Aug 22, 2013 at 11:25 PM, Yuvaraj Cd <yuvaraj.lkml@gmail.com> wrote:
>>>                 b.card-detect-delay
>>>                 c.samsung,dw-mshc-ciu-div
>>>                 d.samsung,dw-mshc-sdr-timing
>>>                 e.samsung,dw-mshc-ddr-timing

OK, so I don't know about card-detect-delay, but here's my belief
about the others.  Feel free to tell me I'm wrong, since I'm not an EE
by training and also the stuff below has been cobbled together from
lots of different docs.  I also haven't experimented enough to know
100% that it's correct.  I also know nothing about the actual
signaling protocols of SD/MMC...  Enough caveats?


sdr-timing / ddr-timing:

* First number (I think) allows you to drive data related lines at a
phase offset from the clock line.  So if you have crazy routing on
your board and the data lines are much longer than the clock lines you
might want to do this.  This is not common, so usually you want 0
here.  Note that some other docs I have disagree with this and claim
that this number has to do with hold time requirements.

* Second number allows you to sample signals from the card at a phase
offset from the clock line.  This number might depend on the card, but
hopefully not much.  It's supposed to depend more on the length of the
lines (AKA depends on the board), though it might also depend on
pullup values as well and somewhat on the card?  This number needs to
be tuned (like link training) when you operate a card at > 50MHz.

* For ciu-div:

With a ciu-div of 3 (really 3+1 = 4) you get phase offsets of 45 degrees.
With a ciu-div of 1 (really 1+1 = 2) you get phase offsets of 90 degrees.
WIth a ciu-div of 0 (really 0+1 = 1) you get no phase offsets (I would
have guessed 180, but manual says otherwise)

So ciu-div intimately affects the sdr-timing and ddr-timing.  Thus if
those are board-specific then so is ciu-div.

---

All of the above suggests to me the following untested things:

* If you happened to have a situation where you had a "ciu-div" of 3
and all of your sdr-timing/ddr-timing values were even, you could cut
the input clock in half, change "ciu-div" to 1, and cut all your
timings in half.  I'd imagine that would save you power (better to
slow clocks down higher in the clock tree?).  It would be sorta nice
if this was done automatically (assuming that you have full control of
input clock).

* I'm a little unclear exactly how the CLKDIV register interacts with
all of the above.  I guess I'd be under the assumption that the CLKDIV
applies to the main clock, the sample clock, and the drive clock.
...but maybe I'm confused.  I think you also get different results (in
terms of how many ns the drive and sample are delayed) depending on
whether the CLKDIV applies _after_ ciu-div or before.  My guess is
that it applies after.

---

Anyway, not sure that helps a whole lot, but that's a summary of what
I've come to understand.  I'm happy to be enlightened.  I'm still
trying to figure how how these numbers were picked for our hardware
and whether those numbers are actually right.

-Doug
