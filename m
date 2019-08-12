From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] mmc: core: Prevent processing SDIO IRQs when the card is
 suspended
Date: Mon, 12 Aug 2019 11:39:54 -0700
Message-ID: <20190812183954.GQ250418@google.com>
References: <20190611123221.11580-1-ulf.hansson@linaro.org>
 <CAD=FV=XBVRsdiOD0vhgTvMXmqm=fzy9Bzd_x=E1TNPBsT_D-tQ@mail.gmail.com>
 <CAPDyKFqR-xSKdYZYBTK5kKOt1dk7dx_BjedHiDOKs7-X4od=dg@mail.gmail.com>
 <CAD=FV=WODbZa1fBrLbJBsd77xn5ekHWjks-ydxOSzjdBK83Rmg@mail.gmail.com>
 <CAPDyKFpqk4ZcVTqifnbnW1WgNfx9ZNebCttUPcK_e9KWqpDMjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpqk4ZcVTqifnbnW1WgNfx9ZNebCttUPcK_e9KWqpDMjQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Guenter Roeck <groeck@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Kalle Valo <kvalo@codeaurora.org>, linux-wireless <linux-wireless@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Fri, Jun 14, 2019 at 01:55:54PM +0200, Ulf Hansson wrote:
> On Thu, 13 Jun 2019 at 20:05, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Jun 13, 2019 at 2:30 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > > A) Do we need to do anything extra to make sure we actually call the
> > > > interrupt handler after we've resumed?  I guess we can't actually
> > > > "lose" the interrupt since it will be sitting asserted in CCCR_INTx
> > > > until we deal with it (right?), but maybe we need to do something to
> > > > ensure the handler gets called once we're done resuming?
> > >
> > > Good point!
> > >
> > > Although, it also depends on if we are going to power off the SDIO
> > > card or not. In other words, if the SDIO IRQ are configured as a
> > > system wakeup.
> >
> > Even if it's not a system wakeup, we still don't want to drop the
> > interrupt on the ground though, do we?  For instance, think about a
> > level-triggered GPIO interrupt that's _not_ a wakeup interrupt.  If
> > that gets asserted in suspend then we won't wakeup the system, but as
> > soon as the system gets to a certain point in the resume sequence then
> > we should pass the interrupt on to the handler.  If an edge triggered
> > (but non-wakeup) interrupt fires when the system is resuming then we
> > should similarly not drop it, should we?
> 
> GPIOs is clearly different.
> 
> When it comes to SDIO cards, re-playing/re-kicking an SDIO IRQ doesn't
> make sense in case the SDIO card was powered off during system
> suspend. The reason is simply because the internal state inside the
> SDIO card gets lost at a power off. For example, the used SDIO func
> number, needs to re-enabled before any SDIO IRQs can be delivered for
> it.
> 
> So yes, I really think we should drop the SDIO IRQ, unless it's
> configured as a wakeup. Simply because it's not valid after the system
> has resumed.

With the dropped interrupts SDIO is broken on veyron jerry when
the Marvell 8997 Bluetooth controller sends events while
suspending. On the system MMC remains powered during suspend, but SDIO
isn't configured as wakeup. On this system the problem can be fixed by
processing the interrupt after resuming, however from the discussion
it seems this isn't universally a good solution.

Not sure if this is just a special case that is best worked around in
the downstream kernel of the device, or if this could affect other
systems and it would be worth to address it upstream (e.g. by
processing the dropped interrupt on resume if MMC_PM_KEEP_POWER is
set and the SDIO interrupt is not configured as wakeup).
