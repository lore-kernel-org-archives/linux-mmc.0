From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v10 2/2] ARM: edma: remove unused transfer controller handlers
Date: Mon, 17 Jun 2013 15:36:11 +0530
Message-ID: <1371463571-2578-3-git-send-email-nsekhar@ti.com>
References: <1371463571-2578-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1371463571-2578-1-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Joel Fernandes A <joelagnel-l0cyMroinI0@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>

Fix build on OMAP, the irqs are undefined on AM33xx.
These error interrupt handlers were hardcoded as disabled
so since they are unused code, simply remove them.

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
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
1.7.10.1
