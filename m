From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/3] mmc: sdhci-pltfm: export sdhci_pltfm_suspend/resume
Date: Mon, 31 Jul 2017 21:56:48 +0900
Message-ID: <1501505809-393-3-git-send-email-yamada.masahiro@socionext.com>
References: <1501505809-393-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501505809-393-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Piotr Sroka <piotrs@cadence.com>, Adrian Hunter <adrian.hunter@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This will be useful when drivers want to reuse only the suspend/resume
callbacks instead of whole of sdhci_pltfm_pmops.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-pltfm.c | 6 ++++--
 drivers/mmc/host/sdhci-pltfm.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index be9a79d62e22..a34eacac612f 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -209,7 +209,7 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
 
 #ifdef CONFIG_PM_SLEEP
-static int sdhci_pltfm_suspend(struct device *dev)
+int sdhci_pltfm_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -226,8 +226,9 @@ static int sdhci_pltfm_suspend(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(sdhci_pltfm_suspend);
 
-static int sdhci_pltfm_resume(struct device *dev)
+int sdhci_pltfm_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -239,6 +240,7 @@ static int sdhci_pltfm_resume(struct device *dev)
 
 	return sdhci_resume_host(host);
 }
+EXPORT_SYMBOL_GPL(sdhci_pltfm_resume);
 #endif
 
 const struct dev_pm_ops sdhci_pltfm_pmops = {
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 957839d0fe37..1e91fb1c020e 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -109,6 +109,8 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
 	return host->private;
 }
 
+int sdhci_pltfm_suspend(struct device *dev);
+int sdhci_pltfm_resume(struct device *dev);
 extern const struct dev_pm_ops sdhci_pltfm_pmops;
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
-- 
2.7.4
