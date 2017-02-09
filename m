From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document  pinctrl-ingenic
Date: Thu, 09 Feb 2017 18:28:25 +0100
Message-ID: <fd3c507484a9ee34a08c9f92e60624db@mail.crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
 <20170125185207.23902-2-paul@crapouillou.net>
 <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop>
 <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
 <CACRpkdbAgy4sh6NT5DdQD6EQtOZEwevohEA6OGRcVz98yqS52Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbAgy4sh6NT5DdQD6EQtOZEwevohEA6OGRcVz98yqS52Q@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
List-Id: linux-mmc@vger.kernel.org

Le 2017-01-31 14:09, Linus Walleij a écrit :
> On Tue, Jan 31, 2017 at 11:31 AM, Paul Cercueil <paul@crapouillou.net> 
> wrote:
>> [Rob]:
>>> From the overlapping register addresses in the examples and this
>>> description, it looks like the pinctrlr and gpio controller are 1 
>>> block.
>>> If so, then there should only be 1 node.
>> 
>> Well, that's what I had until Linus W. just told me to do the 
>> opposite:
>> 
>>> Just pull all these down two levels and make them one device
>>> each instead of having them inside the pin controller node
>>> like this.
> 
> I guess the argument is that they are in the same coherent memory
> range so they should be one device node. That is how we handle
> e.g. system controllers so it makes some sense.
> 
> So can the two GPIO controllers be modeled as two subnodes of
> the pin controller then?
> 
> Subnodes are certainly OK, we have that for many other devices
> such as interrupt controllers on PCI bridges and what not.
> 
> So when the probing of the pin controller is ready it can just
> walk down and populate the GPIO subdevices with
> of_platform_default_populate() or simply by registering the
> device directly with platform_device_add_data() just like an
> MFD device does?
> 
> This is nice because we want to use the standard gpio ranges
> to map pins to GPIO lines.
> 
> I'm sorry about the unclarities here, but it's essentially an intrinsic
> problem with GPIO that has been with us for years: do we model
> each "bank" as a device or do we just register each bank as a
> gpiochip, or do we even make one gpiochip to cover all the banks.
> All solutions can be found in the kernel... also the different DT 
> bindings:
> one node for a whole slew of GPIO controllers, or seveal nodes
> and I bet also several nodes for memory ranges in close proximity.
> 
> I don't know for sure what is the most elegant solution, we might
> need to build some consensus here for the future so it doesn't
> get to heterogeneous.
> 
> Yours,
> Linus Walleij

I was thinking that instead of having one pinctrl-ingenic instance 
covering
0x600 of register space, and 6 instances of gpio-ingenic having 0x100 
each,
I could just have 6 instances of pinctrl-ingenic, each one with an 
instance
of gpio-ingenic declared as a sub-node, each handling just 0x100 of 
memory space.

Then I can make pinctrl-ingenic and gpio-ingenic share a regmap (through 
syscon),
which would be a good idea anyway since the two drivers poke to the very 
same
registers (in theory not at the same time, but it's never safe to assume 
things
like this).

Problem is, that in that case the pin functions/groups (and 
ingenic,pull-ups)
would have to be in DTS because we would have 6 instances with different 
pin
groups, and I know you hate that.

Thoughts?
