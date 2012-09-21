From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 08/13] mmc: omap_hsmmc: limit max_segs with the
	EDMA DMAC
Date: Fri, 21 Sep 2012 19:47:21 +0100
Message-ID: <20120921184721.GD31374@n2100.arm.linux.org.uk>
References: <1348152226-13588-1-git-send-email-mporter@ti.com> <1348152226-13588-9-git-send-email-mporter@ti.com> <CANfBPZ81anOy8fWgKM1PgCtB4V2pEp2x1Qi4x1uPsq7QieMN5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANfBPZ81anOy8fWgKM1PgCtB4V2pEp2x1Qi4x1uPsq7QieMN5g@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Matt Porter <mporter@ti.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Arnd Bergmann <arnd@arndb.de>, Linux Documentation List <linux-doc@vger.kernel.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Dan Williams <djbw@fb.com>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 21, 2012 at 10:45:29PM +0530, S, Venkatraman wrote:
> On Thu, Sep 20, 2012 at 8:13 PM, Matt Porter <mporter@ti.com> wrote:
> > The EDMA DMAC has a hardware limitation that prevents supporting
> > scatter gather lists with any number of segments. Since the EDMA
> > DMA Engine driver sets the maximum segments to 16, we do the
> > same.
> >
> > Note: this can be removed once the DMA Engine API supports an
> > API to query the DMAC's segment limitations.
> >
> 
> I wouldn't want to bind the properties of EDMA to omap_hsmmc as this patch
> suggests. Why don't we have a max_segs property, which when explicitly specified
> in DT, will override the default ?

Why not have a generic way that DMA engine can export these kinds of
properties?
