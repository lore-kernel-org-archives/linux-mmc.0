From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v6] ESDHC: Workaround for data crc error on p1010rdb
Date: Wed, 8 Feb 2012 08:00:27 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C01E623@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1328671848-15659-1-git-send-email-r66093@freescale.com>
 <m28vke2d6e.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:43191
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754824Ab2BHIAd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Feb 2012 03:00:33 -0500
In-Reply-To: <m28vke2d6e.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jain Priyanka-B32167 <B32167@freescale.com>

> > diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> > index c750f85..2418c91 100644
> > --- a/include/linux/mmc/sdhci.h
> > +++ b/include/linux/mmc/sdhci.h
> > @@ -90,6 +90,9 @@ struct sdhci_host {
> >
> >  	unsigned int quirks2;	/* More deviations from spec. */
> >
> > +/* Controller operates the cards at reduced frequency */
> > +#define SDHCI_QUIRK2_RELAX_FREQ				(1<<0)
> > +
> >  	int irq;		/* Device IRQ */
> >  	void __iomem *ioaddr;	/* Mapped address */
> 
> This looks identical to the previous patch version to me?  You're still
> defining a new quirk in include/linux/mmc/sdhci.h, which is what I don't
> want you to do for a driver-local quirk.

Thank, Chris.
I understand you, and will send the new version patch according to your suggest.

Jerry Huang

