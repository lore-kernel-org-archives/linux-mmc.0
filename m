From: Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH 2/8] at_hdmac: prepare clk before calling enable
Date: Wed, 19 Jun 2013 13:15:44 +0200
Message-ID: <1371640544-9515-1-git-send-email-b.brezillon@overkiz.com>
References: <1371640263-9268-1-git-send-email-b.brezillon@overkiz.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371640263-9268-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Boris BREZILLON <b.brezillon@overkiz.com>
List-Id: linux-mmc@vger.kernel.org

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/dma/at_hdmac.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index e923cda..19a484a 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1374,7 +1374,9 @@ static int __init at_dma_probe(struct platform_device *pdev)
 		err = PTR_ERR(atdma->clk);
 		goto err_clk;
 	}
-	clk_enable(atdma->clk);
+	err = clk_prepare_enable(atdma->clk);
+	if (err)
+		goto err_clk_prepare;
 
 	/* force dma off, just in case */
 	at_dma_off(atdma);
@@ -1475,7 +1477,8 @@ err_pool_create:
 	platform_set_drvdata(pdev, NULL);
 	free_irq(platform_get_irq(pdev, 0), atdma);
 err_irq:
-	clk_disable(atdma->clk);
+	clk_disable_unprepare(atdma->clk);
+err_clk_prepare:
 	clk_put(atdma->clk);
 err_clk:
 	iounmap(atdma->regs);
@@ -1512,7 +1515,7 @@ static int at_dma_remove(struct platform_device *pdev)
 		list_del(&chan->device_node);
 	}
 
-	clk_disable(atdma->clk);
+	clk_disable_unprepare(atdma->clk);
 	clk_put(atdma->clk);
 
 	iounmap(atdma->regs);
@@ -1531,7 +1534,7 @@ static void at_dma_shutdown(struct platform_device *pdev)
 	struct at_dma	*atdma = platform_get_drvdata(pdev);
 
 	at_dma_off(platform_get_drvdata(pdev));
-	clk_disable(atdma->clk);
+	clk_disable_unprepare(atdma->clk);
 }
 
 static int at_dma_prepare(struct device *dev)
@@ -1588,7 +1591,7 @@ static int at_dma_suspend_noirq(struct device *dev)
 
 	/* disable DMA controller */
 	at_dma_off(atdma);
-	clk_disable(atdma->clk);
+	clk_disable_unprepare(atdma->clk);
 	return 0;
 }
 
@@ -1618,7 +1621,9 @@ static int at_dma_resume_noirq(struct device *dev)
 	struct dma_chan *chan, *_chan;
 
 	/* bring back DMA controller */
-	clk_enable(atdma->clk);
+	err = clk_prepare_enable(atdma->clk);
+	if (err)
+		return err;
 	dma_writel(atdma, EN, AT_DMA_ENABLE);
 
 	/* clear any pending interrupt */
-- 
1.7.9.5
