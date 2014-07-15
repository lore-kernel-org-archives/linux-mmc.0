From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 04/11] mmc: tmio: Configure DMA slave bus width
Date: Wed, 16 Jul 2014 00:45:14 +0200
Message-ID: <1405464321-4723-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54062 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaGOWpY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jul 2014 18:45:24 -0400
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>

Even though some implementations support 4-bytes data register access,
the tmio driver never configures the hardware in such a way and always
performs 2-bytes accesses. Hardcode the DMA transfer size to 2 bytes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/tmio_mmc_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 03e7b28..eb8f1d5 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -294,6 +294,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 			cfg.slave_id = pdata->dma->slave_id_tx;
 		cfg.direction = DMA_MEM_TO_DEV;
 		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->pdata->bus_shift);
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		cfg.src_addr = 0;
 		ret = dmaengine_slave_config(host->chan_tx, &cfg);
 		if (ret < 0)
@@ -312,6 +313,7 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
 			cfg.slave_id = pdata->dma->slave_id_rx;
 		cfg.direction = DMA_DEV_TO_MEM;
 		cfg.src_addr = cfg.dst_addr;
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		cfg.dst_addr = 0;
 		ret = dmaengine_slave_config(host->chan_rx, &cfg);
 		if (ret < 0)
-- 
1.8.5.5

