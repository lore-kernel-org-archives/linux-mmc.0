From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Sat, 26 Jan 2013 19:53:53 +0100
Message-ID: <CAPDyKFq+UwV6ACTqiS+oOSs0NHHFuhyF1s=z-oq=dciiy0B3Fg@mail.gmail.com>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
	<CAPDyKFpOd3abjoYyrOeV=i+VRwUqisMwJe8_33j0G7zcd5r6Eg@mail.gmail.com>
	<1359030968.26878.46.camel@hornet>
	<CAPDyKFpc3GZd0Zr4TcGBX_cobJLXFJzr+LAO5Z6TEJu2_26ekA@mail.gmail.com>
	<20130124125907.GV23505@n2100.arm.linux.org.uk>
	<CACRpkdbG=Ad27EPdWz4hGg5D84FjS=b1M6BpPdLu9-nnMpADSA@mail.gmail.com>
	<CAPDyKFq-8ZHgvNUL7fpZMdQsjaDEYog4qe0pTPZ_e0Ldv4dNZQ@mail.gmail.com>
	<CACRpkdbgmJW4X6vzuDjPM+cHgcPSMW0Y2jCKwmYk9-t0RtOv8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:52851 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3AZSxz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 26 Jan 2013 13:53:55 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so2240532lbb.8
        for <linux-mmc@vger.kernel.org>; Sat, 26 Jan 2013 10:53:53 -0800 (PST)
In-Reply-To: <CACRpkdbgmJW4X6vzuDjPM+cHgcPSMW0Y2jCKwmYk9-t0RtOv8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On 25 January 2013 10:35, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jan 24, 2013 at 9:11 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 24 January 2013 18:12, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>>> We're talking about this I guess:
>>> http://marc.info/?l=linux-arm-kernel&m=123790711306850&w=4
>>>
>>> In these experiments I actually gated not only the
>>> enable bit (bit 8) to the MCI clock, but also the pclk to
>>> the PrimeCell itself as well. This was due to the U300
>>> clock framework doing that behind the scenes on
>>> clk_disable(host->clk);
>>>
>>> And the reason the clock framework was doing that
>>> was that the U300 had the block clock and the card
>>> clock wired to the same clock tap ...
>>> The equivalent patch today would also call
>>> amba_pclk_disable() when the card was inactive.
>>>
>>> Thus we also got rid of all the switching leaks in the PL180
>>> logic. (Containing two big state machines for example.)
>>>
>>> It was an interesting comparison to just enable PwrSave
>>> (bit 9) instead, and disable the other clock logic.
>>>
>>> It turned out that this saving was significantly bigger when
>>> gating the entire PrimeCell than the savings for just gating
>>> the clock out to the card itself with bit 9.
>>>
>>> But at this time I didn't have a card in the slot, so as to
>>> eliminate the power consumed in the card (assuming
>>> this would drown the overall current consumption).
>>>
>>> So I have second thoughts about this. The experiment
>>> was not testing the PwrSave bit with a card inserted, this
>>> is the wrong thing to do. To determine if that bit is a good
>>> thing to turn on, it needs to be tested with a card in the
>>> slot.
>>>
>>> The only really useful information is that the switching
>>> logic inside the PL180 synthesized IP-core consumes
>>> circa 200uA, so it could be useful to gate it at times.
>>
>> So in the runtime_pm callbacks, it you don't just want to do normal
>> clk gating/ungating with the clock API, which is done right now. You
>> also would like to actually gate the clock internally by using
>> clock/power register. Does that make sense?
>
> Well in the currently merged patches it will only cut of
> MCLK through the clock API right?
>
> Maybe it makes sense to also call amba_pclk_disable()
> in these hooks so as to propagate up and gate off the
> silicon pclk?

That is already taken care off in the amba bus. So no need to worry :-)

>
> In the ST case, with SDIO support and all, this can not be
> done on SDIO devices though, as that thing needs to
> react to IRQs, and thus the logic must always be clocked.
> But for blocks connected to cards/eMMCs where the device
> is essentially passive, it seems like the right thing to do.
>

You are right, but until/if we implement SDIO_IRQ support for mmci, we
don't have to bother.

Morover, if the SDIO IRQ is rerouted to a GPIO IRQ when going to
runtime_suspend it will do the trick.

> (Actually in a finer technology the power savings could of
> course be greater than 200uA for doing this.)
>

Yes, new measurements would be great to do.

> Yours,
> Linus Walleij

Kind regards
Ulf Hansson
