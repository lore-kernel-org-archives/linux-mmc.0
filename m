From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Sat, 15 Feb 2014 17:21:11 +0100
Message-ID: <1528854.BAQRr94nzx@wuerfel>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <1580658.FIe4en5bEU@wuerfel> <52FF6A16.5080201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60462 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbaBOQWI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Feb 2014 11:22:08 -0500
In-Reply-To: <52FF6A16.5080201@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Saturday 15 February 2014 14:22:30 Tomasz Figa wrote:
> On 15.02.2014 14:09, Arnd Bergmann wrote:
>
> > For spi-mode SDIO devices I'm assuming it's similar, except that
> > you'd describe the actual SDIO device in the board info rather than
> > create a fake SDIO controller. Still not discoverable unless I'm
> > missing your point.
> 
> I'm not sure if we should assume that SPI = MMC over SPI. I believe 
> there might be a custom protocol involved as well.

In case of SD/MMC, you essentially have three separate command sets:
SPI, MMC and SD, and each of them has multiple versions. MMC and SD
compatible devices generally also support the SPI command set (IIRC
it is required, but I'm not completely sure), and on the bus 
the main difference seems to be that you have only 1-bit serial
signalling, while MMC also supports 4-bit and 8-bit parallel
transmission.

If a device supports both SDIO and SPI, I think a straightforward
implementation would be to use the exact same command set, but
you are right that this isn't the only possibility, and the SD/MMC
shows how they can be slightly different already.

> Stepping aside from SPI, I already gave an example of a WLAN chip that 
> supports multiple control busses [1]. In addition to the commonly used 
> SDIO, it supports USB and HSIC as well:
> 
> [1] http://www.marvell.com/wireless/assets/marvell_avastar_88w8797.pdf
> 
> Moreover, some of Samsung boards use HSIC to communicate with modem 
> chips, which have exactly the same problem as we're trying to solve here 
> - they need to be powered on to be discovered.

Thanks, this definitely makes a good example. I see that it also
supports SPI mode for SDIO as mentioned in your link.

> So I really don't think we should be limiting this to MMC alone by any 
> means.

Agreed. Putting the same chip on USB or HSIC has the exact same
requirements, since we also have a discoverable bus, but actually
finding the device likely involves some power-on sequencing before
the bus controller can find it.

> Now I don't really know why we want that badly to represent low level 
> control parts of such devices as children of control buses of their 
> enumerable parts. Could you tell me what benefits it has to justify the 
> added complexity of having to instantiate fake devices in respective 
> devices, even though they can be fully detected later?

It's not that I "badly want" to do it one way or another, I'm just
trying to find arguments either way, since as Russell points out
whatever we decide to do in DT is what we're stuck with for the
long term future.

Let me try to summarize what we found so far:

* Common aspects:
  * we need a way to attach properties for run-time configuration
    to devices on discoverable buses when the configuration
    is not discoverable. In your 88w8797 example, this includes
    the use of the GPIO pins, runtime power management (clocks,
    regulators) and the attached codecs.
  * We may want to connect the same device to either a discoverable
    or a nondiscoverable bus, ideally using the same binding and
    sharing code whereever possible.

* Olof's proposal (add properties or a child node to the host
  controller node with just power-on sequencing information):
  + We only need one implementation for each bus, possibly shared
    across buses to some degree, and can handle lots of devices
    without having to touch their individual drivers.
  + A logical extension of things we already do on SD cards
    (CD/WP GPIOs, external clocks and voltages supplied to
    standard compliant devices as part of the normal probing)
  - The shared code may get rather complex to deal with all
    possible corner cases we run into over the years.
  - Somewhat harder to do if you have to attach the power
    information to a device node for a USB hub port, rather
    than an SDIO controller that only has one slave device.

* Arnd's proposal (change bus code to probe nonstandard devices
  from DT if we can't easily detect them):
  + Matches what we already do for PCI (at least on powerpc)
    and AMBA/Primecell devices: If a device can't be probed
    using the standard method, we treat it as nondiscoverable
    and describe it using DT.
  + Devices can have arbitrary complex requirements without
    impacting the core, since all code is contained in the
    driver for the nonstandard device.
  + Properties that are required for probing and runtime
    configuration only have to be set once (e.g. you may
    need clk_get() for probing and clk_set_rate() for
    runtime-pm).
  + Devices that have alternative bus interfaces like 88w8797
    can implement the power-on code in a central place per
    driver, and can reuse the code they have for nondiscoverable
    buses on the buses that are normally discoverable but
    broken here.
  - Still need to modify each subsystem to have alternate
    ways of probing, and match up devices later.
  - Has to be implemented in each driver that needs it, making
    it harder to share code for drivers with the same need
    (e.g. every device that just needs an external reset
    trigger).

	Arnd
