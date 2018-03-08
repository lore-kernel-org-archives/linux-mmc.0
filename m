From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 8/8] mmc: sunxi: Add runtime_pm support
Date: Thu,  8 Mar 2018 15:52:54 +0100
Message-ID: <052c21c000f64c28fd6b64c4db11e4b706bebf79.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, ulf.hansson@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-mmc@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

So far, even if our card was not in use, we didn't shut down our main
clock, which meant that it was still output on the MMC bus.

While this obviously means that we could save some power there, it also
created issues when it comes with EMC control since we'll have a perfect
peak at the card clock rate.

Let's implement runtime_pm with autosuspend so that we will shut down the
clock when it's not been in use for quite some time.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 46 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index f6374066081b..0f98a5fcaade 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -35,6 +35,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/scatterlist.h>
@@ -973,6 +974,9 @@ static void sunxi_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	unsigned long flags;
 	u32 imask;
 
+	if (enable)
+		pm_runtime_get_noresume(host->dev);
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	imask = mmc_readl(host, REG_IMASK);
@@ -985,6 +989,9 @@ static void sunxi_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 	mmc_writel(host, REG_IMASK, imask);
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (!enable)
+		pm_runtime_put_noidle(host->mmc->parent);
 }
 
 static void sunxi_mmc_hw_reset(struct mmc_host *mmc)
@@ -1398,6 +1405,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_dma;
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = mmc_add_host(mmc);
 	if (ret)
 		goto error_free_dma;
@@ -1418,6 +1430,7 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
 
 	mmc_remove_host(mmc);
+	pm_runtime_force_suspend(&pdev->dev);
 	disable_irq(host->irq);
 	sunxi_mmc_disable(host);
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
@@ -1426,10 +1439,43 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int sunxi_mmc_runtime_resume(struct device *dev)
+{
+	struct mmc_host	*mmc = dev_get_drvdata(dev);
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+	int ret;
+
+	ret = sunxi_mmc_enable(host);
+	if (ret)
+		return ret;
+
+	sunxi_mmc_power_up(mmc, &mmc->ios);
+
+	return 0;
+}
+
+static int sunxi_mmc_runtime_suspend(struct device *dev)
+{
+	struct mmc_host	*mmc = dev_get_drvdata(dev);
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+
+	sunxi_mmc_power_off(mmc, &mmc->ios);
+	sunxi_mmc_disable(host);
+
+	return 0;
+}
+
+static const struct dev_pm_ops sunxi_mmc_pm_ops = {
+	SET_RUNTIME_PM_OPS(sunxi_mmc_runtime_suspend,
+			   sunxi_mmc_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver sunxi_mmc_driver = {
 	.driver = {
 		.name	= "sunxi-mmc",
 		.of_match_table = of_match_ptr(sunxi_mmc_of_match),
+		.pm = &sunxi_mmc_pm_ops,
 	},
 	.probe		= sunxi_mmc_probe,
 	.remove		= sunxi_mmc_remove,
-- 
git-series 0.9.1
