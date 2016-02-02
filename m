From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: mmc-test: y2038, use boottime to compare time
Date: Tue, 02 Feb 2016 17:01:53 +0100
Message-ID: <2594405.KBuGFUnPmH@wuerfel>
References: <1454298188-17174-1-git-send-email-klock.android@gmail.com> <5473957.GNRnMugOEa@wuerfel> <CALiE4M38JGQgYhr=6AZ24EMExv=HYE0AC6M9Pq+LjmdzjOBw9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:57817 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933369AbcBBQB5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 11:01:57 -0500
In-Reply-To: <CALiE4M38JGQgYhr=6AZ24EMExv=HYE0AC6M9Pq+LjmdzjOBw9A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Abhilash Jindal <klock.android@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On Tuesday 02 February 2016 10:14:46 Abhilash Jindal wrote:
> Thanks for the reply Arnd.
> 
> On Mon, Feb 1, 2016 at 2:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Sunday 31 January 2016 22:43:08 Abhilash Jindal wrote:
> > > Wall time obtained from getnstimeofday gives 32 bit timeval which can
> > only
> > > represent time until January 2038. This patch moves to ktime_t, a 64-bit
> > time.
> > >
> > > Also, wall time is susceptible to sudden jumps due to user setting the
> > time or
> > > due to NTP.  Boot time is constantly increasing time better suited for
> > > subtracting two timestamps.
> > >
> > > Signed-off-by: Abhilash Jindal <klock.android@gmail.com>
> >
> > Everything looks correct to me, nice work!
> >
> > I have a few comments to make the approach consistent with what we have
> > been doing with other drivers:
> >
> > Using boottime sounds like a correct approach, but I wonder whether
> > we should just use monotonic time instead, as we do for most conversions.
> >
> 
>  I used boottime to allow CPU to fall asleep and wakeup during testing. If
> the CPU isn't allowed to suspend then both boottime and monotonic shall be
> equivalent. I can change to what you see fit.

My guess is that monotonic works slightly better then: if the system
suspends, the mmc will also be suspended, so any test going on
at the time should have its time stopped until the MMC device also
resumes.

When a CPU is just sleeping (as opposed to the whole system being
suspended), both times keep ticking.

> >
> > >  static void mmc_test_print_avg_rate(struct mmc_test_card *test,
> > uint64_t bytes,
> > > -                                 unsigned int count, struct timespec
> > *ts1,
> > > -                                 struct timespec *ts2)
> > > +                                 unsigned int count, ktime_t tm1,
> > > +                                 ktime_t tm2)
> > >  {
> > >       unsigned int rate, iops, sectors = bytes >> 9;
> > >       uint64_t tot = bytes * count;
> > > -     struct timespec ts;
> > > -
> > > -     ts = timespec_sub(*ts2, *ts1);
> > > +     ktime_t tm = ktime_sub(tm2, tm1);
> > > +     struct timespec ts = ktime_to_timespec(tm);
> >
> > Please use timespec64 here, otherwise we have to come back to the driver
> > again to change that when we remove 'struct timespec'.
> >
> 
> 
> I used timespec only for the time difference; that shouldn't overflow its
> 32 bits. Are there plans on completely removing timespec in near future?

Yes, I'm slowly working my way through all device drivers (with the help
of lots of other folks) to replace every instance of timespec with ktime_t
or timespec64. This is done so we can reasonably assume that once we have
removed timespec that no new y2038 bugs can get added to the kernel.

We still need to support user interfaces that use the old timespec,
but that will become a compile-time option: whenever you run with
a libc implementation that uses a 64-bit time_t, those interfaces
are not needed, and removing them from the kernel image means that
again we have a higher confidence in having found all y2038 bugs in
user space.

	Arnd
