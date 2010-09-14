From: Alan Cox <alan@linux.intel.com>
Subject: Re: cleaning up sdhci? (was Re: [RFC] thoughts about recent Samsung
 related patches)
Date: Tue, 14 Sep 2010 11:21:29 +0100
Message-ID: <20100914112129.0c7b93eb@linux.intel.com>
References: <20100906110059.GC2617@pengutronix.de>
	<AANLkTikoC35Rg52jJ5NMwvtMh9PfxgS7RqtfvfBeD6LV@mail.gmail.com>
	<20100913123108.GA5497@pengutronix.de>
	<AANLkTi=zpAz+0VT0GGGrMP3KOJiWqvypWVfxuDZDpoSx@mail.gmail.com>
	<20100914102858.GB2629@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36155 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab0INLGQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Sep 2010 07:06:16 -0400
In-Reply-To: <20100914102858.GB2629@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, pierre-list@ossman.eu, gdavis@mvista.com, cbouatmailru@gmail.com, m.szyprowski@samsung.com, akpm@linux-foundation.org, =?UTF-8?B?7KCV7J6s?= =?UTF-8?B?7ZuI?= <jh80.chung@samsung.com>

> That is, if some implementations of a controller do not adhere to
> that standard and change some bits in the register layout, well, then
> they have to live with the quirks and their performance issues IMHO.

The ATA layer uses I/O accessors although it abstracts them a bit (so
its got 'read status' type abstractions. For performance reasons one or
two places the abstraction is higher level (eg block data transfers)
but with those in place it doesn't seem to be measurable.

> Seeing Alan's patchset, it seems to be a good time to do some
> sdhci-cleanup. My impression is that we could get generalize a few
> quirks by using io-accessors and overriding capabilties-flags. I am

I avoided doing any of it by making I/O access functions fake results
because that seemed to be a recipe for hard to debug future problems.
When dealing with different register layouts or specific bugs it seems
sensible

(and 8250 serial does this succesfully with some devices faking certain
register bits their hardware gets wrong)

> open for other opinions, though. All in all, it would be great if we
> all could combine our efforts and get some kind of master-plan :)
> Will take a look at Alan's patches now...

If there is going to be a grand clean up my preference long term would
be that there is no

	if (host->ops->foo)
		host->ops->foo(...)
	else {
		do foo
	
	}

but that host->ops gets all the NULL entries filled in and the core
code simply calls host->ops->xxx in each case.

Alan
