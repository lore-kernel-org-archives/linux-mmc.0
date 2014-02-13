From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Thu, 13 Feb 2014 17:13:14 +0100
Message-ID: <1626419.Ta3A7zgHIt@wuerfel>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <2874395.Ul86gYA57i@wuerfel> <20140213144106.GW26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52961 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbaBMQOG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2014 11:14:06 -0500
In-Reply-To: <20140213144106.GW26684@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Thursday 13 February 2014 14:41:06 Russell King - ARM Linux wrote:
> On Thu, Feb 13, 2014 at 01:48:55PM +0100, Arnd Bergmann wrote:
> > On Thursday 13 February 2014 10:42:48 Russell King - ARM Linux wrote:
> > > 
> > > What if we have a platform where things subtly change, like for instance,
> > > the wiring on the SD slot to fix a problem with UHS-1 cards, which means
> > > you don't have UHS-1 support for some platforms but do for others.
> > > 
> > > What if you have a platform which uses a brcm4329 chip for Wifi, but then
> > > later in the production run switch to using a different Wifi chipset?
> > 
> > As far as I can tell, the power sequencing is normally really
> > dependent on the device. If someone has an on-board brcm4329
> > that requires a specific set of clocks, resets, voltages etc
> > to be routed to the chip and enabled in the correct order to
> > allow probing, it seems unlikely that changing the wifi chipset
> > to something else would keep the exact same requirements.
> 
> That's your assertion - however, do we /know/ whether there's a situation
> where Olof's solution doesn't work because the sequencing is wrong?
> 
> I see nothing unreasonable about the sequence:
> 
> 1. hold reset at low level
> 2. apply power
> 3. turn clock on
> 4. apply reset
> 5. release reset

I was thinking of cases where you may need a more complex sequence:
- wait for a device specific time between some of the steps
  (the cw1200 driver seems to need that, but we could probably
   get away with waiting long enough for everyone)
- have more than one of each, and turn them on in the right order.
  cw1200 seems to need two voltages, two gpio resets ("reset"
  and "powerup").
  Again, we could specify a larger number of clocks that can be
  provided to the host, but if we make it a device specific
  property, we already know how many we need.

I can't think of anything that would require significant changes
to the procedure though, just refinements as we run into problems.

> The points being:
> * never set a signal to a high level before power is applied, otherwise
>   we can end up supplying power through that signal (which may cause
>   damage.)  That goes for the reset and clock.
> * devices normally want clocks running to complete their reset sequencing.
> 
> This is actually the sequence which MMC/SD cards do (except without the
> reset) anyway - it's spec'd that on the MMC/SD bus, power will be applied
> and will be stable before the clock signal is applied, and then the clock
> signal runs for a certain number of cycles before you even start talking
> to the card.

It may be dangerous to refer to the spec, since we are talking
specifically about devices that require something beyond what the
spec says ;-) For instance in SD/MMC cards I'd assume the device clock
to be derived from the bus clock. However we can expect that clock
to work already (any working mmc host driver would provide that),
but we may need to drive the device clock. It still sounds reasonable
to assume that the sequencing is the same as for the bus clock.

> That all said, we do have the problem that once we decide, we need to
> support it because it becomes part of DT - this is one of the things I
> hate about DT, it requires over-design.

Yes, I agree. It is a problem that we have to face all the time.
We have in the past defined bindings of both types, overdesigned
and not thought through enough.

>  Your point is "Olof's solution
> may break if we have a device which requires a different sequence" which
> is a valid point which has to be considered from the DT perspective and
> addressed whether or not we actually have a device which meets that
> criteria.  I don't see an easy solution to this.

I think either one will work. With Olof's suggestion that may mean we
have to keep adding support for increasingly complex cases when we
run into them, or it may all be easy. With my suggestion, we give
more room for function drivers to mess things up, but at least we
can keep the complexity in the places that need them and only need
to change the core once.

Aside from the power-on problem, my suggestion would at the same
time solve the second problem of having a place to stick arbitrary
DT properties for the sdio function. Again looking at the cw1200
example, they may require passing an IRQ descriptor, a MAC address,
the device clock rate, and two flags for things that are not
detectable by looking at the device ID (whether a 5GHz antenna is
connected and something about odd block size transfers).
This is probably the main difference between the two approaches.

	Arnd
