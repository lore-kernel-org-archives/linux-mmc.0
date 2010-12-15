From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/4] sdhci: add quirk for broken sdio irq
Date: Wed, 15 Dec 2010 05:34:42 -0600
Message-ID: <20101215113442.GA2500@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-3-git-send-email-olof@lixom.net> <20101215105701.GC3515@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:42961 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab0LOLem (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Dec 2010 06:34:42 -0500
Content-Disposition: inline
In-Reply-To: <20101215105701.GC3515@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On Wed, Dec 15, 2010 at 11:57:01AM +0100, Wolfram Sang wrote:
> On Tue, Dec 14, 2010 at 10:49:34PM -0600, Olof Johansson wrote:
> > Some controllers can't handle SDIO IRQ properly. Give a way to
> > disable it.
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> >  drivers/mmc/host/sdhci.c  |    6 +++++-
> >  include/linux/mmc/sdhci.h |    2 ++
> >  2 files changed, 7 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c0094c1..98f3d3d 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1871,7 +1871,10 @@ int sdhci_add_host(struct sdhci_host *host)
> >  		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
> >  
> >  	mmc->f_max = host->max_clk;
> > -	mmc->caps |= MMC_CAP_SDIO_IRQ;
> > +	mmc->caps = 0;
> 
> That would clear flags already set in custom probe functions (check
> sdhci-pxa) for example.

Good point, will fix.

> > +
> > +	if (!(host->quirks & SDHCI_QUIRK_NO_SDIO_IRQ))
> > +		mmc->caps |= MMC_CAP_SDIO_IRQ;
> 
> As we are running out of quirk-bits, can you imagine a solution without
> a quirk (same for the other patch)?

See other sub-thread. Not without violating the layering. If anyone else
has suggestions I'm all ears though.


-Olof
