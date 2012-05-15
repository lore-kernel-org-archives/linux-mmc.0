From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 00/12] OMAP DMA engine conversion
Date: Tue, 15 May 2012 08:41:41 +0100
Message-ID: <20120515074141.GA16276@n2100.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk> <1337055564.16185.5356.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1337055564.16185.5356.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, May 15, 2012 at 09:49:24AM +0530, Vinod Koul wrote:
> On Mon, 2012-04-23 at 17:04 +0100, Russell King - ARM Linux wrote:
> > For the full text, please see 
> > 
> > http://lists.arm.linux.org.uk/lurker/message/20120418.100954.7fa7acf8.en.html
> > 
> > This version contains updates for some of the comments received from the
> > previous round, and adds the OMAP1/2 MMC and SPI drivers to the conversion.
> > 
> > I've also added a note to feature-removal noting that the existing APIs
> > will be removed around 2013 - I'm planning January for that at the
> > moment.  Having drivers around which are unconverted blocks further work
> > on the DMA engine conversion, so it's actually important that we get
> > as many drivers converted as soon as possible.
> > 
> > Anything which isn't converted will probably have its DMA code removed,
> > or if that results in the driver not being usable, the driver itself
> > will be removed.
> > 
> > This series is still in RFC mode...
> Hi Russell,
> 
> What is the state of this series, would be good to have this merged in
> upcoming merge window.

It's not ready for merging.  While it allows some of the OMAP drivers
to be converted, there's others which need changes to omap-dma.c.

So, I'm _not_ planning to see this in for the upcoming merge window.
