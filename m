From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Mon, 26 May 2014 19:55:47 +0200
Message-ID: <53838023.2080807@redhat.com>
References: <537E31F7.1030505@gmail.com>	<537F1148.3010102@redhat.com>	<20140523112239.GB12304@sirena.org.uk>	<537F3610.3050104@redhat.com>	<20140523162718.GE22111@sirena.org.uk>	<53806F26.6050706@redhat.com>	<20140525123452.GS22111@sirena.org.uk>	<53824294.1090609@redhat.com>	<20140526103807.GV22111@sirena.org.uk>	<538321AB.4050006@redhat.com>	<20140526142225.GF22111@sirena.org.uk>	<538356DA.7090302@redhat.com> <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6783 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbaEZR4t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 May 2014 13:56:49 -0400
In-Reply-To: <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>

Hi,

On 05/26/2014 06:07 PM, Ulf Hansson wrote:
> [snip]
> 
>>>
>>> We don't typically actually bind multiple compatibles for a single
>>> device.  We've got a bunch of options we can choose from but we
>>> generally pick the one that matches best and ignore the others.
>>>
>>>> Where as what you're suggesting is to always pick driver foo, unless
>>>> driver bar is available and has a special flag saying to not use foo, this
>>>> is a whole new way to use compatibles really, and not one which I think
>>>> we want to introduce.
>>>
>>> I'm not sure I'm buying the idea that we have a powerup driver that's
>>> meaningfully not part of the main device driver.
> 
> I am having a bit hard to follow the terminology here. :-) What is a
> "powerup driver" and what is a "main device driver" in this context?
> 
> I had a slide which I used at a mmc subsystem crash course recently,
> please have a look - hopefully this will help us to sort out this.
> 
> https://drive.google.com/file/d/0B2ePGK-iqMupbDQ2S0o5b3Bhek0/edit?usp=sharing

Right, the problem is that in the case(s) we're talking about before the sdio
device in question can be probed the sdio device may need to have several clk
signals enables, reset signal deasserted, etc.

Some piece of code needs to do that, the proposal so far has been to let the
mmc-core deal with this, which will likely work fine for 90% of the cases
were we need any form of "powerup", but in some more complex case this may need
to happen in a specific order / with specific delays, etc. In this case some
separate piece of board and/or sdio device specific code would need to take
care of this, hence I was talking about a "powerup-driver", which I agree is
not the best name. So lets just forget about the power-driver nomenclature
completely.

> 
>>
>> Well, if we merge some variant of Olof's code, we will have a powerup driver
>> that is part of the mmc core, and thus not of the sdio function driver.
>>
>>>>> Well, if things aren't going to work either way for these devices
>>>>> without extra stuff it seems it doesn't much matter but it helps the
>>>>> simple case to have things default to working.
>>>
>>>> The simple case still needs a child node describing the needed resources,
>>>> adding a compatible = "simple-sdio-powerup" to that at the same as creating
>>>> the child node in the first place really is no extra effort at all.
>>>
>>> From where I'm sitting it's more effort since instead of just putting
>>> the device in there (and possibly also some other devices that are
>>> software compatible) we have to put in another compatible string which
>>> is really just a boolean flag to be used in conjunction with the others.
>>> That's harder to think about and we clearly don't want to go through the
>>> compatible list, decide that we don't know how to handle the device
>>> except power it up so go and do that.
>>>
>>> If it were done as something like "set boolean property X or
>>> powerup-method = Y in the card description" or whatever it'd seem a bit
>>> annoying but not a big deal, I think it's the fact that it's getting put
>>> into the compatible list that's really concerning me.
>>
>> Ok, so lets switch it over to a boolean, options for the name I see are:
>>
>> linux,mmc-host-powerup  (opt in to powerup being dealt with by the mmc core, implementation specific)
>> simple-powerup          (platform neutral opt in to say just enable all resources and be done with it)
>> custom-powerup          (platform neutral opt out version of simple-powerup)
>> linux,custom-powerup    (same, but consider this something linux specific)
> 
> This seems reasonable to me.

This being the last option ?

> Well, I don't like the "simple-powerup", because I think a simple
> powerup sequence is to me already supported by the mmc core, through
> the regular host interface (->set_ios()).
> 
> If I understand correctly, this binding is supposed to be configured
> per host device and thus also per host device slots?

Yes, although I must admit that have not thought about how to deal with
slots, I've no experience with the mmc slots concept at all, or is slot
just a different name for sdio function ?

Thinking more about this, maybe we can solve the problem of people
worrying about complex power-on scenarios coming around later, by
also encoding the sequence in dt, e.g. something like:

                mmc3: mmc@01c12000 {
                        #address-cells = <1>;
                        #size-cells = <0>;

                        pinctrl-names = "default";
                        pinctrl-0 = <&mmc3_pins_a>;
                        vmmc-supply = <&reg_vmmc3>;
                        bus-width = <4>;
                        non-removable;
                        status = "okay";

                        brcmf: bcrmf@1 {
                                reg = <1>;
                                compatible = "brcm,bcm43xx-fmac";
                                interrupt-parent = <&pio>;
                                interrupts = <10 8>; /* PH10 / EINT10 */
                                interrupt-names = "host-wake";
				clocks = <&clk_out_a>;
				clock-names = "clk_32khz";
				gpios = <&pio 7 24 0>;
				gpio-names = "gpio_reg_enable";
				power-on-seq = "gpio_reg_enable", "usleep 1000", "clk_32khz", "usleep 200";
                                status = "okay";				
                        };
                };

Where power-on-seq would tell the mmc-core exactly how to bring up the sdio
device, using standard prefixes so that the mmc-core knows that something is
a clock / gpio / reset / whatever.

This should pretty much work for everything, and if something comes around which
really needs some custom bit of code to bring it up, the mmc-core powerup stuff
can simply be opted-out by leaving out the power-on-seq property.

Regards,

Hans
