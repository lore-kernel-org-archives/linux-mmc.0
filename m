From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 2/6 v2] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
Date: Mon, 20 Dec 2010 15:53:47 +0000
Message-ID: <1292860431-16195-3-git-send-email-arnd@arndnet.de>
References: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Hannemann <arnd@arndnet.de>
List-Id: linux-mmc@vger.kernel.org

The SDHI Controller on SH-Mobile SoCs supports SDIO IRQ signalling.
This patch advertises this fact to the tmio_mmc driver.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
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

