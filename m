From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 4/4 v5] ESDHC: Workaround for data crc error on p1010rdb
Date: Wed, 8 Feb 2012 03:34:16 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C01E2D6@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1326694386-28820-1-git-send-email-r66093@freescale.com>
	<1326694386-28820-2-git-send-email-r66093@freescale.com>
	<1326694386-28820-3-git-send-email-r66093@freescale.com>
	<1326694386-28820-4-git-send-email-r66093@freescale.com>
	<1326694386-28820-5-git-send-email-r66093@freescale.com>
 <m2y5si9r3b.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:7155
	"EHLO AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753228Ab2BHDeX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Feb 2012 22:34:23 -0500
In-Reply-To: <m2y5si9r3b.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>

Hi, Chris,
I have reworked it and send it to the maillist, please review it.

Best regards
Jerry Huang

> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Sunday, February 05, 2012 6:22 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Jain Priyanka-
> B32167
> Subject: Re: [PATCH 4/4 v5] ESDHC: Workaround for data crc error on
> p1010rdb
> 
> Hi Jerry,
> 
> On Mon, Jan 16 2012, r66093@freescale.com wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > SD card read was failing (data crc error)on some cards at maximum
> > possible frequency on P1010(CCB frequency set to 400MHz).
> > Some clock deviations are also observed at this frequency.
> > Hence reduced the mmc clock freq.
> >
> > Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> > Singed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Chris Ball <cjb@laptop.org>
> > Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> > ---
> > changes for v2:
> > 	- change the property to compatible for quirks changes for v3:
> > 	- fix one compile error
> > changes for v4:
> > 	- use hooks to suspend/resume the special platform changes for v5:
> > 	- add the Acked-by
> >
> >  drivers/mmc/host/sdhci-esdhc.h |    9 ++++++++-
> >  drivers/mmc/host/sdhci-pltfm.c |    3 +++
> >  include/linux/mmc/sdhci.h      |    2 ++
> >  3 files changed, 13 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc.h
> > b/drivers/mmc/host/sdhci-esdhc.h index b97b2f5..8e00174 100644
> > --- a/drivers/mmc/host/sdhci-esdhc.h
> > +++ b/drivers/mmc/host/sdhci-esdhc.h
> > @@ -1,7 +1,7 @@
> >  /*
> >   * Freescale eSDHC controller driver generics for OF and pltfm.
> >   *
> > - * Copyright (c) 2007 Freescale Semiconductor, Inc.
> > + * Copyright (c) 2007,2011 Freescale Semiconductor, Inc.
> >   * Copyright (c) 2009 MontaVista Software, Inc.
> >   * Copyright (c) 2010 Pengutronix e.K.
> >   *   Author: Wolfram Sang <w.sang@pengutronix.de>
> > @@ -56,6 +56,13 @@ static inline void esdhc_set_clock(struct sdhci_host
> *host, unsigned int clock)
> >  	if (clock == 0)
> >  		goto out;
> >
> > +	if (host->quirks2 & SDHCI_QUIRK2_RELAX_FREQ) {
> > +		if (clock > 20000000)
> > +			clock -= 5000000;
> > +		if (clock > 40000000)
> > +			clock -= 5000000;
> > +	}
> > +
> >  	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
> >  		pre_div *= 2;
> >
> > diff --git a/drivers/mmc/host/sdhci-pltfm.c
> > b/drivers/mmc/host/sdhci-pltfm.c index 04fa130..c932316 100644
> > --- a/drivers/mmc/host/sdhci-pltfm.c
> > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > @@ -81,6 +81,9 @@ void sdhci_get_of_property(struct platform_device
> *pdev)
> >  					"fsl,mpc8536-esdhc"))
> >  			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> >
> > +		if (of_device_is_compatible(np, "fsl,p1010-esdhc"))
> > +			host->quirks2 |= SDHCI_QUIRK2_RELAX_FREQ;
> > +
> >  		clk = of_get_property(np, "clock-frequency", &size);
> >  		if (clk && size == sizeof(*clk) && *clk)
> >  			pltfm_host->clock = be32_to_cpup(clk); diff --git
> > a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h index
> > e4b6935..f7c1e13 100644
> > --- a/include/linux/mmc/sdhci.h
> > +++ b/include/linux/mmc/sdhci.h
> > @@ -91,6 +91,8 @@ struct sdhci_host {
> >  	unsigned int quirks2;	/* More deviations from spec. */
> >
> >  #define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
> > +/* Controller operates the cards at reduced frequency */
> > +#define SDHCI_QUIRK2_RELAX_FREQ				(1<<1)
> >
> >  	int irq;		/* Device IRQ */
> >  	void __iomem *ioaddr;	/* Mapped address */
> 
> I don't think this should be implemented as a global SDHCI quirk, because
> I don't think it's ever going to be used on non-ESDHC hardware.
> Since you're already handling the clock change in an esdhc-only function,
> can you just use your "fsl,p1010-esdhc" test to set some driver-local
> flag to use later, instead of involving sdhci.h?
> 
> Thanks.  (No need to resend the other patches, I'll take this one
> separately when it's been reworked.)
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child


