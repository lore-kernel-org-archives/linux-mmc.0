From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: sdhci-msm: avoid unused function warning
Date: Mon, 10 Dec 2018 21:45:36 +0100
Message-ID: <20181210204546.2384299-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Vijay Viswanath <vviswana@codeaurora.org>, Evan Green <evgreen@chromium.org>, Sayali Lokhande <sayalil@codeaurora.org>, Veerabhadrarao Badiganti <vbadigan@codeaurora.org>, "weiyongjun (A)" <weiyongjun1@huawei.com>, Loic Poulain <loic.poulain@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The newly added sdhci_msm_restore_sdr_dll_config() function is only
called if CONFIG_PM is enabled:

drivers/mmc/host/sdhci-msm.c:1050:12: error: 'sdhci_msm_restore_sdr_dll_config' defined but not used [-Werror=unused-function]

Better remove the incorrect #ifdef altogether and just use __maybe_unused,
which is harder to get wrong.

Fixes: ec3349733550 ("mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-msm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5497a71abe07..d6c9ebd8d263 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1997,8 +1997,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int sdhci_msm_runtime_suspend(struct device *dev)
+static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2010,7 +2009,7 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int sdhci_msm_runtime_resume(struct device *dev)
+static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -2030,7 +2029,6 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sdhci_msm_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-- 
2.20.0
