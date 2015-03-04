From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] mmc: sdio: support switching to 1-bit before turning
 off clocks
Date: Wed, 4 Mar 2015 07:08:27 -0800
Message-ID: <20150304150827.GA13520@atomide.com>
References: <20150224024023.22719.32436.stgit@notabene.brown>
 <20150224024223.22719.91536.stgit@notabene.brown>
 <20150303225355.GE3756@atomide.com>
 <20150304162848.2d33914d@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150304162848.2d33914d@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>, Florian Vaussard <florian.vaussard@epfl.ch>, Ash Charles <ash@gumstix.com>
List-Id: linux-mmc@vger.kernel.org

* NeilBrown <neilb@suse.de> [150303 21:29]:
> On Tue, 3 Mar 2015 14:53:55 -0800 Tony Lindgren <tony@atomide.com> wrote:
> > 
> > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > @@ -367,6 +367,7 @@
> >  };
> >  
> >  &mmc2 {
> > +	interrupts-extended = <&intc 86 &omap3_pmx_core 0x12e>;
> >  	vmmc-supply = <&vaux4>;
> >  	bus-width = <4>;
> >  	ti,non-removable;
> 
> I had 
> 
> +       interrupts-extended = <&intc 86 &gpio5 5 0>; /* GPIO_133 */
> +       pinctrl-names = "default", "idle";
> +       pinctrl-0 = <&mmc2_pins>;
> +       pinctrl-1 = <&mmc2_cirq_pin>;
> 
> together with
> 
> +       mmc2_cirq_pin: pinmux_cirq_pin {
> +               pinctrl-single,pins = <
> +                       OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE4) 
> +               >;
> +       };
> +
> 
> 
> and a longer definition for mmc2_pins.
> 
> Is that one line reconfigure the pin on demand?  How does that work?

Well the remuxing of the mmc2 dat1 pin is not needed on omap3/4/5.
These SoCs have the iochain wake-up events.

Remuxing is needed on SoCs with no iochain wake-up events, such as
am355x, am437x and dra7 variants.

Not sure if we actually have the gpio5 bank wake-up the system
properly currently from off-idle. It could be that only gpio1 bank
is currently capable of wake-up from off-idle without needing
to use the iochain wake-up also for GPIO lines.

Regards,

Tony
