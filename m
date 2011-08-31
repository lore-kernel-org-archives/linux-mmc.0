From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: sdhci-esdhc-imx and SDIO interrupts
Date: Wed, 31 Aug 2011 17:50:11 +0200
Message-ID: <20110831155011.GN8104@pengutronix.de>
References: <20110831120912.GN21500@whatever.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52559 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab1HaPuM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2011 11:50:12 -0400
Content-Disposition: inline
In-Reply-To: <20110831120912.GN21500@whatever.nu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per-Henrik Lundblom <ph@whatever.nu>
Cc: linux-mmc@vger.kernel.org

On Wed, Aug 31, 2011 at 02:09:12PM +0200, Per-Henrik Lundblom wrote:
> I'm working with a driver for an SDIO Wireless LAN card and just tried
> it out on an i.MX35 based development board (Phytec PCM-043). My
> impression is that the sdhci-esdhc-imx driver doesn't support SDIO
> interrupts, is that correct?

I think we didn't test this on the PCM043 so far, so it probably won't
work without further activities.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
