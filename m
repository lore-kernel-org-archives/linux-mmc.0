From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Thu, 24 Jan 2013 18:12:52 +0100
Message-ID: <CACRpkdbG=Ad27EPdWz4hGg5D84FjS=b1M6BpPdLu9-nnMpADSA@mail.gmail.com>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
	<CAPDyKFpOd3abjoYyrOeV=i+VRwUqisMwJe8_33j0G7zcd5r6Eg@mail.gmail.com>
	<1359030968.26878.46.camel@hornet>
	<CAPDyKFpc3GZd0Zr4TcGBX_cobJLXFJzr+LAO5Z6TEJu2_26ekA@mail.gmail.com>
	<20130124125907.GV23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:51396 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab3AXRMx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jan 2013 12:12:53 -0500
Received: by mail-ia0-f182.google.com with SMTP id w33so5078550iag.41
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jan 2013 09:12:52 -0800 (PST)
In-Reply-To: <20130124125907.GV23505@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On Thu, Jan 24, 2013 at 1:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> The clock can be masked independently too via the clock enable bit in
> the clock register.
>
> However, it's interesting to note: experiments that Linus did with having
> the primecell automatically masking the clock to the card did not prove
> worthwhile (see the comment in the code).  We seem to be heading towards
> doing this in software and people suggesting it is worthwhile...  Why is
> this?
>
> If the hardware can gate the clock and it doesn't produce the power
> savings we expect, how does then gating the clock via software then
> become worthwhile?  It doesn't make sense.

We're talking about this I guess:
http://marc.info/?l=linux-arm-kernel&m=123790711306850&w=4

In these experiments I actually gated not only the
enable bit (bit 8) to the MCI clock, but also the pclk to
the PrimeCell itself as well. This was due to the U300
clock framework doing that behind the scenes on
clk_disable(host->clk);

And the reason the clock framework was doing that
was that the U300 had the block clock and the card
clock wired to the same clock tap ...
The equivalent patch today would also call
amba_pclk_disable() when the card was inactive.

Thus we also got rid of all the switching leaks in the PL180
logic. (Containing two big state machines for example.)

It was an interesting comparison to just enable PwrSave
(bit 9) instead, and disable the other clock logic.

It turned out that this saving was significantly bigger when
gating the entire PrimeCell than the savings for just gating
the clock out to the card itself with bit 9.

But at this time I didn't have a card in the slot, so as to
eliminate the power consumed in the card (assuming
this would drown the overall current consumption).

So I have second thoughts about this. The experiment
was not testing the PwrSave bit with a card inserted, this
is the wrong thing to do. To determine if that bit is a good
thing to turn on, it needs to be tested with a card in the
slot.

The only really useful information is that the switching
logic inside the PL180 synthesized IP-core consumes
circa 200uA, so it could be useful to gate it at times.

Anyone wants to re-do the measurements?

Yours,
Linus Walleij
