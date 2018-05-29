From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V2 4/4] mmc: host: Register changes for sdcc V5
Date: Tue, 29 May 2018 15:22:41 +0530
Message-ID: <1527587561-27448-5-git-send-email-vviswana@codeaurora.org>
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Add support to use the new compatible string "qcom,sdhci-msm-v5".

Based on the msm variant, pick the relevant variant data and
use it for register read/write to msm specific registers.

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 347 +++++++++++++++++++++++++++----------------
 1 file changed, 221 insertions(+), 126 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 2a66aa0..4d0fd2d 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -33,16 +33,11 @@
 #define CORE_MCI_GENERICS		0x70
 #define SWITCHABLE_SIGNALING_VOLTAGE	BIT(29)
 
-#define CORE_HC_MODE		0x78
 #define HC_MODE_EN		0x1
 #define CORE_POWER		0x0
 #define CORE_SW_RST		BIT(7)
 #define FF_CLK_SW_RST_DIS	BIT(13)
 
-#define CORE_PWRCTL_STATUS	0xdc
-#define CORE_PWRCTL_MASK	0xe0
-#define CORE_PWRCTL_CLEAR	0xe4
-#define CORE_PWRCTL_CTL		0xe8
 #define CORE_PWRCTL_BUS_OFF	BIT(0)
 #define CORE_PWRCTL_BUS_ON	BIT(1)
 #define CORE_PWRCTL_IO_LOW	BIT(2)
@@ -63,17 +58,13 @@
 #define CORE_CDR_EXT_EN		BIT(19)
 #define CORE_DLL_PDN		BIT(29)
 #define CORE_DLL_RST		BIT(30)
-#define CORE_DLL_CONFIG		0x100
 #define CORE_CMD_DAT_TRACK_SEL	BIT(0)
-#define CORE_DLL_STATUS		0x108
 
-#define CORE_DLL_CONFIG_2	0x1b4
 #define CORE_DDR_CAL_EN		BIT(0)
 #define CORE_FLL_CYCLE_CNT	BIT(18)
 #define CORE_DLL_CLOCK_DISABLE	BIT(21)
 
-#define CORE_VENDOR_SPEC	0x10c
-#define CORE_VENDOR_SPEC_POR_VAL	0xa1c
+#define CORE_VENDOR_SPEC_POR_VAL 0xa1c
 #define CORE_CLK_PWRSAVE	BIT(1)
 #define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
 #define CORE_HC_MCLK_SEL_HS400	(3 << 8)
@@ -111,17 +102,14 @@
 #define CORE_CDC_SWITCH_BYPASS_OFF	BIT(0)
 #define CORE_CDC_SWITCH_RC_EN		BIT(1)
 
-#define CORE_DDR_200_CFG		0x184
 #define CORE_CDC_T4_DLY_SEL		BIT(0)
 #define CORE_CMDIN_RCLK_EN		BIT(1)
 #define CORE_START_CDC_TRAFFIC		BIT(6)
-#define CORE_VENDOR_SPEC3	0x1b0
+
 #define CORE_PWRSAVE_DLL	BIT(3)
 
-#define CORE_DDR_CONFIG		0x1b8
 #define DDR_CONFIG_POR_VAL	0x80040853
 
-#define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
 #define INVALID_TUNING_PHASE	-1
 #define SDHCI_MSM_MIN_CLOCK	400000
@@ -137,6 +125,12 @@
 /* Timeout value to avoid infinite waiting for pwr_irq */
 #define MSM_PWR_IRQ_TIMEOUT_MS 5000
 
+#define MSM_HOST_READL(msm_host, host, offset) \
+	msm_host->var_ops->msm_readl_relaxed(host, offset)
+
+#define MSM_HOST_WRITEL(msm_host, val, host, offset) \
+	msm_host->var_ops->msm_writel_relaxed(val, host, offset)
+
 struct sdhci_msm_offset {
 	u32 core_hc_mode;
 	u32 core_mci_data_cnt;
@@ -268,6 +262,14 @@ struct sdhci_msm_host {
 	const struct sdhci_msm_offset *offset;
 };
 
+const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	return msm_host->offset;
+}
+
 /*
  * APIs to read/write to vendor specific registers which were there in the
  * core_mem region before MCI was removed.
@@ -349,10 +351,12 @@ static inline int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
 	u32 wait_cnt = 50;
 	u8 ck_out_en;
 	struct mmc_host *mmc = host->mmc;
+	const struct sdhci_msm_offset *msm_offset =
+					sdhci_priv_msm_offset(host);
 
 	/* Poll for CK_OUT_EN bit.  max. poll time = 50us */
-	ck_out_en = !!(readl_relaxed(host->ioaddr + CORE_DLL_CONFIG) &
-			CORE_CK_OUT_EN);
+	ck_out_en = !!(readl_relaxed(host->ioaddr +
+			msm_offset->core_dll_config) & CORE_CK_OUT_EN);
 
 	while (ck_out_en != poll) {
 		if (--wait_cnt == 0) {
@@ -362,8 +366,8 @@ static inline int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
 		}
 		udelay(1);
 
-		ck_out_en = !!(readl_relaxed(host->ioaddr + CORE_DLL_CONFIG) &
-				CORE_CK_OUT_EN);
+		ck_out_en = !!(readl_relaxed(host->ioaddr +
+			msm_offset->core_dll_config) & CORE_CK_OUT_EN);
 	}
 
 	return 0;
@@ -379,16 +383,18 @@ static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
 	unsigned long flags;
 	u32 config;
 	struct mmc_host *mmc = host->mmc;
+	const struct sdhci_msm_offset *msm_offset =
+					sdhci_priv_msm_offset(host);
 
 	if (phase > 0xf)
 		return -EINVAL;
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_dll_config);
 	config &= ~(CORE_CDR_EN | CORE_CK_OUT_EN);
 	config |= (CORE_CDR_EXT_EN | CORE_DLL_EN);
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config);
 
 	/* Wait until CK_OUT_EN bit of DLL_CONFIG register becomes '0' */
 	rc = msm_dll_poll_ck_out_en(host, 0);
@@ -399,24 +405,24 @@ static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
 	 * Write the selected DLL clock output phase (0 ... 15)
 	 * to CDR_SELEXT bit field of DLL_CONFIG register.
 	 */
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_dll_config);
 	config &= ~CDR_SELEXT_MASK;
 	config |= grey_coded_phase_table[phase] << CDR_SELEXT_SHIFT;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config);
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_dll_config);
 	config |= CORE_CK_OUT_EN;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config);
 
 	/* Wait until CK_OUT_EN bit of DLL_CONFIG register becomes '1' */
 	rc = msm_dll_poll_ck_out_en(host, 1);
 	if (rc)
 		goto err_out;
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_dll_config);
 	config |= CORE_CDR_EN;
 	config &= ~CORE_CDR_EXT_EN;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config);
 	goto out;
 
 err_out:
@@ -542,6 +548,8 @@ static int msm_find_most_appropriate_phase(struct sdhci_host *host,
 static inline void msm_cm_dll_set_freq(struct sdhci_host *host)
 {
 	u32 mclk_freq = 0, config;
+	const struct sdhci_msm_offset *msm_offset =
+					sdhci_priv_msm_offset(host);
 
 	/* Program the MCLK value to MCLK_FREQ bit field */
 	if (host->clock <= 112000000)
@@ -561,10 +569,10 @@ static inline void msm_cm_dll_set_freq(struct sdhci_host *host)
 	else if (host->clock <= 200000000)
 		mclk_freq = 7;
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_dll_config);
 	config &= ~CMUX_SHIFT_PHASE_MASK;
 	config |= mclk_freq << CMUX_SHIFT_PHASE_SHIFT;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config);
 }
 
 /* Initialize the DLL (Programmable Delay Line) */
@@ -576,6 +584,8 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	int wait_cnt = 50;
 	unsigned long flags;
 	u32 config;
+	const struct sdhci_msm_offset *msm_offset =
+					msm_host->offset;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -584,34 +594,43 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	 * tuning is in progress. Keeping PWRSAVE ON may
 	 * turn off the clock.
 	 */
-	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_vendor_spec);
 	config &= ~CORE_CLK_PWRSAVE;
-	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_vendor_spec);
 
 	if (msm_host->use_14lpp_dll_reset) {
-		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_dll_config);
 		config &= ~CORE_CK_OUT_EN;
-		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+		writel_relaxed(config, host->ioaddr +
+				msm_offset->core_dll_config);
 
-		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_dll_config_2);
 		config |= CORE_DLL_CLOCK_DISABLE;
-		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
+		writel_relaxed(config, host->ioaddr +
+				msm_offset->core_dll_config_2);
 	}
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr +
+			msm_offset->core_dll_config);
 	config |= CORE_DLL_RST;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr +
+			msm_offset->core_dll_config);
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr +
+			msm_offset->core_dll_config);
 	config |= CORE_DLL_PDN;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr +
+			msm_offset->core_dll_config);
 	msm_cm_dll_set_freq(host);
 
 	if (msm_host->use_14lpp_dll_reset &&
 	    !IS_ERR_OR_NULL(msm_host->xo_clk)) {
 		u32 mclk_freq = 0;
 
-		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_dll_config_2);
 		config &= CORE_FLL_CYCLE_CNT;
 		if (config)
 			mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 8),
@@ -620,40 +639,52 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 			mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 4),
 					clk_get_rate(msm_host->xo_clk));
 
-		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_dll_config_2);
 		config &= ~(0xFF << 10);
 		config |= mclk_freq << 10;
 
-		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
+		writel_relaxed(config, host->ioaddr +
+				msm_offset->core_dll_config_2);
 		/* wait for 5us before enabling DLL clock */
 		udelay(5);
 	}
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr +
+			msm_offset->core_dll_config);
 	config &= ~CORE_DLL_RST;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr +
+			msm_offset->core_dll_config);
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr +
+			msm_offset->core_dll_config);
 	config &= ~CORE_DLL_PDN;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr +
+			msm_offset->core_dll_config);
 
 	if (msm_host->use_14lpp_dll_reset) {
 		msm_cm_dll_set_freq(host);
-		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_dll_config_2);
 		config &= ~CORE_DLL_CLOCK_DISABLE;
-		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
+		writel_relaxed(config, host->ioaddr +
+				msm_offset->core_dll_config_2);
 	}
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr +
+			msm_offset->core_dll_config);
 	config |= CORE_DLL_EN;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr +
+			msm_offset->core_dll_config);
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr +
+			msm_offset->core_dll_config);
 	config |= CORE_CK_OUT_EN;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr +
+			msm_offset->core_dll_config);
 
 	/* Wait until DLL_LOCK bit of DLL_STATUS register becomes '1' */
-	while (!(readl_relaxed(host->ioaddr + CORE_DLL_STATUS) &
+	while (!(readl_relaxed(host->ioaddr + msm_offset->core_dll_status) &
 		 CORE_DLL_LOCK)) {
 		/* max. wait for 50us sec for LOCK bit to be set */
 		if (--wait_cnt == 0) {
@@ -674,19 +705,21 @@ static void msm_hc_select_default(struct sdhci_host *host)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	u32 config;
+	const struct sdhci_msm_offset *msm_offset =
+					msm_host->offset;
 
 	if (!msm_host->use_cdclp533) {
 		config = readl_relaxed(host->ioaddr +
-				CORE_VENDOR_SPEC3);
+				msm_offset->core_vendor_spec3);
 		config &= ~CORE_PWRSAVE_DLL;
 		writel_relaxed(config, host->ioaddr +
-				CORE_VENDOR_SPEC3);
+				msm_offset->core_vendor_spec3);
 	}
 
-	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_vendor_spec);
 	config &= ~CORE_HC_MCLK_SEL_MASK;
 	config |= CORE_HC_MCLK_SEL_DFLT;
-	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_vendor_spec);
 
 	/*
 	 * Disable HC_SELECT_IN to be able to use the UHS mode select
@@ -695,10 +728,10 @@ static void msm_hc_select_default(struct sdhci_host *host)
 	 * Write 0 to HC_SELECT_IN and HC_SELECT_IN_EN field
 	 * in VENDOR_SPEC_FUNC
 	 */
-	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_vendor_spec);
 	config &= ~CORE_HC_SELECT_IN_EN;
 	config &= ~CORE_HC_SELECT_IN_MASK;
-	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_vendor_spec);
 
 	/*
 	 * Make sure above writes impacting free running MCLK are completed
@@ -714,32 +747,36 @@ static void msm_hc_select_hs400(struct sdhci_host *host)
 	struct mmc_ios ios = host->mmc->ios;
 	u32 config, dll_lock;
 	int rc;
+	const struct sdhci_msm_offset *msm_offset =
+					msm_host->offset;
 
 	/* Select the divided clock (free running MCLK/2) */
-	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_vendor_spec);
 	config &= ~CORE_HC_MCLK_SEL_MASK;
 	config |= CORE_HC_MCLK_SEL_HS400;
 
-	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_vendor_spec);
 	/*
 	 * Select HS400 mode using the HC_SELECT_IN from VENDOR SPEC
 	 * register
 	 */
 	if ((msm_host->tuning_done || ios.enhanced_strobe) &&
 	    !msm_host->calibration_done) {
-		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_vendor_spec);
 		config |= CORE_HC_SELECT_IN_HS400;
 		config |= CORE_HC_SELECT_IN_EN;
-		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+		writel_relaxed(config, host->ioaddr +
+				msm_offset->core_vendor_spec);
 	}
 	if (!msm_host->clk_rate && !msm_host->use_cdclp533) {
 		/*
 		 * Poll on DLL_LOCK or DDR_DLL_LOCK bits in
-		 * CORE_DLL_STATUS to be set.  This should get set
+		 * core_dll_status to be set. This should get set
 		 * within 15 us at 200 MHz.
 		 */
 		rc = readl_relaxed_poll_timeout(host->ioaddr +
-						CORE_DLL_STATUS,
+						msm_offset->core_dll_status,
 						dll_lock,
 						(dll_lock &
 						(CORE_DLL_LOCK |
@@ -791,6 +828,8 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	u32 config, calib_done;
 	int ret;
+	const struct sdhci_msm_offset *msm_offset =
+					msm_host->offset;
 
 	pr_debug("%s: %s: Enter\n", mmc_hostname(host->mmc), __func__);
 
@@ -807,13 +846,13 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
 	if (ret)
 		goto out;
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_dll_config);
 	config |= CORE_CMD_DAT_TRACK_SEL;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config);
 
-	config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_ddr_200_cfg);
 	config &= ~CORE_CDC_T4_DLY_SEL;
-	writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_ddr_200_cfg);
 
 	config = readl_relaxed(host->ioaddr + CORE_CSR_CDC_GEN_CFG);
 	config &= ~CORE_CDC_SWITCH_BYPASS_OFF;
@@ -823,9 +862,9 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
 	config |= CORE_CDC_SWITCH_RC_EN;
 	writel_relaxed(config, host->ioaddr + CORE_CSR_CDC_GEN_CFG);
 
-	config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_ddr_200_cfg);
 	config &= ~CORE_START_CDC_TRAFFIC;
-	writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_ddr_200_cfg);
 
 	/* Perform CDC Register Initialization Sequence */
 
@@ -877,9 +916,9 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
 		goto out;
 	}
 
-	config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_ddr_200_cfg);
 	config |= CORE_START_CDC_TRAFFIC;
-	writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_ddr_200_cfg);
 out:
 	pr_debug("%s: %s: Exit, ret %d\n", mmc_hostname(host->mmc),
 		 __func__, ret);
@@ -891,32 +930,38 @@ static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
 	struct mmc_host *mmc = host->mmc;
 	u32 dll_status, config;
 	int ret;
+	const struct sdhci_msm_offset *msm_offset =
+					sdhci_priv_msm_offset(host);
 
 	pr_debug("%s: %s: Enter\n", mmc_hostname(host->mmc), __func__);
 
 	/*
-	 * Currently the CORE_DDR_CONFIG register defaults to desired
+	 * Currently the core_ddr_config register defaults to desired
 	 * configuration on reset. Currently reprogramming the power on
 	 * reset (POR) value in case it might have been modified by
 	 * bootloaders. In the future, if this changes, then the desired
 	 * values will need to be programmed appropriately.
 	 */
-	writel_relaxed(DDR_CONFIG_POR_VAL, host->ioaddr + CORE_DDR_CONFIG);
+	writel_relaxed(DDR_CONFIG_POR_VAL, host->ioaddr +
+			msm_offset->core_ddr_config);
 
 	if (mmc->ios.enhanced_strobe) {
-		config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_ddr_200_cfg);
 		config |= CORE_CMDIN_RCLK_EN;
-		writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
+		writel_relaxed(config, host->ioaddr +
+				msm_offset->core_ddr_200_cfg);
 	}
 
-	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_dll_config_2);
 	config |= CORE_DDR_CAL_EN;
-	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config_2);
 
-	ret = readl_relaxed_poll_timeout(host->ioaddr + CORE_DLL_STATUS,
-					 dll_status,
-					 (dll_status & CORE_DDR_DLL_LOCK),
-					 10, 1000);
+	ret = readl_relaxed_poll_timeout(host->ioaddr +
+					msm_offset->core_dll_status,
+					dll_status,
+					(dll_status & CORE_DDR_DLL_LOCK),
+					10, 1000);
 
 	if (ret == -ETIMEDOUT) {
 		pr_err("%s: %s: CM_DLL_SDC4 calibration was not completed\n",
@@ -924,9 +969,9 @@ static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
 		goto out;
 	}
 
-	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC3);
+	config = readl_relaxed(host->ioaddr + msm_offset->core_vendor_spec3);
 	config |= CORE_PWRSAVE_DLL;
-	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC3);
+	writel_relaxed(config, host->ioaddr + msm_offset->core_vendor_spec3);
 
 	/*
 	 * Drain writebuffer to ensure above DLL calibration
@@ -946,6 +991,8 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 	struct mmc_host *mmc = host->mmc;
 	int ret;
 	u32 config;
+	const struct sdhci_msm_offset *msm_offset =
+					msm_host->offset;
 
 	pr_debug("%s: %s: Enter\n", mmc_hostname(host->mmc), __func__);
 
@@ -963,9 +1010,11 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
 					      msm_host->saved_tuning_phase);
 		if (ret)
 			goto out;
-		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_dll_config);
 		config |= CORE_CMD_DAT_TRACK_SEL;
-		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+		writel_relaxed(config, host->ioaddr +
+				msm_offset->core_dll_config);
 	}
 
 	if (msm_host->use_cdclp533)
@@ -1095,6 +1144,8 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	u16 ctrl_2;
 	u32 config;
+	const struct sdhci_msm_offset *msm_offset =
+					msm_host->offset;
 
 	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	/* Select Bus Speed Mode for host */
@@ -1135,13 +1186,17 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
 		 * DLL is not required for clock <= 100MHz
 		 * Thus, make sure DLL it is disabled when not required
 		 */
-		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_dll_config);
 		config |= CORE_DLL_RST;
-		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+		writel_relaxed(config, host->ioaddr +
+				msm_offset->core_dll_config);
 
-		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_dll_config);
 		config |= CORE_DLL_PDN;
-		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
+		writel_relaxed(config, host->ioaddr +
+				msm_offset->core_dll_config);
 
 		/*
 		 * The DLL needs to be restored and CDCLP533 recalibrated
@@ -1183,7 +1238,9 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	bool done = false;
-	u32 val;
+	u32 val = SWITCHABLE_SIGNALING_VOLTAGE;
+	const struct sdhci_msm_offset *msm_offset =
+					msm_host->offset;
 
 	pr_debug("%s: %s: request %d curr_pwr_state %x curr_io_level %x\n",
 			mmc_hostname(host->mmc), __func__, req_type,
@@ -1192,8 +1249,12 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
 	/*
 	 * The power interrupt will not be generated for signal voltage
 	 * switches if SWITCHABLE_SIGNALING_VOLTAGE in MCI_GENERICS is not set.
+	 * Since sdhci-msm-v5, this bit has been removed and SW must consider
+	 * it as always set.
 	 */
-	val = readl(msm_host->core_mem + CORE_MCI_GENERICS);
+	if (!msm_host->mci_removed)
+		val = MSM_HOST_READL(msm_host, host,
+				msm_offset->core_generics);
 	if ((req_type & REQ_IO_HIGH || req_type & REQ_IO_LOW) &&
 	    !(val & SWITCHABLE_SIGNALING_VOLTAGE)) {
 		return;
@@ -1241,12 +1302,14 @@ static void sdhci_msm_dump_pwr_ctrl_regs(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_msm_offset *msm_offset =
+					msm_host->offset;
 
 	pr_err("%s: PWRCTL_STATUS: 0x%08x | PWRCTL_MASK: 0x%08x | PWRCTL_CTL: 0x%08x\n",
-			mmc_hostname(host->mmc),
-			readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS),
-			readl_relaxed(msm_host->core_mem + CORE_PWRCTL_MASK),
-			readl_relaxed(msm_host->core_mem + CORE_PWRCTL_CTL));
+		mmc_hostname(host->mmc),
+		MSM_HOST_READL(msm_host, host, msm_offset->core_pwrctl_status),
+		MSM_HOST_READL(msm_host, host, msm_offset->core_pwrctl_mask),
+		MSM_HOST_READL(msm_host, host, msm_offset->core_pwrctl_ctl));
 }
 
 static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
@@ -1257,11 +1320,14 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	int retry = 10;
 	u32 pwr_state = 0, io_level = 0;
 	u32 config;
+	const struct sdhci_msm_offset *msm_offset = msm_host->offset;
 
-	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
+	irq_status = MSM_HOST_READL(msm_host, host,
+			msm_offset->core_pwrctl_status);
 	irq_status &= INT_MASK;
 
-	writel_relaxed(irq_status, msm_host->core_mem + CORE_PWRCTL_CLEAR);
+	MSM_HOST_WRITEL(msm_host, irq_status, host,
+			msm_offset->core_pwrctl_clear);
 
 	/*
 	 * There is a rare HW scenario where the first clear pulse could be
@@ -1270,8 +1336,8 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	 * sure status register is cleared. Otherwise, this will result in
 	 * a spurious power IRQ resulting in system instability.
 	 */
-	while (irq_status & readl_relaxed(msm_host->core_mem +
-				CORE_PWRCTL_STATUS)) {
+	while (irq_status & MSM_HOST_READL(msm_host, host,
+				msm_offset->core_pwrctl_status)) {
 		if (retry == 0) {
 			pr_err("%s: Timedout clearing (0x%x) pwrctl status register\n",
 					mmc_hostname(host->mmc), irq_status);
@@ -1279,8 +1345,8 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 			WARN_ON(1);
 			break;
 		}
-		writel_relaxed(irq_status,
-				msm_host->core_mem + CORE_PWRCTL_CLEAR);
+		MSM_HOST_WRITEL(msm_host, irq_status, host,
+			msm_offset->core_pwrctl_clear);
 		retry--;
 		udelay(10);
 	}
@@ -1311,7 +1377,8 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	 * report back if it succeded or not to this register. The voltage
 	 * switches are handled by the sdhci core, so just report success.
 	 */
-	writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
+	MSM_HOST_WRITEL(msm_host, irq_ack, host,
+			msm_offset->core_pwrctl_ctl);
 
 	/*
 	 * If we don't have info regarding the voltage levels supported by
@@ -1330,7 +1397,8 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 		 * controllers with only 1.8V, we will set the IO PAD bit
 		 * without waiting for a REQ_IO_LOW.
 		 */
-		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_vendor_spec);
 		new_config = config;
 
 		if ((io_level & REQ_IO_HIGH) &&
@@ -1341,8 +1409,8 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 			new_config |= CORE_IO_PAD_PWR_SWITCH;
 
 		if (config ^ new_config)
-			writel_relaxed(new_config,
-					host->ioaddr + CORE_VENDOR_SPEC);
+			writel_relaxed(new_config, host->ioaddr +
+					msm_offset->core_vendor_spec);
 	}
 
 	if (pwr_state)
@@ -1503,6 +1571,7 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	struct regulator *supply = mmc->supply.vqmmc;
 	u32 caps = 0, config;
 	struct sdhci_host *host = mmc_priv(mmc);
+	const struct sdhci_msm_offset *msm_offset = msm_host->offset;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		if (regulator_is_supported_voltage(supply, 1700000, 1950000))
@@ -1522,7 +1591,8 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 		 */
 		u32 io_level = msm_host->curr_io_level;
 
-		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+		config = readl_relaxed(host->ioaddr +
+				msm_offset->core_vendor_spec);
 		config |= CORE_IO_PAD_PWR_SWITCH_EN;
 
 		if ((io_level & REQ_IO_HIGH) && (caps &	CORE_3_0V_SUPPORT))
@@ -1530,7 +1600,8 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 		else if ((io_level & REQ_IO_LOW) || (caps & CORE_1_8V_SUPPORT))
 			config |= CORE_IO_PAD_PWR_SWITCH;
 
-		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+		writel_relaxed(config,
+				host->ioaddr + msm_offset->core_vendor_spec);
 	}
 	msm_host->caps_0 |= caps;
 	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
@@ -1559,7 +1630,8 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 };
 
 static const struct of_device_id sdhci_msm_dt_match[] = {
-	{ .compatible = "qcom,sdhci-msm-v4" },
+	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
 	{},
 };
 
@@ -1596,6 +1668,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	u16 host_version, core_minor;
 	u32 core_version, config;
 	u8 core_major;
+	const struct sdhci_msm_offset *msm_offset;
+	const struct sdhci_msm_variant_info *var_info;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
 	if (IS_ERR(host))
@@ -1611,6 +1685,18 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (ret)
 		goto pltfm_free;
 
+	/*
+	 * Based on the compatible string, load the required msm host info from
+	 * the data associated with the version info.
+	 */
+	var_info = of_device_get_match_data(&pdev->dev);
+
+	msm_host->mci_removed = var_info->mci_removed;
+	msm_host->var_ops = var_info->var_ops;
+	msm_host->offset = var_info->offset;
+
+	msm_offset = msm_host->offset;
+
 	sdhci_get_of_property(pdev);
 
 	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
@@ -1675,32 +1761,40 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "TCXO clk not present (%d)\n", ret);
 	}
 
-	core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	msm_host->core_mem = devm_ioremap_resource(&pdev->dev, core_memres);
+	if (!msm_host->mci_removed) {
+		core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		msm_host->core_mem = devm_ioremap_resource(&pdev->dev,
+				core_memres);
 
-	if (IS_ERR(msm_host->core_mem)) {
-		dev_err(&pdev->dev, "Failed to remap registers\n");
-		ret = PTR_ERR(msm_host->core_mem);
-		goto clk_disable;
+		if (IS_ERR(msm_host->core_mem)) {
+			dev_err(&pdev->dev, "Failed to remap registers\n");
+			ret = PTR_ERR(msm_host->core_mem);
+			goto clk_disable;
+		}
 	}
 
 	/* Reset the vendor spec register to power on reset state */
 	writel_relaxed(CORE_VENDOR_SPEC_POR_VAL,
-		       host->ioaddr + CORE_VENDOR_SPEC);
-
-	/* Set HC_MODE_EN bit in HC_MODE register */
-	writel_relaxed(HC_MODE_EN, (msm_host->core_mem + CORE_HC_MODE));
-
-	config = readl_relaxed(msm_host->core_mem + CORE_HC_MODE);
-	config |= FF_CLK_SW_RST_DIS;
-	writel_relaxed(config, msm_host->core_mem + CORE_HC_MODE);
+			host->ioaddr + msm_offset->core_vendor_spec);
+
+	if (!msm_host->mci_removed) {
+		/* Set HC_MODE_EN bit in HC_MODE register */
+		MSM_HOST_WRITEL(msm_host, HC_MODE_EN, host,
+				msm_offset->core_hc_mode);
+		config = MSM_HOST_READL(msm_host, host,
+				msm_offset->core_hc_mode);
+		config |= FF_CLK_SW_RST_DIS;
+		MSM_HOST_WRITEL(msm_host, config, host,
+				msm_offset->core_hc_mode);
+	}
 
 	host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
 	dev_dbg(&pdev->dev, "Host Version: 0x%x Vendor Version 0x%x\n",
 		host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
 			       SDHCI_VENDOR_VER_SHIFT));
 
-	core_version = readl_relaxed(msm_host->core_mem + CORE_MCI_VERSION);
+	core_version = MSM_HOST_READL(msm_host, host,
+			msm_offset->core_mci_version);
 	core_major = (core_version & CORE_VERSION_MAJOR_MASK) >>
 		      CORE_VERSION_MAJOR_SHIFT;
 	core_minor = core_version & CORE_VERSION_MINOR_MASK;
@@ -1725,7 +1819,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		config = readl_relaxed(host->ioaddr + SDHCI_CAPABILITIES);
 		config |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
 		writel_relaxed(config, host->ioaddr +
-			       CORE_VENDOR_SPEC_CAPABILITIES0);
+				msm_offset->core_vendor_spec_capabilities0);
 	}
 
 	/*
@@ -1754,7 +1848,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	sdhci_msm_init_pwr_irq_wait(msm_host);
 	/* Enable pwr irq interrupts */
-	writel_relaxed(INT_MASK, msm_host->core_mem + CORE_PWRCTL_MASK);
+	MSM_HOST_WRITEL(msm_host, INT_MASK, host,
+		msm_offset->core_pwrctl_mask);
 
 	ret = devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, NULL,
 					sdhci_msm_pwr_irq, IRQF_ONESHOT,
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
