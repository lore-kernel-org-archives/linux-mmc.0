From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing
 led
Date: Thu, 22 Sep 2016 10:00:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609220957460.1835-100000@iolanthe.rowland.org>
References: <1474550656.11364.32.camel@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474550656.11364.32.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wei WANG <wei_wang-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>, Roger Tseng <rogerable-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 22 Sep 2016, Oliver Neukum wrote:

> On Wed, 2016-09-21 at 10:35 -0400, Alan Stern wrote:
> > On Wed, 21 Sep 2016, Oliver Neukum wrote:
> 
> > > Yes, but this is not the point. A heuristic with a timeout makes
> > > sense only if the uses are unpredictable. If you know with a high
> > > degree of probability when the next activity comes, you ought to either
> > > suspend now or not all until the next activity.
> > > 
> > > Likewise the heuristic is appropriate for leaf nodes. You get nothing
> > > from a delay on inner nodes.
> > 
> > Almost true, but not quite.  When an inner node has more than one leaf
> > beneath it, enabling an autosuspend delay for the inner node can make 
> > sense -- particularly if the leaf activities are uncorrelated.
> 
> 
> Well, it is true that an inner node is likelier to be woken up
> depending on the number of children. That is a reason to have a longer
> timeout for an inner node. But it should start when the first node goes
> idle. It makes no sense to start yet another timeout when the last node
> goes idle.
> 
> In terms of mathematics I think we would need to multiply the timeout
> with the square root of busy children and restart it whenever a child
> goes to idle.
> But it seems to me that this is impractical.
> 
> So I would suggest that we are missing an API for drivers to tell the
> core that they become idle for a known period of time and to propagate
> that immediately up if that is the last leaf to become idle.

This seems like over-engineering.  In many cases the driver does not 
know how long the idle period will last.  And it may happen that the 
leaf drivers do not understand the energy tradeoffs involved in 
suspending the ancestor device.

> > > Any storage (generic sense) device
> > > is an inner node. It should suspend immediately after the block
> > > device which is the leaf node.
> > 
> > Yes.  In this case, however, the USB device has two platform devices 
> > beneath it: one for SDMMC and one for MemoryStick cards.
> 
> Indeed, we can hope that the power efficient work queue used will
> join the polling of both devices. Ideally we could model the mutual
> exclusion.

Ulf is going to work on it.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
