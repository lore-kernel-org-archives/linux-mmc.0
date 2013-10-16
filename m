From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3] PM / Runtime: Respect autosuspend when idle triggers suspend
Date: Wed, 16 Oct 2013 02:21:29 +0200
Message-ID: <5764286.HPu6e8VtQu@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1310151643240.1377-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52383 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759727Ab3JPAJj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Oct 2013 20:09:39 -0400
In-Reply-To: <Pine.LNX.4.44L0.1310151643240.1377-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Hilman <khilman@linaro.org>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Tuesday, October 15, 2013 04:43:38 PM Alan Stern wrote:
> On Tue, 15 Oct 2013, Ulf Hansson wrote:
> 
> > For devices which don't have a .runtime_idle callback or if it returns
> > 0, rpm_idle will end up in triggering a call to rpm_suspend, thus
> > trying to carry out a runtime_suspend directly from runtime_idle.
> > 
> > In the above situation we want to respect devices which has enabled
> > autosuspend, we therfore append the flag sent to rpm_suspend with
> > RPM_AUTO.
> > 
> > Do note that drivers still needs to update the device last busy mark,
> > to control the delay for this circumstance.
> > 
> > Updated runtime PM documentation accordingly.
> > 
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Kevin Hilman <khilman@linaro.org>
> > Cc: Rob Landley <rob@landley.net>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc@vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Acked-by: Kevin Hilman <khilman@linaro.org>
> > ---
> >  Documentation/power/runtime_pm.txt |   14 ++++++++------
> >  drivers/base/power/runtime.c       |    5 +++--
> >  2 files changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> > index 71d8fe4..0f54333 100644
> > --- a/Documentation/power/runtime_pm.txt
> > +++ b/Documentation/power/runtime_pm.txt
> > @@ -145,11 +145,13 @@ The action performed by the idle callback is totally dependent on the subsystem
> >  if the device can be suspended (i.e. if all of the conditions necessary for
> >  suspending the device are satisfied) and to queue up a suspend request for the
> >  device in that case.  If there is no idle callback, or if the callback returns
> > -0, then the PM core will attempt to carry out a runtime suspend of the device;
> > -in essence, it will call pm_runtime_suspend() directly.  To prevent this (for
> > -example, if the callback routine has started a delayed suspend), the routine
> > -should return a non-zero value.  Negative error return codes are ignored by the
> > -PM core.
> > +0, then the PM core will attempt to carry out a runtime suspend of the device,
> > +also respecting devices configured for autosuspend.  In essence this means a
> > +call to pm_runtime_autosuspend() (do note that drivers needs to update the
> > +device last busy mark, pm_runtime_mark_last_busy(), to control the delay under
> > +this circumstance).  To prevent this (for example, if the callback routine has
> > +started a delayed suspend), the routine must return a non-zero value.  Negative
> > +error return codes are ignored by the PM core.
> >  
> >  The helper functions provided by the PM core, described in Section 4, guarantee
> >  that the following constraints are met with respect to runtime PM callbacks for
> > @@ -308,7 +310,7 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
> >      - execute the subsystem-level idle callback for the device; returns an
> >        error code on failure, where -EINPROGRESS means that ->runtime_idle() is
> >        already being executed; if there is no callback or the callback returns 0
> > -      then run pm_runtime_suspend(dev) and return its result
> > +      then run pm_runtime_autosuspend(dev) and return its result
> >  
> >    int pm_runtime_suspend(struct device *dev);
> >      - execute the subsystem-level suspend callback for the device; returns 0 on
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 268a350..72e00e6 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -258,7 +258,8 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> >   * Check if the device's runtime PM status allows it to be suspended.  If
> >   * another idle notification has been started earlier, return immediately.  If
> >   * the RPM_ASYNC flag is set then queue an idle-notification request; otherwise
> > - * run the ->runtime_idle() callback directly.
> > + * run the ->runtime_idle() callback directly. If the ->runtime_idle callback
> > + * doesn't exist or if it returns 0, call rpm_suspend with the RPM_AUTO flag.
> >   *
> >   * This function must be called under dev->power.lock with interrupts disabled.
> >   */
> > @@ -331,7 +332,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
> >  
> >   out:
> >  	trace_rpm_return_int(dev, _THIS_IP_, retval);
> > -	return retval ? retval : rpm_suspend(dev, rpmflags);
> > +	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
> >  }
> >  
> >  /**
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

I've queued up this patch for 3.13.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
