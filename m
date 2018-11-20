From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
Date: Tue, 20 Nov 2018 14:08:28 +0100
Message-ID: <CAPDyKFrFz9bHa5EmiBmQvXnoRibbL4-Gq9E7E5vDBbd=uj_2kA@mail.gmail.com>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com> <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
 <20181107084741.GA31092@kunai> <CAPDyKFpedP1f4XZYvebFCuooYrBa2ux9F9mYRNi1Q=M-5eJ0Rg@mail.gmail.com>
 <20181120102300.GA1056@kunai> <aa26f5dc9e595feb3772495a6d0542c007948f48.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aa26f5dc9e595feb3772495a6d0542c007948f48.camel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, Faiz Abbas <faiz_abbas@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel@collabora.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hongjie Fang <hongjiefang@asrmicro.com>, Bastian Stender <bst@pengutronix.de>, Kyle Roeschley <kyle.roeschley@ni.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Simon Horman <horms+renesas@verge.net.au>, Hal Emmerich <hal@halemmerich.com>
List-Id: linux-mmc@vger.kernel.org

+ Hal Emmerich

On 20 November 2018 at 12:38, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> On Tue, 2018-11-20 at 11:23 +0100, Wolfram Sang wrote:
>> > > > That also happens to be one of the cards we deploy; However i
>> > > > did
>> > > > wonder about adding a quirk but decided against it as it was
>> > > > not clear
>> > > > to me from the specification that CACHE ON really is meant to
>> > > > complete
>> > > > within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in
>> > > > hit-a-
>> > > > mole games as the failure is really quite tedious (boot
>> > > > failure).
>> > >
>> > > I agree that we should use the more defensive variant as a
>> > > default. I
>> > > mean there should be no performance regression since most cards
>> > > will
>> > > respond just faster, or? The only downside I could see is that we
>> > > might
>> > > miss a real timeout with no bounds set and might get stuck?
>> >
>> > Well, you have a point, but still it's kind of nice to know which
>> > cards are behaving well and which ones that doesn't. Hence I think
>> > I
>> > prefer to stick using a quirk, unless you have a strong opinion.
>
> Not an incredibly strong opinion either; I just wonder if it's the
> right trade-off.
>
> If the quirk/work-around is not there while it should be, the impact is
> that you get an unusable card (which for eMMC is likely to mean a
> failure to boot the system). Which is somewhat unfortunate.
>
> If the work-around is there while it's not needed then there doesn't
> seem to be much of an impact at all; Apart from it not being reported
> to the user/developer/kernel community?
>
> In which case it might make more to put in a warning iff the card takes
> too long with a list of cards for which this is known?
>
>> No strong opinion. Especially not if you say it is in the spec
>> (although
>> "must be sufficient" would be better than "should be" ;)). Also, I
>> assume this failure is reproducible and should turn up during
>> development? Compared to "happens once in a while randomly"?
>
> For the card in question it happens only on hard power off; The time it
> takes seems correlated to the state of the cache at hard power off (It
> takes substantially longer if there was a lot of I/O activity at
>  the time of hard power off). With light I/O activity the current
> timeout is sometimes enough.
>
> So if you know the pattern, or just happen to hit it often in e.g.
> automated testing, it does show up during development. Otherwise it can
> appear to "happen once in a while randomly".

I don't quite follow. As far as I understand, the extended timeout is
needed when turning the cache on.

The above seems more related to flushing the cache, no? Flushing have
no timeout (also reported to be an issue [1]), which happens either at
_mmc_hw_reset() or at _mmc_suspend().

What is the relation here?

>
> Unfortunately for me, it was really a case of getting reports of some
> boards started failing at some point which took a while to track back.
> Especially since it's a battery powered device (thus hard poweroffs are
> rather rare) and we allow the board manufactorer to select from various
> different eMMCs depending on price/available at build time...
>
>> Yet, if we add a quirk for that, then we should probably mention it
>> in
>> an error message when we hit -ETIMEDOUT for cache on ("does your card
>> need this quirk?")? It can be pretty time consuming to track this
>> down
>> otherwise, I'd think.
>
> Yes please. It would be nice if someone happens to have the right
> contacts with Micron to see if it's a known issue for their cards in
> general or just this one.
>
> Also would be good to have a timeout higher then 1 seconds (or for
> these cards not have one?); On our testing thusfar we've seen timeouts
> up to 850ms, but it's impossible to ensure that that's the true upper
> bound.

Using no limit of the timeout, would mean we may hang for ~10 minutes
(MMC_OPS_TIMEOUT_MS) instead, no thanks.

I am fine with let's say double of 850ms (1700ms), to have some room.

Anyway, the point is, the timeouts in the spec is there for reason.
Unfortunate I think the spec is "lazy" in some other regards and don't
specify timeouts, which complicates things.

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-mmc/msg51815.html
