From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 03/54] mmc: sdhci: Make signal voltage support explicit
Date: Wed, 29 Jun 2016 16:24:16 +0300
Message-ID: <1467206707-30185-4-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35817 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbcF2N3c (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:29:32 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Signal voltage support is not a quirk, it is a capability. According to the
SDHCI specification, support for 1.8V signaling is determined by the
presence of one of the capability bits SDHCI_SUPPORT_SDR50,
SDHCI_SUPPORT_SDR104, or SDHCI_SUPPORT_DDR50. This is complicated by also
supporting eMMC which has 1.8V modes and 1.2V modes. It would be possible
to use the transfer mode to determine signal voltage support, except for
eMMC DDR52 mode which uses the same capability (MMC_CAP_1_8V_DDR) for 1.8V
signaling and 3V signaling.

In addition, the mmc core will fail over from one signaling voltage to the
next (refer mmc_power_up()) which means SDHCI really needs to validate
which voltages are actually supported.

Introduce SDHCI flags for signal voltage support and set them based on the
supported transfer modes. In general, drivers should prefer to set the
supported transfer modes correctly rather than change the signal voltage
capability, except in the case where 3V DDR52 is supported but 1.8V is
not.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 17 +++++++++++++++++
 drivers/mmc/host/sdhci.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 22061faf7fa4..8ac5a9df2c01 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1733,6 +1733,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 
 	switch (ios->signal_voltage) {
 	case MMC_SIGNAL_VOLTAGE_330:
+		if (!(host->flags & SDHCI_SIGNALING_330))
+			return -EINVAL;
 		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
 		ctrl &= ~SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
@@ -1759,6 +1761,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 
 		return -EAGAIN;
 	case MMC_SIGNAL_VOLTAGE_180:
+		if (!(host->flags & SDHCI_SIGNALING_180))
+			return -EINVAL;
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = regulator_set_voltage(mmc->supply.vqmmc,
 					1700000, 1950000);
@@ -1790,6 +1794,8 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 
 		return -EAGAIN;
 	case MMC_SIGNAL_VOLTAGE_120:
+		if (!(host->flags & SDHCI_SIGNALING_120))
+			return -EINVAL;
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
 						    1300000);
@@ -2798,6 +2804,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	host->mmc_host_ops = sdhci_ops;
 	mmc->ops = &host->mmc_host_ops;
 
+	host->flags = SDHCI_SIGNALING_330;
+
 	return host;
 }
 
@@ -3257,6 +3265,15 @@ int sdhci_setup_host(struct sdhci_host *host)
 		goto unreg;
 	}
 
+	if ((mmc->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
+			  MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
+			  MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR)) ||
+	    (mmc->caps2 & (MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)))
+		host->flags |= SDHCI_SIGNALING_180;
+
+	if (mmc->caps2 & MMC_CAP2_HSX00_1_2V)
+		host->flags |= SDHCI_SIGNALING_120;
+
 	spin_lock_init(&host->lock);
 
 	/*
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b16aec2faa2e..419911f107d3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -447,6 +447,9 @@ struct sdhci_host {
 #define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
 #define SDHCI_USE_64_BIT_DMA	(1<<12)	/* Use 64-bit DMA */
 #define SDHCI_HS400_TUNING	(1<<13)	/* Tuning for HS400 */
+#define SDHCI_SIGNALING_330	(1<<14)	/* Host is capable of 3.3V signaling */
+#define SDHCI_SIGNALING_180	(1<<15)	/* Host is capable of 1.8V signaling */
+#define SDHCI_SIGNALING_120	(1<<16)	/* Host is capable of 1.2V signaling */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.9.1

