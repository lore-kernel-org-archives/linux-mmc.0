From: David Lechner <david@lechnology.com>
Subject: [PATCH v3 3/5] mmc: davinci: fix unwinding in probe
Date: Wed, 16 Mar 2016 22:45:33 -0500
Message-ID: <1458186341-6970-4-git-send-email-david@lechnology.com>
References: <1458186341-6970-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458186341-6970-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Unwiding from an error in davinci_mmcsd_probe was a mess. Some errors were
not handled and not all paths unwound correctly. Also using devm_ where
possible to simplify things.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes: fixed ret = -ENODEV mistake. Updated to apply on top of patch from
Peter Ujfalusi.


 drivers/mmc/host/davinci_mmc.c | 96 ++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 59 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 498c42d..e75407d 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1205,7 +1205,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	struct mmc_davinci_host *host = NULL;
 	struct mmc_host *mmc = NULL;
 	struct resource *r, *mem = NULL;
-	int ret = 0, irq = 0;
+	int ret, irq;
 	size_t mem_size;
 	const struct platform_device_id *id_entry;
 
@@ -1215,38 +1215,38 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
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
+		return -ENOMEM;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;	/* Important */
 
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
@@ -1264,7 +1264,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	if (host->use_dma) {
 		ret = davinci_acquire_dma_channels(host);
 		if (ret == -EPROBE_DEFER)
-			goto out;
+			goto dma_probe_defer;
 		else if (ret)
 			host->use_dma = 0;
 	}
@@ -1321,15 +1321,17 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 
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
@@ -1342,28 +1344,18 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 
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
+dma_probe_defer:
+	clk_disable(host->clk);
+clk_enable_fail:
+clk_get_fail:
+ioremap_fail:
+	mmc_free_host(mmc);
 
 	return ret;
 }
@@ -1372,25 +1364,11 @@ static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
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
