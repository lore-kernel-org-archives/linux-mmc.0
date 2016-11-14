From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v7 13/14] mmc: sdhci-msm: Add calibration tuning for CDCLP533 circuit
Date: Mon, 14 Nov 2016 11:30:47 +0530
Message-ID: <1479103248-9491-14-git-send-email-riteshh@codeaurora.org>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43588 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965042AbcKNGC7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2016 01:02:59 -0500
In-Reply-To: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>

In HS400 mode a new RCLK is introduced on the interface for read data
transfers. The eMMC5.0 device transmits the read data to the host with
respect to rising and falling edges of RCLK. In order to ensure correct
operation of read data transfers in HS400 mode, the incoming RX data
needs to be sampled by delayed version of RCLK.

The CDCLP533 delay circuit shifts the RCLK by T/4. It needs to be
initialized, configured and enabled once during HS400 mode switch and
when operational voltage/clock is changed.

Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 163 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 95b47aa..9f8f070 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/mmc/mmc.h>
 #include <linux/slab.h>
+#include <linux/iopoll.h>
 
 #include "sdhci-pltfm.h"
 
@@ -57,6 +58,7 @@
 #define CORE_DLL_PDN		BIT(29)
 #define CORE_DLL_RST		BIT(30)
 #define CORE_DLL_CONFIG		0x100
+#define CORE_CMD_DAT_TRACK_SEL	BIT(0)
 #define CORE_DLL_STATUS		0x108
 
 #define CORE_DLL_CONFIG_2	0x1b4
@@ -72,6 +74,33 @@
 #define CORE_HC_SELECT_IN_HS400	(6 << 19)
 #define CORE_HC_SELECT_IN_MASK	(7 << 19)
 
+#define CORE_CSR_CDC_CTLR_CFG0		0x130
+#define CORE_SW_TRIG_FULL_CALIB		BIT(16)
+#define CORE_HW_AUTOCAL_ENA		BIT(17)
+
+#define CORE_CSR_CDC_CTLR_CFG1		0x134
+#define CORE_CSR_CDC_CAL_TIMER_CFG0	0x138
+#define CORE_TIMER_ENA			BIT(16)
+
+#define CORE_CSR_CDC_CAL_TIMER_CFG1	0x13C
+#define CORE_CSR_CDC_REFCOUNT_CFG	0x140
+#define CORE_CSR_CDC_COARSE_CAL_CFG	0x144
+#define CORE_CDC_OFFSET_CFG		0x14C
+#define CORE_CSR_CDC_DELAY_CFG		0x150
+#define CORE_CDC_SLAVE_DDA_CFG		0x160
+#define CORE_CSR_CDC_STATUS0		0x164
+#define CORE_CALIBRATION_DONE		BIT(0)
+
+#define CORE_CDC_ERROR_CODE_MASK	0x7000000
+
+#define CORE_CSR_CDC_GEN_CFG		0x178
+#define CORE_CDC_SWITCH_BYPASS_OFF	BIT(0)
+#define CORE_CDC_SWITCH_RC_EN		BIT(1)
+
+#define CORE_DDR_200_CFG		0x184
+#define CORE_CDC_T4_DLY_SEL		BIT(0)
+#define CORE_START_CDC_TRAFFIC		BIT(6)
+
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
 #define INVALID_TUNING_PHASE	-1
@@ -433,6 +462,131 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	return 0;
 }
 
+static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	u32 config, calib_done;
+	int ret;
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
+
+	/* Write 0 to CDC_T4_DLY_SEL field in VENDOR_SPEC_DDR200_CFG */
+	config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
+	config &= ~CORE_CDC_T4_DLY_SEL;
+	writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
+
+	/* Write 0 to CDC_SWITCH_BYPASS_OFF field in CORE_CSR_CDC_GEN_CFG */
+	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_GEN_CFG);
+	config &= ~CORE_CDC_SWITCH_BYPASS_OFF;
+	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_GEN_CFG);
+
+	/* Write 1 to CDC_SWITCH_RC_EN field in CORE_CSR_CDC_GEN_CFG */
+	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_GEN_CFG);
+	config |= CORE_CDC_SWITCH_RC_EN;
+	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_GEN_CFG);
+
+	/* Write 0 to START_CDC_TRAFFIC field in CORE_DDR200_CFG */
+	config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
+	config &= ~CORE_START_CDC_TRAFFIC;
+	writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
+
+	/*
+	 * Perform CDC Register Initialization Sequence
+	 *
+	 * CORE_CSR_CDC_CTLR_CFG0	0x11800EC
+	 * CORE_CSR_CDC_CTLR_CFG1	0x3011111
+	 * CORE_CSR_CDC_CAL_TIMER_CFG0	0x1201000
+	 * CORE_CSR_CDC_CAL_TIMER_CFG1	0x4
+	 * CORE_CSR_CDC_REFCOUNT_CFG	0xCB732020
+	 * CORE_CSR_CDC_COARSE_CAL_CFG	0xB19
+	 * CORE_CSR_CDC_DELAY_CFG	0x3AC
+	 * CORE_CDC_OFFSET_CFG		0x0
+	 * CORE_CDC_SLAVE_DDA_CFG	0x16334
+	 */
+
+	writel_relaxed(0x11800EC, host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
+	writel_relaxed(0x3011111, host->ioaddr + CORE_CSR_CDC_CTLR_CFG1);
+	writel_relaxed(0x1201000, host->ioaddr + CORE_CSR_CDC_CAL_TIMER_CFG0);
+	writel_relaxed(0x4, host->ioaddr + CORE_CSR_CDC_CAL_TIMER_CFG1);
+	writel_relaxed(0xCB732020, host->ioaddr + CORE_CSR_CDC_REFCOUNT_CFG);
+	writel_relaxed(0xB19, host->ioaddr + CORE_CSR_CDC_COARSE_CAL_CFG);
+	writel_relaxed(0x3AC, host->ioaddr + CORE_CSR_CDC_DELAY_CFG);
+	writel_relaxed(0x0, host->ioaddr + CORE_CDC_OFFSET_CFG);
+	writel_relaxed(0x16334, host->ioaddr + CORE_CDC_SLAVE_DDA_CFG);
+
+	/* CDC HW Calibration */
+
+	/* Write 1 to SW_TRIG_FULL_CALIB field in CORE_CSR_CDC_CTLR_CFG0 */
+	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
+	config |= CORE_SW_TRIG_FULL_CALIB;
+	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
+
+	/* Write 0 to SW_TRIG_FULL_CALIB field in CORE_CSR_CDC_CTLR_CFG0 */
+	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
+	config &= ~CORE_SW_TRIG_FULL_CALIB;
+	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
+
+	/* Write 1 to HW_AUTOCAL_ENA field in CORE_CSR_CDC_CTLR_CFG0 */
+	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
+	config |= CORE_HW_AUTOCAL_ENA;
+	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
+
+	/* Write 1 to TIMER_ENA field in CORE_CSR_CDC_CAL_TIMER_CFG0 */
+	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_CAL_TIMER_CFG0);
+	config |= CORE_TIMER_ENA;
+	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_CAL_TIMER_CFG0);
+
+	/* Poll on CALIBRATION_DONE field in CORE_CSR_CDC_STATUS0 to be 1 */
+	ret = readl_relaxed_poll_timeout(host->ioaddr + CORE_CSR_CDC_STATUS0,
+					 calib_done,
+					 (calib_done & CORE_CALIBRATION_DONE),
+					 1, 50);
+
+	if (ret == -ETIMEDOUT) {
+		pr_err("%s: %s: CDC calibration was not completed\n",
+		       mmc_hostname(host->mmc), __func__);
+		goto out;
+	}
+
+	/* Verify CDC_ERROR_CODE field in CORE_CSR_CDC_STATUS0 is 0 */
+	ret = readl_relaxed(host->ioaddr + CORE_CSR_CDC_STATUS0)
+			& CORE_CDC_ERROR_CODE_MASK;
+	if (ret) {
+		pr_err("%s: %s: CDC error code %d\n",
+		       mmc_hostname(host->mmc), __func__, ret);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Write 1 to START_CDC_TRAFFIC field in CORE_DDR200_CFG */
+	config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
+	config |= CORE_START_CDC_TRAFFIC;
+	writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
+out:
+	pr_debug("%s: %s: Exit, ret %d\n", mmc_hostname(host->mmc),
+		 __func__, ret);
+	return ret;
+}
+
 static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int tuning_seq_cnt = 3;
@@ -575,6 +729,15 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 	dev_dbg(mmc_dev(mmc), "%s: clock=%u uhs=%u ctrl_2=0x%x\n",
 		mmc_hostname(host->mmc), host->clock, uhs, ctrl_2);
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+	spin_unlock_irq(&host->lock);
+	/* CDCLP533 HW calibration is only required for HS400 mode*/
+	if (host->clock > CORE_FREQ_100MHZ &&
+	    msm_host->tuning_done && !msm_host->calibration_done &&
+	    (mmc->ios.timing == MMC_TIMING_MMC_HS400))
+		if (!sdhci_msm_cdclp533_calibration(host))
+			msm_host->calibration_done = true;
+	spin_lock_irq(&host->lock);
 }
 
 static void sdhci_msm_voltage_switch(struct sdhci_host *host)
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

