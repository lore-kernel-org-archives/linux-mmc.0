From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: core: Run handlers for pending SDIO interrupts
 on resume
Date: Fri, 30 Aug 2019 08:08:18 +0200
Message-ID: <CAPDyKFo-NkkYyNNxtU9PpP7aG5zRd-pXsxOujdN53J=uAezieA@mail.gmail.com>
References: <20190828214620.66003-1-mka@chromium.org> <20190828214620.66003-2-mka@chromium.org>
 <CAPDyKFr2R-ta5Xob12-6k=+mXXt0NowJ=dpLGJu10qhn7cB1HQ@mail.gmail.com>
 <20190829171555.GD70797@google.com> <CAD=FV=VhAFGZusYac8hqYNZ9t+ipTZ5EAo5qY5+A8jA4xjw2vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VhAFGZusYac8hqYNZ9t+ipTZ5EAo5qY5+A8jA4xjw2vg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 29 Aug 2019 at 19:40, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Aug 29, 2019 at 10:16 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > > In one way, this change makes sense as it adopts the legacy behavior,
> > > signaling "cached" SDIO IRQs also for the new SDIO irq work interface.
> > >
> > > However, there is at least one major concern I see with this approach.
> > > That is, in the execution path for sdio_signal_irq() (or calling
> > > wake_up_process() for the legacy path), we may end up invoking the
> > > SDIO func's ->irq_handler() callback, as to let the SDIO func driver
> > > to consume the SDIO IRQ.
> > >
> > > The problem with this is, that the corresponding SDIO func driver may
> > > not have been system resumed, when the ->irq_handler() callback is
> > > invoked.
> >
> > While debugging the the problem with btmrvl I found that this is
> > already the case without the patch, just not during resume, but when
> > suspending. The func driver suspends before the SDIO bus and
> > interrupts can keep coming in. These are processed while the func
> > driver is suspended, until the SDIO core starts dropping the
> > interrupts.
> >
> > And I think it is also already true at resume time: mmc_sdio_resume()
> > re-enables SDIO IRQs and disables dropping them.
>
> I would also note that this matches the design of the normal system
> suspend/resume functions.  Interrupts continue to be enabled even
> after the "suspend" call is made for a device.  Presumably this is so
> that the suspend function can make use of interrupts even if there is
> no other reason.

I understand and you have a good point!

However, in my experience, the most common generic case, is that it's
a bad idea to let a device process interrupts once they have been
suspended. This also applies to runtime suspend (via runtime PM).

> If it's important for a device to stop getting
> interrupts after the "suspend" function is called then it's up to that
> device to re-configure the device to stop giving interrupts.

Again, you have a very good point. The corresponding driver for the
device in question is responsible for dealing with this.

Then, for this particular case, the SDIO func driver scenario, how
would that work?

For example, assume that the SDIO func driver can't process IRQs after
its been system suspended, however it still wants the IRQs to be
re-kicked to consume them once it has been resumed?

Or are you saying that the SDIO func driver for cases when IRQs can't
be consumed during system suspend, that is should call
sdio_release_irq() (then reclaim the IRQ once resumed)?

Kind regards
Uffe
