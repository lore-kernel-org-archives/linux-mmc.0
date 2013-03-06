From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v9 2/9] ARM: edma: remove unused transfer controller handlers
Date: Wed,  6 Mar 2013 11:15:32 -0500
Message-ID: <1362586540-10393-3-git-send-email-mporter@ti.com>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1362586540-10393-1-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Fix build on OMAP, the irqs are undefined on AM33xx.
These error interrupt handlers were hardcoded as disabled
so since they are unused code, simply remove them.

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/common/edma.c |   37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index dcaeb8e..a1db6cd 100644
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
@@ -1541,23 +1521,6 @@ static int __init edma_probe(struct platform_device *pdev)
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


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
