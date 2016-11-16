From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v8 06/16] mmc: sdhci-msm: Update DLL reset sequence
Date: Wed, 16 Nov 2016 21:30:42 +0530
Message-ID: <1479312052-22396-7-git-send-email-riteshh@codeaurora.org>
References: <1479312052-22396-1-git-send-email-riteshh@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479312052-22396-1-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
 drivers/mmc/host/sdhci-msm.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 2dcbeb0..7e72105 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -59,6 +59,10 @@
 #define CORE_DLL_CONFIG		0x100
 #define CORE_DLL_STATUS		0x108
 
+#define CORE_DLL_CONFIG_2	0x1b4
+#define CORE_FLL_CYCLE_CNT	BIT(18)
+#define CORE_DLL_CLOCK_DISABLE	BIT(21)
+
 #define CORE_VENDOR_SPEC	0x10c
 #define CORE_CLK_PWRSAVE	BIT(1)
 
@@ -77,7 +81,9 @@ struct sdhci_msm_host {
 	struct clk *clk;	/* main SD/MMC bus clock */
 	struct clk *pclk;	/* SDHC peripheral bus clock */
 	struct clk *bus_clk;	/* SDHC bus voter clock */
+	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
 	struct mmc_host *mmc;
+	bool use_14lpp_dll_reset;
 };
 
 /* Platform specific tuning */
@@ -305,6 +311,8 @@ static inline void msm_cm_dll_set_freq(struct sdhci_host *host)
 static int msm_init_cm_dll(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	int wait_cnt = 50;
 	unsigned long flags;
 	u32 config;
@@ -320,6 +328,16 @@ static int msm_init_cm_dll(struct sdhci_host *host)
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
 	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
 	config |= CORE_DLL_RST;
 	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
@@ -329,6 +347,28 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 	msm_cm_dll_set_freq(host);
 
+	if (msm_host->use_14lpp_dll_reset &&
+	    !IS_ERR_OR_NULL(msm_host->xo_clk)) {
+		u32 mclk_freq = 0;
+
+		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+		config &= CORE_FLL_CYCLE_CNT;
+		if (config)
+			mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 8),
+					clk_get_rate(msm_host->xo_clk));
+		else
+			mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 4),
+					clk_get_rate(msm_host->xo_clk));
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
 	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
 	config &= ~CORE_DLL_RST;
 	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
@@ -337,6 +377,13 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	config &= ~CORE_DLL_PDN;
 	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
 
+	if (msm_host->use_14lpp_dll_reset) {
+		msm_cm_dll_set_freq(host);
+		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+		config &= ~CORE_DLL_CLOCK_DISABLE;
+		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
+	}
+
 	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
 	config |= CORE_DLL_EN;
 	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
@@ -590,6 +637,16 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto pclk_disable;
 	}
 
+	/*
+	 * xo_clock is needed for FLL feature of cm_dll.
+	 * In case if xo_clock is not mentioned in DT, warn and proceed.
+	 */
+	msm_host->xo_clk = devm_clk_get(&pdev->dev, "xo_clock");
+	if (IS_ERR(msm_host->xo_clk)) {
+		ret = PTR_ERR(msm_host->xo_clk);
+		dev_warn(&pdev->dev, "TCXO clk not present (%d)\n", ret);
+	}
+
 	/* Vote for maximum clock rate for maximum performance */
 	ret = clk_set_rate(msm_host->clk, INT_MAX);
 	if (ret)
@@ -635,6 +692,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "MCI Version: 0x%08x, major: 0x%04x, minor: 0x%02x\n",
 		core_version, core_major, core_minor);
 
+	if (core_major == 1 && core_minor >= 0x42)
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
