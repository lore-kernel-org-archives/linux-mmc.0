From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Fri, 10 Dec 2010 23:01:06 +0100
Message-ID: <201012102301.06772.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1012101202040.2521-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45338 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756199Ab0LJWCE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Dec 2010 17:02:04 -0500
In-Reply-To: <Pine.LNX.4.44L0.1012101202040.2521-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>

On Friday, December 10, 2010, Alan Stern wrote:
> On Fri, 10 Dec 2010, Rafael J. Wysocki wrote:
> 
> > On Friday, December 10, 2010, Ohad Ben-Cohen wrote:
> > > When pm_runtime_put_sync() returns, the _put operation is completed,
> > > and if needed (zero usage_count, children are ignored or their count
> > > is zero, ->runtime_idle() called pm_runtime_suspend(), no
> > > runtime_error, no disable_depth, etc...) the device is powered down.
> > > 
> > > This behavior is sometimes desirable and even required: drivers may
> > > call pm_runtime_put_sync() and rely on PM core to synchronously power
> > > down the device.
> 
> That would be a mistake.  The "sync" in pm_runtime_put_sync means that
> _if_ a runtime_suspend call occurs, the call will occur synchronously.  
> It does not guarantee that a runtime_suspend call will occur.
> 
> > > This is usually all good, but when we combine this requirement with
> > > logical sub-devices that cannot be power-managed on their own (e.g.
> > > SDIO functions), things get a bit racy, since their parent is not
> > > suspended synchronously (the sub-device is rpm_suspend()'ed
> > > synchronously, but its parent is pm_request_idle()ed, which is
> > > asynchronous in nature).
> > > 
> > > Since drivers might rely on pm_runtime_put_sync() to synchronously
> > > power down the device,
> 
> Drivers should never do this.
> 
> > >  if that doesn't happen, a rapid subsequent
> > > pm_runtime_get{_sync} might cancel the suspend. This can lead the
> > > driver, e.g., to reinitialize a device that wasn't powered down, and
> > > the results can be fatal.
> 
> What if the device's usage_count was larger than 1?  Then 
> pm_runtime_put_sync() wouldn't cause a suspend in any case.
> 
> It sounds like the reinitialization is done at the wrong time.  It
> should occur when the parent is resumed, since we are assuming the
> parent controls the device's power.  Then if the device doesn't get
> powered down because the parent's suspend was cancelled, there would be
> no reinitialization and nothing would go wrong.
> 
> > > One possible solution is to call pm_runtime_idle(parent), instead of
> > > pm_request_idle(parent), when a no_callbacks device is suspended:
> 
> What if something else has incremented the parent's usage_count?  Then 
> the driver will get into trouble regardless of which idle call is made 
> for the parent.  The real issue here is that the driver is making a bad 
> assumption.
> 
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 02c652b..d7659d3 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -407,7 +407,10 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> > >         if (parent && !parent->power.ignore_children) {
> > >                 spin_unlock_irq(&dev->power.lock);
> > > 
> > > -               pm_request_idle(parent);
> > > +               if (dev->power.no_callbacks)
> > > +                       pm_runtime_idle(parent);
> > > +               else
> > > +                       pm_request_idle(parent);
> > > 
> > >                 spin_lock_irq(&dev->power.lock);
> > >         }
> 
> I'm okay with this change.  It makes sense, even though it's not the 
> proper solution to the problem described above.

I agree.

> > > This solution assumes that such sub-devices don't really need to have
> > > callbacks of their own. It would work for SDIO, since we are
> > > effectively no_callbacks devices anyway, and it only seems reasonable
> > > to set SDIO functions as no_callbacks devices.
> > > 
> > > A different, bolder solution, will always call pm_runtime_idle instead
> > > of pm_request_idle (see below): when a device is runtime suspended, it
> > > can't be too bad to immediately send idle notification to its parent,
> > > too. I'm aware this might not always be desirable, but I'm bringing
> > > this up even just for the sake of discussion:
> > > 
> > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > index 02c652b..9719811 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -407,7 +407,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> > >         if (parent && !parent->power.ignore_children) {
> > >                 spin_unlock_irq(&dev->power.lock);
> > > 
> > > -               pm_request_idle(parent);
> > > +               pm_runtime_idle(parent);
> > > 
> > >                 spin_lock_irq(&dev->power.lock);
> > >         }
> > 
> > I acutally think we can do that.  If the parent cannot be suspended,
> > pm_runtime_idle() will just return, which is fine.  Right now I don't see
> > any big drawback of this.
> > 
> > Alan, what do you think?
> 
> I don't like this change quite so much.  It can give rise to unbounded
> nested suspend sequences: we suspend the device, then call the parent's
> runtime_idle routine which suspends the parent, then we call the
> grandparent's runtime_idle routine, etc.
> 
> Of course, we already do the same thing with nested resumes, so this
> wouldn't be awful.  I won't NAK it.

OK.  I thought it would be kind of symmetrical with the resume case, but we
really need to do that for the resume and for suspend it would be a little
artificial.

I prefer the first patch, so Ohad, if you want it merged, please resend with
a sign-off etc.

> On the other hand, neither of these patches really addresses Ohad's 
> underlying problem.  That can be fixed only by changing the driver.

Agreed.

Thanks,
Rafael
