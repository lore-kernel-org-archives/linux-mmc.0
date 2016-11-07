From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v6 05/14] mmc: sdhci-msm: Update DLL reset sequence
Date: Mon,  7 Nov 2016 16:54:28 +0530
Message-ID: <1478517877-23733-6-git-send-email-riteshh@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Venkat Gopalakrishnan <venkatg@codeaurora.org>

SDCC core with minor version >= 0x42 introduced new 14lpp
DLL. This has additional requirements in the reset sequence
for DLL tuning. Make necessary changes as needed.

Without this patch we see below errors on such SDHC controllers
	sdhci_msm 7464900.sdhci: mmc0: DLL failed to LOCK
	mmc0: tuning execution failed: -110

Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 42f42aa..32b0b79 100644
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
+	bool use_14lpp_dll_reset;
 };
 
 /* Platform specific tuning */
@@ -304,6 +311,8 @@ static inline void msm_cm_dll_set_freq(struct sdhci_host *host)
 static int msm_init_cm_dll(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	int wait_cnt = 50;
 	unsigned long flags;
 	u32 config = 0;
@@ -319,6 +328,16 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	config &= ~CORE_CLK_PWRSAVE;
 	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
 
+	if (msm_host->use_14lpp_dll_reset) {
+		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+		config &= ~CORE_CK_OUT_EN;
+		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+
+		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+		config |= CORE_DLL_CLOCK_DISABLE;
+		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
+	}
+
 	/* Write 1 to DLL_RST bit of DLL_CONFIG register */
 	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
 	config |= CORE_DLL_RST;
@@ -330,6 +349,24 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 	msm_cm_dll_set_freq(host);
 
+	if (msm_host->use_14lpp_dll_reset) {
+		u32 mclk_freq = 0;
+
+		if ((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
+					& CORE_FLL_CYCLE_CNT))
+			mclk_freq = (u32)((host->clock / TCXO_FREQ) * 8);
+		else
+			mclk_freq = (u32)((host->clock / TCXO_FREQ) * 4);
+
+		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+		config &= ~(0xFF << 10);
+		config |= mclk_freq << 10;
+
+		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
+		/* wait for 5us before enabling DLL clock */
+		udelay(5);
+	}
+
 	/* Write 0 to DLL_RST bit of DLL_CONFIG register */
 	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
 	config &= ~CORE_DLL_RST;
@@ -340,6 +377,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	config &= ~CORE_DLL_PDN;
 	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
+	if (msm_host->use_14lpp_dll_reset) {
+		msm_cm_dll_set_freq(host);
+		/* Enable the DLL clock */
+		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+		config &= ~CORE_DLL_CLOCK_DISABLE;
+		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
+	}
+
 	/* Set DLL_EN bit to 1. */
 	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
 	config |= CORE_DLL_EN;
@@ -641,6 +686,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
 		core_version, core_major, core_minor);
 
+	if ((core_major == 1) && (core_minor >= 0x42))
+		msm_host->use_14lpp_dll_reset = true;
+
 	/*
 	 * Support for some capabilities is not advertised by newer
 	 * controller versions and must be explicitly enabled.
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
