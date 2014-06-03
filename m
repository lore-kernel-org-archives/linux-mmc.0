From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Tue, 3 Jun 2014 12:57:52 +0200
Message-ID: <CAPDyKFo_xHSKzoeKJb5sh+O3cMGsnqx_yVivpw8Tk72whPHGLQ@mail.gmail.com>
References: <53824294.1090609@redhat.com>
	<20140526103807.GV22111@sirena.org.uk>
	<538321AB.4050006@redhat.com>
	<20140526142225.GF22111@sirena.org.uk>
	<538356DA.7090302@redhat.com>
	<CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
	<53838023.2080807@redhat.com>
	<CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
	<20140527175326.GZ12304@sirena.org.uk>
	<CAPDyKFqCwSfnbXJffQeMUMLEgZPcqjEMhbTXxi4HKOKqExQ70g@mail.gmail.com>
	<20140528110351.GI12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:52403 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbaFCK5x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jun 2014 06:57:53 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so12751922qga.14
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2014 03:57:53 -0700 (PDT)
In-Reply-To: <20140528110351.GI12304@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>

On 28 May 2014 13:03, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 28, 2014 at 10:19:11AM +0200, Ulf Hansson wrote:
>> On 27 May 2014 19:53, Mark Brown <broonie@kernel.org> wrote:
>
>> > This then either conflicts with cases where we need to describe the
>> > actual contents of the slot with a compatible string or means that the
>> > SDIO driver needs to handle powerup sequencing since we should be
>> > binding to the first compatible we find.  If the host controller driver
>> > and/or subsystem is going to deal with the powering up it's not clear
>> > that it specifically needs to be the compatible property that's used
>> > to determine the powerup method, it could just be a boolean or a
>> > 'power-method = blah' property (where blah is one of a series of strings
>> > defining methods).  Alternatively we could have separate nodes for the
>> > slot and SDIO device but that feels meh.  What's the hard requirement
>> > for it to specifically be a compatible property?
>
>> Since the sdio bus is a discoverable bus, we must leave the "SDIO card
>> device id" outside the information of the DT child node. Instead the
>> "SDIO card device id" will be fetched once the card has been properly
>> powered and initialized. From sdio bus' ->match(), the "SDIO func
>> driver id" will be matched with the "SDIO card device id".
>
>> What we need to describe in the child node is only what "powerup
>> driver" to use (an obviously it's resources). I don't see why there
>> should be a conflict in using a compatible property, but I might be
>> missing your point.
>
> I wouldn't assume that the SDIO bus will always be accurately
> discoverable - hardware engineers can always repurpose things for other
> purposes.

Right! Though I think we should be able to handle most if these issues
through the mmc quirks.

>
>> > There's also the need for the SDIO device to be able to get at the
>> > resources provided and actively work with them at runtime if it wants to
>> > manage things more actively (partial poweroff for low power states or
>> > managing clock rates for example).
>
>> Yes, that's is also a reason to why I thought it would make sense to
>> have a "powerup driver". Typically this driver should support runtime
>> PM to handle these kind of fine grained power management.
>
> No, runtime PM isn't really fine grained - I'm talking about things
> like starting and stopping individual resources or configuring them.

Are you saying that you have several levels of quiescent mode of your
external chip?

>
>> The SDIO func driver will have access (through the struct
>> mmc_card|host) to the "powerup driver's" struct device, and can use
>> pm_runtime_get|put() for it, to tell the "powerup driver" when it may
>> go into power save state.
>
>> This kind of fine grained power management is not related directly to
>> the SDIO specification, and should not be a part of the mmc core in my
>> opinion.
>
>> If we don't have a compatible string in the DT child node of the mmc
>> host, but just a DT property - is there a way to achieve the above
>> anyway?
>
> I don't see any relationship between having compatible strings and the
> ability to achieve things like that to be honest.  Having compatible
> strings has no real impact on what we can implement, the power driver
> you're talking about can easily be library code or a feature of part of
> the code that already exists - so long as we know what hardware is there
> it's up to us how we interpret that.

Agree.

I am a bit puzzled of how such library should look like, but I suppose
we need to be able to go to different power states through it.
Typically the library may be invoked both from the mmc core to do
power up/off and from the sdio func driver to handle power save.

Does it make sense to you as well?

Kind regards
Ulf Hansson
