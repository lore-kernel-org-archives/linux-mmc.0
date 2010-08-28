From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 1/2] mmc: Add helper function to check if a card is
 removable
Date: Sat, 28 Aug 2010 15:28:15 +0100
Message-ID: <20100828142815.GA2623@console-pimps.org>
References: <20100828133737.GH18829@console-pimps.org>
 <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org>
 <1283004789.7653.76.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:60705 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753812Ab0H1O2R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Aug 2010 10:28:17 -0400
Content-Disposition: inline
In-Reply-To: <1283004789.7653.76.camel@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, Yunpeng Gao <yunpeng.gao@intel.com>

On Sat, Aug 28, 2010 at 03:13:09PM +0100, Ben Hutchings wrote:
> On Sat, 2010-08-28 at 14:53 +0100, Matt Fleming wrote:
> [...]
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -272,5 +272,12 @@ static inline void mmc_set_disable_delay(struct mmc_host *host,
> >  	host->disable_delay = disable_delay;
> >  }
> >  
> > +extern int mmc_assume_removable;
> 
> This variable is already declared in drivers/mmc/core/core.h.  Either
> remove the declaration from there or define the following function there
> instead of here.

Sure, I'll remove the declaration from drivers/mmc/core/core.h.

> > +static inline int mmc_card_is_removable(struct mmc_host *host)
> > +{
> > +	return (!(host->caps & MMC_CAP_NONREMOVABLE) || mmc_assume_removable);
> > +}
> > +
> 
> That '||' should be an '&&'.

Oops, yes, it should be.

Thanks for the review.
