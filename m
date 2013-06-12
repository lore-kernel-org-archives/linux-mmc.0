From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] mmc: omap_hsmmc: Remux pins to support SDIO
 interrupt and PM runtime
Date: Wed, 12 Jun 2013 06:21:44 -0700
Message-ID: <20130612132144.GP8164@atomide.com>
References: <20130607214557.18581.75288.stgit@localhost>
 <20130607214957.18581.90624.stgit@localhost>
 <CACRpkdZ5CUvULBFpdHZ_AMotqfUdBcAQ63+8cT+r6TZ77bUWOA@mail.gmail.com>
 <20130610162356.GL8164@atomide.com>
 <CACRpkdaEjLzXfA3HX5mra0Mjheia4e2O3kbvikeZQRsNczS7kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24623 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754784Ab3FLNVw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 09:21:52 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdaEjLzXfA3HX5mra0Mjheia4e2O3kbvikeZQRsNczS7kg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, Andreas Fenkart <afenkart@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

* Linus Walleij <linus.walleij@linaro.org> [130611 01:00]:
> On Mon, Jun 10, 2013 at 6:23 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > We only should remux the pins that need remuxing as that's done
> > every time hitting idle. So I think we should have the following
> > default groups:
> >
> > default         Static pins that don't change, no need to remux
> >                 configured in consumer driver probe like we already
> >                 do
> >
> > active          Optional dynamic pins remuxed for runtime, can be
> >                 configured and selected in consumer driver probe.
> >                 The consumer driver may also want to select this
> >                 state in PM runtime resume.
> >
> > idle            Optional dynamic pins remuxed for idle. The consumer
> >                 driver may also want to select this state in PM
> >                 runtime suspend depending on device_can_wakeup()
> >                 and driver specific needs.
> 
> The one thing I don't understand is why a driver would select the
> active state in probe(), unless it's a driver that does not support
> runtime PM. (But maybe that's what you mean.)

Yes you're right, there should not be any need to select active state
in probe, that should be selected by PM runtime.
 
> Compare this to <linus/pinctrl/pinctrl-state.h>:
> 
> /**
>  * @PINCTRL_STATE_DEFAULT: the state the pinctrl handle shall be put
>  *      into as default, usually this means the pins are up and ready to
>  *      be used by the device driver. This state is commonly used by
>  *      hogs to configure muxing and pins at boot, and also as a state
>  *      to go into when returning from sleep and idle in
>  *      .pm_runtime_resume() or ordinary .resume() for example.
>  * @PINCTRL_STATE_IDLE: the state the pinctrl handle shall be put into
>  *      when the pins are idle. This is a state where the system is relaxed
>  *      but not fully sleeping - some power may be on but clocks gated for
>  *      example. Could typically be set from a pm_runtime_suspend() or
>  *      pm_runtime_idle() operation.
>  * @PINCTRL_STATE_SLEEP: the state the pinctrl handle shall be put into
>  *      when the pins are sleeping. This is a state where the system is in
>  *      its lowest sleep state. Could typically be set from an
>  *      ordinary .suspend() function.
>  */
> #define PINCTRL_STATE_DEFAULT "default"
> #define PINCTRL_STATE_IDLE "idle"
> #define PINCTRL_STATE_SLEEP "sleep"
> 
> The way I currently use these in e.g.
> drivers/spi/spi-pl022 is:
> 
> probe:
>  -> default
> 
> runtime_suspend:
>  -> idle
> 
> runtime_resume:
>  -> default
> 
> suspend:
>  -> sleep
> 
> resume:
>   -> default
>   -> idle
> 
> Notice that we go to default then idle on probe and
> runtime resume. This is because the idle state is
> optional (as is the sleep state).
> 
> So I guess if we should extend this terminology to match
> what you are using for the OMAP it would rather be like
> this:
> 
> probe:
>  -> default
> 
> runtime_suspend:
>  -> idle
> 
> runtime_resume:
>  -> default
>  -> active

At least for omaps, there's no need to select default in
runtime_resume as the default pins stay that way.
 
> suspend:
>  -> sleep

For omaps, we would just select idle pins again in the
suspend case.
 
> resume:
>   -> default
>   -> idle

And for omaps, there's no need to select default in resume
either. Just selecting active would do the trick for resume.

So for omaps, the sequence would be:

probe:
 -> default (typically all device pins except rx pin)

runtime_suspend:
suspend:
 -> idle (remux rx pin from device to gpio input for wake)
 
runtime_resume:
resume:
 -> active (remux rx pin from gpio input to device)
 
> Just one more optional "active" state in runtime resume.
> Correct?

Yes the "active" is needed, but "sleep" would be unused for
omaps.
 
> If we can agree on this I will add the active state to the
> state table and add a container in the core for this as well
> as pinctrl_pm_select_active_state() so we can skip all the
> pointless boilerplate also in the OMAP drivers, plus increase
> the readability and portability quite a bit.

Sounds good to me as long as we don't always need to select
the default pins over and over in PM runtime_resume.
 
> >> However in this case I *suspect* that what you really want
> >> to do it to rename the state called "default" to "sleep"
> >> (it appears the default state is sleepy) and then rename
> >> the "active" state to "default" (as this is the defined semantic
> >> meaning of "default" from <linux/pinctrl/pinctrl-state.h>.
> >
> > The idle state above could also be called sleep instead of idle
> > if you prefer that.
> 
> No I think we should reserve that name for the pin state
> associated with suspend(). Let's leave it like this.

OK
 
> > I think the confusion is caused by the fact that we need three
> > mux groups, not just two :) The toggling between active and idle
> > is the hotpath as that can potentially happen for multiple drivers
> > every time we enter and exit idle.
> 
> Actually we have the same thing, it's just that our "default"
> and "active" are the same thing. But it seems we need to
> add your granularity to this.

Well the difference seems to be that you need to remux all the
device pins for runtime_suspend and resume while in most of the
cases I know of only one device pins needs to be toggled and the
rest can be selected in driver probe.

Regards,

Tony
