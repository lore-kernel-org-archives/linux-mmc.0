From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Mon, 20 Nov 2017 21:11:42 +0100
Message-ID: <20171120201142.n4l4jelxsmmtwjj6@tetsubishi>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato>
 <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50581 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbdKTULp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Nov 2017 15:11:45 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi Yamada-san,

> Sorry, I missed lots of legacy boards under arch/sh/boards/.
> 
> At first, I imagined <linux/mfd/tmio.h> was used
> for passing parameters from MFD to tmio-mmc.
> Then, I thought it would be possible to copy parameters
> to tmio_mmc_host in drivers/mmc/host/tmio_mmc.c
> But, actually renesas also depends on platform-data,
> so it does not seem so easy as I had imagined first.
> 
> 
> We could split tmio_mmc_data out to include/linux/platform_data/tmio-mmc.h
> but ideal goal might be split DT drivers and legacy board drivers.
> (just an idea, not looking into the detail.)

I think we need to sort out the high level view first. Do we want this
rename at all?

> > If we can rename things easily to match reality, I am not against it. In
> > this case, I wonder, though, if the rename is really easy? If you just
> > change the filenames, then we got a strange mix, because the function
> > names are still using tmio_*. If you change those function names, too,
> > then the resulting change is very intrusive.
> 
> Right.  This is a discussion point.
> 
> I admit it it a huge churn, but (I hope) one-time churn.

Churns have drawbacks independent of applying them once or multiple
times. git history becomes messy and customers having local patches will
have extra pain when updating the kernel. If it is worth it, OK.
However, I still don't see a real advantage yet.

> All functions / macros are prefixed with tmio_,
> so sed scripts will do a good job.

I have done that and it can be done, no doubt. But usually, this also
means fixing some leftovers manually and this can introduce the errors.
Like I said, can be done when needed but I am still wondering if it is
needed.

> It is just renaming, so no functional change will be added.
> If we find a build error (probably reported by 0-day bot),
> it will be easy to fix.

Sure. But there is also the case of a wrong auto-completion when
manually fixing things in a rare code path. Might not be needed here,
but could be. I wouldn't say the risk is 0%.

> Probably this could be the last chance for matching the code to reality
> if we had (or, maybe it is too late...).

Frankly, I'd think this is too late.

a) the documentation for TMIO/SDHI is hardly available even today.
   So, not much of a surprise if people hacking drivers get some
   details wrong. This is simply what happens when not working with
   the community timely enough. Absolutely no offence here, it is
   just the way it is.

b) but even today, you hardly know from datasheets if an IP core has
   been bought in. This is why I always compare register sets when
   getting new drivers for the I2C subsystem. Even the developer in
   that company usually doesn't know that there is a duplicate driver
   already.

So, this is something we have to live with anyhow.

> For DW and SDHCI, the naming scheme is really clean.
> Kconfig options are prefixed with CONFIG_MMC_DW / CONFIG_MMC_SDHCI.
> Same for file names and function names.

At least SDHCI had public documentation early, that helped. Dunno about
DesignWare. But I think for both it was clear from the beginning that
those are IP cores to be included by other vendors.

> It is true that names are just names, but having a good name-space
> is helpful to understand the code structure.

I agree. Though, good name space here means consistent in my book. I
don't think the code will be more readable if you exchange "tmio_" with
"mnsd_". It is helpful to have a different namespace for SDHI, but we
have that already.

> If my suggestion is NACK, do you have any suggestion for naming
> new drivers?
> 
> If we make 'tmio_mmc_core' is really the right name,
> do we want to do like  CONFIG_MMC_TMIO_UNIPHIER, tmio_mmc_uniphier.c?
> (then rename renesas ones likewise, or maybe not?)
> 
> Or, is it completely "don't care" things, like Renesas is currently doing?

It is not exactly "don't care". This naming scheme was suggested by Arnd
Bergmann [1] and agreed by us :) I don't think it is strange if
CONFIG_MMC_UNIPHIER includes CONFIG_MMC_TMIO_CORE. I have such setups in
I2C world, too. It might not be ideal, but is it really that confusing?

[1] http://www.spinics.net/lists/linux-mmc/msg38004.html

> Linux is in a special position in open source world.
> Various projects get influence from Linux.
> U-Boot borrow code, ideas, and names from Linux
> (barebox is more linux-addicted), so if we fix the history,

So, what about the idea in my last mail of adding the paragraph to the
source explaining the situation? This is far more educating than
changing the first four letters in a function name (which nobody really
knows what they mean anyhow). So, other projects can then decide to do
it better. Or, they copy the paragraph which in my book is again more
educational.

What do you think?

And maybe Ulf has something to add, too?

Kind regards,

   Wolfram

