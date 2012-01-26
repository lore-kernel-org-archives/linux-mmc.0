From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/7 v2] mmc: sh_mobile_sdhi: prepare for conversion to simple DMA
Date: Thu, 26 Jan 2012 15:56:21 +0100
Message-ID: <1327589784-4287-5-git-send-email-g.liakhovetski@gmx.de>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64387 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab2AZO4g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jan 2012 09:56:36 -0500
In-Reply-To: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index f91c3aa..2c3a9d3 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -130,10 +130,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->cd_gpio = p->cd_gpio;
 
 		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
-			priv->param_tx.slave_id = p->dma_slave_tx;
-			priv->param_rx.slave_id = p->dma_slave_rx;
-			priv->dma_priv.chan_priv_tx = &priv->param_tx;
-			priv->dma_priv.chan_priv_rx = &priv->param_rx;
+			priv->param_tx.simple_slave.slave_id = p->dma_slave_tx;
+			priv->param_rx.simple_slave.slave_id = p->dma_slave_rx;
+			priv->dma_priv.chan_priv_tx = &priv->param_tx.simple_slave;
+			priv->dma_priv.chan_priv_rx = &priv->param_rx.simple_slave;
 			priv->dma_priv.alignment_shift = 1; /* 2-byte alignment */
 			mmc_data->dma = &priv->dma_priv;
 		}
-- 
1.7.2.5

