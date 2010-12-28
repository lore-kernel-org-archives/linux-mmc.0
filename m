From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 2/6 v3] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
Date: Tue, 28 Dec 2010 23:22:32 +0100
Message-ID: <1293574956-30035-3-git-send-email-arnd@arndnet.de>
References: <1293574956-30035-1-git-send-email-arnd@arndnet.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1293574956-30035-1-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Hannemann <arnd@arndnet.de>
List-Id: linux-mmc@vger.kernel.org

The SDHI Controller on SH-Mobile SoCs supports SDIO IRQ signalling.
This patch advertises this fact to the tmio_mmc driver.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/sh_mobile_sdhi.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
index 3ca20ec..0a7df44 100644
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ b/drivers/mfd/sh_mobile_sdhi.c
@@ -131,6 +131,11 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	 */
 	mmc_data->flags |= TMIO_MMC_BLKSZ_2BYTES;
 
+	/*
+	 * All SDHI blocks support SDIO IRQ signalling.
+	 */
+	mmc_data->flags |= TMIO_MMC_SDIO_IRQ;
+
 	if (p && p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
 		priv->param_tx.slave_id = p->dma_slave_tx;
 		priv->param_rx.slave_id = p->dma_slave_rx;
-- 
1.7.2.3

