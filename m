From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 29/39] mmc: sdhci: Get rid of 'extern' in header file
Date: Fri, 10 Feb 2017 14:55:42 +0200
Message-ID: <1486731352-8018-30-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15378 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751370AbdBJN51 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:57:27 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Get rid of unnecessary 'extern' in header file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.h | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 61753492a8e8..8735c9325e9e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -652,24 +652,22 @@ static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
 
 #endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
 
-extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
-	size_t priv_size);
-extern void sdhci_free_host(struct sdhci_host *host);
+struct sdhci_host *sdhci_alloc_host(struct device *dev, size_t priv_size);
+void sdhci_free_host(struct sdhci_host *host);
 
 static inline void *sdhci_priv(struct sdhci_host *host)
 {
 	return host->private;
 }
 
-extern void sdhci_card_detect(struct sdhci_host *host);
-extern void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps,
-			      u32 *caps1);
-extern int sdhci_setup_host(struct sdhci_host *host);
-extern int __sdhci_add_host(struct sdhci_host *host);
-extern int sdhci_add_host(struct sdhci_host *host);
-extern void sdhci_remove_host(struct sdhci_host *host, int dead);
-extern void sdhci_send_command(struct sdhci_host *host,
-				struct mmc_command *cmd);
+void sdhci_card_detect(struct sdhci_host *host);
+void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps,
+		       u32 *caps1);
+int sdhci_setup_host(struct sdhci_host *host);
+int __sdhci_add_host(struct sdhci_host *host);
+int sdhci_add_host(struct sdhci_host *host);
+void sdhci_remove_host(struct sdhci_host *host, int dead);
+void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
 
 static inline void sdhci_read_caps(struct sdhci_host *host)
 {
@@ -695,11 +693,11 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 
 #ifdef CONFIG_PM
-extern int sdhci_suspend_host(struct sdhci_host *host);
-extern int sdhci_resume_host(struct sdhci_host *host);
-extern void sdhci_enable_irq_wakeups(struct sdhci_host *host);
-extern int sdhci_runtime_suspend_host(struct sdhci_host *host);
-extern int sdhci_runtime_resume_host(struct sdhci_host *host);
+int sdhci_suspend_host(struct sdhci_host *host);
+int sdhci_resume_host(struct sdhci_host *host);
+void sdhci_enable_irq_wakeups(struct sdhci_host *host);
+int sdhci_runtime_suspend_host(struct sdhci_host *host);
+int sdhci_runtime_resume_host(struct sdhci_host *host);
 #endif
 
 void sdhci_dumpregs(struct sdhci_host *host);
-- 
1.9.1

