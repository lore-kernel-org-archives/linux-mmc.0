From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix bug that may block a data transfer
 forever.
Date: Fri, 14 Sep 2012 08:22:37 +0530
Message-ID: <1347591157.1943.5.camel@vkoul-udesk3>
References: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42338 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763Ab2INC4I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Sep 2012 22:56:08 -0400
In-Reply-To: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, s.hauer@pengutronix.de, cjb@laptop.org, fabio.estevam@freescale.com, gcembed@gmail.com

On Fri, 2012-09-07 at 12:43 +0200, Javier Martin wrote:
> 
> The problem can be easily reproduced using a script that loops
> copying a file in an SD card to another place in the same SD card
> and its related to read transfers. This only happens with DMA enabled.
> 
> This is related to the fact that, when reading, an MMC irq signals
> the fact that all data from the SD card has been copied to the
> internal buffers. However, it doesn't signal whether the DMA transfer
> that is in charge of moving data from these internal buffers to RAM
> has finished or not. Thus, calling dmaengine_terminate_all() in the
> MMC irq routine can cancel an ongoing DMA transfer leaving some data
> in the internal buffers that produces an accumulative effect which,
> in the end, blocks a read data transfer forever.
> 
> The following patch watches DMA irq for reading and MMC irqs for
> writing transfers. The 'dangerous' usage of dmaengine_terminate_all()
> is removed and a timeout of 10 seconds is added so that the MMC won't
> block forever anymore. 
For a normal transactions why should you call dmaengine_terminate_all().
This should be called when you doing abort or cleanup in some erranous
situation.

why was it called in first place?
-- 
~Vinod

