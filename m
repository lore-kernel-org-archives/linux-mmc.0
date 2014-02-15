From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Sat, 15 Feb 2014 20:52:00 +0000
Message-ID: <20140215205159.GL30257@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <1580658.FIe4en5bEU@wuerfel> <52FF6A16.5080201@gmail.com> <1528854.BAQRr94nzx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:37520 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753847AbaBOUwO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Feb 2014 15:52:14 -0500
Content-Disposition: inline
In-Reply-To: <1528854.BAQRr94nzx@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Sat, Feb 15, 2014 at 05:21:11PM +0100, Arnd Bergmann wrote:
> On Saturday 15 February 2014 14:22:30 Tomasz Figa wrote:
> > On 15.02.2014 14:09, Arnd Bergmann wrote:
> >
> > > For spi-mode SDIO devices I'm assuming it's similar, except that
> > > you'd describe the actual SDIO device in the board info rather than
> > > create a fake SDIO controller. Still not discoverable unless I'm
> > > missing your point.
> > 
> > I'm not sure if we should assume that SPI = MMC over SPI. I believe 
> > there might be a custom protocol involved as well.
> 
> In case of SD/MMC, you essentially have three separate command sets:
> SPI, MMC and SD, and each of them has multiple versions. MMC and SD
> compatible devices generally also support the SPI command set (IIRC
> it is required,

SPI support is mandatory for SDIO as well.

SDIO has CIS (remember card information structures... like PCMCIA)
which identifies the various different logical functions of the device,
giving class information, vendor information etc.

So... certainly the type of the attached device is discoverable even
on SPI.

> If a device supports both SDIO and SPI, I think a straightforward
> implementation would be to use the exact same command set, but
> you are right that this isn't the only possibility, and the SD/MMC
> shows how they can be slightly different already.

Given that the SPI mode is mandatory for SDIO cards, why would you
also implement another SPI mode with different commands?

> > Stepping aside from SPI, I already gave an example of a WLAN chip that 
> > supports multiple control busses [1]. In addition to the commonly used 
> > SDIO, it supports USB and HSIC as well:
> > 
> > [1] http://www.marvell.com/wireless/assets/marvell_avastar_88w8797.pdf
> > 
> > Moreover, some of Samsung boards use HSIC to communicate with modem 
> > chips, which have exactly the same problem as we're trying to solve here 
> > - they need to be powered on to be discovered.
> 
> Thanks, this definitely makes a good example. I see that it also
> supports SPI mode for SDIO as mentioned in your link.

Well, USB is another discoverable bus.  As HSIC is a derivative of USB,
I'd be surprised if it weren't discoverable there too.

So, out of everything identified so far, we have no undiscoverable buses.

> Agreed. Putting the same chip on USB or HSIC has the exact same
> requirements, since we also have a discoverable bus, but actually
> finding the device likely involves some power-on sequencing before
> the bus controller can find it.

That's partly the nature of integrating something onto a board where you
want maximal power savings.  It's basically that dreaded word which
software people seem to hate: "embedded".

> * Arnd's proposal (change bus code to probe nonstandard devices
>   from DT if we can't easily detect them):
>   + Matches what we already do for PCI (at least on powerpc)
>     and AMBA/Primecell devices: If a device can't be probed
>     using the standard method, we treat it as nondiscoverable
>     and describe it using DT.
>   + Devices can have arbitrary complex requirements without
>     impacting the core, since all code is contained in the
>     driver for the nonstandard device.
>   + Properties that are required for probing and runtime
>     configuration only have to be set once (e.g. you may
>     need clk_get() for probing and clk_set_rate() for
>     runtime-pm).
>   + Devices that have alternative bus interfaces like 88w8797
>     can implement the power-on code in a central place per
>     driver, and can reuse the code they have for nondiscoverable
>     buses on the buses that are normally discoverable but
>     broken here.
>   - Still need to modify each subsystem to have alternate
>     ways of probing, and match up devices later.
>   - Has to be implemented in each driver that needs it, making
>     it harder to share code for drivers with the same need
>     (e.g. every device that just needs an external reset
>     trigger).

 - requires different DT if the chip is changed, which causes problems
   for users to identify which out of zillions of DT files they should
   use for their exact platform.
 - have to work out how to match up the fake device with a probed device
   when it becomes available: existing SDIO drivers all assume that the
   card has been through a fairly complex initialisation sequence already.
 - multi-function SDIO is much harder to deal with since you have mutliple
   drivers involved, and the SDIO device as a whole needs initialisation
   before anyone can drive it.
 - adds complexity to the SDIO drivers; they would have to know whether
   they're embedded or on a plug-in card.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
