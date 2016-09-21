From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing
 led
Date: Wed, 21 Sep 2016 10:35:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609211031420.1996-100000@iolanthe.rowland.org>
References: <1474451450.2675.13.camel@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474451450.2675.13.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Micky Ching <micky_ching-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>, Wei WANG <wei_wang-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>, Roger Tseng <rogerable-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 21 Sep 2016, Oliver Neukum wrote:

> On Tue, 2016-09-20 at 10:12 -0400, Alan Stern wrote:
> > On Tue, 20 Sep 2016, Oliver Neukum wrote:
> 
> > That shouldn't be an issue in this case, at least, not with the current 
> > code.  The sdmmc and memstick drivers block autosuspend if media is 
> > present.
> 
> Good.
> > 
> > > > Which means that autosuspend matters only when a card isn't present, 
> > > > and the host is polled every second or so to see whether a card has 
> > > > been inserted.
> > > > 
> > > > Under those circumstances you probably don't want to use
> > > > autosuspend.  
> > > > That is, resuming before each poll and suspending afterward may use 
> > > > less energy than staying at full power all the time.
> > > 
> > > Is that based on concrete figures about power consumption?
> > 
> > No.
> 
> Well, I have no idea how to improve this much without hideous
> overengineering.
> 
> > > And it seems to me that we need a way to indicate that the heuristics
> > > should not be used, but a device immediately suspended. The timer
> > > is sensible only if the next wakeup is unknown.
> > 
> > The driver can always turn off autosuspend if it wants to.
> 
> Yes, but this is not the point. A heuristic with a timeout makes
> sense only if the uses are unpredictable. If you know with a high
> degree of probability when the next activity comes, you ought to either
> suspend now or not all until the next activity.
> 
> Likewise the heuristic is appropriate for leaf nodes. You get nothing
> from a delay on inner nodes.

Almost true, but not quite.  When an inner node has more than one leaf
beneath it, enabling an autosuspend delay for the inner node can make 
sense -- particularly if the leaf activities are uncorrelated.

> Any storage (generic sense) device
> is an inner node. It should suspend immediately after the block
> device which is the leaf node.

Yes.  In this case, however, the USB device has two platform devices 
beneath it: one for SDMMC and one for MemoryStick cards.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
