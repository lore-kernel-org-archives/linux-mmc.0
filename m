From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: core: Attach PM domain prior probing of SDIO func
 driver
Date: Tue, 2 Jun 2015 16:06:17 +0100
Message-ID: <20150602150617.GF2067@n2100.arm.linux.org.uk>
References: <1433153905-25204-1-git-send-email-ulf.hansson@linaro.org>
 <20150601194209.GB30024@dtor-ws>
 <CAPDyKFr+SucSGZRigc4a6zei9TR4f5TuNHXTqWDDj2YQK1yn5A@mail.gmail.com>
 <20150602085101.GY2067@n2100.arm.linux.org.uk>
 <20150602110715.GA20704@n2100.arm.linux.org.uk>
 <CAPDyKFrxjnTUE2W9PGS4=TJeW9ODiL7=UnBtMLALpbLfXotcxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:60123 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbbFBPG2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jun 2015 11:06:28 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFrxjnTUE2W9PGS4=TJeW9ODiL7=UnBtMLALpbLfXotcxw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Aaron Lu <aaron.lu@intel.com>

On Tue, Jun 02, 2015 at 03:18:07PM +0200, Ulf Hansson wrote:
> On 2 June 2015 at 13:07, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jun 02, 2015 at 09:51:01AM +0100, Russell King - ARM Linux wrote:
> >> What would resolve that would be to have the device registration succeed,
> >> but also to scan all devices in the system when a PM domain is attached
> >> and attach the PM domain to matching devices.  The problem you then have
> >> is the same race between attaching the PM domain to all devices in the
> >> domain, and devices being probed.  Remember, this may not be happening at
> >> boot time, but during module load, which on some systems is multithreaded.
> >> So, the problem of not having all devices in the PM domain hasn't changed
> >> and nothing is solved by this approach - the only thing is the code has
> >> become more complex.
> >>
> >> I don't think that's an improvement.
> >
> > Another idea, which I came up with while replying to Ivan on a different
> > but related topic is:
> >
> > * When we create a device which we know has a PM domain which should be
> >   attached, try to look up that PM domain.
> > * If we find the PM domain, attach the domain, otherwise create the
> >   domain but mark it "incomplete".
> > * When the device is attempted to be probed, force the probe to defer if
> >   the PM domain is inccomplete.
> > * When a PM domain is initialised, search for any incomplete PM domain,
> >   and if found, connect with the domain and arrange to handle it.
> 
> This is a good description from what I had in mind and for what I have
> started working on. :-)

It would help if you explained things better, since your original
comment made it sound like you were intending to _only_ attach PM
domains at device probe time.

> > The problem you still run into is whether all devices have been registered
> > into the domain, but I really think that expecting all devices to be
> > registered is in itself a problem.
> >
> > Consider the case where a PM domain spreads between a parent device (eg,
> > a bridge) and a set of child devices.  We may need to probe the bridge
> > in order to discover and register the child devices.  If we're expecting
> > the PM domain to be fully populated with all devices before that happens,
> > we're in a catch-22 situation: we can't register the child devices until
> > the bridge has been probed, and we can't probe the bridge because the
> > PM domain is incomplete.
> 
> I think I understand what you have in mind and it's an important point!
> 
> Although, I have some ideas for how we could allow the PM domain to be
> initialized independently of whether all devices has been attached or
> not. That would address your concerns, right!?

Yes, but then I end up wondering what the point of changing this stuff
is.  It sounds like it's change for the sake of change rather than for
any proper tangible benefit.

> > I don't think there's a good answer to that one, not without going back
> > to today's model, where a PM domain is able to be brought up and down
> > without all of its associated devices attached.  That, in itself, should
> > not be a problem since drivers should _not_ assume that the device has
> > any context preserved from the last time it saw it (eg, consider the
> > random state of a device when a crashed kernel kexecs into a new kernel.)
> > Doing anything else is just fragile.
> 
> I agree that today's model has some positives, but there are also
> drawbacks. See below.
> 
> 1. In the case where the PM domain driver hasn't yet been probed and
> thus not called pm_genpd_init() + of_genpd_add_provider_*(), we can't
> support probe deferral of a device which needs its PM domain powered.
> Simply because dev_pm_domain_attach() has no knowledge about the (not
> yet registered) PM domain.

Why can't we do something like the clk API, regulator API, or of the
many other resource providing subsystems, and detect when there's an
firmware node saying that a resource should be provided to a device,
but the resource is not yet available?

For example, if you call clk_get() for a device and clock consumer name
and firmware says that the clock should exist, but it can't be found,
clk_get() returns an EPROBE_DEFER error-pointer.  Same for the regulator
subsystem.  IRQ domains behave very similarly, but earlier on before the
device driver's probe function is called.

Why can't PM domains also follow this model?

> 2. We can't attach a devices to its PM domain via DT, unless it has a
> matching bus/driver which can be probed.
> 
> 3. Dealing with device enumeration from HW is fragile, since there are
> no way to keep the PM domain powered during that sequence. That's
> because the PM domain hasn't yet been attached. For example
> amba_device_add() has this limitation.

Stop right there.  Device enumeration from hardware is _not_ fragile,
it's what is used on virtually all PCI-using platforms out there.  If
you invent something that takes the kernel away from being able to do
hardware enumeration, you will be breaking lots of stuff outside the
ARM architecture and you will _not_ be popular.

You're working on a core subsystem, and you _have_ to realise that the
world is not made up of DT - you have to cater for other probing styles
besides DT, which includes hardware based enumeration.   You can't say
"we're not going to support that anymore" - that's not your decision to
make.

Yes, amba_device_add() has the limitation that the ID must be readable
when the device is declared, and we can't do much about that because
the ID is exported to userspace - hence it's part of the kernel's
userspace API.  Changing it is going to risk breaking userspace, so
we need to be careful about what we do there - but that's my problem,
not yours.  I know Linaro likes to take chunks of the kernel away from
me without talking to me first, but I do wish they wouldn't.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
