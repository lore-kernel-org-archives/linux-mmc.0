From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
Date: Thu, 13 Oct 2011 14:16:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110131413410.2026-100000@iolanthe.rowland.org>
References: <20111013171539.GA18574@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20111013171539.GA18574@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Ming Lei <tom.leiming@gmail.com>, Andrei Warkentin <awarkentin@vmware.com>, Greg KH <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, Manjunath@jasper.es, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-mmc@vger.kernel.org

On Thu, 13 Oct 2011, Grant Likely wrote:

> For the deferred case; here is an example of the additional
> constraint.  Consider the following hierarchy:
> 
> -A
>  +-B
>  | +-C
>  | +-D
>  |
>  +-E
>    +-F
>    +-G
> 
> dpm_list could be ordered in at least the following ways (depending on
> exactly when devices get registered).  There are many permutation, but
> children are always be listed after its direct parent.
> 
> 1) ABECDFG (breadth first)
> 2) AEBFGCD (breadth first)
> 3) ABCDEFG (depth first)
> 4) AEFGBCD (depth first)
> 
> Now, assume that device B depends on device F, and also assume that
> there is no way either to express that in the hierarchy or even for
> the constraint to be known at device registration time (the is exactly
> the situation we're dealing with on embedded platforms).  Only the
> driver for B knows that it needs a resource provided by F's driver.
> So, the situation becomes that the ordering of dpm_list must now also
> be sorted so that non-tree dependencies are also accounted for.  Of
> the list above, only sort order 4 meets the new constraint.
> 
> The question then becomes, how can the dpm_list get resorted
> dynamically at runtime to ensure that the new constraints are always
> met without breaking old ones.  Here are some options I can think of:

This was a long message and I haven't absorbed the whole thing.  
However it's worth pointing out right at the start that we already have
device_pm_move_before(), device_pm_move_after(), and
device_pm_move_last().  They are intended specifically to provide
drivers with a way of making sure that dpm_list is in the right order 
-- people have been aware of these issues for some time.

Alan Stern

