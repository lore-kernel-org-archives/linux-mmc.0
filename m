From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: sdhci: remove unneeded (void *) casts in sdhci_(pltfm_)priv()
Date: Thu, 10 Nov 2016 22:22:17 +0900
Message-ID: <1478784138-18594-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The type of host->private is (unsigned long *).  No cast is needed
to return an opaque pointer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-pltfm.h | 2 +-
 drivers/mmc/host/sdhci.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 3280f20..957839d 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -106,7 +106,7 @@ extern int sdhci_pltfm_register(struct platform_device *pdev,
 
 static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
 {
-	return (void *)host->private;
+	return host->private;
 }
 
 extern const struct dev_pm_ops sdhci_pltfm_pmops;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 766df17..9886115 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -655,7 +655,7 @@ extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 static inline void *sdhci_priv(struct sdhci_host *host)
 {
-	return (void *)host->private;
+	return host->private;
 }
 
 extern void sdhci_card_detect(struct sdhci_host *host);
-- 
1.9.1
