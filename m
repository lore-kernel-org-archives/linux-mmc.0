From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to
 arm/common
Date: Fri, 1 Feb 2013 13:49:16 -0500
Message-ID: <20130201184915.GP2244@beef>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Nori, Sekhar" <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Cousson, Benoit" <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Feb 01, 2013 at 06:41:08PM +0000, Tony Lindgren wrote:
> * Matt Porter <mporter@ti.com> [130201 10:25]:
> > Move mach-davinci/dma.c to common/edma.c so it can be used
> > by OMAP (specifically AM33xx) as well.
> 
> I think this should rather go to drivers/dma/?

No, this is the private EDMA API. It's the analogous thing to
the private OMAP dma API that is in plat-omap/dma.c. The actual
dmaengine driver is in drivers/dma/edma.c as a wrapper around
this...same way OMAP DMA engine conversion is being done.

-Matt
