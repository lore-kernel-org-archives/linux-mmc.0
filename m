From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Wed, 12 Jun 2013 14:39:22 -0500
Message-ID: <1371065962.14236.21.camel@linux-builds1>
References: <1370996924-23048-1-git-send-email-dinguyen@altera.com>
	 <201306121731.53120.arnd@arndb.de> <1371052413.32077.2.camel@linux-builds1>
	 <3040528.yQVRPuV2pW@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:6013
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753747Ab3FLTjW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 15:39:22 -0400
In-Reply-To: <3040528.yQVRPuV2pW@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Pavel Machek <pavel@denx.de>

On Wed, 2013-06-12 at 19:46 +0200, Arnd Bergmann wrote:
> On Wednesday 12 June 2013 10:53:33 Dinh Nguyen wrote:
> > On Wed, 2013-06-12 at 17:31 +0200, Arnd Bergmann wrote:
> > > On Wednesday 12 June 2013, dinguyen@altera.com wrote:
> > > > +static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
> > > > +{
> > > > +       struct dw_mci_socfpga_priv_data *priv = host->priv;
> > > > +
> > > > +       clk_disable_unprepare(host->ciu_clk);
> > > > +       regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
> > > > +               priv->hs_timing);
> > > > +       clk_prepare_enable(host->ciu_clk);
> > > > +
> > > > +       host->bus_hz /= (priv->ciu_div + 1);
> > > > +       return 0;
> > > > +}
> > > 
> > > 
> > > Sorry for being so late in the game here, but why do you need a
> > > regmap_write() call in the driver here? Shouldn't you just be able
> > > to use the clk_set_rate() interface from the generic dw_mmc-pltfm
> > > code?
> > 
> > This write is necessary for setting phase_shift(s) for the clocks that
> > are feeding the CIU clock. 
> 
> I don't understand. Shouldn't that be an implementation detail
> of the clock controller rather than the mmc controller?

The clock controller provides 2 clock to the mmc controller. 1 clock is
for the IP and another is for clocking the Card Interface Unit(CIU). The
CIU does exactly like the name states, it interfaces with the physical
SD card. The IP allows for adjusting the phase_shift of this CIU clock
to support different data rates on SD cards. 

So this "clocking" register is very specific to the SD block. Socfpga
has them in the system manager, while the exynos platform has them in
the SD block itself.

Hope that was clear...
Dinh
> 
> 	Arnd
> 



