From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] ARM: OMAP: fix DMA vs memory ordering
Date: Mon, 23 Apr 2012 07:27:47 -0700
Message-ID: <20120423142745.GB3739@atomide.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk>
 <20120420222230.GH21106@atomide.com>
 <20120423141924.GB24299@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63087 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab2DWO2I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Apr 2012 10:28:08 -0400
Content-Disposition: inline
In-Reply-To: <20120423141924.GB24299@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120423 07:22]:
> On Fri, Apr 20, 2012 at 03:22:33PM -0700, Tony Lindgren wrote:
> > * Russell King <rmk+kernel@arm.linux.org.uk> [120418 03:14]:
> > > Using coherent DMA memory with the OMAP DMA engine results in
> > > unpredictable behaviour due to memory ordering issues; as things stand,
> > > there is no guarantee that data written to coherent DMA memory will be
> > > visible to the DMA hardware.
> > > 
> > > This is because the OMAP dma_write() accessor contains no barriers,
> > > necessary on ARMv6 and above.  The effect of this can be seen in comments
> > > in the OMAP serial driver, which incorrectly talks about cache flushing
> > > for the coherent DMA stuff.
> > > 
> > > Rather than adding barriers to the accessors, add it in the DMA support
> > > code just before we enable DMA, and just after we disable DMA.  This
> > > avoids having barriers for every DMA register access.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Would you like me to push this upstream on my next -rc push (with a
> stable tag?)

Yes sounds good to me.

Regards,

Tony
