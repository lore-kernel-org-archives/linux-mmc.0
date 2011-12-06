From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/4] SDHCI: add sdhci_get_cd callback to detect the card
Date: Tue, 6 Dec 2011 05:43:20 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F1163309E@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
 <5D8008F58939784290FAB48F549751984EAE509937@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:52436 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab1LFFnV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 00:43:21 -0500
In-Reply-To: <5D8008F58939784290FAB48F549751984EAE509937@shsmsx502.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi, Chuanxiao

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Dong, Chuanxiao
> Sent: Monday, December 05, 2011 7:25 PM
> To: Huang Changming-R66093; linux-mmc@vger.kernel.org
> Cc: Huang Changming-R66093
> Subject: RE: [PATCH 1/4] SDHCI: add sdhci_get_cd callback to detect the
> card
> 
> Hi Jerry,
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org
> > [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of
> > r66093@freescale.com
> > Sent: Monday, December 05, 2011 5:24 PM
> > To: linux-mmc@vger.kernel.org
> > Cc: Jerry Huang
> > Subject: [PATCH 1/4] SDHCI: add sdhci_get_cd callback to detect the
> > card
> >
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > Add callback function sdhci_get_cd to detect the card.
> > In order to check if the card is present, we will read the PRESENT
> > STATE register and check the bit13(Card detect pin level) and
> bit15(CINS).
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci.c |   20 ++++++++++++++++++++
> >  drivers/mmc/host/sdhci.h |    1 +
> >  2 files changed, 21 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> > 6d8eea3..66afd82 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2,6 +2,7 @@
> >   *  linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller
> > Interface driver
> >   *
> >   *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
> > + *  Copyright (C) 2011 Freescale Semiconductor Inc.
> >   *
> >   * This program is free software; you can redistribute it and/or
> modify
> >   * it under the terms of the GNU General Public License as published
> > by @@ -1518,6 +1519,24 @@ static int sdhci_get_ro(struct mmc_host *mmc)
> >  	return ret;
> >  }
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
> 
> As far as I know, some SDHC host controller didn't implement its present
> register well...The present register of some SDHC host controller will
> report "there is a card" forever. So, according to your patch2, using
> such method is not a proper solution for card detection, I think.
Yes, maybe some controller don't support this feature, maybe can add one callback function to the platform special code.
But, we need to define this interface.

