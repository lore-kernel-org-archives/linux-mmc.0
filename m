From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3] mmc: SDHI: DMA slave ID 0 is invalid
Date: Tue, 24 May 2011 12:24:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105241222470.31628@axis700.grange>
References: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: linux-mmc@vger.kernel.org

Don't try to allocate DMA resources, if the platform didn't specify
positive DMA slave IDs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index c05d699..e646741 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -132,7 +132,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->ocr_mask = p->tmio_ocr_mask;
 		mmc_data->capabilities |= p->tmio_caps;
 
-		if (p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
+		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
 			priv->param_tx.slave_id = p->dma_slave_tx;
 			priv->param_rx.slave_id = p->dma_slave_rx;
 			priv->dma_priv.chan_priv_tx = &priv->param_tx;
-- 
1.7.2.5

