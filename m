From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V2 2/2] mmc: sdhci-msm: support voltage pad switching
Date: Mon, 12 Feb 2018 11:31:18 +0530
Message-ID: <1518415278-59062-3-git-send-email-vviswana@codeaurora.org>
References: <1518415278-59062-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518415278-59062-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, vviswana@codeaurora.org, Krishna Konda <kkonda@codeaurora.org>
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
 drivers/mmc/host/sdhci-msm.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5c23e92..96c81df 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -78,6 +78,8 @@
 #define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
 #define CORE_HC_MCLK_SEL_HS400	(3 << 8)
 #define CORE_HC_MCLK_SEL_MASK	(3 << 8)
+#define CORE_IO_PAD_PWR_SWITCH_EN	(1 << 15)
+#define CORE_IO_PAD_PWR_SWITCH  (1 << 16)
 #define CORE_HC_SELECT_IN_EN	BIT(18)
 #define CORE_HC_SELECT_IN_HS400	(6 << 19)
 #define CORE_HC_SELECT_IN_MASK	(7 << 19)
@@ -1109,6 +1111,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	u32 irq_status, irq_ack = 0;
 	int retry = 10;
 	int pwr_state = 0, io_level = 0;
+	u32 config = 0;
 
 
 	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
@@ -1166,6 +1169,30 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	 */
 	writel_relaxed(irq_ack, msm_host->core_mem + CORE_PWRCTL_CTL);
 
+	/* Ensure order between core_mem and hc_mem */
+	mb();
+	/*
+	 * We should unset IO PAD PWR switch only if the register write can
+	 * set IO lines high and the regulator also switches to 3 V.
+	 * Else, we should keep the IO PAD PWR switch set.
+	 * This is applicable to certain targets where eMMC vccq supply is only
+	 * 1.8V. In such targets, even during REQ_IO_HIGH, the IO PAD PWR
+	 * switch must be kept set to reflect actual regulator voltage. This
+	 * way, during initialization of controllers with only 1.8V, we will
+	 * set the IO PAD bit without waiting for a REQ_IO_LOW.
+	 */
+	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+
+	if ((io_level & REQ_IO_HIGH) && (msm_host->caps_0 & CORE_3_0V_SUPPORT))
+		config &= ~CORE_IO_PAD_PWR_SWITCH;
+	else if ((io_level & REQ_IO_LOW) ||
+			(msm_host->caps_0 & CORE_1_8V_SUPPORT))
+		config |= CORE_IO_PAD_PWR_SWITCH;
+
+	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+	/* Ensure IO pad update before any further register read/writes */
+	mb();
+
 	if (pwr_state)
 		msm_host->curr_pwr_state = pwr_state;
 	if (io_level)
@@ -1518,6 +1545,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	}
 
 	/*
+	 * Set the PAD_PWR_SWITCH_EN bit so that the PAD_PWR_SWITCH bit can
+	 * be used as required later on.
+	 */
+	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
+	config |= CORE_IO_PAD_PWR_SWITCH_EN;
+	writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
+	/*
 	 * Power on reset state may trigger power irq if previous status of
 	 * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
 	 * interrupt in GIC, any pending power irq interrupt should be
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
