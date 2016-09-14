From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Wed, 14 Sep 2016 11:19:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609141101380.1576-100000@iolanthe.rowland.org>
References: <1473864634.9913.12.camel@researchut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473864634.9913.12.camel-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 14 Sep 2016, Ritesh Raj Sarraf wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Hello Ulf and Alan,
> 
> On Fri, 2016-09-09 at 19:34 +0530, Ritesh Raj Sarraf wrote:
> > For #2, I'm building the 4.8-rc5 kernel with the following change. This build
> > does not include the previous change you had suggested (related to
> > POWER_CYCLE)
> > 
> > Date:   Fri Sep 9 19:28:03 2016 +0530
> > 
> >     Disable pm runtime in mmc core
> > 
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index e55cde6..32388d5 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -970,9 +970,6 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t
> > *abort)
> >         spin_unlock_irqrestore(&host->lock, flags);
> >         remove_wait_queue(&host->wq, &wait);
> >  
> > -       if (pm)
> > -               pm_runtime_get_sync(mmc_dev(host));
> > -
> >         return stop;
> >  }
> >  EXPORT_SYMBOL(__mmc_claim_host);
> > @@ -1000,7 +997,6 @@ void mmc_release_host(struct mmc_host *host)
> >                 spin_unlock_irqrestore(&host->lock, flags);
> >                 wake_up(&host->wq);
> >                 pm_runtime_mark_last_busy(mmc_dev(host));
> > -               pm_runtime_put_autosuspend(mmc_dev(host));
> >         }
> >  }
> >  EXPORT_SYMBOL(mmc_release_host);
> 
> I tried with these changes on 4.8-rc6 and I only saw 2 resets so far.
> I captured the usb trace [1], just in case if you need it.
> 
> [1] https://people.debian.org/~rrs/tmp/4.8-rc6-ulf.txt.gz

The situation isn't any better.  At the start of the trace, 
the device is in runtime suspend but there are many attempts to 
communicate with it, all of which fail.

Then a little less than an hour after the trace started, the device was 
resumed.  At that point it started working okay.  Until there was a 
spontaneous disconnect.

The device reconnected, but after 3 seconds it was runtime suspended 
again -- and the I/O attempts continued.  Some time later there was 
another runtime resume, and the device began working again.  Until 
another spontaneous disconnect occurred.  And so on...

Ulf, we really need to figure out why the autosuspends are occurring 
and why the I/O doesn't stop while the device is suspended.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
