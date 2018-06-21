From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH RFC 2/2] mmc: sdhci-msm: Use internal voltage control
Date: Thu, 21 Jun 2018 17:53:46 +0530
Message-ID: <1529583826-42020-3-git-send-email-vviswana@codeaurora.org>
References: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Some sdhci-msm controllers require that voltage switching be done after
the HW is ready for it. The HW informs its readiness through power irq.
The voltage switching should happen only then.

Use the quirk for internal voltage switching and then control the
voltage switching using power irq.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 99 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index a0dc3e1..ebdde29 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -43,7 +43,9 @@
 #define CORE_PWRCTL_IO_LOW	BIT(2)
 #define CORE_PWRCTL_IO_HIGH	BIT(3)
 #define CORE_PWRCTL_BUS_SUCCESS BIT(0)
+#define CORE_PWRCTL_BUS_FAIL    BIT(1)
 #define CORE_PWRCTL_IO_SUCCESS	BIT(2)
+#define CORE_PWRCTL_IO_FAIL     BIT(3)
 #define REQ_BUS_OFF		BIT(0)
 #define REQ_BUS_ON		BIT(1)
 #define REQ_IO_LOW		BIT(2)
@@ -258,6 +260,7 @@ struct sdhci_msm_host {
 	bool mci_removed;
 	const struct sdhci_msm_variant_ops *var_ops;
 	const struct sdhci_msm_offset *offset;
+	bool pltfm_init_done;
 };
 
 static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
@@ -1314,8 +1317,9 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct mmc_host *mmc = host->mmc;
 	u32 irq_status, irq_ack = 0;
-	int retry = 10;
+	int retry = 10, ret = 0;
 	u32 pwr_state = 0, io_level = 0;
 	u32 config;
 	const struct sdhci_msm_offset *msm_offset = msm_host->offset;
@@ -1351,14 +1355,59 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 
 	/* Handle BUS ON/OFF*/
 	if (irq_status & CORE_PWRCTL_BUS_ON) {
-		pwr_state = REQ_BUS_ON;
-		io_level = REQ_IO_HIGH;
-		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+		if (mmc->supply.vmmc) {
+			ret = regulator_set_load(mmc->supply.vmmc, 800000);
+			ret |= mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+					mmc->ios.vdd);
+			if (ret)
+				pr_err("%s: vmmc enable failed: %d\n",
+						mmc_hostname(mmc), ret);
+		}
+		if (mmc->supply.vqmmc && !ret) {
+			ret = regulator_set_load(mmc->supply.vqmmc, 22000);
+			ret |= mmc_regulator_set_ocr(mmc, mmc->supply.vqmmc,
+					mmc->ios.vdd);
+			if (!ret)
+				ret = regulator_enable(mmc->supply.vqmmc);
+			if (ret)
+				pr_err("%s: vqmmc enable failed: %d\n",
+						mmc_hostname(mmc), ret);
+		}
+		if (!ret) {
+			pwr_state = REQ_BUS_ON;
+			io_level = REQ_IO_HIGH;
+			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+		} else {
+			pr_err("%s: BUS_ON req failed(%d). irq_status: 0x%08x\n",
+					mmc_hostname(mmc), ret, irq_status);
+			irq_ack |= CORE_PWRCTL_BUS_FAIL;
+		}
 	}
 	if (irq_status & CORE_PWRCTL_BUS_OFF) {
-		pwr_state = REQ_BUS_OFF;
-		io_level = REQ_IO_LOW;
-		irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+		if (mmc->supply.vmmc && msm_host->pltfm_init_done) {
+			ret = regulator_set_load(mmc->supply.vmmc, 0);
+			ret |= mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+					mmc->ios.vdd);
+			if (ret)
+				pr_err("%s: vqmmc disabling failed: %d\n",
+						mmc_hostname(mmc), ret);
+		}
+		if (mmc->supply.vqmmc && msm_host->pltfm_init_done && !ret) {
+			ret = regulator_set_load(mmc->supply.vqmmc, 0);
+			ret |= regulator_disable(mmc->supply.vqmmc);
+			if (ret)
+				pr_err("%s: vqmmc disabling failed: %d\n",
+						mmc_hostname(mmc), ret);
+		}
+		if (!ret) {
+			pwr_state = REQ_BUS_OFF;
+			io_level = REQ_IO_LOW;
+			irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
+		} else {
+			pr_err("%s: BUS_ON req failed(%d). irq_status: 0x%08x\n",
+					mmc_hostname(mmc), ret, irq_status);
+			irq_ack |= CORE_PWRCTL_BUS_FAIL;
+		}
 	}
 	/* Handle IO LOW/HIGH */
 	if (irq_status & CORE_PWRCTL_IO_LOW) {
@@ -1370,6 +1419,15 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 		irq_ack |= CORE_PWRCTL_IO_SUCCESS;
 	}
 
+	if (io_level && mmc->supply.vqmmc && !pwr_state) {
+		ret = mmc_regulator_set_vqmmc(mmc, &mmc->ios);
+		if (ret)
+			pr_err("%s: IO_level setting failed(%d). signal_voltage: %d, vdd: %d irq_status: 0x%08x\n",
+					mmc_hostname(mmc), ret,
+					mmc->ios.signal_voltage, mmc->ios.vdd,
+					irq_status);
+	}
+
 	/*
 	 * The driver has to acknowledge the interrupt, switch voltages and
 	 * report back if it succeded or not to this register. The voltage
@@ -1415,10 +1473,9 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 		msm_host->curr_pwr_state = pwr_state;
 	if (io_level)
 		msm_host->curr_io_level = io_level;
-
 	pr_debug("%s: %s: Handled IRQ(%d), irq_status=0x%x, ack=0x%x\n",
-		mmc_hostname(msm_host->mmc), __func__, irq, irq_status,
-		irq_ack);
+			mmc_hostname(msm_host->mmc), __func__,
+			irq, irq_status, irq_ack);
 }
 
 static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
@@ -1605,6 +1662,19 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	pr_debug("%s: supported caps: 0x%08x\n", mmc_hostname(mmc), caps);
 }
 
+static int sdhci_msm_register_vreg(struct sdhci_msm_host *msm_host)
+{
+	int ret = 0;
+
+	ret = mmc_regulator_get_supply(msm_host->mmc);
+	if (ret)
+		return ret;
+	sdhci_msm_set_regulator_caps(msm_host);
+
+	return 0;
+
+}
+
 static const struct sdhci_msm_variant_ops mci_var_ops = {
 	.msm_readl_relaxed = sdhci_msm_mci_variant_readl_relaxed,
 	.msm_writel_relaxed = sdhci_msm_mci_variant_writel_relaxed,
@@ -1650,7 +1720,8 @@ static void sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_INTERNAL_PWR_CTL,
 	.ops = &sdhci_msm_ops,
 };
 
@@ -1819,6 +1890,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 				msm_offset->core_vendor_spec_capabilities0);
 	}
 
+	ret = sdhci_msm_register_vreg(msm_host);
+	if (ret == -EPROBE_DEFER)
+		goto clk_disable;
+
 	/*
 	 * Power on reset state may trigger power irq if previous status of
 	 * PWRCTL was either BUS_ON or IO_HIGH_V. So before enabling pwr irq
@@ -1867,7 +1942,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto pm_runtime_disable;
-	sdhci_msm_set_regulator_caps(msm_host);
+	msm_host->pltfm_init_done = true;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
