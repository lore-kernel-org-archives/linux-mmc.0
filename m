From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Mon, 9 Jun 2014 16:07:54 +0200
Message-ID: <CAPDyKFo+OPDj0Bs_1JOgdqFAOwfcsUSV5=tijCVgRxE5s2vrbQ@mail.gmail.com>
References: <538321AB.4050006@redhat.com>
	<20140526142225.GF22111@sirena.org.uk>
	<538356DA.7090302@redhat.com>
	<CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
	<53838023.2080807@redhat.com>
	<CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
	<20140527175326.GZ12304@sirena.org.uk>
	<CAPDyKFqCwSfnbXJffQeMUMLEgZPcqjEMhbTXxi4HKOKqExQ70g@mail.gmail.com>
	<20140528110351.GI12304@sirena.org.uk>
	<CAPDyKFo_xHSKzoeKJb5sh+O3cMGsnqx_yVivpw8Tk72whPHGLQ@mail.gmail.com>
	<20140604155529.GP2520@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:38092 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbaFIOH4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jun 2014 10:07:56 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so7831632qab.18
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jun 2014 07:07:55 -0700 (PDT)
In-Reply-To: <20140604155529.GP2520@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Tomasz Figa <tomasz.figa@gmail.com>, Arend van Spriel <arend@broadcom.com>, Olof Johansson <olof@lixom.net>
Cc: Chen-Yu Tsai <wens@csie.org>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>

On 4 June 2014 17:55, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 03, 2014 at 12:57:52PM +0200, Ulf Hansson wrote:
>> On 28 May 2014 13:03, Mark Brown <broonie@kernel.org> wrote:
>
>> > No, runtime PM isn't really fine grained - I'm talking about things
>> > like starting and stopping individual resources or configuring them.
>
>> Are you saying that you have several levels of quiescent mode of your
>> external chip?
>
> Partly, but also there can be active modes that don't use all
> functionality and hence can leave some of the inputs powered down (for
> example if a reference clock is used for some feature that isn't used
> all the time then that reference clock may be able to be powered down
> when the function is not in use).  The device isn't suspended but it can
> do without some of the resources it has.
>
>> I am a bit puzzled of how such library should look like, but I suppose
>> we need to be able to go to different power states through it.
>> Typically the library may be invoked both from the mmc core to do
>> power up/off and from the sdio func driver to handle power save.
>
>> Does it make sense to you as well?
>
> Yes, certainly for the power up/down and runtime PM type operations.

For your information; I have started implementing a library to handle
power sequences. I intend to have this separated from mmc, to let
other subsystems re-use the same code.

It will not require a compatible string, but instead use something
like 'power-method = blah' property.

I intend to post this as an RFC in couple of days.

Kind regards
Uffe
