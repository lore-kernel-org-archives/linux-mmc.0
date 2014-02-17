From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Mon, 17 Feb 2014 14:00:43 +0100
Message-ID: <201402171400.43899.arnd@arndb.de>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <1528854.BAQRr94nzx@wuerfel> <20140215205159.GL30257@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61504 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbaBQNBA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2014 08:01:00 -0500
In-Reply-To: <20140215205159.GL30257@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Saturday 15 February 2014, Russell King - ARM Linux wrote:
> On Sat, Feb 15, 2014 at 05:21:11PM +0100, Arnd Bergmann wrote:
> > On Saturday 15 February 2014 14:22:30 Tomasz Figa wrote:
> > > On 15.02.2014 14:09, Arnd Bergmann wrote:
> > >
> > > > For spi-mode SDIO devices I'm assuming it's similar, except that
> > > > you'd describe the actual SDIO device in the board info rather than
> > > > create a fake SDIO controller. Still not discoverable unless I'm
> > > > missing your point.
> > > 
> > > I'm not sure if we should assume that SPI = MMC over SPI. I believe 
> > > there might be a custom protocol involved as well.
> > 
> > In case of SD/MMC, you essentially have three separate command sets:
> > SPI, MMC and SD, and each of them has multiple versions. MMC and SD
> > compatible devices generally also support the SPI command set (IIRC
> > it is required,
> 
> SPI support is mandatory for SDIO as well.
> 
> SDIO has CIS (remember card information structures... like PCMCIA)
> which identifies the various different logical functions of the device,
> giving class information, vendor information etc.
> 
> So... certainly the type of the attached device is discoverable even
> on SPI

But how are SPI SDIO devices used in Linux and described in DT?

If we always use the MMC_SPI host controller driver and only
describe the controller in DT, then you are right, and there is
no difference to the normal SDIO case.

If we just describe it as an SPI device OTOH, the fact that we can
identify it is useless, because we first have to know what it
is before we can ask for its identity.

> > If a device supports both SDIO and SPI, I think a straightforward
> > implementation would be to use the exact same command set, but
> > you are right that this isn't the only possibility, and the SD/MMC
> > shows how they can be slightly different already.
> 
> Given that the SPI mode is mandatory for SDIO cards, why would you
> also implement another SPI mode with different commands?

I don't know why, I was just saying that it's what storage SD cards do.

> > > Stepping aside from SPI, I already gave an example of a WLAN chip that 
> > > supports multiple control busses [1]. In addition to the commonly used 
> > > SDIO, it supports USB and HSIC as well:
> > > 
> > > [1] http://www.marvell.com/wireless/assets/marvell_avastar_88w8797.pdf
> > > 
> > > Moreover, some of Samsung boards use HSIC to communicate with modem 
> > > chips, which have exactly the same problem as we're trying to solve here 
> > > - they need to be powered on to be discovered.
> > 
> > Thanks, this definitely makes a good example. I see that it also
> > supports SPI mode for SDIO as mentioned in your link.
> 
> Well, USB is another discoverable bus.  As HSIC is a derivative of USB,
> I'd be surprised if it weren't discoverable there too.
> 
> So, out of everything identified so far, we have no undiscoverable buses.

The device also lists a high-speed uart interface. While in Linux a
tty line discipline is not exactly the same as a driver, I would
still count it as a nondiscoverable interface.

>  - requires different DT if the chip is changed, which causes problems
>    for users to identify which out of zillions of DT files they should
>    use for their exact platform.

I'm still not buying this argument. Making any changes to the board
design that are visible to software can have this effect.

>  - have to work out how to match up the fake device with a probed device
>    when it becomes available: existing SDIO drivers all assume that the
>    card has been through a fairly complex initialisation sequence already.

This one is an implementation detail. Yes, we have to ensure it works,
but it's not inherently harder that getting the other approach to work.

>  - multi-function SDIO is much harder to deal with since you have mutliple
>    drivers involved, and the SDIO device as a whole needs initialisation
>    before anyone can drive it.

Agreed, this point is a big one that I hadn't considered before.
I agree that my approach isn't ideal for multifunction cards, especially
when you want to be able to load function drivers individually or have
only one of them in use. It can probably work fine for things like calling
clk_get() where you can simply describe the clock in each function device
node separately, but I don't see how I'd easily use a 'reset' line
that has to be triggered for the first function driver that gets loaded
but must not be triggered again for the second one :(

>  - adds complexity to the SDIO drivers; they would have to know whether
>    they're embedded or on a plug-in card.

How so? If a device can be a plug-in card, I would assume that it is
actually discoverable without a special power-on sequence, while a device
that needs this can't be used standalone.

	Arnd
