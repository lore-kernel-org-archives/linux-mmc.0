From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Wed, 28 May 2014 10:43:30 +0200
Message-ID: <CAPDyKFoPvFOoYvpwNZTxPa_tox5-E2c4O6EA1ZEH4fZowU0Mww@mail.gmail.com>
References: <20140525123452.GS22111@sirena.org.uk>
	<53824294.1090609@redhat.com>
	<20140526103807.GV22111@sirena.org.uk>
	<538321AB.4050006@redhat.com>
	<20140526142225.GF22111@sirena.org.uk>
	<538356DA.7090302@redhat.com>
	<CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
	<53838023.2080807@redhat.com>
	<CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
	<20140527175326.GZ12304@sirena.org.uk>
	<20140527185535.GB27420@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:47114 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbaE1Inc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 04:43:32 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so16659985qge.40
        for <linux-mmc@vger.kernel.org>; Wed, 28 May 2014 01:43:30 -0700 (PDT)
In-Reply-To: <20140527185535.GB27420@quad.lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Mark Brown <broonie@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>

On 27 May 2014 20:55, Olof Johansson <olof@lixom.net> wrote:
> On Tue, May 27, 2014 at 06:53:26PM +0100, Mark Brown wrote:
>> On Tue, May 27, 2014 at 03:50:33PM +0200, Ulf Hansson wrote:
>>
>> > To describe the HW in DT, the embedded SDIO card (actually it could be
>> > any type of embedded card) shall be modelled as a child node to the
>> > mmc host in DT. Similar to what you have proposed, but with the
>> > difference that the child node _must_ contain a DT compatible string,
>> > which means a "powerup-driver" can be probed.
>>
>> > Yes, I understand we might need one DT compatible string per board,
>> > but that's because we need to model the hardware - and it differs.
>>
>> > To clarify my view, we do need a "powerup-driver" and the primary
>> > reason is that we must not model "power up sequences" within DT.
>> > Typically I see the "powerup-driver" as a simple platform driver
>> > attached to the platform bus, but I that could of course differ.
>>
>> This then either conflicts with cases where we need to describe the
>> actual contents of the slot with a compatible string or means that the
>> SDIO driver needs to handle powerup sequencing since we should be
>> binding to the first compatible we find.  If the host controller driver
>> and/or subsystem is going to deal with the powering up it's not clear
>> that it specifically needs to be the compatible property that's used
>> to determine the powerup method, it could just be a boolean or a
>> 'power-method = blah' property (where blah is one of a series of strings
>> defining methods).  Alternatively we could have separate nodes for the
>> slot and SDIO device but that feels meh.  What's the hard requirement
>> for it to specifically be a compatible property?
>
> +1. Just because we have a subnode in a device tree, we don't have to have
> a driver bind against it. The MMC core code could go down into the subnodes,
> find a "power-method = <foo>" property and go ahead and parse the rest of it.
> There's no requirement that we do this through the Linux driver model of
> probe(), etc.

Using "power-method" might work.

It's would simplify things quite a bit regarding the synchronization
point, in the mmc_of_parse().

But... does it prevent us from handling fine grained power management
through runtime PM? See more comments below.

>
>> > The slot will be the first level of child node under the mmc host,
>> > then each slot may have a child node which models the embedded card.
>> > But, let's leave that discussion for now. :-)
>>
>> OK, that's the separate node for the slot and device.
>>
>> > Powerup driver's ->probe():
>> > Typically the "powerup driver" will need to register a few callback
>> > functions towards the mmc core. Typically at mmc_of_parse(), those
>> > callbacks will have to be connected to a particular mmc host.
>>
>> > I would like to see three different callbacks, mirroring each of the
>> > mmc_ios power_mode states MMC_POWER_OFF|UP|ON.
>>
>> > The power up sequence, performed by the mmc core:
>> > The mmc_power_up|off functions, will invoke the registered "powerup
>> > driver's" callbacks if they exists for the particular host it operates
>> > on.
>>
>> There's also the need for the SDIO device to be able to get at the
>> resources provided and actively work with them at runtime if it wants to
>> manage things more actively (partial poweroff for low power states or
>> managing clock rates for example).
>
> Again, I think it gets overly complicated by using a full driver for the
> power management. Abstracted out into something separate and scalable
> as number of devices grow? Sure, definitely. As a driver? Not convinced.

To handle the fine grained power management, runtime PM is for sure
what we should use here. So, then we need a struct device to be
created to represent the power-method.

Now, if we don't implement this through a "powerup driver" which may
have runtime PM callbacks set up - how do we handle this?

I suppose we could register a specific "mmc power bus", and create/add
the struct device representing the power-method to it. Would that
work?

Kind regards
Ulf Hansson
