From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Tue, 27 May 2014 15:50:33 +0200
Message-ID: <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
References: <537E31F7.1030505@gmail.com>
	<537F1148.3010102@redhat.com>
	<20140523112239.GB12304@sirena.org.uk>
	<537F3610.3050104@redhat.com>
	<20140523162718.GE22111@sirena.org.uk>
	<53806F26.6050706@redhat.com>
	<20140525123452.GS22111@sirena.org.uk>
	<53824294.1090609@redhat.com>
	<20140526103807.GV22111@sirena.org.uk>
	<538321AB.4050006@redhat.com>
	<20140526142225.GF22111@sirena.org.uk>
	<538356DA.7090302@redhat.com>
	<CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
	<53838023.2080807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:64661 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbaE0Nue (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 May 2014 09:50:34 -0400
Received: by mail-qg0-f52.google.com with SMTP id a108so13569168qge.25
        for <linux-mmc@vger.kernel.org>; Tue, 27 May 2014 06:50:33 -0700 (PDT)
In-Reply-To: <53838023.2080807@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>

[snip]

>> I am having a bit hard to follow the terminology here. :-) What is a
>> "powerup driver" and what is a "main device driver" in this context?
>>
>> I had a slide which I used at a mmc subsystem crash course recently,
>> please have a look - hopefully this will help us to sort out this.
>>
>> https://drive.google.com/file/d/0B2ePGK-iqMupbDQ2S0o5b3Bhek0/edit?usp=sharing
>
> Right, the problem is that in the case(s) we're talking about before the sdio
> device in question can be probed the sdio device may need to have several clk
> signals enables, reset signal deasserted, etc.

Yes. That's an important point.

>
> Some piece of code needs to do that, the proposal so far has been to let the
> mmc-core deal with this, which will likely work fine for 90% of the cases
> were we need any form of "powerup", but in some more complex case this may need
> to happen in a specific order / with specific delays, etc. In this case some
> separate piece of board and/or sdio device specific code would need to take
> care of this, hence I was talking about a "powerup-driver", which I agree is
> not the best name. So lets just forget about the power-driver nomenclature
> completely.

I have now given this a serious thought, sorry for not doing this
earlier. Please consider the following ideas and statements. Feel free
to shoot them down. :-)

DT is supposed to described the hardware. Encoding power up sequences
within DT, to for example let the mmc core handle this means we are
touching the concept of open firmware. This is not what DT should be
used for.

To describe the HW in DT, the embedded SDIO card (actually it could be
any type of embedded card) shall be modelled as a child node to the
mmc host in DT. Similar to what you have proposed, but with the
difference that the child node _must_ contain a DT compatible string,
which means a "powerup-driver" can be probed.

Yes, I understand we might need one DT compatible string per board,
but that's because we need to model the hardware - and it differs.

To clarify my view, we do need a "powerup-driver" and the primary
reason is that we must not model "power up sequences" within DT.
Typically I see the "powerup-driver" as a simple platform driver
attached to the platform bus, but I that could of course differ.

[snip]

>>>
>>> Ok, so lets switch it over to a boolean, options for the name I see are:
>>>
>>> linux,mmc-host-powerup  (opt in to powerup being dealt with by the mmc core, implementation specific)
>>> simple-powerup          (platform neutral opt in to say just enable all resources and be done with it)
>>> custom-powerup          (platform neutral opt out version of simple-powerup)
>>> linux,custom-powerup    (same, but consider this something linux specific)
>>
>> This seems reasonable to me.
>
> This being the last option ?

Sorry for the confusion here. As stated above, we need a compatible string.

>
>> Well, I don't like the "simple-powerup", because I think a simple
>> powerup sequence is to me already supported by the mmc core, through
>> the regular host interface (->set_ios()).
>>
>> If I understand correctly, this binding is supposed to be configured
>> per host device and thus also per host device slots?
>
> Yes, although I must admit that have not thought about how to deal with
> slots, I've no experience with the mmc slots concept at all, or is slot
> just a different name for sdio function ?

Some mmc hosts may support more than one slot. Thus they can operate
on more than one card.

Currently, there are no support for this in the mmc core. There can
only be one card per host, but that's due to software limitation of
the mmc stack.  Following your suggestion; modelling the card as child
node under the mmc host, can easily be extended to support more than
one slot.

The slot will be the first level of child node under the mmc host,
then each slot may have a child node which models the embedded card.
But, let's leave that discussion for now. :-)

>
> Thinking more about this, maybe we can solve the problem of people
> worrying about complex power-on scenarios coming around later, by
> also encoding the sequence in dt, e.g. something like:
>
>                 mmc3: mmc@01c12000 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&mmc3_pins_a>;
>                         vmmc-supply = <&reg_vmmc3>;
>                         bus-width = <4>;
>                         non-removable;
>                         status = "okay";
>
>                         brcmf: bcrmf@1 {
>                                 reg = <1>;
>                                 compatible = "brcm,bcm43xx-fmac";
>                                 interrupt-parent = <&pio>;
>                                 interrupts = <10 8>; /* PH10 / EINT10 */
>                                 interrupt-names = "host-wake";
>                                 clocks = <&clk_out_a>;
>                                 clock-names = "clk_32khz";
>                                 gpios = <&pio 7 24 0>;
>                                 gpio-names = "gpio_reg_enable";
>                                 power-on-seq = "gpio_reg_enable", "usleep 1000", "clk_32khz", "usleep 200";
>                                 status = "okay";
>                         };
>                 };
>
> Where power-on-seq would tell the mmc-core exactly how to bring up the sdio
> device, using standard prefixes so that the mmc-core knows that something is
> a clock / gpio / reset / whatever.

I suppose I already made my point here. I don't think this is not a good idea.

>
> This should pretty much work for everything, and if something comes around which
> really needs some custom bit of code to bring it up, the mmc-core powerup stuff
> can simply be opted-out by leaving out the power-on-seq property.
>
> Regards,
>
> Hans

Here are some more thoughts of how this should be implemented.

Synchronization point:
My idea is to let the mmc_of_parse() function act as the
synchronization point, to make sure we are able to perform a full
power up of the card - before we actually start initialization of it.

If the mmc host has a child node to model the card, mmc_of_parse()
needs to verify that a struct device is created for it and that it's
corresponding "powerup driver" has been probed successfully.

If the mmc_of_parse() returns -EPROBE_DEFER, the mmc host driver will
return the same error code from it's ->probe(). This provides us with
the ability of waiting for the "powerup driver" to be probed.

If the mmc_of_parse() returns another error code, due to that the
"powerup driver" failed to be probed, the mmc host driver's ->probe()
will return the same error code and consequentially no power up of the
card will be performed at all.


Powerup driver's ->probe():
Typically the "powerup driver" will need to register a few callback
functions towards the mmc core. Typically at mmc_of_parse(), those
callbacks will have to be connected to a particular mmc host.

I would like to see three different callbacks, mirroring each of the
mmc_ios power_mode states MMC_POWER_OFF|UP|ON.


The power up sequence, performed by the mmc core:
The mmc_power_up|off functions, will invoke the registered "powerup
driver's" callbacks if they exists for the particular host it operates
on.


Comments are of course welcome! :-)

Kind regards
Ulf Hansson
