From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 07/10] pinctrl: add pinctrl driver for Rockchip SoCs
Date: Wed, 5 Jun 2013 09:01:44 +0200
Message-ID: <CACRpkdZty-TszfBTOab4_PUi8dy5DYim=wNERv=pyqC3HNuT4w@mail.gmail.com>
References: <201306030055.15413.heiko@sntech.de>
	<201306030059.47611.heiko@sntech.de>
	<CACRpkdbBr7s1NoTQewVOotorHJHLL8Z6-_gAx5GC0x6uNUX0gw@mail.gmail.com>
	<201306041405.13320.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201306041405.13320.heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Turquette <mturquette@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 4, 2013 at 2:05 PM, Heiko St=FCbner <heiko@sntech.de> wrote=
:

>> > +PULL_AUTO      (1 << 0): indicate this pin needs a pull setting f=
or SoCs
>> > +                         that determine the pull up or down thems=
elfs
>>
>> Hm, never saw that before...
>
> Citing the original gpio driver:
>
>         /*
>          * Values written to this register independently
>          * control Pullup/Pulldown or not for the
>          * corresponding data bit in GPIO.
>          * 0: pull up/down enable, PAD type will decide
>          * to be up or down, not related with this value
>          * 1: pull up/down disable
>          */
>
> So if it's a pull up or down is decided based on the mux of the pin. =
Calling
> everything a "pull down" (or up) when it isn't seemed somehow wrong t=
o me.
>
> The rk3188 on the other hand supports both pull up and down separatel=
y.
>
> Or should this be selected as PULL_UP | PULL_DOWN in the config?

The generic config is pretty much either/or so it'd be a new
config for that approach.

Basically it seems they have embedded knowledge into the
silicon: there is no specific rule as to whether a pad should be
pulled up or down depending on "pad type" as is stated, rather
it's so that if you know a pad will be used for I2C SCL then
you know it needs pull-up. Probably something like a "1" on
some constant switch in VHDL/Verilog is hard-coded into
the silicon turning on pull-up if I2C is selected and the
autopull is set for example.

>> +config PINCTRL_ROCKCHIP
>> +       bool
>> +       select PINMUX
>> +       select PINCONF
>> +       select GENERIC_IRQ_CHIP
>>
>> Why is this super-simple pin config thing not using
>> GENERIC_PINCONF?
>>
>> I *know* it is simpler to implement your own thing, but think of the
>> poor maintainers that have to wade through 50 identical implementati=
ons.
>> Do this, it pays off.
>
> generic pinconf sounds interesting ... will give it a try.
>
> The only problem is the pull stuff mentioned above that is either pul=
l up or
> down without the driver having knowledge about it. And generic_pincon=
f only
> knows about them separately right now.

Create a separate patch adding PIN_CONFIG_BIAS_PULL_AUTO
to include/linux/pinctrl/pinconf-generic.h, don't forget the
kerneldoc, and patching drivers/pinctrl/pinconf-generic.c.

I'll apply it right away.

>> Nothing else you want to say about the pins here?
>> (No big deal for sure, but....)
>
> when using pinconfig_generic, its dump_pin function should be more ta=
lkative
> right?

Yes, one of the things you get for free... soon also the pin config
DT parser will be for free I hope.

Yours,
Linus Walleij
