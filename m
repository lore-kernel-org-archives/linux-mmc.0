From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 16/25] mmc: sdhci: Get rid of 'extern' in header file
Date: Mon, 20 Mar 2017 19:50:44 +0200
Message-ID: <1490032253-6030-17-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18862 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756262AbdCTR6Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:25 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Get rid of unnecessary 'extern' in header file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.h | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 51c440eebe5c..6fe6005b284e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -648,24 +648,22 @@ static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
 
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
@@ -691,11 +689,11 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
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

