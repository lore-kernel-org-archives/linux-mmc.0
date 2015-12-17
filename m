From: David Jander <david@protonic.nl>
Subject: Re: SDHCI long sleep with interrupts off
Date: Thu, 17 Dec 2015 16:09:03 +0100
Message-ID: <20151217160903.556af1af@archvile>
References: <20151217112814.6250a3b9@archvile>
	<1450350190.3163.93.camel@pengutronix.de>
	<20151217122053.036daf37@archvile>
	<1450351655.3163.97.camel@pengutronix.de>
	<CAPDyKFosBeyP3YYXz-1uyiqoaLuMQj3+ojzpt1-QY7JU9epggw@mail.gmail.com>
	<20151217132229.1c699f69@archvile>
	<CAPDyKFpxx5oXM=MAYcdg1fBiodOo2HjoEvHmZk9nHBCW=qqBQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpxx5oXM=MAYcdg1fBiodOo2HjoEvHmZk9nHBCW=qqBQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


Dear Ulf,

On Thu, 17 Dec 2015 15:54:54 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> [...]
> 
> >> If/when you decide to fix this issue. Please keep in mind the following
> >> things.
> >>
> >> - Try to convert the SDHCI into a pure library. No more quirks or
> >> callbacks.
> >> - I assume we can simplify lots of code if we convert SDHCI into using
> >> a threaded IRQ in favour of the tasklet.
> >>
> >> Any patches that moves SDHCI into this direction will be greatly
> >> appreciated!
> >
> > Ok, this sounds like a good way to go. Unfortunately it also sounds like a
> > major endeavor, for which good knowledge of the SDHCI standard is
> > necessary. This knowledge is based on documentation that is not openly
> > available without cost AFAIK. This probably also explains why there hasn't
> > been a real fix ever. On top of that, the whole sdhci code is unmaintained
> > currently as it seems. I was studying the code a bit more, and I now
> > understand that I am not even close to having the experience and
> > standards-knowledge it takes to pull this off reliably. I guess the one
> > who takes on this task may as well become official maintainer afterwards...
> 
> You are right, a maintainer is needed for sdhci.
> 
> Also, I am a bit surprised that none have stepped up, especially since
> it's indeed being *very* widely used.

So, you probably understand my surprise as for the state of things. I am only
casually walking by because I have a latency problem....

> > OTOH, we pretty much depend on this driver now, since all of our new
> > i.MX6/7 boards have eMMC flash. We also use the flexcan peripheral on all
> > designs, which is specially sensible to these latency spikes, so we will
> > have to do something on the long run.... we cannot live forever with
> > disabled PM ;-)
> >
> 
> Unfortunate, PM is only one of the problems.

I already had that suspicion while looking at the code...

> The code is in general fragile. We have have kind of reached the
> point, when I apply changes that fixes one issue it may cause another.

Oh, that is indeed bad.
I wish I was in the position to do this... but this really goes beyond my time
and my knowledge. I think most of the effort will be at cleaning up the mess
and make sure that each one of the many users works well afterwards, and it
definitely takes someone who knows the code (and it's users) very well to pull
this off.

Best regards,

-- 
David Jander
Protonic Holland.
