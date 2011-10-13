From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
Date: Thu, 13 Oct 2011 12:04:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1110131202350.2026-100000@iolanthe.rowland.org>
References: <CACVXFVMoac7psbfO6UdDvNux4c8bQYS4YNUdz1C-o+CiJzyuZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59313 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753443Ab1JMQE0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2011 12:04:26 -0400
In-Reply-To: <CACVXFVMoac7psbfO6UdDvNux4c8bQYS4YNUdz1C-o+CiJzyuZA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Andrei Warkentin <awarkentin@vmware.com>, Greg KH <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, Manjunath@jasper.es, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux PM List <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, 13 Oct 2011, Ming Lei wrote:

> Hi,
> 
> On Thu, Oct 13, 2011 at 10:31 PM, Alan Stern <stern@rowland.harvard.edu>
> >> Maybe we should understand the correct model of the ordering constraints
> >> for the multiple device dependancies first, could you give a description or
> >> some examples about it?
> >
> > The requirement is that devices must be capable of resuming in the
> > order given by dpm_list, and they must be capable of suspending in
> > the reverse order.
> >
> > Therefore if device A can't work unless device B is functional, then B
> > must come before A in dpm_list.
> 
> If all devices can support async suspend and resume correctly, looks like
> the device order given by dpm_list is not needed any longer, doesn't it?

It _is_ needed, because the user can disable async suspend/resume via 
/sys/power/pm_async.

Also, not all devices do support async suspend/resume.

Alan Stern

