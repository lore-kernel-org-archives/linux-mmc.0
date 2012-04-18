From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
Date: Wed, 18 Apr 2012 14:01:44 -0700
Message-ID: <20120418210142.GR21106@atomide.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
 <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
 <20120418152956.GP25053@n2100.arm.linux.org.uk>
 <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
 <20120418194224.GS25053@n2100.arm.linux.org.uk>
 <20120418200214.GP21106@atomide.com>
 <20120418202447.GT25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25841 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab2DRVBw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 17:01:52 -0400
Content-Disposition: inline
In-Reply-To: <20120418202447.GT25053@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120418 13:28]:
> On Wed, Apr 18, 2012 at 01:02:15PM -0700, Tony Lindgren wrote:
> > The scatterlist entries are separate DMA requests on omap1, there's no
> > chaining support in the DMA hardware on omap1. So yes, it's for every
> > scatterlist entry on omap1.
> 
> There's no direct scatterlist support on OMAP2 either (omap_hsmmc _used_
> to do each scatterlist entry separately too).  The DMA engine driver
> does the same, but will walk the scatterlist internally rather than the
> driver having to do it.

OK
 
> I'd like to have the same thing happen on OMAP1 as well (it's actually
> quite simple to do) and it means that this DMA engine implementation
> detail is (correctly) hidden from the drivers - provided there's no
> dependencies on each individual scatterlist entry back to the peripheral
> driver.

That would be nice. If the DMA engine driver can't dynamically adjust the
frame size for each SG entry, then maybe we can work around that by not doing
DMA for entries that are below the frame sizes?

Tony

