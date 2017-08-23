From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 3/4] mmc: sdhci: enable/disable the clock in
 sdhci_pltfm_suspend/resume
Date: Wed, 23 Aug 2017 13:15:02 +0900
Message-ID: <1503461703-16225-4-git-send-email-yamada.masahiro@socionext.com>
References: <1503461703-16225-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1503461703-16225-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Barry Song <baohua@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hao <haokexin@gmail.com>, Scott Branden <sbranden@broadcom.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Christian Daudt <csd@broadcom.com>, Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Hu Ziji <huziji@marvell.com>, bcm-kernel-feedback-list@broadcom.com, Zhangfei Gao <zhangfei.gao@marvell.com>, Gregory Fong <gregory.0xf0@gmail.com>, Olof Johansson <olof@lixom.net>, Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org, Piotr Sroka <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org

This commit provides similar cleanups as commit 83eacdfa2529 ("mmc:
sdhci: disable the clock in sdhci_pltfm_unregister()") did for
unregister hooks.

sdhci-brcmstb.c and sdhci-sirf.c implement their own suspend/resume
hooks to handle pltfm_host->clk.  Move clock handling to sdhci_pltfm.c
so that the drivers can reuse sdhci_pltfm_pmops.

The following drivers did not previously touch pltfm_host->clk during
suspend/resume, but now do:
  - sdhci-bcm-kona.c
  - sdhci-dove.c
  - sdhci-iproc.c
  - sdhci-pxav2.c
  - sdhci-tegra.c
  - sdhci-xenon.c

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
  - Disable clk when resume fails

Changes in v3: None
Changes in v2:
  - Fix build error reported by kbuild test robot

 drivers/mmc/host/sdhci-brcmstb.c | 37 +------------------------------------
 drivers/mmc/host/sdhci-pltfm.c   | 22 ++++++++++++++++++++--
 drivers/mmc/host/sdhci-sirf.c    | 39 +--------------------------------------
 3 files changed, 22 insertions(+), 76 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index e2f638338e8f..6d461fcdd663 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -21,41 +21,6 @@
 
 #include "sdhci-pltfm.h"
 
-#ifdef CONFIG_PM_SLEEP
-
-static int sdhci_brcmstb_suspend(struct device *dev)
-{
-	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int res;
-
-	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
-		mmc_retune_needed(host->mmc);
-
-	res = sdhci_suspend_host(host);
-	if (res)
-		return res;
-	clk_disable_unprepare(pltfm_host->clk);
-	return res;
-}
-
-static int sdhci_brcmstb_resume(struct device *dev)
-{
-	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int err;
-
-	err = clk_prepare_enable(pltfm_host->clk);
-	if (err)
-		return err;
-	return sdhci_resume_host(host);
-}
-
-#endif /* CONFIG_PM_SLEEP */
-
-static SIMPLE_DEV_PM_OPS(sdhci_brcmstb_pmops, sdhci_brcmstb_suspend,
-			sdhci_brcmstb_resume);
-
 static const struct sdhci_ops sdhci_brcmstb_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -131,7 +96,7 @@ MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
 static struct platform_driver sdhci_brcmstb_driver = {
 	.driver		= {
 		.name	= "sdhci-brcmstb",
-		.pm	= &sdhci_brcmstb_pmops,
+		.pm	= &sdhci_pltfm_pmops,
 		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
 	},
 	.probe		= sdhci_brcmstb_probe,
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e090d8c42ddb..4c0135e184e9 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -212,18 +212,36 @@ EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
 static int sdhci_pltfm_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-	return sdhci_suspend_host(host);
+	ret = sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(pltfm_host->clk);
+
+	return 0;
 }
 
 static int sdhci_pltfm_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		return ret;
 
-	return sdhci_resume_host(host);
+	ret = sdhci_resume_host(host);
+	if (ret)
+		clk_disable_unprepare(pltfm_host->clk);
+
+	return ret;
 }
 #endif
 
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index c251c6c0a112..0c7aa89df4e2 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -230,43 +230,6 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sdhci_sirf_suspend(struct device *dev)
-{
-	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int ret;
-
-	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
-		mmc_retune_needed(host->mmc);
-
-	ret = sdhci_suspend_host(host);
-	if (ret)
-		return ret;
-
-	clk_disable(pltfm_host->clk);
-
-	return 0;
-}
-
-static int sdhci_sirf_resume(struct device *dev)
-{
-	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	int ret;
-
-	ret = clk_enable(pltfm_host->clk);
-	if (ret) {
-		dev_dbg(dev, "Resume: Error enabling clock\n");
-		return ret;
-	}
-
-	return sdhci_resume_host(host);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(sdhci_sirf_pm_ops, sdhci_sirf_suspend, sdhci_sirf_resume);
-
 static const struct of_device_id sdhci_sirf_of_match[] = {
 	{ .compatible = "sirf,prima2-sdhc" },
 	{ }
@@ -277,7 +240,7 @@ static struct platform_driver sdhci_sirf_driver = {
 	.driver		= {
 		.name	= "sdhci-sirf",
 		.of_match_table = sdhci_sirf_of_match,
-		.pm	= &sdhci_sirf_pm_ops,
+		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_sirf_probe,
 	.remove		= sdhci_pltfm_unregister,
-- 
2.7.4
