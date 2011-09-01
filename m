From: Lin Tony-B19295 <B19295@freescale.com>
Subject: RE: sdhci-esdhc-imx and SDIO interrupts
Date: Thu, 1 Sep 2011 05:30:43 +0000
Message-ID: <97D3A72708D04647A5AC84A04996E5B519DCC2@039-SN1MPN1-002.039d.mgd.msft.net>
References: <20110831120912.GN21500@whatever.nu>
 <20110831155011.GN8104@pengutronix.de> <20110831163359.GO21500@whatever.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:59443
	"EHLO AM1EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751286Ab1IAFb2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Sep 2011 01:31:28 -0400
In-Reply-To: <20110831163359.GO21500@whatever.nu>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per-Henrik Lundblom <ph@whatever.nu>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I commit a patch to fix this issue. Did you update your code? 

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Per-Henrik Lundblom
> Sent: Thursday, September 01, 2011 12:34 AM
> To: linux-mmc@vger.kernel.org
> Subject: Re: sdhci-esdhc-imx and SDIO interrupts
> 
> * Robert Schwebel <r.schwebel@pengutronix.de> [110831 17:50]:
> 
> > > I'm working with a driver for an SDIO Wireless LAN card and just
> > > tried it out on an i.MX35 based development board (Phytec PCM-043).
> > > My impression is that the sdhci-esdhc-imx driver doesn't support
> > > SDIO interrupts, is that correct?
> >
> > I think we didn't test this on the PCM043 so far, so it probably won't
> > work without further activities.
> 
> Just having a quick look at the code and a few printouts from sdhci.c
> indicates that SDIO IRQs are enabled but in the end the eSDHC controller
> doesn't report any IRQs. On the other hand, the IRQ handling for SDIO
> IRQs in sdhci.c doesn't follow the steps described in the i.MX35
> Reference Manual (but that doesn't explain why there is not one single
> SDIO IRQ reported).
> 
> /PH
> 
> --
> Per-Henrik Lundblom           epost: ph@whatever.nu
> hemsida: www.whatever.nu
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html


