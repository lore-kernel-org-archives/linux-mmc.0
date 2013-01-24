From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Thu, 24 Jan 2013 14:16:59 +0100
Message-ID: <CAPDyKFqZjWdfYheQB+1YDnj=fZk4QwASP0Fb3i+zqP5WXFWd2w@mail.gmail.com>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
	<CAPDyKFpOd3abjoYyrOeV=i+VRwUqisMwJe8_33j0G7zcd5r6Eg@mail.gmail.com>
	<1359030968.26878.46.camel@hornet>
	<CAPDyKFpc3GZd0Zr4TcGBX_cobJLXFJzr+LAO5Z6TEJu2_26ekA@mail.gmail.com>
	<20130124125907.GV23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:52031 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab3AXNRB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jan 2013 08:17:01 -0500
Received: by mail-lb0-f178.google.com with SMTP id n1so4680187lba.37
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jan 2013 05:16:59 -0800 (PST)
In-Reply-To: <20130124125907.GV23505@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Pawel Moll <pawel.moll@arm.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On 24 January 2013 13:59, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 24, 2013 at 01:48:39PM +0100, Ulf Hansson wrote:
>> Correct. ST-variants requires to use the POWER register to gate the
>> clock. So if this is not the case for VE you don't need to bother,
>> otherwise you should set "pwrreg_clkgate" for this variant as well.
>
> The ARM variant does gate the clock as well.  It's all described in the
> TRM.
>
> When power is turned off, the clock and power is removed from the card.
> When power is applied, there is a defined sequence that must be gone
> through (which is partly handled by the device and partly by the software)
> through the OFF->POWER UP->POWER ON sequence.
>
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

For ST-variants it is clearly stated in specs that the power register
needs to be used to gate the clock. However for these variants the
power register is not used for controlling the power to the card, that
is handled by external regulators. In that sense the MMCI_POWER
register does not seems like the proper name at all for this register.
So, likely this is some legacy from the primecell. Just a guess
though. :-)

Kind regards
Ulf Hansson
