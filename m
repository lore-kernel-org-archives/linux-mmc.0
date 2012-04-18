From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/8] ARM: OMAP: fix DMA vs memory ordering
Date: Wed, 18 Apr 2012 11:17:33 +0100
Message-ID: <20120418101733.GL25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk> <20120418101519.GU13842@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120418101519.GU13842@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 18, 2012 at 01:15:20PM +0300, Felipe Balbi wrote:
> On Wed, Apr 18, 2012 at 11:10:35AM +0100, Russell King wrote:
> > Using coherent DMA memory with the OMAP DMA engine results in
> > unpredictable behaviour due to memory ordering issues; as things stand,
> > there is no guarantee that data written to coherent DMA memory will be
> > visible to the DMA hardware.
> > 
> > This is because the OMAP dma_write() accessor contains no barriers,
> > necessary on ARMv6 and above.  The effect of this can be seen in comments
> > in the OMAP serial driver, which incorrectly talks about cache flushing
> > for the coherent DMA stuff.
> > 
> > Rather than adding barriers to the accessors, add it in the DMA support
> > code just before we enable DMA, and just after we disable DMA.  This
> > avoids having barriers for every DMA register access.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> cool, should this go to stable too ?

Has anyone seen a problem (other than me when trying to get DMA engine
working with omap-serial transmit paths) ?
