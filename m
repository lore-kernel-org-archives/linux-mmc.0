From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/25] mmc: sdhci: Add sdhci_cleanup_host
Date: Mon, 20 Mar 2017 19:50:45 +0200
Message-ID: <1490032253-6030-18-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26806 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756269AbdCTR60 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:26 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Add sdhci_cleanup_host() to cleanup __sdhci_add_host().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 37 ++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fc5cd8c21527..b2ef0d93cebd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3562,6 +3562,22 @@ int sdhci_setup_host(struct sdhci_host *host)
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
@@ -3626,16 +3642,6 @@ int __sdhci_add_host(struct sdhci_host *host)
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
@@ -3648,7 +3654,16 @@ int sdhci_add_host(struct sdhci_host *host)
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
index 6fe6005b284e..477b3f5bedfd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -660,6 +660,7 @@ static inline void *sdhci_priv(struct sdhci_host *host)
 void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps,
 		       u32 *caps1);
 int sdhci_setup_host(struct sdhci_host *host);
+void sdhci_cleanup_host(struct sdhci_host *host);
 int __sdhci_add_host(struct sdhci_host *host);
 int sdhci_add_host(struct sdhci_host *host);
 void sdhci_remove_host(struct sdhci_host *host, int dead);
-- 
1.9.1

