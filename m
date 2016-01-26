From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: omap_hsmmc: don't print uninitialized variables
Date: Tue, 26 Jan 2016 16:18:25 +0100
Message-ID: <26439572.8QBco8eDYu@wuerfel>
References: <1453737031-1959584-1-git-send-email-arnd@arndb.de> <56A78838.3050400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:64237 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442AbcAZPS7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 10:18:59 -0500
In-Reply-To: <56A78838.3050400@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>, Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 26 January 2016 16:52:40 Peter Ujfalusi wrote:
> > @@ -2133,7 +2131,17 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
> >  
> >       omap_hsmmc_conf_bus_power(host);
> >  
> > -     if (!pdev->dev.of_node) {
> > +     host->tx_chan = dma_request_slave_channel(&pdev->dev, "tx");
> > +     host->rx_chan = dma_request_slave_channel(&pdev->dev, "rx");
> > +     if (!host->tx_chan || !host->rx_chan) {
> 
> While it is really unlikely that we are failing to get only one of the
> channels... It means anyway that the omap_hsmmc is not usable, but we will
> still try to get via legacy mode and there is a chance that we might get some
> channel.
> 
> Too bad that I can not send the conversion to dma_request_chan() yet due to
> missing things in arch...
> 
> It might be simpler to just remove the printout of the rx/tx_req from the
> dev_err() when reporting failed channel requests...

Fine with me too, I'll send that patch as well and let Ulf pick.

	Arnd
