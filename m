From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 2/2] mmc: sh_mmcif: Fix compilation warning on 64-bit platforms
Date: Wed, 27 Nov 2013 01:34:40 +0100
Message-ID: <1385512480-10432-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385512480-10432-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:49276 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab3K0Aem (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Nov 2013 19:34:42 -0500
In-Reply-To: <1385512480-10432-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Casting an integer to a void * generates a "cast to pointer from integer
of different size" warning. Cast the integer to an unsigned long first
to fix it.

Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/mmc/host/sh_mmcif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index bebf2fe..54730f4 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -403,7 +403,7 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
 		slave_id = 0;
 
 	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
-				(void *)slave_id, &host->pd->dev,
+				(void *)(unsigned long)slave_id, &host->pd->dev,
 				direction == DMA_MEM_TO_DEV ? "tx" : "rx");
 
 	dev_dbg(&host->pd->dev, "%s: %s: got channel %p\n", __func__,
-- 
1.8.3.2

