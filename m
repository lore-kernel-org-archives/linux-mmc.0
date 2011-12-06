From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/4] SDHCI: add sdhci_get_cd callback to detect the card
Date: Tue, 6 Dec 2011 05:35:36 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1163306C@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
 <F2681397-0395-43F7-902F-9A575EDD843B@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:40939
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976Ab1LFFfm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Dec 2011 00:35:42 -0500
In-Reply-To: <F2681397-0395-43F7-902F-9A575EDD843B@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Philip Rakity
> Sent: Tuesday, December 06, 2011 2:49 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093
> Subject: Re: [PATCH 1/4] SDHCI: add sdhci_get_cd callback to detect the
> card
> 
> 
> On Dec 5, 2011, at 1:23 AM, <r66093@freescale.com> <r66093@freescale.com>
> wrote:
> 
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > Add callback function sdhci_get_cd to detect the card.
> > In order to check if the card is present, we will read the PRESENT
> > STATE register and check the bit13(Card detect pin level) and
> bit15(CINS).
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > ---
> > drivers/mmc/host/sdhci.c |   20 ++++++++++++++++++++
> > drivers/mmc/host/sdhci.h |    1 +
> > 2 files changed, 21 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> > 6d8eea3..66afd82 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2,6 +2,7 @@
> >  *  linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller
> > Interface driver
> >  *
> >  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
> > + *  Copyright (C) 2011 Freescale Semiconductor Inc.
> 
> 
> Lots of folks have made mods to this code and they have not added a
> copyright name.
> What is the rule Chris ?
If someone think the copyright should be removed, I can do.

> >  *
> >  * This program is free software; you can redistribute it and/or
> > modify
> >  * it under the terms of the GNU General Public License as published
> > by @@ -1518,6 +1519,24 @@ static int sdhci_get_ro(struct mmc_host *mmc)
> > 	return ret;
> > }
> >
> > +static int sdhci_get_cd(struct mmc_host *mmc) {
> > +	struct sdhci_host *host = mmc_priv(mmc);
> > +	unsigned long flags;
> > +	int present;
> > +
> > +	spin_lock_irqsave(&host->lock, flags);
> > +
> > +	if (host->flags & SDHCI_DEVICE_DEAD)
> > +		present = 0;
> > +	else
> > +		present = sdhci_readl(host, SDHCI_PRESENT_STATE);
> > +
> > +	spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +	return (present & (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL)); }
> > +
> > static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int
> > enable) {
> > 	if (host->flags & SDHCI_DEVICE_DEAD)
> > @@ -1884,6 +1903,7 @@ static const struct mmc_host_ops sdhci_ops = {
> > 	.request	= sdhci_request,
> > 	.set_ios	= sdhci_set_ios,
> > 	.get_ro		= sdhci_get_ro,
> > +	.get_cd		= sdhci_get_cd,
> 
> 
> A better approach would be to define a callback into platform specific
> code and use that.  For your chip reading present state works but for
> other chips this will not be sufficient so a more general solution would
> be better.
Yes, I have thought about it, if some chip can't support this feature, the simple method is add the ifdef.
Of course, the better way is to define a callback into platform specific code, but there is not the interface.


