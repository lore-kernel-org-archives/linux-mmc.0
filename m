From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V3 2/2] mmc: sdhci-msm: support voltage pad switching
Date: Wed, 28 Mar 2018 18:25:39 +0530
Message-ID: <1522241739-56274-3-git-send-email-vviswana@codeaurora.org>
References: <1522241739-56274-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522241739-56274-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, Krishna Konda <kkonda@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Krishna Konda <kkonda@codeaurora.org>

The PADs for SD card are dual-voltage that support 3v/1.8v. Those PADs
have a control signal  (io_pad_pwr_switch/mode18 ) that indicates
whether the PAD works in 3v or 1.8v.

SDHC core on msm platforms should have IO_PAD_PWR_SWITCH bit set/unset
based on actual voltage used for IO lines. So when power irq is
triggered for io high or io low, the driver should check the voltages
supported and set the pad accordingly.

Signed-off-by: Krishna Konda <kkonda@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 65 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index a822f10..2ffb7bb 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -78,12 +78,15 @@
 #define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
 #define CORE_HC_MCLK_SEL_HS400	(3 << 8)
 #define CORE_HC_MCLK_SEL_MASK	(3 << 8)
+#define CORE_IO_PAD_PWR_SWITCH_EN	(1 << 15)
+#define CORE_IO_PAD_PWR_SWITCH  (1 << 16)
 #define CORE_HC_SELECT_IN_EN	BIT(18)
 #define CORE_HC_SELECT_IN_HS400	(6 << 19)
 #define CORE_HC_SELECT_IN_MASK	(7 << 19)
 
 #define CORE_3_0V_SUPPORT	(1 << 25)
 #define CORE_1_8V_SUPPORT	(1 << 26)
+#define CORE_VOLT_SUPPORT	(CORE_3_0V_SUPPORT | CORE_1_8V_SUPPORT)
 
 #define CORE_CSR_CDC_CTLR_CFG0		0x130
 #define CORE_SW_TRIG_FULL_CALIB		BIT(16)
@@ -1109,7 +1112,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	u32 irq_status, irq_ack = 0;
 	int retry = 10;
 	u32 pwr_state = 0, io_level = 0;
-
+	u32 config;
 
 	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
 	irq_status &= INT_MASK;
@@ -1166,11 +1169,51 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	 */
 	writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
 
+	/*
+	 * If we don't have info regarding the voltage levels supported by
+	 * regulators, don't change the IO PAD PWR SWITCH.
+	 */
+	if (msm_host->caps_0 & CORE_VOLT_SUPPORT) {
+		/* Ensure order between core_mem and hc_mem */
+		mb();
+		/*
+		 * We should unset IO PAD PWR switch only if the register write
+		 * can set IO lines high and the regulator also switches to 3 V.
+		 * Else, we should keep the IO PAD PWR switch set.
+		 * This is applicable to certain targets where eMMC vccq supply
+		 * is only 1.8V. In such targets, even during REQ_IO_HIGH, the
+		 * IO PAD PWR switch must be kept set to reflect actual
+		 * regulator voltage. This way, during initialization of
+		 * controllers with only 1.8V, we will set the IO PAD bit
+		 * without waiting for a REQ_IO_LOW.
+		 */
+		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+
+		if (((io_level & REQ_IO_HIGH) && (msm_host->caps_0 &
+				CORE_3_0V_SUPPORT)) &&
+				(config & CORE_IO_PAD_PWR_SWITCH)) {
+			config &= ~CORE_IO_PAD_PWR_SWITCH;
+			writel_relaxed(config,
+					host->ioaddr + CORE_VENDOR_SPEC);
+			/* IO PAD register is in different memory space */
+			mb();
+		} else if (((io_level & REQ_IO_LOW) ||
+				(msm_host->caps_0 & CORE_1_8V_SUPPORT)) &&
+				!(config & CORE_IO_PAD_PWR_SWITCH)) {
+			config |= CORE_IO_PAD_PWR_SWITCH;
+			writel_relaxed(config,
+					host->ioaddr + CORE_VENDOR_SPEC);
+			/* IO PAD bit is in different memory space */
+			mb();
+		}
+	}
+
 	if (pwr_state)
 		msm_host->curr_pwr_state = pwr_state;
 	if (io_level)
 		msm_host->curr_io_level = io_level;
 
+
 	pr_debug("%s: %s: Handled IRQ(%d), irq_status=0x%x, ack=0x%x\n",
 		mmc_hostname(msm_host->mmc), __func__, irq, irq_status,
 		irq_ack);
@@ -1322,7 +1365,8 @@ static int sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 {
 	struct mmc_host *mmc = msm_host->mmc;
 	struct regulator *supply = mmc->supply.vqmmc;
-	u32 caps = 0;
+	u32 caps = 0, config;
+	struct sdhci_host *host = mmc_priv(mmc);
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 		if (regulator_is_supported_voltage(supply, 1700000, 1950000))
@@ -1335,6 +1379,23 @@ static int sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 					mmc_hostname(mmc), __func__);
 	}
 
+	if (caps) {
+		/*
+		 * Set the PAD_PWR_SWITCH_EN bit so that the PAD_PWR_SWITCH
+		 * bit can be used as required later on.
+		 */
+		u32 io_level = msm_host->curr_io_level;
+
+		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+		config |= CORE_IO_PAD_PWR_SWITCH_EN;
+
+		if ((io_level & REQ_IO_HIGH) && (caps &	CORE_3_0V_SUPPORT))
+			config &= ~CORE_IO_PAD_PWR_SWITCH;
+		else if ((io_level & REQ_IO_LOW) || (caps & CORE_1_8V_SUPPORT))
+			config |= CORE_IO_PAD_PWR_SWITCH;
+
+		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+	}
 	msm_host->caps_0 |= caps;
 	pr_debug("%s: %s: supported caps: 0x%08x\n", mmc_hostname(mmc),
 			__func__, caps);
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
