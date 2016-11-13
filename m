From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] mmc: allow mmc_alloc_host() and tmio_mmc_host_alloc()
Date: Sun, 13 Nov 2016 11:58:03 +0100
Message-ID: <20161113105803.GD8388@kroah.com>
References: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
 <20161110133559.GA10191@kroah.com>
 <CAK7LNAThxsE3QW4EdPUyxmxbnt_PPjeogi8Fox5AHkddsuu-Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933121AbcKMK5x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Nov 2016 05:57:53 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNAThxsE3QW4EdPUyxmxbnt_PPjeogi8Fox5AHkddsuu-Sg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sascha Sommer <saschasommer@freenet.de>, Johan Hovold <johan@kernel.org>, Sonic Zhang <sonic.zhang@analog.com>, devel@driverdev.osuosl.org, Russell King <linux@armlinux.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Chen-Yu Tsai <wens@csie.org>, Pierre Ossman <pierre@ossman.eu>, Harald Welte <HaraldWelte@viatech.com>, Alex Dubov <oakad@yahoo.com>, adi-buildroot-devel@lists.sourceforge.net, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Ben Dooks <ben-linux@fluff.org>, Tony Olech <tony.olech@elandigitalsystems.com>, Matthias

On Fri, Nov 11, 2016 at 12:19:05PM +0900, Masahiro Yamada wrote:
> 2016-11-10 22:35 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> > On Thu, Nov 10, 2016 at 10:24:21PM +0900, Masahiro Yamada wrote:
> >>
> >> sdhci_alloc_host() returns an error pointer when it fails.
> >> but mmc_alloc_host() cannot.
> >>
> >> This series allow to propagate a proper error code
> >> when host-allocation fails.
> >
> > Why?  What can we really do about the error except give up?  Why does
> > having a explicit error value make any difference to the caller, they
> > can't do anything different, right?
> 
> 
> The error code is shown in the console, like
> 
>   probe of 5a000000.sdhc failed with error -12
> 
> 
> The proper error code will give a clue why the driver failed to probe.

Can't the mmc core show the reason once, and not require each and every
individual driver to show/say the same thing?  All a driver needs to
know is if it worked or didn't work.  Every time it didn't work, it
needs to unwind stuff and then recover properly.

The drivers do not do different things based on what type of error
happened, as they don't care at all.

So I strongly suggest leaving it simple, as it is today, as this makes
drivers simpler, they don't have to duplicate the same type of error
reporting all over the place, and it's easy to audit for.

It also makes it so that large patchsets that touch every driver like
this are not needed at all.

> > I suggest just leaving it as-is, it's simple, and you don't have to mess
> > with PTR_ERR() anywhere.
> 
> 
> Why?
> 
> Most of driver just give up probing for any error,
> but we still do ERR_PTR()/PTR_ERR() here and there.
> I think this patch is the same pattern.

I think we need to get rid of more of the ERR_PTR() stuff, as again,
it's useless.  All we need to know is an error happened, that's it.

> If a function returns NULL on failure, we need to think about
> "what is the most common failure case".
> 
> Currently, MMC drivers assume -ENOMEM is the best
> fit for mmc_alloc_host(), but the assumption is fragile.
> 
> Already, mmc_alloc_host() calls a function
> that returns not only -ENOMEM, but also -ENOSPC.
> 
> In the future, some other failure cases might be
> added to mmc_alloc_host().
> 
> Once we decide the API returns an error pointer,
> drivers just propagate the return value from the API.
> This is much more stable implementation.

Again, no, it makes more work for the different drivers, duplicates code
all over the place, and really doesn't help any user, or developer, out
at all.

Just have the mmc core properly log what went wrong, and all should be
fine.

Again, keep it simple, that's the best policy for the kernel, and
really, most software :)

thanks,

greg k-h
