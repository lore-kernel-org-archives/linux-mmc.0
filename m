From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 2/3] mmc: sh_mmcif: Fix compilation warning on 64-bit platforms
Date: Wed, 30 Oct 2013 12:34:52 +0100
Message-ID: <1383132893-27008-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383086274-11049-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383132893-27008-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1383132893-27008-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Casting an integer to a void * generates a "cast to pointer from integer
of different size" warning. Cast the integer to an unsigned long first
to fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/mmc/host/sh_mmcif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I've kept this change separate from 1/3 to show why 1/3 and 2/3 are required
to fix a compilation warning before applying 3/3. Feel free to squash 1/3 and
2/3 if preferred.

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 92b9273..1f1438f 100644
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
1.8.1.5

