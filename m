From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 02/54] mmc: sdhci: Split sdhci_add_host()
Date: Wed, 29 Jun 2016 16:24:15 +0300
Message-ID: <1467206707-30185-3-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13035 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbcF2N32 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:29:28 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Split sdhci-add_host() in order to further our objective to make
sdhci into a library.

The split divides code that sets up mmc and sdhci parameters, from
code that actually activates things - such as tasklet initialization,
requesting the irq, and adding (and starting) the host.

This gives drivers an opportunity to change various settings before
committing to start the host.

Drivers can continue to call sdhci_add_host() but drivers that want
to take advantage of the split instead call sdhci_setup_host() followed
by __sdhci_add_host().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 39 ++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7009c862ca9b..22061faf7fa4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2833,7 +2833,7 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 	return ret;
 }
 
-int sdhci_add_host(struct sdhci_host *host)
+int sdhci_setup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
 	u32 caps[2] = {0, 0};
@@ -3314,6 +3314,28 @@ int sdhci_add_host(struct sdhci_host *host)
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 
+	return 0;
+
+unreg:
+	if (!IS_ERR(mmc->supply.vqmmc))
+		regulator_disable(mmc->supply.vqmmc);
+undma:
+	if (host->align_buffer)
+		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
+				  host->adma_table_sz, host->align_buffer,
+				  host->align_addr);
+	host->adma_table = NULL;
+	host->align_buffer = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sdhci_setup_host);
+
+int __sdhci_add_host(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
 	/*
 	 * Init tasklets.
 	 */
@@ -3370,10 +3392,10 @@ unirq:
 	free_irq(host->irq, host);
 untasklet:
 	tasklet_kill(&host->finish_tasklet);
-unreg:
+
 	if (!IS_ERR(mmc->supply.vqmmc))
 		regulator_disable(mmc->supply.vqmmc);
-undma:
+
 	if (host->align_buffer)
 		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
 				  host->adma_table_sz, host->align_buffer,
@@ -3383,7 +3405,18 @@ undma:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(__sdhci_add_host);
+
+int sdhci_add_host(struct sdhci_host *host)
+{
+	int ret;
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
 
+	return __sdhci_add_host(host);
+}
 EXPORT_SYMBOL_GPL(sdhci_add_host);
 
 void sdhci_remove_host(struct sdhci_host *host, int dead)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 609f87ca536b..b16aec2faa2e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -645,6 +645,8 @@ static inline void *sdhci_priv(struct sdhci_host *host)
 }
 
 extern void sdhci_card_detect(struct sdhci_host *host);
+extern int sdhci_setup_host(struct sdhci_host *host);
+extern int __sdhci_add_host(struct sdhci_host *host);
 extern int sdhci_add_host(struct sdhci_host *host);
 extern void sdhci_remove_host(struct sdhci_host *host, int dead);
 extern void sdhci_send_command(struct sdhci_host *host,
-- 
1.9.1

