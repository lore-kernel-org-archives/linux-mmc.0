From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 01/10] mmc: sdhci-msm: Update DLL reset sequence
Date: Wed, 10 Aug 2016 20:31:50 +0530
Message-ID: <1470841319-6091-2-git-send-email-riteshh@codeaurora.org>
References: <1470841319-6091-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53455 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935359AbcHJSlG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2016 14:41:06 -0400
In-Reply-To: <1470841319-6091-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

From: Venkat Gopalakrishnan <venkatg@codeaurora.org>

SDCC core with minor version >= 0x42 requires a change in the reset
sequence for DLL tuning. Make necessary changes as needed.

Without this patch we see below errors on such SDHC controllers
	sdhci_msm 7464900.sdhci: mmc0: DLL failed to LOCK
	mmc0: tuning execution failed: -110

Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8ef44a2a..9e08424 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -58,11 +58,17 @@
 #define CORE_DLL_CONFIG		0x100
 #define CORE_DLL_STATUS		0x108
 
+#define CORE_DLL_CONFIG_2	0x1b4
+#define CORE_FLL_CYCLE_CNT	BIT(18)
+#define CORE_DLL_CLOCK_DISABLE	BIT(21)
+
 #define CORE_VENDOR_SPEC	0x10c
 #define CORE_CLK_PWRSAVE	BIT(1)
 
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
+#define TCXO_FREQ		19200000
+
 #define CDR_SELEXT_SHIFT	20
 #define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
 #define CMUX_SHIFT_PHASE_SHIFT	24
@@ -76,6 +82,7 @@ struct sdhci_msm_host {
 	struct clk *pclk;	/* SDHC peripheral bus clock */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct mmc_host *mmc;
+	bool use_updated_dll_reset;
 };
 
 /* Platform specific tuning */
@@ -303,6 +310,8 @@ static inline void msm_cm_dll_set_freq(struct sdhci_host *host)
 static int msm_init_cm_dll(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	int wait_cnt = 50;
 	unsigned long flags;
 
@@ -316,6 +325,15 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC)
 			& ~CORE_CLK_PWRSAVE), host->ioaddr + CORE_VENDOR_SPEC);
 
+	if (msm_host->use_updated_dll_reset) {
+		writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
+				& ~CORE_CK_OUT_EN),
+				host->ioaddr + CORE_DLL_CONFIG);
+		writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
+				| CORE_DLL_CLOCK_DISABLE),
+				host->ioaddr + CORE_DLL_CONFIG_2);
+	}
+
 	/* Write 1 to DLL_RST bit of DLL_CONFIG register */
 	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
 			| CORE_DLL_RST), host->ioaddr + CORE_DLL_CONFIG);
@@ -325,6 +343,22 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 			| CORE_DLL_PDN), host->ioaddr + CORE_DLL_CONFIG);
 	msm_cm_dll_set_freq(host);
 
+	if (msm_host->use_updated_dll_reset) {
+		u32 mclk_freq = 0;
+
+		if ((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
+					& CORE_FLL_CYCLE_CNT))
+			mclk_freq = (u32) ((host->clock / TCXO_FREQ) * 8);
+		else
+			mclk_freq = (u32) ((host->clock / TCXO_FREQ) * 4);
+
+		writel_relaxed(((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
+				& ~(0xFF << 10)) | (mclk_freq << 10)),
+				host->ioaddr + CORE_DLL_CONFIG_2);
+		/* wait for 5us before enabling DLL clock */
+		udelay(5);
+	}
+
 	/* Write 0 to DLL_RST bit of DLL_CONFIG register */
 	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
 			& ~CORE_DLL_RST), host->ioaddr + CORE_DLL_CONFIG);
@@ -333,6 +367,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
 			& ~CORE_DLL_PDN), host->ioaddr + CORE_DLL_CONFIG);
 
+	if (msm_host->use_updated_dll_reset) {
+		msm_cm_dll_set_freq(host);
+		/* Enable the DLL clock */
+		writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
+				& ~CORE_DLL_CLOCK_DISABLE),
+				host->ioaddr + CORE_DLL_CONFIG_2);
+	}
+
 	/* Set DLL_EN bit to 1. */
 	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
 			| CORE_DLL_EN), host->ioaddr + CORE_DLL_CONFIG);
@@ -631,6 +673,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
 		core_version, core_major, core_minor);
 
+	if ((core_major == 1) && (core_minor >= 0x42))
+		msm_host->use_updated_dll_reset = true;
+
 	/*
 	 * Support for some capabilities is not advertised by newer
 	 * controller versions and must be explicitly enabled.
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

