From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 1/2] mmc: dw_mmc: use devres functions in dw_mmc
Date: Wed, 28 Nov 2012 19:26:03 +0900
Message-ID: <001b01cdcd52$c4b85700$4e290500$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11802 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab2K1K0F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Nov 2012 05:26:05 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0ME700FJE0ZFFKZ0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 28 Nov 2012 19:26:03 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0ME7007580ZFOCA0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 28 Nov 2012 19:26:03 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Use managed device resource functions for easy handling.
This makes driver simpler in the routine of error and exit.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   43 ++++++++++++++-----------------------------
 1 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7342029..6785d62 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1914,7 +1914,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 #endif /* CONFIG_MMC_DW_IDMAC */
 	}
 
-	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
+	host->vmmc = devm_regulator_get(mmc_dev(mmc), "vmmc");
 	if (IS_ERR(host->vmmc)) {
 		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc = NULL;
@@ -1963,7 +1963,7 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
 static void dw_mci_init_dma(struct dw_mci *host)
 {
 	/* Alloc memory for sg translation */
-	host->sg_cpu = dma_alloc_coherent(host->dev, PAGE_SIZE,
+	host->sg_cpu = dmam_alloc_coherent(host->dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
 	if (!host->sg_cpu) {
 		dev_err(host->dev, "%s: could not alloc DMA memory\n",
@@ -2112,26 +2112,24 @@ int dw_mci_probe(struct dw_mci *host)
 		return -ENODEV;
 	}
 
-	host->biu_clk = clk_get(host->dev, "biu");
+	host->biu_clk = devm_clk_get(host->dev, "biu");
 	if (IS_ERR(host->biu_clk)) {
 		dev_dbg(host->dev, "biu clock not available\n");
 	} else {
 		ret = clk_prepare_enable(host->biu_clk);
 		if (ret) {
 			dev_err(host->dev, "failed to enable biu clock\n");
-			clk_put(host->biu_clk);
 			return ret;
 		}
 	}
 
-	host->ciu_clk = clk_get(host->dev, "ciu");
+	host->ciu_clk = devm_clk_get(host->dev, "ciu");
 	if (IS_ERR(host->ciu_clk)) {
 		dev_dbg(host->dev, "ciu clock not available\n");
 	} else {
 		ret = clk_prepare_enable(host->ciu_clk);
 		if (ret) {
 			dev_err(host->dev, "failed to enable ciu clock\n");
-			clk_put(host->ciu_clk);
 			goto err_clk_biu;
 		}
 	}
@@ -2233,7 +2231,8 @@ int dw_mci_probe(struct dw_mci *host)
 	if (!host->card_workqueue)
 		goto err_dmaunmap;
 	INIT_WORK(&host->card_work, dw_mci_work_routine_card);
-	ret = request_irq(host->irq, dw_mci_interrupt, host->irq_flags, "dw-mci", host);
+	ret = devm_request_irq(host->dev, host->irq, dw_mci_interrupt,
+			       host->irq_flags, "dw-mci", host);
 	if (ret)
 		goto err_workqueue;
 
@@ -2271,7 +2270,7 @@ int dw_mci_probe(struct dw_mci *host)
 	} else {
 		dev_dbg(host->dev, "attempted to initialize %d slots, "
 					"but failed on all\n", host->num_slots);
-		goto err_init_slot;
+		goto err_workqueue;
 	}
 
 	/*
@@ -2291,33 +2290,24 @@ int dw_mci_probe(struct dw_mci *host)
 
 	return 0;
 
-err_init_slot:
-	free_irq(host->irq, host);
-
 err_workqueue:
 	destroy_workqueue(host->card_workqueue);
 
 err_dmaunmap:
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
-	dma_free_coherent(host->dev, PAGE_SIZE,
-			  host->sg_cpu, host->sg_dma);
 
-	if (host->vmmc) {
+	if (host->vmmc)
 		regulator_disable(host->vmmc);
-		regulator_put(host->vmmc);
-	}
 
 err_clk_ciu:
-	if (!IS_ERR(host->ciu_clk)) {
+	if (!IS_ERR(host->ciu_clk))
 		clk_disable_unprepare(host->ciu_clk);
-		clk_put(host->ciu_clk);
-	}
+
 err_clk_biu:
-	if (!IS_ERR(host->biu_clk)) {
+	if (!IS_ERR(host->biu_clk))
 		clk_disable_unprepare(host->biu_clk);
-		clk_put(host->biu_clk);
-	}
+
 	return ret;
 }
 EXPORT_SYMBOL(dw_mci_probe);
@@ -2339,24 +2329,19 @@ void dw_mci_remove(struct dw_mci *host)
 	mci_writel(host, CLKENA, 0);
 	mci_writel(host, CLKSRC, 0);
 
-	free_irq(host->irq, host);
 	destroy_workqueue(host->card_workqueue);
-	dma_free_coherent(host->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	if (host->vmmc) {
+	if (host->vmmc)
 		regulator_disable(host->vmmc);
-		regulator_put(host->vmmc);
-	}
 
 	if (!IS_ERR(host->ciu_clk))
 		clk_disable_unprepare(host->ciu_clk);
+
 	if (!IS_ERR(host->biu_clk))
 		clk_disable_unprepare(host->biu_clk);
-	clk_put(host->ciu_clk);
-	clk_put(host->biu_clk);
 }
 EXPORT_SYMBOL(dw_mci_remove);
 
-- 
1.7.0.4


