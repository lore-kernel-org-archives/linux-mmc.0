From: Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: [PATCH V3 1/7] mmc: sdhci: add sd host v4 mode
Date: Mon,  9 Jul 2018 11:19:52 +0800
Message-ID: <1531106398-14062-2-git-send-email-zhang.chunyan@linaro.org>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
List-Id: linux-mmc@vger.kernel.org

For SD host controller version 4.00 or later ones, there're two
modes of implementation - Version 3.00 compatible mode or
Version 4 mode.  This patch introduced an interface to enable
v4 mode.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 11 +++++++++++
 drivers/mmc/host/sdhci.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0..525862f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3321,6 +3321,17 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 
+/*
+ * Vendor's Host Controller which supports v4 mode can call
+ * this function to enable v4 mode before calling
+ * __sdhci_add_host().
+ */
+void sdhci_enable_v4_mode(struct sdhci_host *host)
+{
+	host->v4_mode = true;
+}
+EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
+
 static int sdhci_set_dma_mask(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f8..e98249b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -184,6 +184,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -566,6 +567,9 @@ struct sdhci_host {
 	u64			data_timeout;
 
 	unsigned long private[0] ____cacheline_aligned;
+
+	/* Host Version 4 Enable */
+	bool			v4_mode;
 };
 
 struct sdhci_ops {
@@ -747,5 +751,6 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 		   int *data_error);
 
 void sdhci_dumpregs(struct sdhci_host *host);
+void sdhci_enable_v4_mode(struct sdhci_host *host);
 
 #endif /* __SDHCI_HW_H */
-- 
2.7.4
