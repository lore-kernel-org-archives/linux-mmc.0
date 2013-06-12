From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Wed, 12 Jun 2013 10:53:33 -0500
Message-ID: <1371052413.32077.2.camel@linux-builds1>
References: <1370996924-23048-1-git-send-email-dinguyen@altera.com>
	 <1370996924-23048-3-git-send-email-dinguyen@altera.com>
	 <201306121731.53120.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:25753
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462Ab3FLPxb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2013 11:53:31 -0400
In-Reply-To: <201306121731.53120.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Pavel Machek <pavel@denx.de>

On Wed, 2013-06-12 at 17:31 +0200, Arnd Bergmann wrote:
> On Wednesday 12 June 2013, dinguyen@altera.com wrote:
> > +static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
> > +{
> > +       struct dw_mci_socfpga_priv_data *priv = host->priv;
> > +
> > +       clk_disable_unprepare(host->ciu_clk);
> > +       regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
> > +               priv->hs_timing);
> > +       clk_prepare_enable(host->ciu_clk);
> > +
> > +       host->bus_hz /= (priv->ciu_div + 1);
> > +       return 0;
> > +}
> 
> 
> Sorry for being so late in the game here, but why do you need a
> regmap_write() call in the driver here? Shouldn't you just be able
> to use the clk_set_rate() interface from the generic dw_mmc-pltfm
> code?

This write is necessary for setting phase_shift(s) for the clocks that
are feeding the CIU clock. 

Dinh
> 
> 	Arnd
> 



