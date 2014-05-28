From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Wed, 28 May 2014 10:19:11 +0200
Message-ID: <CAPDyKFqCwSfnbXJffQeMUMLEgZPcqjEMhbTXxi4HKOKqExQ70g@mail.gmail.com>
References: <53806F26.6050706@redhat.com>
	<20140525123452.GS22111@sirena.org.uk>
	<53824294.1090609@redhat.com>
	<20140526103807.GV22111@sirena.org.uk>
	<538321AB.4050006@redhat.com>
	<20140526142225.GF22111@sirena.org.uk>
	<538356DA.7090302@redhat.com>
	<CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
	<53838023.2080807@redhat.com>
	<CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
	<20140527175326.GZ12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:51545 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbaE1ITM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 04:19:12 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so16970622qgf.31
        for <linux-mmc@vger.kernel.org>; Wed, 28 May 2014 01:19:11 -0700 (PDT)
In-Reply-To: <20140527175326.GZ12304@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>

On 27 May 2014 19:53, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 27, 2014 at 03:50:33PM +0200, Ulf Hansson wrote:
>
>> To describe the HW in DT, the embedded SDIO card (actually it could be
>> any type of embedded card) shall be modelled as a child node to the
>> mmc host in DT. Similar to what you have proposed, but with the
>> difference that the child node _must_ contain a DT compatible string,
>> which means a "powerup-driver" can be probed.
>
>> Yes, I understand we might need one DT compatible string per board,
>> but that's because we need to model the hardware - and it differs.
>
>> To clarify my view, we do need a "powerup-driver" and the primary
>> reason is that we must not model "power up sequences" within DT.
>> Typically I see the "powerup-driver" as a simple platform driver
>> attached to the platform bus, but I that could of course differ.
>
> This then either conflicts with cases where we need to describe the
> actual contents of the slot with a compatible string or means that the
> SDIO driver needs to handle powerup sequencing since we should be
> binding to the first compatible we find.  If the host controller driver
> and/or subsystem is going to deal with the powering up it's not clear
> that it specifically needs to be the compatible property that's used
> to determine the powerup method, it could just be a boolean or a
> 'power-method = blah' property (where blah is one of a series of strings
> defining methods).  Alternatively we could have separate nodes for the
> slot and SDIO device but that feels meh.  What's the hard requirement
> for it to specifically be a compatible property?

Since the sdio bus is a discoverable bus, we must leave the "SDIO card
device id" outside the information of the DT child node. Instead the
"SDIO card device id" will be fetched once the card has been properly
powered and initialized. From sdio bus' ->match(), the "SDIO func
driver id" will be matched with the "SDIO card device id".

What we need to describe in the child node is only what "powerup
driver" to use (an obviously it's resources). I don't see why there
should be a conflict in using a compatible property, but I might be
missing your point.

>
>> The slot will be the first level of child node under the mmc host,
>> then each slot may have a child node which models the embedded card.
>> But, let's leave that discussion for now. :-)
>
> OK, that's the separate node for the slot and device.
>
>> Powerup driver's ->probe():
>> Typically the "powerup driver" will need to register a few callback
>> functions towards the mmc core. Typically at mmc_of_parse(), those
>> callbacks will have to be connected to a particular mmc host.
>
>> I would like to see three different callbacks, mirroring each of the
>> mmc_ios power_mode states MMC_POWER_OFF|UP|ON.
>
>> The power up sequence, performed by the mmc core:
>> The mmc_power_up|off functions, will invoke the registered "powerup
>> driver's" callbacks if they exists for the particular host it operates
>> on.
>
> There's also the need for the SDIO device to be able to get at the
> resources provided and actively work with them at runtime if it wants to
> manage things more actively (partial poweroff for low power states or
> managing clock rates for example).

Yes, that's is also a reason to why I thought it would make sense to
have a "powerup driver". Typically this driver should support runtime
PM to handle these kind of fine grained power management.

The SDIO func driver will have access (through the struct
mmc_card|host) to the "powerup driver's" struct device, and can use
pm_runtime_get|put() for it, to tell the "powerup driver" when it may
go into power save state.

This kind of fine grained power management is not related directly to
the SDIO specification, and should not be a part of the mmc core in my
opinion.

If we don't have a compatible string in the DT child node of the mmc
host, but just a DT property - is there a way to achieve the above
anyway?

Kind regards
Ulf Hansson
