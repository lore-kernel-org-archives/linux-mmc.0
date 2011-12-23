From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/4] Fix the left DMA_NONE from dma_transfer_direction
 migration
Date: Fri, 23 Dec 2011 21:33:49 +0530
Message-ID: <1324656229.1633.12.camel@vkoul-udesk3>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42399 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557Ab1LWQDs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Dec 2011 11:03:48 -0500
In-Reply-To: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Artem Bityutskiy <artem.bityutskiy@intel.com>, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org

On Tue, 2011-12-13 at 23:48 +0800, Shawn Guo wrote:
> I have been working on -rc recently, and have not noticed the failure
> until I ran next tree today.  The mxs-mmc driver is broken on next
> tree because the DMA_NONE was left over from the dma_transfer_direction
> migration for mxs-dma and its client drivers.
> 
> This seires is trying to fix it up.
Applied, Thanks

> 
> Huang Shijie (1):
>       mtd: fix compile error for gpmi-nand
> 
> Shawn Guo (3):
>       dmaengine: add DMA_TRANS_NONE to dma_transfer_direction
>       mmc: mxs-mmc: fix the dma_transfer_direction migration
>       mtd: gpmi-nand: move to dma_transfer_direction
> 
>  drivers/dma/mxs-dma.c                 |    2 +-
>  drivers/mmc/host/mxs-mmc.c            |    3 +
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   22 ++++++-----
>  include/linux/dmaengine.h             |    1 +
>  include/linux/mtd/gpmi-nand.h         |   68 +++++++++++++++++++++++++++++++++
>  5 files changed, 85 insertions(+), 11 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
~Vinod

