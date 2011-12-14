From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is first claimed
Date: Wed, 14 Dec 2011 11:15:00 +0100
Message-ID: <201112141115.00945.rjw@sisk.pl>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange> <Pine.LNX.4.64.1112131658330.20293@axis700.grange> <4EE865CA.8000407@stericsson.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4EE865CA.8000407@stericsson.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday, December 14, 2011, Ulf Hansson wrote:
> Guennadi Liakhovetski wrote:
> > Hi Ulf
> > 
> > On Tue, 13 Dec 2011, Ulf Hansson wrote:
> > 
> >> Guennadi Liakhovetski wrote:
> >>> Some MMC hosts implement a fine-grained runtime PM, whereby they
> >>> runtime-suspend and -resume the host interface on each transfer. This can
> >>> negatively affect performance, if the user was trying to transfer data
> >>> blocks back-to-back. This patch adds a PM QoS constraint to avoid such a
> >>> throughput reduction. This constraint prevents runtime-suspending the
> >>> device, if the expected wakeup latency is larger than 100us.
> >>>
> >>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >> I think host drivers can use autosuspend with some ms delay for this instead.
> >> This will mean that requests coming in bursts will not be affected (well only
> >> the first request in the burst will suffer from the runtime resume latency).
> > 
> > I think, Rafael is the best person to explain, why exactly this is not 
> > desired. In short, this is the wrong location to make such decisions and 
> > to define these criteria. The only thing, that the driver may be aware of 
> > is how quickly it wants to be able to wake up, if it got suspended. And 
> > it's already the PM subsystem, that has to decide, whether it can satisfy 
> > this requirement or not. Rafael will correct me, if my explanation is 
> > wrong.
> 
> You have a point. But I am not convinced. :-)
> 
> Some host drivers already make use of autosuspend. I think this is most 
> straightforward solution to this problem right now.

The problem is not about _when_ to suspend (which autosuspend is about),
but _what_ _state_ to go when suspended.  That's quite a different issue.

> However, we could also do pm_runtime_get_sync of the host device in 
> claim host and vice verse in release host, thus preventing the host 
> driver from triggering runtime_suspend|resume for every request. Though, 
> I am not 100% sure this is really what you want either.

No, I don't want that.  I want the device to be suspended when possible,
but I don't want that to cause the system to go into an overly deep power
state as a result.

> Using PM QoS as you propose, might prevent some hosts from doing 
> runtime_suspend|resume completely and thus those might not fulfill power 
> consumption requirements instead.

I'm not sure what scenario you have in mind.  Care to elaborate?

> I do not think we can take this decision at this level. Is performance more
> important than power save, that is kind of the question.

Yes, it is.  Also, the number used here is somewhat arbitrary.

However, since no one except for SH7372 is now using device PM QoS, no one
else will be affected by this change at the moment.

Thanks,
Rafael
