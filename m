From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
Date: Tue, 20 Nov 2018 15:00:13 +0100
Message-ID: <515b72f2bd526d144fdc662126aa6e1e8484a25c.camel@collabora.co.uk>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
         <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
         <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
         <20181107084741.GA31092@kunai>
         <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
         <20181120102300.GA1056@kunai>
         <aa26f5dc9e595feb3772495a6d0542c007948f48.camel@collabora.co.uk>
         <CAPDyKFrFz9bHa5EmiBmQvXnoRibbL4-Gq9E7E5vDBbd=uj_2kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrFz9bHa5EmiBmQvXnoRibbL4-Gq9E7E5vDBbd=uj_2kA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Faiz Abbas <faiz_abbas@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel@collabora.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hongjie Fang <hongjiefang@asrmicro.com>, Bastian Stender <bst@pengutronix.de>, Kyle Roeschley <kyle.roeschley@ni.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Simon Horman <horms+renesas@verge.net.au>, Hal Emmerich <hal@halemmerich.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2018-11-20 at 14:08 +0100, Ulf Hansson wrote:
> + Hal Emmerich
> 
> On 20 November 2018 at 12:38, Sjoerd Simons
> <sjoerd.simons@collabora.co.uk> wrote:
> > On Tue, 2018-11-20 at 11:23 +0100, Wolfram Sang wrote:
> > > > > > 
> > So if you know the pattern, or just happen to hit it often in e.g.
> > automated testing, it does show up during development. Otherwise it
> > can
> > appear to "happen once in a while randomly".
> 
> I don't quite follow. As far as I understand, the extended timeout is
> needed when turning the cache on.
> 
> The above seems more related to flushing the cache, no? Flushing have
> no timeout (also reported to be an issue [1]), which happens either
> at
> _mmc_hw_reset() or at _mmc_suspend().
> 
> What is the relation here?

Yes it's the kinda of behaviour you would expect on a flush indeed! I
don't know what the card actaully does when turning the cache on,
whether it's actually flush of something persistent when turning the
cache on after a hard poweroff or doing some other validation. 

All i can share is what our testing seems to indicate, which is that
there is a wide spread in the time the card needs *and* there seems to
be strong correlation to the I/O activity before the hard power off and
the time taken by "cache on". 

> > Unfortunately for me, it was really a case of getting reports of
> > some
> > boards started failing at some point which took a while to track
> > back.
> > Especially since it's a battery powered device (thus hard poweroffs
> > are
> > rather rare) and we allow the board manufactorer to select from
> > various
> > different eMMCs depending on price/available at build time...
> > 
> > > Yet, if we add a quirk for that, then we should probably mention
> > > it
> > > in
> > > an error message when we hit -ETIMEDOUT for cache on ("does your
> > > card
> > > need this quirk?")? It can be pretty time consuming to track this
> > > down
> > > otherwise, I'd think.
> > 
> > Yes please. It would be nice if someone happens to have the right
> > contacts with Micron to see if it's a known issue for their cards
> > in
> > general or just this one.
> > 
> > Also would be good to have a timeout higher then 1 seconds (or for
> > these cards not have one?); On our testing thusfar we've seen
> > timeouts
> > up to 850ms, but it's impossible to ensure that that's the true
> > upper
> > bound.
> 
> Using no limit of the timeout, would mean we may hang for ~10 minutes
> (MMC_OPS_TIMEOUT_MS) instead, no thanks.

Probably a silly question, but would this actually cause e.g. boot to
hang while waiting for the card (assuming rootfs is somewhere else)?

> I am fine with let's say double of 850ms (1700ms), to have some room.
> 

> Anyway, the point is, the timeouts in the spec is there for reason.
> Unfortunate I think the spec is "lazy" in some other regards and
> don't
> specify timeouts, which complicates things.


-- 
Sjoerd Simons
Collabora Ltd.
