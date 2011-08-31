From: Per-Henrik Lundblom <ph@whatever.nu>
Subject: Re: sdhci-esdhc-imx and SDIO interrupts
Date: Wed, 31 Aug 2011 18:33:59 +0200
Message-ID: <20110831163359.GO21500@whatever.nu>
References: <20110831120912.GN21500@whatever.nu>
 <20110831155011.GN8104@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from roadrunner.df.lth.se ([194.47.250.105]:34578 "EHLO
	roadrunner.df.lth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322Ab1HaQeB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2011 12:34:01 -0400
Received: from roadrunner.df.lth.se (localhost [127.0.0.1])
	by roadrunner.df.lth.se (Postfix) with ESMTP id C82706A4
	for <linux-mmc@vger.kernel.org>; Wed, 31 Aug 2011 18:33:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110831155011.GN8104@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

* Robert Schwebel <r.schwebel@pengutronix.de> [110831 17:50]:

> > I'm working with a driver for an SDIO Wireless LAN card and just tried
> > it out on an i.MX35 based development board (Phytec PCM-043). My
> > impression is that the sdhci-esdhc-imx driver doesn't support SDIO
> > interrupts, is that correct?
> 
> I think we didn't test this on the PCM043 so far, so it probably won't
> work without further activities.

Just having a quick look at the code and a few printouts from sdhci.c
indicates that SDIO IRQs are enabled but in the end the eSDHC controller
doesn't report any IRQs. On the other hand, the IRQ handling for SDIO
IRQs in sdhci.c doesn't follow the steps described in the i.MX35
Reference Manual (but that doesn't explain why there is not one single
SDIO IRQ reported).

/PH

--
Per-Henrik Lundblom           epost: ph@whatever.nu
hemsida: www.whatever.nu

