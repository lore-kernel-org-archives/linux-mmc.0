From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Thu, 24 Jan 2013 12:59:07 +0000
Message-ID: <20130124125907.GV23505@n2100.arm.linux.org.uk>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com> <CAPDyKFpOd3abjoYyrOeV=i+VRwUqisMwJe8_33j0G7zcd5r6Eg@mail.gmail.com> <1359030968.26878.46.camel@hornet> <CAPDyKFpc3GZd0Zr4TcGBX_cobJLXFJzr+LAO5Z6TEJu2_26ekA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54083 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab3AXM7T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jan 2013 07:59:19 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpc3GZd0Zr4TcGBX_cobJLXFJzr+LAO5Z6TEJu2_26ekA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On Thu, Jan 24, 2013 at 01:48:39PM +0100, Ulf Hansson wrote:
> Correct. ST-variants requires to use the POWER register to gate the
> clock. So if this is not the case for VE you don't need to bother,
> otherwise you should set "pwrreg_clkgate" for this variant as well.

The ARM variant does gate the clock as well.  It's all described in the
TRM.

When power is turned off, the clock and power is removed from the card.
When power is applied, there is a defined sequence that must be gone
through (which is partly handled by the device and partly by the software)
through the OFF->POWER UP->POWER ON sequence.

The clock can be masked independently too via the clock enable bit in
the clock register.

However, it's interesting to note: experiments that Linus did with having
the primecell automatically masking the clock to the card did not prove
worthwhile (see the comment in the code).  We seem to be heading towards
doing this in software and people suggesting it is worthwhile...  Why is
this?

If the hardware can gate the clock and it doesn't produce the power
savings we expect, how does then gating the clock via software then
become worthwhile?  It doesn't make sense.
