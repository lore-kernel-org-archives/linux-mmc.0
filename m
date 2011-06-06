From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/3] dmaengine: add new dma API for
	max_segment_number
Date: Mon, 6 Jun 2011 10:47:51 +0100
Message-ID: <20110606094751.GC10508@n2100.arm.linux.org.uk>
References: <1307345414-26872-1-git-send-email-shawn.guo@linaro.org> <20110606170420I.fujita.tomonori@lab.ntt.co.jp> <20110606091410.GB10508@n2100.arm.linux.org.uk> <20110606183925D.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52015 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab1FFJsL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2011 05:48:11 -0400
Content-Disposition: inline
In-Reply-To: <20110606183925D.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: shawn.guo@linaro.org, patches@linaro.org, vinod.koul@intel.com, gregkh@suse.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, dan.j.williams@intel.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 06, 2011 at 06:41:09PM +0900, FUJITA Tomonori wrote:
> On Mon, 6 Jun 2011 10:14:10 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Mon, Jun 06, 2011 at 05:06:03PM +0900, FUJITA Tomonori wrote:
> > > max_segs isn't unrelated with the dma mapping API. I explained above,
> > > IOMMUs doesn't increase the number of segments (could decrease the
> > > number of segments by merging).
> > > 
> > > The limitation about the number of segment already lives elsewhere
> > > (e.g. queue's limits.max_segments).
> > 
> > I think you're missing the point entirely.
> > 
> > Lets take the problem at hand: you have two devices.  One of them is
> > handled by the DMA engine code.  One of them is a block device.
> > 
> > The block layer needs to know the various parameters of what is
> > allowable for DMA, including such things as the maximum size of a
> > segment, and the _number_ of segments that can be placed into any
> > one request.
> > 
> > As the DMA provider is _entirely_ separate and unknown to the block
> > device driver, the block device driver has no way to sanely provide
> > these parameters to the block layer - they are not a property of the
> > block device driver, but of the DMA provider.
> 
> struct device_dma_parameters is used for a property of the block
> device drivers (and scsi HBA drivers, etc). Not DMA provider. Right?

Wrong.  struct device_dma_parameters is a property of the _DMA_ _provider_.
It has to be.  Read what I said above and think about it.

In many cases, it so happens that the DMA provider and the block device
driver are the same entity, and so it may appear that device_dma_parameters
is a property of the block device driver.  As soon as you have to start
dealing with DMA providers being separate from the block device driver
then your eyes will be opened and you'll see that it can't work the way
you seem to want it to.

The DMA parameters have to come from the DMA provider or they're a total
nonsense.

> The drivers calls dma_set_seg_boundary() and the subsystems call
> dma_get_seg_boundary to set the value to queues.

And the device parameter which you pass into that has to be the DMA
providers struct device, not the block device's struct device.  The
block device itself has no DMA parameters of its own.

> This patch is trying to use struct device_dma_parameters in a
> different way. It adds a new DMA parameter but for the DMA parameter
> for a different layer. I'm not sure about different-layer stuff in 
> one structure and using similar API.

No it's not.
