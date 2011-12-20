From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 0/4] Fix the left DMA_NONE from dma_transfer_direction
 migration
Date: Tue, 20 Dec 2011 20:54:02 +0800
Message-ID: <20111220125401.GA5129@S2101-09.ap.freescale.net>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
 <1324373044.1641.10096.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:32536
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750830Ab1LTMpA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2011 07:45:00 -0500
Content-Disposition: inline
In-Reply-To: <1324373044.1641.10096.camel@vkoul-udesk3>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>, Artem Bityutskiy <artem.bityutskiy@intel.com>, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org

On Tue, Dec 20, 2011 at 02:54:04PM +0530, Vinod Koul wrote:
> On Tue, 2011-12-13 at 23:48 +0800, Shawn Guo wrote:
> > I have been working on -rc recently, and have not noticed the failure
> > until I ran next tree today.  The mxs-mmc driver is broken on next
> > tree because the DMA_NONE was left over from the dma_transfer_direction
> > migration for mxs-dma and its client drivers.
> > 
> For DMA transfer, the NONE direction makes no sense?
> 
> In your conetext, what are you trying to achieve?
> 
The mxs-dma controller has a feature to program peripheral registers
with given values (mxs-dma PIO mode).  This is designed to pipeline
the operations.  For example, we can put mxs-mmc controller register
values into scatter list as one element together with actual data.
Triggering the mxs-dma, the dma will program the values into mxs-mmc
controller register to set up and enable mxs-mmc, and then dma
continue transfer data from/to mxs-mmc.  All these get done in one
dmaengine_submit().

And DMA_NONE was used to let mxs-dma know this is a PIO operation.

-- 
Regards,
Shawn

