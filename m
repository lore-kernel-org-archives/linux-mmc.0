From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v9 13/16] mmc: sdhci-msm: Add HS400 platform support
Date: Mon, 21 Nov 2016 12:07:23 +0530
Message-ID: <1479710246-26676-14-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Venkat Gopalakrishnan <venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

The following msm platform specific changes are added to support HS400.
- Allow tuning for HS400 mode.
- Configure HS400 timing mode using the VENDOR_SPECIFIC_FUNC register.

Signed-off-by: Venkat Gopalakrishnan <venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/host/sdhci-msm.c | 122 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index c50cee8..b1888c3 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -32,6 +32,7 @@
 #define HC_MODE_EN		0x1
 #define CORE_POWER		0x0
 #define CORE_SW_RST		BIT(7)
+#define FF_CLK_SW_RST_DIS	BIT(13)
 
 #define CORE_PWRCTL_STATUS	0xdc
 #define CORE_PWRCTL_MASK	0xe0
@@ -65,10 +66,17 @@
 
 #define CORE_VENDOR_SPEC	0x10c
 #define CORE_CLK_PWRSAVE	BIT(1)
+#define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
+#define CORE_HC_MCLK_SEL_HS400	(3 << 8)
+#define CORE_HC_MCLK_SEL_MASK	(3 << 8)
+#define CORE_HC_SELECT_IN_EN	BIT(18)
+#define CORE_HC_SELECT_IN_HS400	(6 << 19)
+#define CORE_HC_SELECT_IN_MASK	(7 << 19)
 
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
 #define SDHCI_MSM_MIN_CLOCK	400000
+#define CORE_FREQ_100MHZ	(100 * 1000 * 1000)
 
 #define CDR_SELEXT_SHIFT	20
 #define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
@@ -87,6 +95,8 @@ struct sdhci_msm_host {
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
+	bool tuning_done;
+	bool calibration_done;
 };
 
 /* Platform specific tuning */
@@ -174,8 +184,8 @@ static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
  * Find out the greatest range of consecuitive selected
  * DLL clock output phases that can be used as sampling
  * setting for SD3.0 UHS-I card read operation (in SDR104
- * timing mode) or for eMMC4.5 card read operation (in HS200
- * timing mode).
+ * timing mode) or for eMMC4.5 card read operation (in
+ * HS400/HS200 timing mode).
  * Select the 3/4 of the range and configure the DLL with the
  * selected DLL clock output phase.
  */
@@ -424,9 +434,10 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 	 * Tuning is required for SDR104, HS200 and HS400 cards and
 	 * if clock frequency is greater than 100MHz in these modes.
 	 */
-	if (host->clock <= 100 * 1000 * 1000 ||
-	    !((ios.timing == MMC_TIMING_MMC_HS200) ||
-	      (ios.timing == MMC_TIMING_UHS_SDR104)))
+	if (host->clock <= CORE_FREQ_100MHZ ||
+	    !(ios.timing == MMC_TIMING_MMC_HS400 ||
+	    ios.timing == MMC_TIMING_MMC_HS200 ||
+	    ios.timing == MMC_TIMING_UHS_SDR104))
 		return 0;
 
 retry:
@@ -477,6 +488,8 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 		rc = -EIO;
 	}
 
+	if (!rc)
+		msm_host->tuning_done = true;
 	return rc;
 }
 
@@ -484,7 +497,10 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 					unsigned int uhs)
 {
 	struct mmc_host *mmc = host->mmc;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	u16 ctrl_2;
+	u32 config;
 
 	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	/* Select Bus Speed Mode for host */
@@ -499,6 +515,7 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 	case MMC_TIMING_UHS_SDR50:
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
 		break;
+	case MMC_TIMING_MMC_HS400:
 	case MMC_TIMING_MMC_HS200:
 	case MMC_TIMING_UHS_SDR104:
 		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
@@ -515,11 +532,29 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 	 * provide feedback clock, the mode selection can be any value less
 	 * than 3'b011 in bits [2:0] of HOST CONTROL2 register.
 	 */
-	if (host->clock <= 100000000 &&
-	    (uhs == MMC_TIMING_MMC_HS400 ||
-	     uhs == MMC_TIMING_MMC_HS200 ||
-	     uhs == MMC_TIMING_UHS_SDR104))
-		ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	if (host->clock <= CORE_FREQ_100MHZ) {
+		if (uhs == MMC_TIMING_MMC_HS400 ||
+		    uhs == MMC_TIMING_MMC_HS200 ||
+		    uhs == MMC_TIMING_UHS_SDR104)
+			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+		/*
+		 * DLL is not required for clock <= 100MHz
+		 * Thus, make sure DLL it is disabled when not required
+		 */
+		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+		config |= CORE_DLL_RST;
+		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+
+		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+		config |= CORE_DLL_PDN;
+		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+
+		/*
+		 * The DLL needs to be restored and CDCLP533 recalibrated
+		 * when the clock frequency is set back to 400MHz.
+		 */
+		msm_host->calibration_done = false;
+	}
 
 	dev_dbg(mmc_dev(mmc), "%s: clock=%u uhs=%u ctrl_2=0x%x\n",
 		mmc_hostname(host->mmc), host->clock, uhs, ctrl_2);
@@ -611,6 +646,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	struct mmc_ios curr_ios = host->mmc->ios;
+	u32 config;
 	int rc;
 
 	if (!clock) {
@@ -629,6 +665,68 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	    curr_ios.timing == MMC_TIMING_MMC_DDR52 ||
 	    curr_ios.timing == MMC_TIMING_MMC_HS400)
 		clock *= 2;
+	/*
+	 * In general all timing modes are controlled via UHS mode select in
+	 * Host Control2 register. eMMC specific HS200/HS400 doesn't have
+	 * their respective modes defined here, hence we use these values.
+	 *
+	 * HS200 - SDR104 (Since they both are equivalent in functionality)
+	 * HS400 - This involves multiple configurations
+	 *		Initially SDR104 - when tuning is required as HS200
+	 *		Then when switching to DDR @ 400MHz (HS400) we use
+	 *		the vendor specific HC_SELECT_IN to control the mode.
+	 *
+	 * In addition to controlling the modes we also need to select the
+	 * correct input clock for DLL depending on the mode.
+	 *
+	 * HS400 - divided clock (free running MCLK/2)
+	 * All other modes - default (free running MCLK)
+	 */
+	if (curr_ios.timing == MMC_TIMING_MMC_HS400) {
+		/* Select the divided clock (free running MCLK/2) */
+		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+		config &= ~CORE_HC_MCLK_SEL_MASK;
+		config |= CORE_HC_MCLK_SEL_HS400;
+
+		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+		/*
+		 * Select HS400 mode using the HC_SELECT_IN from VENDOR SPEC
+		 * register
+		 */
+		if (msm_host->tuning_done && !msm_host->calibration_done) {
+			/*
+			 * Write 0x6 to HC_SELECT_IN and 1 to HC_SELECT_IN_EN
+			 * field in VENDOR_SPEC_FUNC
+			 */
+			config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+			config |= CORE_HC_SELECT_IN_HS400;
+			config |= CORE_HC_SELECT_IN_EN;
+			writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+		}
+	} else {
+		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+		config &= ~CORE_HC_MCLK_SEL_MASK;
+		config |= CORE_HC_MCLK_SEL_DFLT;
+		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+
+		/*
+		 * Disable HC_SELECT_IN to be able to use the UHS mode select
+		 * configuration from Host Control2 register for all other
+		 * modes.
+		 * Write 0 to HC_SELECT_IN and HC_SELECT_IN_EN field
+		 * in VENDOR_SPEC_FUNC
+		 */
+		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+		config &= ~CORE_HC_SELECT_IN_EN;
+		config &= ~CORE_HC_SELECT_IN_MASK;
+		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+	}
+
+	/*
+	 * Make sure above writes impacting free running MCLK are completed
+	 * before changing the clk_rate at GCC.
+	 */
+	wmb();
 
 	rc = clk_set_rate(msm_host->clk, clock);
 	if (rc) {
@@ -776,6 +874,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	/* Set HC_MODE_EN bit in HC_MODE register */
 	writel_relaxed(HC_MODE_EN, (msm_host->core_mem + CORE_HC_MODE));
 
+	config = readl_relaxed(msm_host->core_mem + CORE_HC_MODE);
+	config |= FF_CLK_SW_RST_DIS;
+	writel_relaxed(config, msm_host->core_mem + CORE_HC_MODE);
+
 	host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
 	dev_dbg(&pdev->dev, "Host Version: 0x%x Vendor Version 0x%x\n",
 		host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
