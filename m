From: Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] mc: sh-mmcif: handle MMC_WRITE_MULTIPLE_BLOCK completion IRQ
 again
Date: Thu, 21 Feb 2013 15:31:18 +0000
Message-ID: <1361460678-9429-1-git-send-email-phil.edworthy@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus <magnus.damm@gmail.com>, Simon <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Phil Edworthy <phil.edworthy@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Upon completion of a MMC_WRITE_MULTIPLE_BLOCK command MMCIF issues an IRQ
with the BUFREN or BUFWEN bits set and often with one or several of CMD12
bits set.

If those interrupts are not acknowledged, an additional interrupt can be
produced and will be delivered later, possibly when the transaction has
already been completed. To prevent this from happening, CMD12 completion
interrupt sources have to be cleared too upon reception of a BUFREN or
BUFWEN IRQ.

This is similar to commit 7a7eb328; this change adds the same handling for
BUFREN and BUFWEN interrupts.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
Tested on Renesas Hurricane board with r8a7779 device, eMMC with DMA.

 drivers/mmc/host/sh_mmcif.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 9a4c151..59fa44e 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1199,10 +1199,14 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_CRSPE);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MCRSPE);
 	} else if (state & INT_BUFREN) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_BUFREN);
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
+			~(INT_CMD12DRE | INT_CMD12RBE |
+			  INT_CMD12CRE | INT_BUFREN));
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 	} else if (state & INT_BUFWEN) {
-		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_BUFWEN);
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
+			~(INT_CMD12DRE | INT_CMD12RBE |
+			  INT_CMD12CRE | INT_BUFWEN));
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 	} else if (state & INT_CMD12DRE) {
 		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
-- 
1.7.5.4

