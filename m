From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 00/12] OMAP DMA engine conversion
Date: Tue, 15 May 2012 10:32:41 +0100
Message-ID: <20120515093241.GB16276@n2100.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk> <1337055564.16185.5356.camel@vkoul-udesk3> <20120515074141.GA16276@n2100.arm.linux.org.uk> <1337072367.16185.5401.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1337072367.16185.5401.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, May 15, 2012 at 02:29:27PM +0530, Vinod Koul wrote:
> On Tue, 2012-05-15 at 08:41 +0100, Russell King - ARM Linux wrote:
> > It's not ready for merging.  While it allows some of the OMAP drivers
> > to be converted, there's others which need changes to omap-dma.c.
> > 
> > So, I'm _not_ planning to see this in for the upcoming merge window.
> Okay, Thanks for the update. I am waiting for the virtual channel
> support in this series.

It's changed a little since the last post to allow it to support the
tx_status semantics we discussed, and has some rudimentary and untested
cyclic support.

As we're in the final week before the merge window, and this stuff has
not had any time in linux-next, it's rather late to think about putting
it in for v3.5.
