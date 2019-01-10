From: Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] mmc: meson-gx: Free irq in release() callback
Date: Thu, 10 Jan 2019 19:49:08 +0100
Message-ID: <20190110184908.27413-1-repk@triplefau.lt>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Elie Roudninski <xademax@gmail.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
List-Id: linux-mmc@vger.kernel.org

Because the irq was requested through device managed resources API
(devm_request_threaded_irq()) it was freed after meson_mmc_remove()
completion, thus after mmc_free_host() has reclaimed meson_host memory.
As this irq is IRQF_SHARED, while using CONFIG_DEBUG_SHIRQ, its handler
get called by free_irq(). So meson_mmc_irq() was called after the
meson_host memory reclamation and was using invalid memory.

We ended up with the following scenario:
device_release_driver()
	meson_mmc_remove()
		mmc_free_host() /* Freeing host memory */
	...
	devres_release_all()
		devm_irq_release()
			__free_irq()
				meson_mmc_irq() /* Uses freed memory */

To avoid this, the irq is released in meson_mmc_remove() before
mmc_free_host() gets called.

This fixes https://marc.info/?l=linux-mmc&m=154707415208716.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 drivers/mmc/host/meson-gx-mmc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c2690c1a50ff..412cfd16bf15 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -179,6 +179,8 @@ struct meson_host {
 	struct sd_emmc_desc *descs;
 	dma_addr_t descs_dma_addr;
 
+	int irq;
+
 	bool vqmmc_enabled;
 };
 
@@ -1231,7 +1233,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct meson_host *host;
 	struct mmc_host *mmc;
-	int ret, irq;
+	int ret;
 
 	mmc = mmc_alloc_host(sizeof(struct meson_host), &pdev->dev);
 	if (!mmc)
@@ -1276,8 +1278,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		goto free_host;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq <= 0) {
 		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
 		ret = -EINVAL;
 		goto free_host;
@@ -1331,9 +1333,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
 	       host->regs + SD_EMMC_IRQ_EN);
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
-					meson_mmc_irq_thread, IRQF_SHARED,
-					NULL, host);
+	ret = devm_request_threaded_irq(&pdev->dev, host->irq, meson_mmc_irq,
+			meson_mmc_irq_thread, IRQF_SHARED, NULL, host);
 	if (ret)
 		goto err_init_clk;
 
@@ -1387,6 +1388,7 @@ static int meson_mmc_remove(struct platform_device *pdev)
 
 	/* disable interrupts */
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
+	devm_free_irq(host->dev, host->irq, host);
 
 	dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
 			  host->descs, host->descs_dma_addr);
-- 
2.20.1
