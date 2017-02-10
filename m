From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 30/39] mmc: sdhci: Add sdhci_cleanup_host
Date: Fri, 10 Feb 2017 14:55:43 +0200
Message-ID: <1486731352-8018-31-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6215 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbdBJP57 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 10:57:59 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Add sdhci_cleanup_host() to cleanup __sdhci_add_host().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 37 ++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5aa96ada1314..cd8a7eb5431d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3596,6 +3596,22 @@ int sdhci_setup_host(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_setup_host);
 
+void sdhci_cleanup_host(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	if (!IS_ERR(mmc->supply.vqmmc))
+		regulator_disable(mmc->supply.vqmmc);
+
+	if (host->align_buffer)
+		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
+				  host->adma_table_sz, host->align_buffer,
+				  host->align_addr);
+	host->adma_table = NULL;
+	host->align_buffer = NULL;
+}
+EXPORT_SYMBOL_GPL(sdhci_cleanup_host);
+
 int __sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -3660,16 +3676,6 @@ int __sdhci_add_host(struct sdhci_host *host)
 untasklet:
 	tasklet_kill(&host->finish_tasklet);
 
-	if (!IS_ERR(mmc->supply.vqmmc))
-		regulator_disable(mmc->supply.vqmmc);
-
-	if (host->align_buffer)
-		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
-				  host->adma_table_sz, host->align_buffer,
-				  host->align_addr);
-	host->adma_table = NULL;
-	host->align_buffer = NULL;
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__sdhci_add_host);
@@ -3682,7 +3688,16 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (ret)
 		return ret;
 
-	return __sdhci_add_host(host);
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	return 0;
+
+cleanup:
+	sdhci_cleanup_host(host);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(sdhci_add_host);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 8735c9325e9e..afa2cc394ae9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -664,6 +664,7 @@ static inline void *sdhci_priv(struct sdhci_host *host)
 void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps,
 		       u32 *caps1);
 int sdhci_setup_host(struct sdhci_host *host);
+void sdhci_cleanup_host(struct sdhci_host *host);
 int __sdhci_add_host(struct sdhci_host *host);
 int sdhci_add_host(struct sdhci_host *host);
 void sdhci_remove_host(struct sdhci_host *host, int dead);
-- 
1.9.1

