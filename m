From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] MMC: mmci: Add required documentation for Device
	Tree bindings
Date: Thu, 15 Mar 2012 17:58:16 +0000
Message-ID: <20120315175816.GH15988@n2100.arm.linux.org.uk>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <1331734803-17954-6-git-send-email-lee.jones@linaro.org> <20120315173508.GE15988@n2100.arm.linux.org.uk> <201203151749.07673.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54961 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827Ab2COR6k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 13:58:40 -0400
Content-Disposition: inline
In-Reply-To: <201203151749.07673.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org

On Thu, Mar 15, 2012 at 05:49:07PM +0000, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> > 
> > On Wed, Mar 14, 2012 at 02:20:03PM +0000, Lee Jones wrote:
> > > +ux500 variant specific properties:
> > > +- gpio-en                : contains the level-shifter enable gpio
> > > +- gpio-vsel              : contains the level-shifter voltage select gpio
> > > +- tx_dst_dev_type        : contains the tx destination device (DMA) 
> > > +- rx_src_dev_type        : contains the rx source device (DMA)
> > 
> > So what about the DMA support being proposed elsewhere?
> > 
> > This sounds like we're inventing one DMA solution for one bit of the tree
> > and another DMA solution for another bit.  This is madness.
> 
> Agreed. I originally made a similar comment for an early version but had not
> noticed that it made it into this one. This should be using the proper DMA
> bindings, or just auxdata while we're not entirely there yet.

It's something that I'm also concerned with the main OF DMA patches.  It's
not at all clear what we want from DMA bindings yet because we've hardly
started converting from platform specific DMA APIs to the DMA engine based
APIs.

The way DMA channels are selected by DMA APIs is significantly different
from the DMA engine based API, and I remain worried that we're locking in
to a platform specific DMA API method.

I think the DMA parts should be left alone until there has been much more
of an effort to convert to DMA engine based APIs for the various platforms.

Note: OMAP DMA is something I've been asked to take over, and is something
I've been looking at over the last couple of weeks so far.
