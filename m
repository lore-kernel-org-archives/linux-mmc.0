From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v5 02/12] mmc: sdhci-msm: Update DLL reset sequence
Date: Wed,  5 Oct 2016 20:10:30 +0530
Message-ID: <1475678440-3525-3-git-send-email-riteshh@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1475678440-3525-1-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Venkat Gopalakrishnan <venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

SDCC core with minor version >= 0x42 introduced new 14lpp
DLL. This has additional requirements in the reset sequence
for DLL tuning. Make necessary changes as needed.

Without this patch we see below errors on such SDHC controllers
	sdhci_msm 7464900.sdhci: mmc0: DLL failed to LOCK
	mmc0: tuning execution failed: -110

Signed-off-by: Venkat Gopalakrishnan <venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/host/sdhci-msm.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 42f42aa..85ddaae 100644
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
+			mclk_freq = (u32) ((host->clock / TCXO_FREQ) * 8);
+		else
+			mclk_freq = (u32) ((host->clock / TCXO_FREQ) * 4);
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
