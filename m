From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/7] sdhci: Rework some of the quirk behaviour
Date: Tue, 14 Sep 2010 15:20:40 +0100
Message-ID: <20100914152040.3d129706@linux.intel.com>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
	<20100913173839.20345.27249.stgit@localhost.localdomain>
	<20100914143437.GG2629@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7447 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099Ab0INPF1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Sep 2010 11:05:27 -0400
In-Reply-To: <20100914143437.GG2629@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

> >  drivers/mmc/host/Kconfig           |   11 ++
> >  drivers/mmc/host/Makefile          |    1 
> >  drivers/mmc/host/sdhci-intel-mid.c |  163
> > ++++++++++++++++++++++++++++++++++++
> 
> Why are those added here and not in patch 3/7?

I thought it would be useful to add the hooks and show how they are
used in one - I can split that easily enough.


> > + * ADMA operation is disabled for Moorestown platform due to
> > + * hardware bugs.
> > + */
> > +static int mrst_hc0_probe(struct sdhci_pci_chip *chip)
> > +{
> > +	/*
> > +	 * slots number is fixed here for MRST as SDIO3 is never
> > used and has
> > +	 * hardware bugs.
> > +	 */
> > +	chip->num_slots = 1;
> > +	return 0;
> > +}
> 
> Why is this function here and not in sdhci-intel-mid.c?

So it follows the pattern of the other drivers, so it doesn't need an
extra exported symbol (at about ten times the size of the function).

We could move probe into host_ops I guess but that means tweaking all
the other drivers which I cannot test.

I guess the other way to do it would be not to have a separate file but
to stick it all in sdhci-pci ?



> >  		mmc->max_blk_size = (caps & SDHCI_MAX_BLOCK_MASK)
> > >> SDHCI_MAX_BLOCK_SHIFT;
> > -		if (mmc->max_blk_size >= 3) {
> > +		if (mmc->max_blk_size > 3) {
> 
> Why this change? Not mentioned in the changelog. And wrong according
> to the simplified standard v2. Is it V3 material?

That's got in by mistake. I thought I'd got all the spec related bits
stripped out.

I actually suspect for the more general case of cleaning up some of the
other driver quirks we need a couple more callbacks but its hard to
sure.
