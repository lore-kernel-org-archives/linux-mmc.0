From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v9 16/16] sdhci: sdhci-msm: update dll configuration
Date: Mon, 21 Nov 2016 12:07:26 +0530
Message-ID: <1479710246-26676-17-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Krishna Konda <kkonda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The newer msm sdhci's cores use a different DLL hardware for HS400.
Update the configuration and calibration of the newer DLL block.

The HS400 DLL block used previously is CDC LP 533 and requires
programming multiple registers and waiting for configuration to
complete and then enable it. It has about 18 register writes and
two register reads.

The newer HS400 DLL block is SDC4 DLL and requires two register
writes for configuration and one register read to confirm that it
is initialized. There is an additional register write to enable
the power save mode for SDC4 DLL block.

Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Krishna Konda <kkonda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/mmc/host/sdhci-msm.c | 125 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5c73f7d..32879b8 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -52,6 +52,7 @@
 #define INT_MASK		0xf
 #define MAX_PHASES		16
 #define CORE_DLL_LOCK		BIT(7)
+#define CORE_DDR_DLL_LOCK	BIT(11)
 #define CORE_DLL_EN		BIT(16)
 #define CORE_CDR_EN		BIT(17)
 #define CORE_CK_OUT_EN		BIT(18)
@@ -63,6 +64,7 @@
 #define CORE_DLL_STATUS		0x108
 
 #define CORE_DLL_CONFIG_2	0x1b4
+#define CORE_DDR_CAL_EN		BIT(0)
 #define CORE_FLL_CYCLE_CNT	BIT(18)
 #define CORE_DLL_CLOCK_DISABLE	BIT(21)
 
@@ -101,6 +103,11 @@
 #define CORE_DDR_200_CFG		0x184
 #define CORE_CDC_T4_DLY_SEL		BIT(0)
 #define CORE_START_CDC_TRAFFIC		BIT(6)
+#define CORE_VENDOR_SPEC3	0x1b0
+#define CORE_PWRSAVE_DLL	BIT(3)
+
+#define CORE_DDR_CONFIG		0x1b8
+#define DDR_CONFIG_POR_VAL	0x80040853
 
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
@@ -128,6 +135,7 @@ struct sdhci_msm_host {
 	bool tuning_done;
 	bool calibration_done;
 	u8 saved_tuning_phase;
+	bool use_cdclp533;
 };
 
 /* Platform specific tuning */
@@ -569,6 +577,87 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
 	return ret;
 }
 
+static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
+{
+	u32 dll_status, config;
+	int ret;
+
+	pr_debug("%s: %s: Enter\n", mmc_hostname(host->mmc), __func__);
+
+	/*
+	 * Currently the CORE_DDR_CONFIG register defaults to desired
+	 * configuration on reset. Currently reprogramming the power on
+	 * reset (POR) value in case it might have been modified by
+	 * bootloaders. In the future, if this changes, then the desired
+	 * values will need to be programmed appropriately.
+	 */
+	writel_relaxed(DDR_CONFIG_POR_VAL, host->ioaddr + CORE_DDR_CONFIG);
+
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+	config |= CORE_DDR_CAL_EN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
+
+	ret = readl_relaxed_poll_timeout(host->ioaddr + CORE_DLL_STATUS,
+					 dll_status,
+					 (dll_status & CORE_DDR_DLL_LOCK),
+					 10, 1000);
+
+	if (ret == -ETIMEDOUT) {
+		pr_err("%s: %s: CM_DLL_SDC4 calibration was not completed\n",
+		       mmc_hostname(host->mmc), __func__);
+		goto out;
+	}
+
+	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC3);
+	config |= CORE_PWRSAVE_DLL;
+	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC3);
+
+	/*
+	 * Drain writebuffer to ensure above DLL calibration
+	 * and PWRSAVE DLL is enabled.
+	 */
+	wmb();
+out:
+	pr_debug("%s: %s: Exit, ret %d\n", mmc_hostname(host->mmc),
+		 __func__, ret);
+	return ret;
+}
+
+static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+	u32 config;
+
+	pr_debug("%s: %s: Enter\n", mmc_hostname(host->mmc), __func__);
+
+	/*
+	 * Retuning in HS400 (DDR mode) will fail, just reset the
+	 * tuning block and restore the saved tuning phase.
+	 */
+	ret = msm_init_cm_dll(host);
+	if (ret)
+		goto out;
+
+	/* Set the selected phase in delay line hw block */
+	ret = msm_config_cm_dll_phase(host, msm_host->saved_tuning_phase);
+	if (ret)
+		goto out;
+
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_CMD_DAT_TRACK_SEL;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	if (msm_host->use_cdclp533)
+		ret = sdhci_msm_cdclp533_calibration(host);
+	else
+		ret = sdhci_msm_cm_dll_sdc4_calibration(host);
+out:
+	pr_debug("%s: %s: Exit, ret %d\n", mmc_hostname(host->mmc),
+		 __func__, ret);
+	return ret;
+}
+
 static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int tuning_seq_cnt = 3;
@@ -715,7 +804,7 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 	if (host->clock > CORE_FREQ_100MHZ &&
 	    msm_host->tuning_done && !msm_host->calibration_done &&
 	    mmc->ios.timing == MMC_TIMING_MMC_HS400)
-		if (!sdhci_msm_cdclp533_calibration(host))
+		if (!sdhci_msm_hs400_dll_calibration(host))
 			msm_host->calibration_done = true;
 	spin_lock_irq(&host->lock);
 }
@@ -805,7 +894,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	struct mmc_ios curr_ios = host->mmc->ios;
-	u32 config;
+	u32 config, dll_lock;
 	int rc;
 
 	if (!clock) {
@@ -862,7 +951,32 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 			config |= CORE_HC_SELECT_IN_EN;
 			writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
 		}
+		if (!msm_host->clk_rate && !msm_host->use_cdclp533) {
+			/*
+			 * Poll on DLL_LOCK or DDR_DLL_LOCK bits in
+			 * CORE_DLL_STATUS to be set.  This should get set
+			 * within 15 us at 200 MHz.
+			 */
+			rc = readl_relaxed_poll_timeout(host->ioaddr +
+							CORE_DLL_STATUS,
+							dll_lock,
+							(dll_lock &
+							(CORE_DLL_LOCK |
+							CORE_DDR_DLL_LOCK)), 10,
+							1000);
+			if (rc == -ETIMEDOUT)
+				pr_err("%s: Unable to get DLL_LOCK/DDR_DLL_LOCK, dll_status: 0x%08x\n",
+				       mmc_hostname(host->mmc), dll_lock);
+		}
 	} else {
+		if (!msm_host->use_cdclp533) {
+			config = readl_relaxed(host->ioaddr +
+					CORE_VENDOR_SPEC3);
+			config &= ~CORE_PWRSAVE_DLL;
+			writel_relaxed(config, host->ioaddr +
+					CORE_VENDOR_SPEC3);
+		}
+
 		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
 		config &= ~CORE_HC_MCLK_SEL_MASK;
 		config |= CORE_HC_MCLK_SEL_DFLT;
@@ -1055,6 +1169,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		msm_host->use_14lpp_dll_reset = true;
 
 	/*
+	 * SDCC 5 controller with major version 1, minor version 0x34 and later
+	 * with HS 400 mode support will use CM DLL instead of CDC LP 533 DLL.
+	 */
+	if (core_major == 1 && core_minor < 0x34)
+		msm_host->use_cdclp533 = true;
+
+	/*
 	 * Support for some capabilities is not advertised by newer
 	 * controller versions and must be explicitly enabled.
 	 */
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
