From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3] mfd: sdhi: require the tmio-mmc driver to bounce unaligned
 buffers
Date: Tue, 23 Nov 2010 17:24:19 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011231723370.25676@axis700.grange>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

The SDHI controller on SH-Mobile SoCs requires even buffer addresses, when used
with DMA.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mfd/sh_mobile_sdhi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
index f1714f9..3ca20ec 100644
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ b/drivers/mfd/sh_mobile_sdhi.c
@@ -136,6 +136,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		priv->param_rx.slave_id = p->dma_slave_rx;
 		priv->dma_priv.chan_priv_tx = &priv->param_tx;
 		priv->dma_priv.chan_priv_rx = &priv->param_rx;
+		priv->dma_priv.alignment_shift = 1; /* 2-byte alignment */
 		mmc_data->dma = &priv->dma_priv;
 	}
 
-- 
1.7.2.3

