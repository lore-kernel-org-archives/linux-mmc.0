From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 3/7] mmc: mediatek: Add PM support for MMC driver
Date: Tue, 28 Apr 2015 17:48:41 +0800
Message-ID: <1430214525-19198-4-git-send-email-chaotian.jing@mediatek.com>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1430214525-19198-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Add PM support for Mediatek MMC driver

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/mmc/host/mtk-sd.c | 58 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 30e688d..79177d9 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -22,6 +22,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spinlock.h>
 
@@ -215,6 +216,7 @@
 #define MSDC_ASYNC_FLAG (0x1 << 1)
 #define MSDC_MMAP_FLAG (0x1 << 2)
 
+#define MTK_MMC_AUTOSUSPEND_DELAY	500
 #define CMD_TIMEOUT         (HZ/10 * 5)	/* 100ms x5 */
 #define DAT_TIMEOUT         (HZ    * 5)	/* 1000ms x5 */
 
@@ -706,6 +708,9 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 	if (mrq->data)
 		msdc_unprepare_data(host, mrq);
 	mmc_request_done(host->mmc, mrq);
+
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 }
 
 /* returns true if command is fully handled; returns false otherwise */
@@ -862,6 +867,8 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		WARN_ON(host->mrq);
 	spin_unlock_irqrestore(&host->lock, flags);
 
+	pm_runtime_get_sync(host->dev);
+
 	if (mrq->data)
 		msdc_prepare_data(host, mrq);
 
@@ -999,7 +1006,6 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 	int ret = 0;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-
 		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
 			min_uv = 3300000;
 			max_uv = 3300000;
@@ -1018,7 +1024,6 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 					ret, min_uv, max_uv);
 		}
 	}
-
 	return ret;
 }
 
@@ -1176,8 +1181,10 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	int ret;
 	u32 ddr = 0;
 
+	pm_runtime_get_sync(host->dev);
+
 	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
-		ios->timing == MMC_TIMING_MMC_DDR52)
+			ios->timing == MMC_TIMING_MMC_DDR52)
 		ddr = 1;
 
 	msdc_set_buswidth(host, ios->bus_width);
@@ -1191,7 +1198,7 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 					ios->vdd);
 			if (ret) {
 				dev_err(host->dev, "Failed to set vmmc power!\n");
-				return;
+				goto end;
 			}
 		}
 		break;
@@ -1227,6 +1234,10 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (host->mclk != ios->clock || host->ddr != ddr)
 		msdc_set_mclk(host, ddr, ios->clock);
+
+end:
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 }
 
 static struct mmc_host_ops mt_msdc_ops = {
@@ -1350,12 +1361,19 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto release;
 
+	pm_runtime_set_active(host->dev);
+	pm_runtime_set_autosuspend_delay(host->dev, MTK_MMC_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(host->dev);
+	pm_runtime_enable(host->dev);
 	ret = mmc_add_host(mmc);
+
 	if (ret)
-		goto release;
+		goto end;
 
 	return 0;
 
+end:
+	pm_runtime_disable(host->dev);
 release:
 	platform_set_drvdata(pdev, NULL);
 	msdc_deinit_hw(host);
@@ -1368,6 +1386,7 @@ release_mem:
 		dma_free_coherent(&pdev->dev,
 			MAX_BD_NUM * sizeof(struct mt_bdma_desc),
 			host->dma.bd, host->dma.bd_addr);
+
 host_free:
 	mmc_free_host(mmc);
 
@@ -1382,10 +1401,14 @@ static int msdc_drv_remove(struct platform_device *pdev)
 	mmc = platform_get_drvdata(pdev);
 	host = mmc_priv(mmc);
 
+	pm_runtime_get_sync(host->dev);
+
 	platform_set_drvdata(pdev, NULL);
 	mmc_remove_host(host->mmc);
 	msdc_deinit_hw(host);
 
+	pm_runtime_disable(host->dev);
+	pm_runtime_put_noidle(host->dev);
 	dma_free_coherent(&pdev->dev,
 			sizeof(struct mt_gpdma_desc),
 			host->dma.gpd, host->dma.gpd_addr);
@@ -1397,6 +1420,30 @@ static int msdc_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int msdc_runtime_suspend(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct msdc_host *host = mmc_priv(mmc);
+
+	msdc_gate_clock(host);
+	return 0;
+}
+
+static int msdc_runtime_resume(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct msdc_host *host = mmc_priv(mmc);
+
+	msdc_ungate_clock(host);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops msdc_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
+};
+
 static const struct of_device_id msdc_of_ids[] = {
 	{   .compatible = "mediatek,mt8135-mmc", },
 	{}
@@ -1408,6 +1455,7 @@ static struct platform_driver mt_msdc_driver = {
 	.driver = {
 		.name = "mtk-msdc",
 		.of_match_table = msdc_of_ids,
+		.pm = &msdc_dev_pm_ops,
 	},
 };
 
-- 
1.8.1.1.dirty
