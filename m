From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 02/11] mmc: sh_mmcif: Fix DMA slave address configuration
Date: Wed, 16 Jul 2014 00:45:12 +0200
Message-ID: <1405464321-4723-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54069 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbaGOWpX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jul 2014 18:45:23 -0400
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>

Commit e5a233cb647d749de2f188477c9a54b94d90477f ("mmc: sh_mmcif:
Factorize DMA channel request and configuration code") incorrectly
set the destination address for both slave channels instead of setting
the source address for the receive channel. Fix that.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/sh_mmcif.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 656fbba..436d663 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -386,7 +386,7 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 			 struct sh_mmcif_plat_data *pdata,
 			 enum dma_transfer_direction direction)
 {
-	struct dma_slave_config cfg;
+	struct dma_slave_config cfg = { 0, };
 	struct dma_chan *chan;
 	unsigned int slave_id;
 	struct resource *res;
@@ -417,8 +417,12 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 	/* In the OF case the driver will get the slave ID from the DT */
 	cfg.slave_id = slave_id;
 	cfg.direction = direction;
-	cfg.dst_addr = res->start + MMCIF_CE_DATA;
-	cfg.src_addr = 0;
+
+	if (direction == DMA_DEV_TO_MEM)
+		cfg.src_addr = res->start + MMCIF_CE_DATA;
+	else
+		cfg.dst_addr = res->start + MMCIF_CE_DATA;
+
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret < 0) {
 		dma_release_channel(chan);
-- 
1.8.5.5

