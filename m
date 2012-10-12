From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/4] MMC: omap_hsmmc: fix DMA config block
Date: Fri, 12 Oct 2012 12:58:13 +0200
Message-ID: <1350039495-360-3-git-send-email-zonque@gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:32904 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010Ab2JLK6s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Oct 2012 06:58:48 -0400
In-Reply-To: <1350039495-360-1-git-send-email-zonque@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Daniel Mack <zonque@gmail.com>, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Matt Porter <mporter@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

The .direction field of the config passed to dmaengine_slave_config()
must be set in order to make the generic code store the configured bus
width.

Without this patch, I keep getting the following error on a AM33xx
board:

[    1.963144] edma-dma-engine edma-dma-engine.0: Undefined slave buswidth
[    1.970158] omap_hsmmc mmc.4: prep_slave_sg() failed
[    1.975454] mmc1: error -1 whilst initialising SD card

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@ti.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/omap_hsmmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4b70823..2c57b0d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1260,6 +1260,8 @@ static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cfg.src_maxburst = data->blksz / 4;
 	cfg.dst_maxburst = data->blksz / 4;
+	cfg.direction = data->flags & MMC_DATA_WRITE ?
+				DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret)
@@ -1270,8 +1272,8 @@ static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 		return ret;
 
 	tx = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
-		data->flags & MMC_DATA_WRITE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
-		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+				     cfg.direction,
+				     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!tx) {
 		dev_err(mmc_dev(host->mmc), "prep_slave_sg() failed\n");
 		/* FIXME: cleanup */
-- 
1.7.11.4

