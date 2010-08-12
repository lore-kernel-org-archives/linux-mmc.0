From: Matt Fleming <matt@console-pimps.org>
Subject: Running out of SDHCI quirk space (Re: [PATCH 1/3 v2] sdhci: Add
	auto CMD12 support for eSDHC driver)
Date: Thu, 12 Aug 2010 12:34:21 +0100
Message-ID: <20100812113421.GB30744@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:37655 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759877Ab0HLLeW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Aug 2010 07:34:22 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Roy Zang <tie-fei.zang@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, Ben Dooks <ben@simtec.co.uk>

On Tue, Aug 03, 2010 at 04:43:46PM -0700, Andrew Morton wrote:
> On Tue, 3 Aug 2010 11:11:10 +0800
> Roy Zang <tie-fei.zang@freescale.com> wrote:
> 
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -240,6 +240,8 @@ struct sdhci_host {
> >  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
> >  /* Controller cannot support End Attribute in NOP ADMA descriptor */
> >  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> > +/* Controller uses Auto CMD12 command to stop the transfer */
> > +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)
> 
> This becomes 1<<29 in my tree.
> 
> We're about to run out.  What happens then?

I've been wondering for a while now if many of the quirks should be
hidden behind function pointers. While we could of course extend the
quirk space, I think that's kinda missing the point that quirks are
being used too liberally. Take SDHCI_QUIRK_SINGLE_POWER_WRITE in
drivers/mmc/host/sdhci.c:sdhci_set_power(). Really, that quirk should
probably be hidden inside a set_power() function in the sdhci_ops
structure.

I'm gonna have a go at trying to remove some of the quirks that don't
make sense being quirks. I'll post the series when I'm done.

Does anyone think that this approach is crazy?
