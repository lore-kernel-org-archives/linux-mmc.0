From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 4/5 v2] SDHCI: add sdhci_get_cd callback to detect the
 card
Date: Wed, 7 Dec 2011 02:35:37 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F116342D5@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323162937-7742-1-git-send-email-r66093@freescale.com>
 <1323162937-7742-2-git-send-email-r66093@freescale.com>
 <1323162937-7742-3-git-send-email-r66093@freescale.com>
 <1323162937-7742-4-git-send-email-r66093@freescale.com>
 <4EDE0669.5060601@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:6578
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754053Ab1LGCfm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Dec 2011 21:35:42 -0500
In-Reply-To: <4EDE0669.5060601@yahoo.es>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hein_Tibosch <hein_tibosch@yahoo.es>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>



> -----Original Message-----
> From: Hein_Tibosch [mailto:hein_tibosch@yahoo.es]
> Sent: Tuesday, December 06, 2011 8:11 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Chris Ball
> Subject: Re: [PATCH 4/5 v2] SDHCI: add sdhci_get_cd callback to detect
> the card
> 
> Hi Jerry,
> 
> On 12/6/2011 5:15 PM, r66093@freescale.com wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > Add callback function sdhci_get_cd to detect the card.
> > And one new callback added to implement the card detect in sdhci
> struncture.
> > If special platform has the card detect callback, it will return the
> > card state, the value zero is for absent cardi and one is for present
> card.
> > If the controller don't support card detect, sdhci_get_cd will return -
> ENOSYS.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Chris Ball <cjb@laptop.org>
> > ---
> > changes for v2:
> > 	- when controller don't support get_cd, return -ENOSYS
> > 	- add new callback for sdhci to detect the card
> > 	- add the CC
> >
> >  drivers/mmc/host/sdhci.c |   21 +++++++++++++++++++++
> >  drivers/mmc/host/sdhci.h |    2 ++
> >  2 files changed, 23 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> > 6d8eea3..2196c5e 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2,6 +2,7 @@
> >   *  linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller
> Interface driver
> >   *
> >   *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
> > + *  Copyright (C) 2011 Freescale Semiconductor Inc.
> >   *
> >   * This program is free software; you can redistribute it and/or
> modify
> >   * it under the terms of the GNU General Public License as published
> > by @@ -1518,6 +1519,25 @@ static int sdhci_get_ro(struct mmc_host *mmc)
> >  	return ret;
> >  }
> >
> > +/* Return values for the sdjco_get_cd callback:
> > + *   0 for a absent card
> > + *   1 for a present card
> > + *   -ENOSYS when not supported (equal to NULL callback)
> > + */
> > +static int sdhci_get_cd(struct mmc_host *mmc) {
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	unsigned long flags;
> > +	int present = -ENOSYS;
> > +
> > +	spin_lock_irqsave(&host->lock, flags);
> > +	if (host->ops->get_cd)
> > +		present = host->ops->get_cd(host);
> > +	spin_unlock_irqrestore(&host->lock, flags);
> 
> Maybe only use spin-lock if get_cd is defined?
> 
Yes, I will move it.

