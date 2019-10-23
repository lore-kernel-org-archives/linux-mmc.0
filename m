From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: core: Re-work HW reset for SDIO cards
Date: Wed, 23 Oct 2019 17:06:54 +0200
Message-ID: <CAPDyKFoumdj9u1B4fQh8ws2PqvtYtVekDyq+M4nLs=hriqD-VA@mail.gmail.com>
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-3-ulf.hansson@linaro.org>
 <CAD=FV=XsCGqLwKOicW47Yk3y3mHzU+9fR8kS7jx2pW6SzjgCbg@mail.gmail.com>
 <CAPDyKFq_Utz+ztdXTV534pY9Q9CyTSBJV_mfyPKAsHxaSyZjpA@mail.gmail.com> <CAD=FV=U7Tm0eB00Ze8PUvCvDw_nqHFL6nGO=vEP2t9d-zVveTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=U7Tm0eB00Ze8PUvCvDw_nqHFL6nGO=vEP2t9d-zVveTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 22 Oct 2019 at 16:47, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>
> Hi,
>
> On Mon, Oct 21, 2019 at 11:51 PM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> >
> > > The problem I see here is that callers of this reset function aren't
> > > expecting it to work this way.  Look specifically at
> > > mwifiex_sdio_card_reset_work().  It's assuming that it needs to do
> > > things like shutdown / reinit.  Now it's true that the old
> > > mwifiex_sdio_card_reset_work() was pretty broken on any systems that
> > > also had SDIO bluetooth, but presumably it worked OK on systems
> > > without SDIO Bluetooth.  I don't think it'll work so well now.
> >
> > Good point!
> >
> > I guess I was hoping that running through ->remove() and then
> > ->probe() for the SDIO func drivers should simply take care of
> > whatever that may be needed. In some way this makes the driver broken
> > already in regards to this path, but never mind.
>
> Yeah, probably true.  I guess if anyone actually expected to use one
> of these cards as a removable SDIO card (I have seen such dev boards
> long ago) then it would always have been possible for someone to
> remove the card at just the wrong time and break things.

Well, this isn't solely about card removal but driver removal as well.
And the latter can be managed from user space at any point in time.

>
>
> > > Testing shows that indeed your patch breaks mwifiex reset worse than
> > > it was before (AKA WiFi totally fails instead of it just killing
> > > Bluetooth).
> > >
> > > I think it may be better to add a new API call rather than trying to
> > > co-opt the old one.  Maybe put a WARN_ON() for the old API call to
> > > make people move away from it, or something?
> >
> > Thanks again for testing and for valuable feedback! Clearly this needs
> > a little more thinking.
> >
> > An additional concern I see with the "hotplug approach" implemented in
> > $subject patch, is that it becomes unnecessary heavy when there is
> > only one SDIO func driver bound.
> >
> > In one way I am tempted to try to address that situation, as it seems
> > a bit silly to do full hotplug dance when it isn't needed.
>
> True, though I kinda like the heavy solution here.  At least in the
> mwifiex case this isn't a part of the normal flow.  AKA: we don't call
> this function during normal bootup nor during any normal operations.
> It's much more of an "oh crap, something's not working and we don't
> know what to do" type solution.  I mean, I guess it's still not
> uncommon that we end up in this code path due to the number of bugs in
> Marvell firmware, but I'm just trying to say that it's an error code
> path and not a normal one.  In my mind that means the more things we
> can re-init the better.

You have a point, but...

>
> If this was, on the other hand, a reset that we were supposed to
> always assert when doing a normal operation (like it wants us to reset
> it when we switch modes, or something) then a lighter operation would
> make more sense.

This is indeed the tricky part, as it depends on the level of bugs,
but also under what specific circumstances the reset is getting
called.

In the TI case (drivers/net/wireless/ti/wlcore/sdio.c) the reset is
executed at the "power on" case, which for example is at system
resume. And we want system resume to be as fast as possible...

I am exploring a few options to deal with both cases, let's see what I
can come up with in a day or two.

Kind regards
Uffe
