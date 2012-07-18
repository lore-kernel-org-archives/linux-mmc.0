From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Tue, 17 Jul 2012 23:59:51 -0700
Message-ID: <20120718065951.GH6522@atomide.com>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
 <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
 <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53289 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab2GRG76 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 02:59:58 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin.Hilman.khilman@ti.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

* Javier Martinez Canillas <javier@dowhile0.org> [120716 23:56]:
> On Tue, Jul 17, 2012 at 8:45 AM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
> > Hi,
> >
> > On Tue, Jul 17, 2012 at 6:00 AM, Javier Martinez Canillas
> > <javier@dowhile0.org> wrote:
> >> The OMAP MMC and OMAP High Speed MMC hosts now use entirely the DMA
> >> engine API instead of the previous private DMA API implementation.
> >>
> >> So, if the kernel is built with support for any of these hosts but it
> >> doesn't support DMA devices nor OMAP DMA support, it fails when trying
> >> to obtain a DMA channel which leads to the following error on an OMAP3
> >> IGEPv2 Rev.C board (and probably on most OMAP boards with MMC support):
> >>
> >> [    2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
> >> [    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
> >>
> >> selecting automatically CONFIG_DMADEVICES and CONFIG_DMA_OMAP solves it.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> >> ---
> > Considering, we are updating drivers to select the DMA engine, can you
> > also include
> > "drivers/spi/spi-omap2-mcspi.c" which is also updated for DMA engine.
> >
> > Regards
> > Santosh
> 
> Hi Santosh,
> 
> Ok, I'll send a v2 now which includes spi-omap2-mcspi then.

I don't think we should do this, the drivers should work with and without
dma. This just needs to be added to the omap2plus_defconfig.

Regards,

Tony
