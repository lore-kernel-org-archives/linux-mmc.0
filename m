From: David Lechner <david@lechnology.com>
Subject: [PATCH 2/4] mmc: davinci: fix unwinding in probe
Date: Wed,  9 Mar 2016 17:50:03 -0600
Message-ID: <1457567405-30475-3-git-send-email-david@lechnology.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1457567405-30475-1-git-send-email-david@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, k.kozlowski.k@gmail.com, linux-mmc@vger.kernel.org
Cc: khilman@deeprootsystems.com, nsekhar@ti.com, David Lechner <david@lechnology.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Unwiding from an error in davinci_mmcsd_probe was a mess. Some errors were
not handled and not all paths unwound correctly.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/mmc/host/davinci_mmc.c | 62 +++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 469aa8c..f571549 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1232,7 +1232,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	struct mmc_davinci_host *host = NULL;
 	struct mmc_host *mmc = NULL;
 	struct resource *r, *mem = NULL;
-	int ret = 0, irq = 0;
+	int ret, irq;
 	size_t mem_size;
 	const struct platform_device_id *id_entry;
 
@@ -1242,22 +1242,21 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
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
 	mem = request_mem_region(r->start, mem_size, pdev->name);
 	if (!mem)
-		goto out;
+		return -EBUSY;
 
-	ret = -ENOMEM;
 	mmc = mmc_alloc_host(sizeof(struct mmc_davinci_host), &pdev->dev);
-	if (!mmc)
-		goto out;
+	if (!mmc) {
+		ret = -ENOMEM;
+		goto mmc_alloc_host_fail;
+	}
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;	/* Important */
@@ -1277,15 +1276,17 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	host->mem_res = mem;
 	host->base = ioremap(mem->start, mem_size);
 	if (!host->base)
-		goto out;
+		goto ioremap_fail;
 
-	ret = -ENXIO;
 	host->clk = clk_get(&pdev->dev, NULL);
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
@@ -1355,11 +1356,11 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
-		goto out;
+		goto mmc_add_host_fail;
 
 	ret = request_irq(irq, mmc_davinci_irq, 0, mmc_hostname(mmc), host);
 	if (ret)
-		goto out;
+		goto request_irq_fail;
 
 	if (host->sdio_irq >= 0) {
 		ret = request_irq(host->sdio_irq, mmc_davinci_sdio_irq, 0,
@@ -1376,28 +1377,21 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 
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
+	clk_put(host->clk);
+clk_get_fail:
+	iounmap(host->base);
+ioremap_fail:
+	mmc_free_host(mmc);
+mmc_alloc_host_fail:
+	release_resource(mem);
 
 	return ret;
 }
-- 
1.9.1
