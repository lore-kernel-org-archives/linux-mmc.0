From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is first claimed
Date: Tue, 13 Dec 2011 22:08:03 +0100
Message-ID: <201112132208.03285.rjw@sisk.pl>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange> <4EE76CC2.9080308@stericsson.com> <Pine.LNX.4.64.1112131658330.20293@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56134 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab1LMVFC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Dec 2011 16:05:02 -0500
In-Reply-To: <Pine.LNX.4.64.1112131658330.20293@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tuesday, December 13, 2011, Guennadi Liakhovetski wrote:
> Hi Ulf
> 
> On Tue, 13 Dec 2011, Ulf Hansson wrote:
> 
> > Guennadi Liakhovetski wrote:
> > > Some MMC hosts implement a fine-grained runtime PM, whereby they
> > > runtime-suspend and -resume the host interface on each transfer. This can
> > > negatively affect performance, if the user was trying to transfer data
> > > blocks back-to-back. This patch adds a PM QoS constraint to avoid such a
> > > throughput reduction. This constraint prevents runtime-suspending the
> > > device, if the expected wakeup latency is larger than 100us.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > I think host drivers can use autosuspend with some ms delay for this instead.
> > This will mean that requests coming in bursts will not be affected (well only
> > the first request in the burst will suffer from the runtime resume latency).
> 
> I think, Rafael is the best person to explain, why exactly this is not 
> desired. In short, this is the wrong location to make such decisions and 
> to define these criteria. The only thing, that the driver may be aware of 
> is how quickly it wants to be able to wake up, if it got suspended. And 
> it's already the PM subsystem, that has to decide, whether it can satisfy 
> this requirement or not. Rafael will correct me, if my explanation is 
> wrong.

It is correct.  More specifically, the problem is, for example, that there
may be two different low-power states of the system that may be entered
when the device is suspended, one of which is relatively shallow, but
having a low exit latency, while the other one is deep with a correspondingly
longer exit latency.  This happens when the device is a member of a power
domain that may be turned off entirely when it is suspended under certain
conditions and at the same time the device's individual clock may be turned
off and on almost instantaneously.  In that case there's no reason to avoid
suspending the device whenever possible, allowing its clock to be turned
off to save energy, but there may be a good reason to avoid turning off the
power domain due to latency constraints.  No amount of playing with
autosuspends is going to help here, unless the driver is aware of the exact
system hardware configuration it is in, which is rather impractical if you
think of universal drivers (such that may be used with different platforms,
for example).

Thanks,
Rafael
