From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v4, 3/5] mmc: sdhci-of-esdhc: add tuning support
Date: Tue, 11 Apr 2017 13:10:29 +0800
Message-ID: <1491887431-31894-4-git-send-email-yangbo.lu@nxp.com>
References: <1491887431-31894-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:11249
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752179AbdDKFZU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Apr 2017 01:25:20 -0400
In-Reply-To: <1491887431-31894-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

eSDHC uses tuning block for tuning procedure. So the tuning
block control register must be configured properly before tuning.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Replaced old function for mmc_host_ops.execute_tuning with
	  esdhc_execute_tuning to support eSDHC tuning.
Changes for v3:
	- Put .execute_tuning assigning after after IS_ERR(host) check.
Changes for v4:
	- None
---
 drivers/mmc/host/sdhci-esdhc.h    |  5 +++++
 drivers/mmc/host/sdhci-of-esdhc.c | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 6869567..c4bbd74 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -53,9 +53,14 @@
 #define ESDHC_CLOCK_HCKEN		0x00000002
 #define ESDHC_CLOCK_IPGEN		0x00000001
 
+/* Tuning Block Control Register */
+#define ESDHC_TBCTL			0x120
+#define ESDHC_TB_EN			0x00000004
+
 /* Control Register for DMA transfer */
 #define ESDHC_DMA_SYSCTL		0x40c
 #define ESDHC_PERIPHERAL_CLK_SEL	0x00080000
+#define ESDHC_FLUSH_ASYNC_FIFO		0x00040000
 #define ESDHC_DMA_SNOOP			0x00000040
 
 #endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4dd28c3..80dc802 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -630,6 +630,25 @@ static int esdhc_signal_voltage_switch(struct mmc_host *mmc,
 	}
 }
 
+static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 val;
+
+	/* Use tuning block for tuning procedure */
+	esdhc_clock_enable(host, false);
+	val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
+	val |= ESDHC_FLUSH_ASYNC_FIFO;
+	sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
+
+	val = sdhci_readl(host, ESDHC_TBCTL);
+	val |= ESDHC_TB_EN;
+	sdhci_writel(host, val, ESDHC_TBCTL);
+	esdhc_clock_enable(host, true);
+
+	return sdhci_execute_tuning(mmc, opcode);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static u32 esdhc_proctl;
 static int esdhc_of_suspend(struct device *dev)
@@ -789,6 +808,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 
 	host->mmc_host_ops.start_signal_voltage_switch =
 		esdhc_signal_voltage_switch;
+	host->mmc_host_ops.execute_tuning = esdhc_execute_tuning;
 
 	esdhc_init(pdev, host);
 
-- 
2.1.0.27.g96db324

