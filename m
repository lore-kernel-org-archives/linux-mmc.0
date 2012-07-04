From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/4] dma: sh: stop using .private
Date: Wed,  4 Jul 2012 18:17:39 +0200
Message-ID: <1341418663-24432-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Vinod

Here's an attempt to convert the shdma driver to a new method, whereby a 
centrally provided filter function is used and the DMA_SLAVE_CONFIG command 
is enabled for slave operation. The last patch is an illustration of how 
this new method shall be used. If this approach is acceptable, I'll also 
convert the remaining shdma user drivers. This patch series goes on top of 
my earlier patches to split shdma.c. It might be easier at some point for 
you to have me provide you a git tree to pull from.

Chris, this time the mmc patch is not yet to be applied. We first have to 
sort out the dmaengine API.

Guennadi Liakhovetski (4):
  dmaengine: shdma: prepare to stop using struct dma_chan::private
  dma: sh: use an integer slave ID to improve API compatibility
  dma: sh: provide a migration path for slave drivers to stop using
    .private
  mmc: sh_mmcif: switch to the new DMA channel allocation and
    configuration

 drivers/dma/sh/shdma-base.c |  130 ++++++++++++++++++++++++++++++++-----------
 drivers/dma/sh/shdma.c      |   35 +++++------
 drivers/dma/sh/shdma.h      |    2 +
 drivers/mmc/host/sh_mmcif.c |   90 +++++++++++++++++-------------
 include/linux/sh_dma.h      |   12 ++--
 include/linux/shdma-base.h  |    7 +-
 6 files changed, 177 insertions(+), 99 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
