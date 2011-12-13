From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is
 first claimed
Date: Tue, 13 Dec 2011 17:13:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1112131658330.20293@axis700.grange>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange>
 <4EE76CC2.9080308@stericsson.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4EE76CC2.9080308@stericsson.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf

On Tue, 13 Dec 2011, Ulf Hansson wrote:

> Guennadi Liakhovetski wrote:
> > Some MMC hosts implement a fine-grained runtime PM, whereby they
> > runtime-suspend and -resume the host interface on each transfer. This can
> > negatively affect performance, if the user was trying to transfer data
> > blocks back-to-back. This patch adds a PM QoS constraint to avoid such a
> > throughput reduction. This constraint prevents runtime-suspending the
> > device, if the expected wakeup latency is larger than 100us.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> I think host drivers can use autosuspend with some ms delay for this instead.
> This will mean that requests coming in bursts will not be affected (well only
> the first request in the burst will suffer from the runtime resume latency).

I think, Rafael is the best person to explain, why exactly this is not 
desired. In short, this is the wrong location to make such decisions and 
to define these criteria. The only thing, that the driver may be aware of 
is how quickly it wants to be able to wake up, if it got suspended. And 
it's already the PM subsystem, that has to decide, whether it can satisfy 
this requirement or not. Rafael will correct me, if my explanation is 
wrong.

> I believe that runtime resume callback should ofcourse be optimized so they
> are executed as fast as possible. But moreover, if they take more 100us, is
> that really a reason for not executing them at all?

I think it is a reason not to execute them during an intensive IO, yes. I 
cannot imagine a case, where if you have multiple IO requests waiting in 
the queue to your medium, you would want to switch off and immediately on 
again. Well, of course, such situations might exist, but then you just 
have to define and use a different governor on your system. This is also 
the flexibility, that this API is giving you.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
