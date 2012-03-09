From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] PM / QoS: Make it possible to expose PM QoS latency
 constraints
Date: Fri, 9 Mar 2012 10:17:32 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1203091015290.1527-100000@iolanthe.rowland.org>
References: <87lina7fj9.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40790 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757092Ab2CIPRe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Mar 2012 10:17:34 -0500
In-Reply-To: <87lina7fj9.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Thu, 8 Mar 2012, Kevin Hilman wrote:

> >> > The word "wakeup" may refer to many different things, as well as the word
> >> > "resume". :-)
> >> 
> >> Yes, but what's the confusion in this case?
> >> 
> >> IMO, The existing /sys/devices/.../power/wakeup* meaning is the same
> >> meaning as as for the wakeup latency in this patch,
> >
> > No, it is not.  They refer to system wakeup. :-)
> 
> OK, now I'm confused (again).  I thought those could be used for runtime
> PM wakeups also.  At least I was planning on using them for any kind of
> wakeup.
> 
> >> so I don't understand where the confusion would be.
> >
> > See above. ;-)
> 
> Sheesh, this is getting ugly.
> 
> So wakeup*  attributes refer to system resume and resume* attribues
> refer to runtime PM.
> 
> Yuck.

How about calling it "runtime latency"?  Or "runtime wakeup latency" in 
case people think there might be some other sort of latency associated 
with runtime power management.

Alan Stern

