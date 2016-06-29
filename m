From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH RFC 8/8] mmc: sdhci-msm: Update DLL reset sequence
Date: Wed, 29 Jun 2016 16:50:33 +0530
Message-ID: <1467199233-20506-9-git-send-email-riteshh@codeaurora.org>
References: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1467199233-20506-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, adrian.hunter@intel.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Venkat Gopalakrishnan <venkatg@codeaurora.org>

The latest version of the SDCC core requires a change in the reset
sequence for DLL tuning. Make necessary changes as needed.

Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 912ca6e..4a864cb 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -61,6 +61,10 @@
 #define CORE_DLL_CONFIG		0x100
 #define CORE_DLL_STATUS		0x108
 
+#define CORE_DLL_CONFIG_2	0x1b4
+#define CORE_FLL_CYCLE_CNT	BIT(18)
+#define CORE_DLL_CLOCK_DISABLE	BIT(21)
+
 #define CORE_VENDOR_SPEC	0x10c
 #define CORE_CLK_PWRSAVE	BIT(1)
 #define CORE_VENDOR_SPEC_POR_VAL	0xa1c
@@ -68,6 +72,8 @@
 
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
+#define TCXO_FREQ		19200000
+
 #define CDR_SELEXT_SHIFT	20
 #define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
 #define CMUX_SHIFT_PHASE_SHIFT	24
@@ -131,6 +137,7 @@ struct sdhci_msm_host {
 	u32 curr_io_level;
 	struct completion pwr_irq_completion;
 	spinlock_t pwr_irq_lock;
+	bool use_updated_dll_reset;
 };
 
 #define MAX_PROP_SIZE 32
@@ -878,9 +885,14 @@ static inline void msm_cm_dll_set_freq(struct sdhci_host *host)
 static int msm_init_cm_dll(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_msm_host *msm_host;
 	int wait_cnt = 50;
 	unsigned long flags;
 
+	pltfm_host = sdhci_priv(host);
+	msm_host = sdhci_pltfm_priv(pltfm_host);
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	/*
@@ -891,6 +903,17 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC)
 			& ~CORE_CLK_PWRSAVE), host->ioaddr + CORE_VENDOR_SPEC);
 
+	if (msm_host->use_updated_dll_reset) {
+		writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
+				& ~CORE_CK_OUT_EN),
+				host->ioaddr + CORE_DLL_CONFIG);
+
+		writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2)
+				| CORE_DLL_CLOCK_DISABLE),
+				host->ioaddr + CORE_DLL_CONFIG_2);
+	}
+
+
 	/* Write 1 to DLL_RST bit of DLL_CONFIG register */
 	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
 			| CORE_DLL_RST), host->ioaddr + CORE_DLL_CONFIG);
@@ -900,6 +923,23 @@ static int msm_init_cm_dll(struct sdhci_host *host)
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
+
 	/* Write 0 to DLL_RST bit of DLL_CONFIG register */
 	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
 			& ~CORE_DLL_RST), host->ioaddr + CORE_DLL_CONFIG);
@@ -908,6 +948,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
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
@@ -1135,6 +1183,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
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
