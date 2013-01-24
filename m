From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Thu, 24 Jan 2013 12:36:08 +0000
Message-ID: <1359030968.26878.46.camel@hornet>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
	 <CAPDyKFpOd3abjoYyrOeV=i+VRwUqisMwJe8_33j0G7zcd5r6Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44506 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab3AXMgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jan 2013 07:36:12 -0500
In-Reply-To: <CAPDyKFpOd3abjoYyrOeV=i+VRwUqisMwJe8_33j0G7zcd5r6Eg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hello Ulf,

On Fri, 2012-12-21 at 11:05 +0000, Ulf Hansson wrote:
> On 14 December 2012 16:38, Pawel Moll <pawel.moll@arm.com> wrote:
> > The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/208
> > and v116/216) contains a modified version of the PL180 MMCI, with
> > PeriphID Configuration value changed to 0x2.
> >
> > This version adds an optional "hardware flow control" feature. When
> > enabled MMC card clock will be automatically disabled when FIFO is
> > about to over/underflow and re-enabled once the host retrieved some
> > data. This makes the controller immune to over/underrun errors caused
> > by big interrupt handling latencies.
> >
> > This patch adds relevant device variant in the driver.
> >
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>

> So enabling this in the variant will also effect how the clock is
> being set/gated when the clock freq is 0.
> 
> Please have a look at "mmc: mmci: Gate the clock when freq is 0", a
> patch I sent out as of 12 dec.
> That patch is using the power register to gate the clock. Will that
> work with this new version of the PL180 as well? If not, that patch
> must be reworked.

I'm not quite sure what you meant here, but I see that v2 of your patch
does whatever it is supposed to do to ST variants only, so I guess your
objections don't apply any more?

Cheers!

Pawel


