From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/4] Fix the left DMA_NONE from dma_transfer_direction migration
Date: Tue, 13 Dec 2011 23:48:02 +0800
Message-ID: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43726 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab1LMPkG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 10:40:06 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, Artem Bityutskiy <artem.bityutskiy@intel.com>
Cc: Huang Shijie <b32955@freescale.com>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

I have been working on -rc recently, and have not noticed the failure
until I ran next tree today.  The mxs-mmc driver is broken on next
tree because the DMA_NONE was left over from the dma_transfer_direction
migration for mxs-dma and its client drivers.

This seires is trying to fix it up.

Huang Shijie (1):
      mtd: fix compile error for gpmi-nand

Shawn Guo (3):
      dmaengine: add DMA_TRANS_NONE to dma_transfer_direction
      mmc: mxs-mmc: fix the dma_transfer_direction migration
      mtd: gpmi-nand: move to dma_transfer_direction

 drivers/dma/mxs-dma.c                 |    2 +-
 drivers/mmc/host/mxs-mmc.c            |    3 +
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   22 ++++++-----
 include/linux/dmaengine.h             |    1 +
 include/linux/mtd/gpmi-nand.h         |   68 +++++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+), 11 deletions(-)
