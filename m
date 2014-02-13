From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Thu, 13 Feb 2014 14:41:06 +0000
Message-ID: <20140213144106.GW26684@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <201401281148.10670.arnd@arndb.de> <20140213104248.GU26684@n2100.arm.linux.org.uk> <2874395.Ul86gYA57i@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35042 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751089AbaBMOlT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2014 09:41:19 -0500
Content-Disposition: inline
In-Reply-To: <2874395.Ul86gYA57i@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Thu, Feb 13, 2014 at 01:48:55PM +0100, Arnd Bergmann wrote:
> On Thursday 13 February 2014 10:42:48 Russell King - ARM Linux wrote:
> > 
> > What if we have a platform where things subtly change, like for instance,
> > the wiring on the SD slot to fix a problem with UHS-1 cards, which means
> > you don't have UHS-1 support for some platforms but do for others.
> > 
> > What if you have a platform which uses a brcm4329 chip for Wifi, but then
> > later in the production run switch to using a different Wifi chipset?
> 
> As far as I can tell, the power sequencing is normally really
> dependent on the device. If someone has an on-board brcm4329
> that requires a specific set of clocks, resets, voltages etc
> to be routed to the chip and enabled in the correct order to
> allow probing, it seems unlikely that changing the wifi chipset
> to something else would keep the exact same requirements.

That's your assertion - however, do we /know/ whether there's a situation
where Olof's solution doesn't work because the sequencing is wrong?

I see nothing unreasonable about the sequence:

1. hold reset at low level
2. apply power
3. turn clock on
4. apply reset
5. release reset

The points being:
* never set a signal to a high level before power is applied, otherwise
  we can end up supplying power through that signal (which may cause
  damage.)  That goes for the reset and clock.
* devices normally want clocks running to complete their reset sequencing.

This is actually the sequence which MMC/SD cards do (except without the
reset) anyway - it's spec'd that on the MMC/SD bus, power will be applied
and will be stable before the clock signal is applied, and then the clock
signal runs for a certain number of cycles before you even start talking
to the card.

That all said, we do have the problem that once we decide, we need to
support it because it becomes part of DT - this is one of the things I
hate about DT, it requires over-design.  Your point is "Olof's solution
may break if we have a device which requires a different sequence" which
is a valid point which has to be considered from the DT perspective and
addressed whether or not we actually have a device which meets that
criteria.  I don't see an easy solution to this.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
