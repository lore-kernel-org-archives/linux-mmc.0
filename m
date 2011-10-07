From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
Date: Fri, 7 Oct 2011 14:23:26 -0700
Message-ID: <20111007212326.GA29003@kroah.com>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
 <1317963790-29426-3-git-send-email-manjugk@ti.com>
 <20111007064928.GE27508@kroah.com>
 <20111007205715.GC5275@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:32842 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752399Ab1JGVYU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2011 17:24:20 -0400
Content-Disposition: inline
In-Reply-To: <20111007205715.GC5275@leaf>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Dilan Lee <dilee@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Manjunath@jasper.es

On Fri, Oct 07, 2011 at 01:57:15PM -0700, Josh Triplett wrote:
> On Thu, Oct 06, 2011 at 11:49:28PM -0700, Greg KH wrote:
> > On Fri, Oct 07, 2011 at 10:33:07AM +0500, G, Manjunath Kondaiah wrote:
> > > +config PROBE_DEFER
> > > +	bool "Deferred Driver Probe"
> > > +	default y
> > > +	help
> > > +	  This option provides deferring driver probe if it has dependency on
> > > +	  other driver. Without this feature, initcall ordering should be done
> > > +	  manually to resolve driver dependencies. This feature completely side
> > > +	  steps the issues by allowing driver registration to occur in any
> > > +	  order, and any driver can request to be retried after a few more other
> > > +	  drivers get probed.
> > 
> > Why is this even an option?  Why would you ever want it disabled?  Why
> > does it need to be selected?
> > 
> > If you are going to default something to 'y' then just make it so it
> > can't be turned off any other way by just not making it an option at
> > all.
> 
> Given that the drivers which use this mechanism will not necessarily get
> built into the kernel, I'd suggest that it should remain optional and
> default to n.  Those drivers can then add a dependency on PROBE_DEFER.
> Let's try to avoid adding more infrastructure to the kernel that takes
> up space even when unused; certainly embedded will appreciate not having
> this feature unless a driver needs it.

How much extra space is this "feature" really?  I don't see it being
anything larger than the amount of memory increase that just happened as
I typed this email as part of the ongoing memory density changes.

greg k-h
