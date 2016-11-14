From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v7 14/14] sdhci: sdhci-msm: update dll configuration
Date: Mon, 14 Nov 2016 11:30:48 +0530
Message-ID: <1479103248-9491-15-git-send-email-riteshh@codeaurora.org>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43652 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965042AbcKNGDC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2016 01:03:02 -0500
In-Reply-To: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>, Krishna Konda <kkonda@codeaurora.org>

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

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Krishna Konda <kkonda@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 132 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9f8f070..4711ee6 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -51,6 +51,7 @@
 #define INT_MASK		0xf
 #define MAX_PHASES		16
 #define CORE_DLL_LOCK		BIT(7)
+#define CORE_DDR_DLL_LOCK	BIT(11)
 #define CORE_DLL_EN		BIT(16)
 #define CORE_CDR_EN		BIT(17)
 #define CORE_CK_OUT_EN		BIT(18)
@@ -62,6 +63,7 @@
 #define CORE_DLL_STATUS		0x108
 
 #define CORE_DLL_CONFIG_2	0x1b4
+#define CORE_DDR_CAL_EN		BIT(0)
 #define CORE_FLL_CYCLE_CNT	BIT(18)
 #define CORE_DLL_CLOCK_DISABLE	BIT(21)
 
@@ -100,6 +102,11 @@
 #define CORE_DDR_200_CFG		0x184
 #define CORE_CDC_T4_DLY_SEL		BIT(0)
 #define CORE_START_CDC_TRAFFIC		BIT(6)
+#define CORE_VENDOR_SPEC3	0x1b0
+#define CORE_PWRSAVE_DLL	BIT(3)
+
+#define CORE_DDR_CONFIG		0x1b8
+#define DDR_CONFIG_POR_VAL	0x80040853
 
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
@@ -126,6 +133,7 @@ struct sdhci_msm_host {
 	bool tuning_done;
 	bool calibration_done;
 	u8 saved_tuning_phase;
+	bool use_cdclp533;
 };
 
 /* Platform specific tuning */
@@ -587,6 +595,93 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
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
+	/* Write 1 to DDR_CAL_EN field in CORE_DLL_CONFIG_2 */
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+	config |= CORE_DDR_CAL_EN;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
+
+	/* Poll on DDR_DLL_LOCK bit in CORE_DLL_STATUS to be set */
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
+	/* set CORE_PWRSAVE_DLL bit in CORE_VENDOR_SPEC3 */
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
+	/* Write 1 to CMD_DAT_TRACK_SEL field in DLL_CONFIG */
+	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config |= CORE_CMD_DAT_TRACK_SEL;
+	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	if (msm_host->use_cdclp533)
+		/* Calibrate CDCLP533 DLL HW */
+		ret = sdhci_msm_cdclp533_calibration(host);
+	else
+		/* Calibrate CM_DLL_SDC4 HW */
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
@@ -735,7 +830,7 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 	if (host->clock > CORE_FREQ_100MHZ &&
 	    msm_host->tuning_done && !msm_host->calibration_done &&
 	    (mmc->ios.timing == MMC_TIMING_MMC_HS400))
-		if (!sdhci_msm_cdclp533_calibration(host))
+		if (!sdhci_msm_hs400_dll_calibration(host))
 			msm_host->calibration_done = true;
 	spin_lock_irq(&host->lock);
 }
@@ -846,7 +941,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	struct mmc_ios curr_ios = host->mmc->ios;
-	u32 config;
+	u32 config, dll_lock;
 	int rc;
 
 	if (!clock) {
@@ -903,7 +998,33 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
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
+			/* set CORE_PWRSAVE_DLL bit in CORE_VENDOR_SPEC3 */
+			config = readl_relaxed(host->ioaddr +
+					CORE_VENDOR_SPEC3);
+			config &= ~CORE_PWRSAVE_DLL;
+			writel_relaxed(config, host->ioaddr +
+					CORE_VENDOR_SPEC3);
+		}
+
 		/* Select the default clock (free running MCLK) */
 		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
 		config &= ~CORE_HC_MCLK_SEL_MASK;
@@ -1100,6 +1221,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		msm_host->use_14lpp_dll_reset = true;
 
 	/*
+	 * SDCC 5 controller with major version 1, minor version 0x34 and later
+	 * with HS 400 mode support will use CM DLL instead of CDC LP 533 DLL.
+	 */
+	if ((core_major == 1) && (core_minor < 0x34))
+		msm_host->use_cdclp533 = true;
+
+	/*
 	 * Support for some capabilities is not advertised by newer
 	 * controller versions and must be explicitly enabled.
 	 */
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

