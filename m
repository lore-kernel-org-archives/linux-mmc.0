From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/3] mmc: tmio: runtime suspend the controller, where possible
Date: Wed, 11 May 2011 18:51:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105111849530.5557@axis700.grange>
References: <Pine.LNX.4.64.1105111843290.5557@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1105111843290.5557@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

The TMIO MMC controller cannot be powered off to save power, when no
card is plugged in, because then it will not be able to detect a new
card-insertion event. On some implementations, however, it is
possible to switch to using another source to detect card insertion.
This patch adds support for such implementations.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    3 ++
 drivers/mmc/host/tmio_mmc_pio.c |   64 +++++++++++++++++++++++++++++++++++----
 include/linux/mfd/tmio.h        |   17 ++++++++++
 3 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index c6bf726..8260bc2 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -131,4 +131,7 @@ int tmio_mmc_host_resume(struct device *dev);
 #define tmio_mmc_host_resume NULL
 #endif
 
+int tmio_mmc_host_runtime_suspend(struct device *dev);
+int tmio_mmc_host_runtime_resume(struct device *dev);
+
 #endif
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index af5d4f6..ad6347b 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -746,6 +746,7 @@ fail:
 static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_data *pdata = host->pdata;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -775,13 +776,24 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	/* Power sequence - OFF -> UP -> ON */
 	if (ios->power_mode == MMC_POWER_UP) {
+		if ((pdata->flags & TMIO_MMC_HAS_COLD_CD) && !pdata->power) {
+			pm_runtime_get_sync(&host->pdev->dev);
+			pdata->power = true;
+		}
 		/* power up SD bus */
 		if (host->set_pwr)
 			host->set_pwr(host->pdev, 1);
 	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
 		/* power down SD bus */
-		if (ios->power_mode == MMC_POWER_OFF && host->set_pwr)
-			host->set_pwr(host->pdev, 0);
+		if (ios->power_mode == MMC_POWER_OFF) {
+			if (host->set_pwr)
+				host->set_pwr(host->pdev, 0);
+			if ((pdata->flags & TMIO_MMC_HAS_COLD_CD) &&
+			    pdata->power) {
+				pdata->power = false;
+				pm_runtime_put(&host->pdev->dev);
+			}
+		}
 		tmio_mmc_clk_stop(host);
 	} else {
 		/* start bus clock */
@@ -853,6 +865,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	if (!mmc)
 		return -ENOMEM;
 
+	pdata->dev = &pdev->dev;
 	_host = mmc_priv(mmc);
 	_host->pdata = pdata;
 	_host->mmc = mmc;
@@ -886,6 +899,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	else
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
+	pdata->power = false;
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
@@ -907,7 +921,8 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	tmio_mmc_request_dma(_host, pdata);
 
 	/* We have to keep the device powered for its card detection to work */
-	pm_runtime_get_noresume(&pdev->dev);
+	if (!(pdata->flags & TMIO_MMC_HAS_COLD_CD))
+		pm_runtime_get_noresume(&pdev->dev);
 
 	mmc_add_host(mmc);
 
@@ -937,15 +952,25 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 {
 	struct platform_device *pdev = host->pdev;
 
+	/*
+	 * We don't have to manipulate pdata->power here: if there is a card in
+	 * the slot, the runtime PM is active and our .runtime_resume() will not
+	 * be run. If there is no card in the slot and the platform can suspend
+	 * the controller, the runtime PM is suspended and pdata->power == false,
+	 * so, our .runtime_resume() will not try to detect a card in the slot.
+	 */
+	if (host->pdata->flags & TMIO_MMC_HAS_COLD_CD)
+		pm_runtime_get_sync(&pdev->dev);
+
 	mmc_remove_host(host->mmc);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
-	iounmap(host->ctl);
-	mmc_free_host(host->mmc);
 
-	/* Compensate for pm_runtime_get_sync() in probe() above */
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	iounmap(host->ctl);
+	mmc_free_host(host->mmc);
 }
 EXPORT_SYMBOL(tmio_mmc_host_remove);
 
@@ -970,6 +995,9 @@ int tmio_mmc_host_resume(struct device *dev)
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
+	/* The MMC core will perform the complete set up */
+	host->pdata->power = false;
+
 	if (!host->pm_error)
 		pm_runtime_get_sync(dev);
 
@@ -982,4 +1010,28 @@ EXPORT_SYMBOL(tmio_mmc_host_resume);
 
 #endif	/* CONFIG_PM */
 
+int tmio_mmc_host_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+EXPORT_SYMBOL(tmio_mmc_host_runtime_suspend);
+
+int tmio_mmc_host_runtime_resume(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_data *pdata = host->pdata;
+
+	tmio_mmc_reset(host);
+
+	if (pdata->power) {
+		/* Only entered after a card-insert interrupt */
+		tmio_mmc_set_ios(mmc, &mmc->ios);
+		mmc_detect_change(mmc, msecs_to_jiffies(100));
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(tmio_mmc_host_runtime_resume);
+
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 8e70310..5a90266 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -4,6 +4,7 @@
 #include <linux/fb.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #define tmio_ioread8(addr) readb(addr)
 #define tmio_ioread16(addr) readw(addr)
@@ -61,6 +62,12 @@
  * Some controllers can support SDIO IRQ signalling.
  */
 #define TMIO_MMC_SDIO_IRQ		(1 << 2)
+/*
+ * Some platforms can detect card insertion events with controller powered
+ * down, in which case they have to call tmio_mmc_cd_wakeup() to power up the
+ * controller and report the event to the driver.
+ */
+#define TMIO_MMC_HAS_COLD_CD		(1 << 3)
 
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
@@ -82,11 +89,21 @@ struct tmio_mmc_data {
 	unsigned long			flags;
 	u32				ocr_mask;	/* available voltages */
 	struct tmio_mmc_dma		*dma;
+	struct device			*dev;
+	bool				power;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 	int (*get_cd)(struct platform_device *host);
 };
 
+static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data *pdata)
+{
+	if (pdata && !pdata->power) {
+		pdata->power = true;
+		pm_runtime_get(pdata->dev);
+	}
+}
+
 /*
  * data for the NAND controller
  */
-- 
1.7.2.5

