From: Matt Porter <mporter@ti.com>
Subject: [PATCH v4 0/3] dmaengine: add slave sg transfer limits api
Date: Wed,  6 Mar 2013 14:56:04 -0500
Message-ID: <1362599767-11292-1-git-send-email-mporter@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <djbw@fb.com>, Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Changes since v3:
	- Change api name to dma_get_slave_sg_limits() to avoid
	  confusion with h/w caps which are static.

Changes since v2:
	- Change to a separate slave sg specific api. Drop the
	  generic per-channel capabilities api that is not used.

Changes since v1:
	- Use the existing dma_transaction_type enums instead of
	  adding the mostly duplicated dmaengine_apis enums

This series adds a new dmaengine api, dma_get_slave_sg_limits(), which
may be used by a client driver to get slave SG transfer limits for a
particular channel. At this time, these include the max number of
segments and max length of a segment that a channel can handle for a
SG transfer.

Along with the API implementation, this series implements the backend
device_slave_sg_limits() in the EDMA DMA Engine driver and converts the
davinci_mmc driver to use dma_get_slave_sg_limits() to replace hardcoded
limits.

This is tested on the AM1808-EVM.

Matt Porter (3):
  dmaengine: add dma_get_slave_sg_limits()
  dma: edma: add device_slave_sg_limits() support
  mmc: davinci: get SG segment limits with dma_get_slave_sg_limits()

 drivers/dma/edma.c                        |   17 +++++++++++++
 drivers/mmc/host/davinci_mmc.c            |   37 ++++++++-------------------
 include/linux/dmaengine.h                 |   39 +++++++++++++++++++++++++++++
 include/linux/platform_data/mmc-davinci.h |    3 ---
 4 files changed, 66 insertions(+), 30 deletions(-)

-- 
1.7.9.5
