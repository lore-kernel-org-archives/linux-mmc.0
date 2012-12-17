From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v10 11/12] mmc: sdhci: add notifier for regulator vqmmc
Date: Mon, 17 Dec 2012 19:22:07 +0800
Message-ID: <1355743328-17758-12-git-send-email-kliu5@marvell.com>
References: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:54676 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752275Ab2LQLXE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Dec 2012 06:23:04 -0500
In-Reply-To: <1355743328-17758-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, arindam.nath@amd.com, peppe.cavallaro@st.com, ulf.hansson@linaro.org, andriy.shevchenko@linux.intel.com, prakity@nvidia.com
Cc: zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com, keyuan.liu@gmail.com, Kevin Liu <kliu5@marvell.com>, Philip Rakity <prakity@marvell.com>

Some soc/platform need specific handling for signal voltage
switch. For example, mmp2/mmp3 need to set the AIB IO domain
control register accordingly.
Use regulator notifier to do this.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c  |    4 ++++
 include/linux/mmc/sdhci.h |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7084a1c..4aa2fb8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2923,6 +2923,8 @@ int sdhci_add_host(struct sdhci_host *host)
 			caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
 					SDHCI_SUPPORT_SDR50 |
 					SDHCI_SUPPORT_DDR50);
+		if (host->nb_vqmmc)
+			regulator_register_notifier(host->vqmmc, host->nb_vqmmc);
 	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
@@ -3250,6 +3252,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	}
 
 	if (host->vqmmc) {
+		if (host->nb_vqmmc)
+			regulator_unregister_notifier(host->vqmmc, host->nb_vqmmc);
 		regulator_disable(host->vqmmc);
 		regulator_put(host->vqmmc);
 	}
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index b838ffc..dbb0a7e 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -103,6 +103,7 @@ struct sdhci_host {
 
 	struct regulator *vmmc;		/* Power regulator (vmmc) */
 	struct regulator *vqmmc;	/* Signaling regulator (vccq) */
+	struct notifier_block	*nb_vqmmc;	/* Regulator notifier for vccq */
 
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
-- 
1.7.0.4

