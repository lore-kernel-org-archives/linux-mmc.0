From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH V4 1/2] mmc: sdhci-msm: Add support to store supported vdd-io voltages
Date: Wed, 28 Mar 2018 18:38:19 +0530
Message-ID: <1522242500-10556-2-git-send-email-vviswana@codeaurora.org>
References: <1522242500-10556-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522242500-10556-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

During probe check whether the vdd-io regulator of sdhc platform device
can support 1.8V and 3V and store this information as a capability of
platform device.

Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index c283291..2fcd9010 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/iopoll.h>
+#include <linux/regulator/consumer.h>
 
 #include "sdhci-pltfm.h"
 
@@ -81,6 +82,9 @@
 #define CORE_HC_SELECT_IN_HS400	(6 << 19)
 #define CORE_HC_SELECT_IN_MASK	(7 << 19)
 
+#define CORE_3_0V_SUPPORT	(1 << 25)
+#define CORE_1_8V_SUPPORT	(1 << 26)
+
 #define CORE_CSR_CDC_CTLR_CFG0		0x130
 #define CORE_SW_TRIG_FULL_CALIB		BIT(16)
 #define CORE_HW_AUTOCAL_ENA		BIT(17)
@@ -148,6 +152,7 @@ struct sdhci_msm_host {
 	u32 curr_io_level;
 	wait_queue_head_t pwr_irq_wait;
 	bool pwr_irq_flag;
+	u32 caps_0;
 };
 
 static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
@@ -1103,7 +1108,7 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	u32 irq_status, irq_ack = 0;
 	int retry = 10;
-	int pwr_state = 0, io_level = 0;
+	u32 pwr_state = 0, io_level = 0;
 
 
 	irq_status = readl_relaxed(msm_host->core_mem + CORE_PWRCTL_STATUS);
@@ -1313,6 +1318,30 @@ static void sdhci_msm_writeb(struct sdhci_host *host, u8 val, int reg)
 		sdhci_msm_check_power_status(host, req_type);
 }
 
+static int sdhci_msm_set_regulator_caps(struct sdhci_msm_host *msm_host)
+{
+	struct mmc_host *mmc = msm_host->mmc;
+	struct regulator *supply = mmc->supply.vqmmc;
+	u32 caps = 0;
+
+	if (!IS_ERR(mmc->supply.vqmmc)) {
+		if (regulator_is_supported_voltage(supply, 1700000, 1950000))
+			caps |= CORE_1_8V_SUPPORT;
+		if (regulator_is_supported_voltage(supply, 2700000, 3600000))
+			caps |= CORE_3_0V_SUPPORT;
+
+		if (!caps)
+			pr_warn("%s: %s: 1.8/3V not supported for vqmmc\n",
+					mmc_hostname(mmc), __func__);
+	}
+
+	msm_host->caps_0 |= caps;
+	pr_debug("%s: %s: supported caps: 0x%08x\n", mmc_hostname(mmc),
+			__func__, caps);
+
+	return 0;
+}
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
@@ -1530,6 +1559,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto pm_runtime_disable;
+	ret = sdhci_msm_set_regulator_caps(msm_host);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to set regulator caps: %d\n",
+				ret);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
