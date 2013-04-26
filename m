From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/3] mmc: sdhi / tmio: add DT DMA
Date: Fri, 26 Apr 2013 17:47:16 +0200
Message-ID: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Samuel Ortiz <sameo@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

These 3 patches add Device Tree DMA support to the TMIO MMC driver, when 
used on SDHI platforms.

Samuel: these patches touch an mfd header file lightly, I think, it's 
better just to get your ack than to make a separate patch via your tree.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (3):
  mmc: sdhi/tmio: make DMA filter implementation specific
  mmc: sdhi/tmio: switch to using dmaengine_slave_config()
  mmc: sdhi/tmio: add DT DMA support

 drivers/mmc/host/sh_mobile_sdhi.c |   24 ++++++++++++------
 drivers/mmc/host/tmio_mmc_dma.c   |   48 +++++++++++++++++++++++++++----------
 include/linux/mfd/tmio.h          |    5 ++++
 3 files changed, 56 insertions(+), 21 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
