From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Tue, 20 Sep 2016 11:43:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609201141591.1379-100000@iolanthe.rowland.org>
References: <1474384626.21100.6.camel@researchut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474384626.21100.6.camel-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Dubov <oakad-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 20 Sep 2016, Ritesh Raj Sarraf wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Hello Alan,
> 
> On Tue, 2016-09-20 at 10:16 -0400, Alan Stern wrote:
> > This is a lot better.  No more I/O errors.
> > 
> > We still have irregular suspends and resumes, but that's to be 
> > expected.  More worrying are the spontaneous disconnects.  They don't 
> > seem to be related to the suspend/resume activity.
> > 
> > You can disable suspend for this device entirely by doing:
> > 
> >         echo on >/sys/bus/usb/devices/2-4/power/control
> > 
> 
> Yes. But that'd also mean to write that value upon every suspend/resume cycle
> because the rtsx usb driver still declares support for autosuspend.
> Should that be dropped ?

No, the value doesn't change across a suspend/resume cycle.

> > I'm afraid that this won't prevent the device from disconnecting
> > itself, though.  This appears to be some sort of hardware bug that
> > can't be fixed in software.
> 
> And that'd mean that upon every reset, the driver will again enable autosuspend
> for that driver.

Yes, that's true.  I'm curious to see if preventing autosuspends will 
get rid of the resets.  My guess is that it won't.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
