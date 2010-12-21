From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Mon, 20 Dec 2010 19:57:48 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012201946330.19558-100000@netrider.rowland.org>
References: <201012202217.09374.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201012202217.09374.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 20 Dec 2010, Rafael J. Wysocki wrote:

> > > In that case, if a device if flagged as "runtime only", we can avoid
> > > calling pm_runtime_get_noirq() for it in dpm_prepare() and, analogously,
> > > calling pm_runtime_put_sync() for it in dpm_complete().  However, we will have
> > > to fail system suspend (or hibernation) if a "runtime only" device has the
> > > power.runtime_auto flag unset.
> > 
> > Or more generally, if pm_runtime_suspended() doesn't return 'true' for 
> > the device.
> 
> That's not necessary, because the device may be suspended using
> pm_runtime_suspend() later than we check pm_runtime_suspended().

What if the device has a child in the RPM_ACTIVE state?  Then 
pm_runtime_suspend() won't do anything, even if the child really is 
dpm-suspended.

> I'd use the "runtime only" (or perhaps better "no_dpm") flag as a declaration
> (if set) that the device is going to be suspended with the help of "runtime"
> callbacks and the driver takes the responsibility for getting things right.

I'm still not sure about this; the design isn't clear.  Are these
runtime callbacks going to come from the PM core or from the driver?  
If from the driver, how will the driver know when to issue them?  What
about coordinating async suspends (the device must be suspended after
its children and before its parent)?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
