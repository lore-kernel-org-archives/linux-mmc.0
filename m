From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Wed, 28 May 2014 11:42:44 +0200
Message-ID: <5385AF94.90004@redhat.com>
References: <537E31F7.1030505@gmail.com>	<537F1148.3010102@redhat.com>	<20140523112239.GB12304@sirena.org.uk>	<537F3610.3050104@redhat.com>	<20140523162718.GE22111@sirena.org.uk>	<53806F26.6050706@redhat.com>	<20140525123452.GS22111@sirena.org.uk>	<53824294.1090609@redhat.com>	<20140526103807.GV22111@sirena.org.uk>	<538321AB.4050006@redhat.com>	<20140526142225.GF22111@sirena.org.uk>	<538356DA.7090302@redhat.com>	<CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>	<53838023.2080807@redhat.com> <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56054 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbaE1Jnk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 May 2014 05:43:40 -0400
In-Reply-To: <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>Sascha Hauer <s.hauer@pengutronix.de>

Hi,

On 05/27/2014 03:50 PM, Ulf Hansson wrote:
> [snip]
> 
>>> I am having a bit hard to follow the terminology here. :-) What is a
>>> "powerup driver" and what is a "main device driver" in this context?
>>>
>>> I had a slide which I used at a mmc subsystem crash course recently,
>>> please have a look - hopefully this will help us to sort out this.
>>>
>>> https://drive.google.com/file/d/0B2ePGK-iqMupbDQ2S0o5b3Bhek0/edit?usp=sharing
>>
>> Right, the problem is that in the case(s) we're talking about before the sdio
>> device in question can be probed the sdio device may need to have several clk
>> signals enables, reset signal deasserted, etc.
> 
> Yes. That's an important point.
> 
>>
>> Some piece of code needs to do that, the proposal so far has been to let the
>> mmc-core deal with this, which will likely work fine for 90% of the cases
>> were we need any form of "powerup", but in some more complex case this may need
>> to happen in a specific order / with specific delays, etc. In this case some
>> separate piece of board and/or sdio device specific code would need to take
>> care of this, hence I was talking about a "powerup-driver", which I agree is
>> not the best name. So lets just forget about the power-driver nomenclature
>> completely.
> 
> I have now given this a serious thought, sorry for not doing this
> earlier. Please consider the following ideas and statements. Feel free
> to shoot them down. :-)
> 
> DT is supposed to described the hardware. Encoding power up sequences
> within DT, to for example let the mmc core handle this means we are
> touching the concept of open firmware. This is not what DT should be
> used for.

Ok, I already expected an answer like this, but I still wanted to voice
the idea of encoding the sequence into the dt.

> To describe the HW in DT, the embedded SDIO card (actually it could be
> any type of embedded card) shall be modelled as a child node to the
> mmc host in DT. Similar to what you have proposed, but with the
> difference that the child node _must_ contain a DT compatible string,
> which means a "powerup-driver" can be probed.
> 
> Yes, I understand we might need one DT compatible string per board,
> but that's because we need to model the hardware - and it differs.
> 
> To clarify my view, we do need a "powerup-driver" and the primary
> reason is that we must not model "power up sequences" within DT.
> Typically I see the "powerup-driver" as a simple platform driver
> attached to the platform bus, but I that could of course differ.

Ok, but if it is a platform device, then how can the mmc-host
depend on it ? Or will the mmc-core code instantiate this
platform device based on the child node, rather then it being
instantiated directly by the platform bus ?

<snip>

>>> Well, I don't like the "simple-powerup", because I think a simple
>>> powerup sequence is to me already supported by the mmc core, through
>>> the regular host interface (->set_ios()).
>>>
>>> If I understand correctly, this binding is supposed to be configured
>>> per host device and thus also per host device slots?
>>
>> Yes, although I must admit that have not thought about how to deal with
>> slots, I've no experience with the mmc slots concept at all, or is slot
>> just a different name for sdio function ?
> 
> Some mmc hosts may support more than one slot. Thus they can operate
> on more than one card.
> 
> Currently, there are no support for this in the mmc core. There can
> only be one card per host, but that's due to software limitation of
> the mmc stack.  Following your suggestion; modelling the card as child
> node under the mmc host, can easily be extended to support more than
> one slot.

Actually what I'm suggesting is based on Sascha Hauer's
"mmc: Add SDIO function devicetree subnode parsing"

Patch, which models the sdio functions as child nodes, (with the
one with reg = <0> being the card itself) this also makes sense since each
sdio-function gets its own device representing it, so having one child node
per sdio-functions leads to one child node per device which seems sensible.

This means how ever that if want to prepare for a future were we support
more then one slot we need an extra level for the slot, so we would
get something like this:

mmc3: mmc@01c12000 {
    #address-cells = <1>;
    #size-cells = <0>;

    pinctrl-names = "default";
    pinctrl-0 = <&mmc3_pins_a>;
    vmmc-supply = <&reg_vcc3v3>;
    bus-width = <4>;
    non-removable;
    status = "okay";

    mmc3slot0: mmc3slot@0 {
        #address-cells = <1>;
        #size-cells = <0>;

        reg = <0>;
        clocks = <&clk_out_a>, <&clk_out_b>;
        clock-frequency = <32768>, <26000000>;
	gpios = <&pio 4 5 0 &pio 1 18 0>;

        brcmf: bcrmf@1 {
            reg = <1>;
            compatible = "brcm,bcm43xx-fmac";
            interrupt-parent = <&pio>;
            interrupts = <10 4>; /* PH10 / EINT10 */
            interrupt-names = "host-wake";
            status = "okay";
        };
    };
};

Note that I've put the powerup related resources at the slot
child-node level, I think having the slots as an explicit level
actually solves a lot of the powerup discussion we've been having.

The slot child node can have the properties for the nodes needed
to powerup the device attached to the slot.

The slot child node can have a compatible string, independent of the
sdio-func child node, and this slot child node compatible can then
be used to select a power-up driver for the slot (which then power
up the sdio device / sdio functions before probing).

>From a Linux implementation pov, this would mean that the mmc-core
would instantiate platform-devices for the slot child nodes and then
let the platform bus take care of loading a driver for this.
After instantiating the platform device, the mmc-core will check if
there is a driver bound, and if not return -EPROBEDEFER to deal with
the power-up driver (module) not being loaded yet, or the powerup
driver actually hitting -EPROBEDEFER itself. This means we will need
a small "null" driver to deal with cases where we don't need any
powerup, but for some reason still need child nodes. Or we could
skip the check if there is no compatible property in the slot child
node, but I think the latter option may come back to bite us later.

> The slot will be the first level of child node under the mmc host,
> then each slot may have a child node which models the embedded card.
> But, let's leave that discussion for now. :-)

Right, I agree, see above, but I believe we need to settle this now,
even without solving the powerup sequence thing we (at least I) need
to get the child node structure + addressing set in stone so that
we can add oob irq support, which requires storing info in the
sdio-func child node.


> 
>>
>> Thinking more about this, maybe we can solve the problem of people
>> worrying about complex power-on scenarios coming around later, by
>> also encoding the sequence in dt, e.g. something like:
>>
>>                 mmc3: mmc@01c12000 {
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>
>>                         pinctrl-names = "default";
>>                         pinctrl-0 = <&mmc3_pins_a>;
>>                         vmmc-supply = <&reg_vmmc3>;
>>                         bus-width = <4>;
>>                         non-removable;
>>                         status = "okay";
>>
>>                         brcmf: bcrmf@1 {
>>                                 reg = <1>;
>>                                 compatible = "brcm,bcm43xx-fmac";
>>                                 interrupt-parent = <&pio>;
>>                                 interrupts = <10 8>; /* PH10 / EINT10 */
>>                                 interrupt-names = "host-wake";
>>                                 clocks = <&clk_out_a>;
>>                                 clock-names = "clk_32khz";
>>                                 gpios = <&pio 7 24 0>;
>>                                 gpio-names = "gpio_reg_enable";
>>                                 power-on-seq = "gpio_reg_enable", "usleep 1000", "clk_32khz", "usleep 200";
>>                                 status = "okay";
>>                         };
>>                 };
>>
>> Where power-on-seq would tell the mmc-core exactly how to bring up the sdio
>> device, using standard prefixes so that the mmc-core knows that something is
>> a clock / gpio / reset / whatever.
> 
> I suppose I already made my point here. I don't think this is not a good idea.

I've heard you loud and clear. As said I already more or less expected this answer.

> 
>>
>> This should pretty much work for everything, and if something comes around which
>> really needs some custom bit of code to bring it up, the mmc-core powerup stuff
>> can simply be opted-out by leaving out the power-on-seq property.
>>
>> Regards,
>>
>> Hans
> 
> Here are some more thoughts of how this should be implemented.
> 
> Synchronization point:
> My idea is to let the mmc_of_parse() function act as the
> synchronization point, to make sure we are able to perform a full
> power up of the card - before we actually start initialization of it.

Ack.

> If the mmc host has a child node to model the card, mmc_of_parse()
> needs to verify that a struct device is created for it and that it's
> corresponding "powerup driver" has been probed successfully.

Right, this would be for the slot child node, which itself can have
card (reg = <0>); and sdio-func childnodes, listing compatible strings
for those (so that the driver loaded through sdio probing can check if
the info in the sdio-func childnode is formatted in a compatible way),
and things like oob irqs, clks not needed for powerup, etc.

> If the mmc_of_parse() returns -EPROBE_DEFER, the mmc host driver will
> return the same error code from it's ->probe(). This provides us with
> the ability of waiting for the "powerup driver" to be probed.

Ack. Note though that mmc_of_parse will likely not do the probe itself,
the way I see it it will do a platform_device_register() and let the
platform bus code do its thing. Downside of this is that
platform_device_register() will not propagate probe errors such as
-EPROBE_DEFER, so we need to check afterwards that a driver is actually
bound, see above.

> If the mmc_of_parse() returns another error code, due to that the
> "powerup driver" failed to be probed, the mmc host driver's ->probe()
> will return the same error code and consequentially no power up of the
> card will be performed at all.

Ack.

> Powerup driver's ->probe():
> Typically the "powerup driver" will need to register a few callback
> functions towards the mmc core. Typically at mmc_of_parse(), those
> callbacks will have to be connected to a particular mmc host.
> 
> I would like to see three different callbacks, mirroring each of the
> mmc_ios power_mode states MMC_POWER_OFF|UP|ON.

Hmm, can't we do something with runtime pm here instead? I would be
nice if we could use the platform bus for this instead of inventing
a new bus for this. Both from not needing to add extra count pov, but
also from the pov of having a solution which other subsystems can
later easily copy. I can even envision the parts of mmc_of_parse
dealing with this being a separate function taking a child node as
argument from day one, which can then hopefully later be moved out
of the mmc subsys and be used elsewhere too (*).

Regards,

Hans


*) I know I'm an optimist, a man can dream can he not ?
