From: Matt Porter <mporter@ti.com>
Subject: [PATCH v6 02/10] ARM: edma: remove unused transfer controller handlers
Date: Wed, 30 Jan 2013 02:00:21 -0500
Message-ID: <1359529229-22207-3-git-send-email-mporter@ti.com>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1359529229-22207-1-git-send-email-mporter@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Chris Ball <cjb@laptop.org>
Cc: Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

Fix build on OMAP, the irqs are undefined on AM33xx.
These error interrupt handlers were hardcoded as disabled
so since they are unused code, simply remove them.

Signed-off-by: Matt Porter <mporter@ti.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/common/edma.c |   37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index be3c04a..2dce245 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -494,26 +494,6 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/******************************************************************************
- *
- * Transfer controller error interrupt handlers
- *
- *****************************************************************************/
-
-#define tc_errs_handled	false	/* disabled as long as they're NOPs */
-
-static irqreturn_t dma_tc0err_handler(int irq, void *data)
-{
-	dev_dbg(data, "dma_tc0err_handler\n");
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t dma_tc1err_handler(int irq, void *data)
-{
-	dev_dbg(data, "dma_tc1err_handler\n");
-	return IRQ_HANDLED;
-}
-
 static int reserve_contiguous_slots(int ctlr, unsigned int id,
 				     unsigned int num_slots,
 				     unsigned int start_slot)
@@ -1538,23 +1518,6 @@ static int edma_probe(struct platform_device *pdev)
 		arch_num_cc++;
 	}
 
-	if (tc_errs_handled) {
-		status = request_irq(IRQ_TCERRINT0, dma_tc0err_handler, 0,
-					"edma_tc0", &pdev->dev);
-		if (status < 0) {
-			dev_dbg(&pdev->dev, "request_irq %d failed --> %d\n",
-				IRQ_TCERRINT0, status);
-			return status;
-		}
-		status = request_irq(IRQ_TCERRINT, dma_tc1err_handler, 0,
-					"edma_tc1", &pdev->dev);
-		if (status < 0) {
-			dev_dbg(&pdev->dev, "request_irq %d --> %d\n",
-				IRQ_TCERRINT, status);
-			return status;
-		}
-	}
-
 	return 0;
 
 fail:
-- 
1.7.9.5

