From: David Lechner <david@lechnology.com>
Subject: [PATCH v2 2/5] mmc: davinci: fix unwinding in probe
Date: Mon, 14 Mar 2016 17:54:38 -0500
Message-ID: <1457996081-21975-3-git-send-email-david@lechnology.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:59497 "EHLO vern.gendns.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbcCNW41 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Mar 2016 18:56:27 -0400
In-Reply-To: <1457996081-21975-1-git-send-email-david@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: nsekhar@ti.com
Cc: khilman@kernel.org, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, David Lechner <david@lechnology.com>

Unwiding from an error in davinci_mmcsd_probe was a mess. Some errors were
not handled and not all paths unwound correctly. Also using devm_ where
possible to simplify things.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes: use devm_ where possible

 drivers/mmc/host/davinci_mmc.c | 93 ++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 58 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index a294d261..6dd9562 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1223,7 +1223,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	struct mmc_davinci_host *host = NULL;
 	struct mmc_host *mmc = NULL;
 	struct resource *r, *mem = NULL;
-	int ret = 0, irq = 0;
+	int ret, irq;
 	size_t mem_size;
 	const struct platform_device_id *id_entry;
 
@@ -1233,22 +1233,20 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	ret = -ENODEV;
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (!r || irq == NO_IRQ)
-		goto out;
+		return -ENODEV;
 
-	ret = -EBUSY;
 	mem_size = resource_size(r);
-	mem = request_mem_region(r->start, mem_size, pdev->name);
+	mem = devm_request_mem_region(&pdev->dev, r->start, mem_size,
+				      pdev->name);
 	if (!mem)
-		goto out;
+		return -EBUSY;
 
-	ret = -ENOMEM;
 	mmc = mmc_alloc_host(sizeof(struct mmc_davinci_host), &pdev->dev);
 	if (!mmc)
-		goto out;
+		ret = -ENOMEM;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;	/* Important */
@@ -1266,17 +1264,19 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 		host->txdma = r->start;
 
 	host->mem_res = mem;
-	host->base = ioremap(mem->start, mem_size);
+	host->base = devm_ioremap(&pdev->dev, mem->start, mem_size);
 	if (!host->base)
-		goto out;
+		goto ioremap_fail;
 
-	ret = -ENXIO;
-	host->clk = clk_get(&pdev->dev, NULL);
+	host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
-		goto out;
+		goto clk_get_fail;
 	}
-	clk_enable(host->clk);
+	ret = clk_enable(host->clk);
+	if (ret)
+		goto clk_enable_fail;
+
 	host->mmc_input_clk = clk_get_rate(host->clk);
 
 	init_mmcsd_host(host);
@@ -1346,15 +1346,17 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
-		goto out;
+		goto mmc_add_host_fail;
 
-	ret = request_irq(irq, mmc_davinci_irq, 0, mmc_hostname(mmc), host);
+	ret = devm_request_irq(&pdev->dev, irq, mmc_davinci_irq, 0,
+			       mmc_hostname(mmc), host);
 	if (ret)
-		goto out;
+		goto request_irq_fail;
 
 	if (host->sdio_irq >= 0) {
-		ret = request_irq(host->sdio_irq, mmc_davinci_sdio_irq, 0,
-				  mmc_hostname(mmc), host);
+		ret = devm_request_irq(&pdev->dev, host->sdio_irq,
+				       mmc_davinci_sdio_irq, 0,
+				       mmc_hostname(mmc), host);
 		if (!ret)
 			mmc->caps |= MMC_CAP_SDIO_IRQ;
 	}
@@ -1367,28 +1369,17 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 
 	return 0;
 
-out:
+request_irq_fail:
+	mmc_remove_host(mmc);
+mmc_add_host_fail:
 	mmc_davinci_cpufreq_deregister(host);
 cpu_freq_fail:
-	if (host) {
-		davinci_release_dma_channels(host);
-
-		if (host->clk) {
-			clk_disable(host->clk);
-			clk_put(host->clk);
-		}
-
-		if (host->base)
-			iounmap(host->base);
-	}
-
-	if (mmc)
-		mmc_free_host(mmc);
-
-	if (mem)
-		release_resource(mem);
-
-	dev_dbg(&pdev->dev, "probe err %d\n", ret);
+	davinci_release_dma_channels(host);
+	clk_disable(host->clk);
+clk_enable_fail:
+clk_get_fail:
+ioremap_fail:
+	mmc_free_host(mmc);
 
 	return ret;
 }
@@ -1397,25 +1388,11 @@ static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
 {
 	struct mmc_davinci_host *host = platform_get_drvdata(pdev);
 
-	if (host) {
-		mmc_davinci_cpufreq_deregister(host);
-
-		mmc_remove_host(host->mmc);
-		free_irq(host->mmc_irq, host);
-		if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
-			free_irq(host->sdio_irq, host);
-
-		davinci_release_dma_channels(host);
-
-		clk_disable(host->clk);
-		clk_put(host->clk);
-
-		iounmap(host->base);
-
-		release_resource(host->mem_res);
-
-		mmc_free_host(host->mmc);
-	}
+	mmc_remove_host(host->mmc);
+	mmc_davinci_cpufreq_deregister(host);
+	davinci_release_dma_channels(host);
+	clk_disable(host->clk);
+	mmc_free_host(host->mmc);
 
 	return 0;
 }
-- 
1.9.1

