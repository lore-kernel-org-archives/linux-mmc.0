From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Sat, 24 May 2014 12:06:30 +0200
Message-ID: <53806F26.6050706@redhat.com>
References: <537DC832.3020006@redhat.com> <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com> <537DE1AA.5050606@redhat.com> <537E31F7.1030505@gmail.com> <537F1148.3010102@redhat.com> <20140523112239.GB12304@sirena.org.uk> <537F3610.3050104@redhat.com> <20140523162718.GE22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60853 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbaEXKH0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 May 2014 06:07:26 -0400
In-Reply-To: <20140523162718.GE22111@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>

Hi,

On 05/23/2014 06:27 PM, Mark Brown wrote:
> On Fri, May 23, 2014 at 01:50:40PM +0200, Hans de Goede wrote:
>> On 05/23/2014 01:22 PM, Mark Brown wrote:
> 
>>> Would it not be better to have this be something in the driver struct
>>> rather than in the device tree?  Putting a compatible in there would be
>>> encoding details of the Linux implementation in the DT which doesn't
>>> seem right especially since these are details we're thinking of changing
>>> later on.
> 
>> The compatible is not a Linux specific thing, it is a marking saying
>> that something needs to take care of enabling the clks (and whatever
>> else we will make part of the binding for this compatible), before
>> scanning the mmc bus.
> 
> We could just say that the mere presence of a child node with the right
> properties is sufficient to trigger the bus to do the startup?

Yes, except that most involved property names are standardized, ie clocks,
and we want to be able to opt out of the KISS mmc core code for
(future) complex power on sequences.

> 
>>> Something like have the driver set flags saying if it wants
>>> to do complicated things.
> 
>> Chicken <-> egg, we won't know which driver to use before we've probed
>> the mmc bus, and we cannot probe the bus before enabling the clks, etc.
> 
> If the device is sufficiently complicated to need a special power up
> sequence I'd expect we'd be able to have a compatible string which would
> provide enough information for us to figure things out.

Hmm, so what you're suggesting is indeed more of an opt out then my initial
opt-in to KISS powerup idea. So to be clear what you're suggesting is:

mmc core walks host mmc-child nodes. Loads drivers based on compatibles
there. The checks a flag field in the driver to see if the driver wants to
opt-out of the KISS powerup code. The problem with this is that it won't
work reliable with modules, think the mmc probe being done from the ramdisk,
and the driver in question only being available from the rootfs. I really
believe that using opt-in with a compatible such as simple-sdio-powerup
is by far the safest thing to do, and as an added advantage we don't need
to worry about how to deal with the future complex power on cases at all,
we leave all the room in the world for various future scenarios. since as
soon as the simple-sdio-powerup compatible is not there the mmc core will
behave as it does today.


> 
>>>> FWIW if we ever get truely complex cases I think modeling the
>>>> power-up hardware as a pmic platform device is not a bad idea,
>>>> we would then need to have a generic mmc-host pmic property, which
>>>> would be used both to do the initial powerup before scanning, as
>>>> well as for the sdio device driver to get a handle to the pmic,
>>>> for run time power-management (if desired).
> 
>>> I don't know if this will ever apply to SDIO but with other buses the
>>> complicated bits come when the driver wants to take over some of the
>>> power management do things like turn some of the supplies or clocks on
>>> and off independently at runtime for low power modes.
> 
>> Hmm, good point in that case actually having these things in the
>> child node makes most sense, because then the driver can find them
>> their. Note that the mmc core enabling things does not mean that
>> the driver cannot later disable them if needed.
> 
> Right, that's good idea for solving the problem - the child device can
> either share the reference with the bus or have some way of getting at
> the object the bus requested depending on what's sensible.  Only
> potentia complication I can think of with that approach is a device with
> multiple bus interfaces (I'm mainly thinking of SDIO vs SPI) but it
> doesn't seem to hard to deal with that in the bus adaption layers of the
> drivers.

I don't think there is a need to share references, ie for clks multiple drivers
can hold a reference and they can be enabled / disabled multiple times, only
when the last enable is countered by a disable the clock will really be disabled,
iow this should all just work. Anyways these are all implementation details
lets focus on the bindings bit first.

Regards,

Hans




