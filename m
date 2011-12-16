From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is
 first claimed
Date: Fri, 16 Dec 2011 10:14:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1112160954030.6572@axis700.grange>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange>
 <201112141115.00945.rjw@sisk.pl> <4EE8849D.1010401@stericsson.com>
 <201112142236.26739.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51614 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756260Ab1LPJOO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Dec 2011 04:14:14 -0500
In-Reply-To: <201112142236.26739.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, 14 Dec 2011, Rafael J. Wysocki wrote:

> On Wednesday, December 14, 2011, Ulf Hansson wrote:

[snip]

> > 2.
> > When executing mmc/sd commands/requests the host must always be claimed 
> > (and thus the host is always enabled).

Why? Why cannot we save some power between IO operations - if we can do 
this quickly and safely without affecting functionality and throughput?

> > But more important some mmc/sd 
> > commands must be executed as a sequence, without the host being disabled 
> > in between the commands (since a disable might mean that the clock to 
> > card gets disabled).

Ok, there might well be such command sequences, but my question is: who 
knows about them? Is this mandated by the MMC(/SD/SDIO/...) standard or is 
it host-specific? Also "might mean" is actually interesting here. I think 
we eventually need a combination of timing-oriented PM constraints and 
"stateful" ones. During such a command sequence you would require the card 
clock to stay on.

> > To solve this, the mmc_claim_host is used, to make 
> > sure the host is enabled during the complete command sequence.
> > 
> > I happily continue this discussion, to see if someone more can break the 
> > idea about having get_sync in mmc_host_enable. :-)
> 
> I'll leave this one to Guennadi, if you don't mind. :-)

As I said above, I think, we need both - to be able to require a certain 
responsiveness / throughput and specific interface parameters like 
supplying clock, power, etc.

Also notice, that setting a constraint doesn't affect in principle, when 
the device is allowed to suspend. This is done as usual per 
pm_runtime_get*() and _put*(). I think, a reasonable solution to use PM 
QoS to impose timing constraints but at the same time to not disable the 
hardware, when this is disallowed, is to tie pm_runtime_get() and _put() 
calls to driver's .set_ios() method, like tmio_mmc and sh_mmcif drivers 
currently do. Those drivers only call pm_runtime_put() when the interface 
clock is gated. So, as long as the core is aware, that that IO sequence 
has to run uninterrupted without stopping the clock between single 
transfers, it just has to avoid gating the clock for that period and the 
interface will not enter any power-saving mode.

So, I don't think we need to enforce pm_runtime_get_sync() in 
mmc_claim_host().

Thanks
Guennadi

> > >> Using PM QoS as you propose, might prevent some hosts from doing 
> > >> runtime_suspend|resume completely and thus those might not fulfill power 
> > >> consumption requirements instead.
> > > 
> > > I'm not sure what scenario you have in mind.  Care to elaborate?
> > 
> > Well, suppose a the host drivers start considering the PM QoS 
> > requirement, but never can fulfill the requirement of 100us for it's 
> > runtime_suspend callback function...
> 
> OK, that's a valid concern.  This means there should be a way for user space
> to specify the constraint somehow, because it's a user space's role to define
> policies.
> 
> > >> I do not think we can take this decision at this level. Is performance more
> > >> important than power save, that is kind of the question.
> > > 
> > > Yes, it is.  Also, the number used here is somewhat arbitrary.
> > 
> > For you maybe power management is less important, but I doubt everybody 
> > else agree to that. It is a more complex balance I believe.
> 
> You're right.
> 
> > > However, since no one except for SH7372 is now using device PM QoS, no one
> > > else will be affected by this change at the moment.
> > 
> > True, but that is not a good reason for adding more stuff to the mmc core.
> 
> Good point.
> 
> Thanks,
> Rafael
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
