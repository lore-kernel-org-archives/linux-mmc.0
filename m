From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] mmc: core: Use autosuspend when applicable at runtime
 idle
Date: Thu, 10 Oct 2013 13:21:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1310101313570.845-100000@iolanthe.rowland.org>
References: <CAPDyKFqnY9rrwgsQmFFu04oSDCtb7GN264sj7wdJs_t6CpOFKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqnY9rrwgsQmFFu04oSDCtb7GN264sj7wdJs_t6CpOFKw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 10 Oct 2013, Ulf Hansson wrote:

> Hi Alan,
> 
> Thanks for response!

You're welcome.

> > I would greatly prefer to see the core rpm_idle() routine changed
> > instead.  Currently the last line says:
> >
> >         return retval ? retval : rpm_suspend(dev, rpmflags);
> >
> > The second argument to rpm_suspend should be rpmflags | RPM_AUTO.  That
> > way, if the runtime-idle callback returns 0, we will automatically do
> > either a normal suspend or an autosuspend, whichever is appropriate.
> 
> I know you guys, Mika and Rafael had a discussion around this feature
> a few month ago. Were thinking of you sending this response. :-)
> 
> At that time, Rafael suggested to go ahead using similar method as I
> implemented here, which is also what Mika proposed for
> drivers/i2c/busses/i2c-designware-platdrv.c, not sure he finally sent
> a formal patch though.

Maybe Rafael wanted to avoid changing a core routine too close to the 
start of an upcoming merge window.  At any rate, IMO it should be 
changed and now seems like a good time to try it.

> Anyway, just wanted us all to be aligned on the best way forward. I am
> also in favour of fixing this in the  runtime PM core. How do you
> think we shall handle drivers that not have the runtime_idle
> callbacks? I guess we want to use the RPM_AUTO flag here as well?

Currently, retval gets set to 0 before the callback is invoked.  If 
there is no callback routine then retval will remain 0.  I agree we 
want to treat this case the same as if the callback had returned 0.

> > As an added benefit, with this change there's no need to add the
> > pm_runtime_autosuspend_used() function.
> 
> In my patch I am also checking if I should update the last busy mark,
> do you mean it should be okay to do this even if not needed?

If the use_autosuspend flag isn't set then the last_busy flag isn't 
used for anything, so updating it won't hurt.

Alan Stern

