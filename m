From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] mmc: omap_hsmmc: Remux pins to support SDIO interrupt
 and PM runtime
Date: Tue, 11 Jun 2013 09:54:32 +0200
Message-ID: <CACRpkdaEjLzXfA3HX5mra0Mjheia4e2O3kbvikeZQRsNczS7kg@mail.gmail.com>
References: <20130607214557.18581.75288.stgit@localhost>
	<20130607214957.18581.90624.stgit@localhost>
	<CACRpkdZ5CUvULBFpdHZ_AMotqfUdBcAQ63+8cT+r6TZ77bUWOA@mail.gmail.com>
	<20130610162356.GL8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:42441 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3FKHyd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jun 2013 03:54:33 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so11478033obb.29
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jun 2013 00:54:32 -0700 (PDT)
In-Reply-To: <20130610162356.GL8164@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, Andreas Fenkart <afenkart@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Jun 10, 2013 at 6:23 PM, Tony Lindgren <tony@atomide.com> wrote:

> We only should remux the pins that need remuxing as that's done
> every time hitting idle. So I think we should have the following
> default groups:
>
> default         Static pins that don't change, no need to remux
>                 configured in consumer driver probe like we already
>                 do
>
> active          Optional dynamic pins remuxed for runtime, can be
>                 configured and selected in consumer driver probe.
>                 The consumer driver may also want to select this
>                 state in PM runtime resume.
>
> idle            Optional dynamic pins remuxed for idle. The consumer
>                 driver may also want to select this state in PM
>                 runtime suspend depending on device_can_wakeup()
>                 and driver specific needs.

The one thing I don't understand is why a driver would select the
active state in probe(), unless it's a driver that does not support
runtime PM. (But maybe that's what you mean.)

Compare this to <linus/pinctrl/pinctrl-state.h>:

/**
 * @PINCTRL_STATE_DEFAULT: the state the pinctrl handle shall be put
 *      into as default, usually this means the pins are up and ready to
 *      be used by the device driver. This state is commonly used by
 *      hogs to configure muxing and pins at boot, and also as a state
 *      to go into when returning from sleep and idle in
 *      .pm_runtime_resume() or ordinary .resume() for example.
 * @PINCTRL_STATE_IDLE: the state the pinctrl handle shall be put into
 *      when the pins are idle. This is a state where the system is relaxed
 *      but not fully sleeping - some power may be on but clocks gated for
 *      example. Could typically be set from a pm_runtime_suspend() or
 *      pm_runtime_idle() operation.
 * @PINCTRL_STATE_SLEEP: the state the pinctrl handle shall be put into
 *      when the pins are sleeping. This is a state where the system is in
 *      its lowest sleep state. Could typically be set from an
 *      ordinary .suspend() function.
 */
#define PINCTRL_STATE_DEFAULT "default"
#define PINCTRL_STATE_IDLE "idle"
#define PINCTRL_STATE_SLEEP "sleep"

The way I currently use these in e.g.
drivers/spi/spi-pl022 is:

probe:
 -> default

runtime_suspend:
 -> idle

runtime_resume:
 -> default

suspend:
 -> sleep

resume:
  -> default
  -> idle

Notice that we go to default then idle on probe and
runtime resume. This is because the idle state is
optional (as is the sleep state).

So I guess if we should extend this terminology to match
what you are using for the OMAP it would rather be like
this:

probe:
 -> default

runtime_suspend:
 -> idle

runtime_resume:
 -> default
 -> active

suspend:
 -> sleep

resume:
  -> default
  -> idle

Just one more optional "active" state in runtime resume.
Correct?

If we can agree on this I will add the active state to the
state table and add a container in the core for this as well
as pinctrl_pm_select_active_state() so we can skip all the
pointless boilerplate also in the OMAP drivers, plus increase
the readability and portability quite a bit.

>> However in this case I *suspect* that what you really want
>> to do it to rename the state called "default" to "sleep"
>> (it appears the default state is sleepy) and then rename
>> the "active" state to "default" (as this is the defined semantic
>> meaning of "default" from <linux/pinctrl/pinctrl-state.h>.
>
> The idle state above could also be called sleep instead of idle
> if you prefer that.

No I think we should reserve that name for the pin state
associated with suspend(). Let's leave it like this.

> I think the confusion is caused by the fact that we need three
> mux groups, not just two :) The toggling between active and idle
> is the hotpath as that can potentially happen for multiple drivers
> every time we enter and exit idle.

Actually we have the same thing, it's just that our "default"
and "active" are the same thing. But it seems we need to
add your granularity to this.

Yours,
Linus Walleij
