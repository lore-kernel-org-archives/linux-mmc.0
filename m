From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
Date: Mon, 21 Feb 2011 11:09:05 +0000
Message-ID: <20110221110905.GL14495@n2100.arm.linux.org.uk>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com> <1298282095-2279-5-git-send-email-richard.zhao@freescale.com> <20110221100439.GE2616@pengutronix.de> <010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net> <20110221104608.GF2616@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48842 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1BULJV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 06:09:21 -0500
Content-Disposition: inline
In-Reply-To: <20110221104608.GF2616@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Zhu Richard-R65037 <R65037@freescale.com>, Zhao Richard-B20223 <B20223@freescale.com>, "cjb@laptop.org" <cjb@laptop.org>, "eric@eukrea.com" <eric@eukrea.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>

On Mon, Feb 21, 2011 at 11:46:08AM +0100, Wolfram Sang wrote:
> > > > -   if (cpu_is_mx35() || cpu_is_mx51())
> > > > +   if (cpu_is_mx53())
> > > > +           host->quirks |= SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;
> > >
> > > Have you tried it doing it via IO-accessors?
> > Richard Zhu: This quirk is used to fix a mechanism problem in the MMC CMDs execution procedure.
> > It would be very abrupt and ugly, if the IO-accessors are added into these original procedures.
> 
> Please don't get it personal, but IMHO it is pretty ugly the way it is
> now. This quirk is very imx-specific and calling something like
> SDHCI_VENDOR_SPEC in sdhci.c looks clearly wrong to me. By the way, what
> does this bit do, the description doesn't say so?

SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO is rather too verbose.  Isn't
there a shorter version which could be used?  SDHCI_QUIRK_SDIO_MULTIBLK_INT
maybe?
