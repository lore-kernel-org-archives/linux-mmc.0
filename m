From: Ritesh Harjani <rharjani@qti.qualcomm.com>
Subject: [RFC 2/4] mmc: sdhci-msm: Add CQHCI support for sdhci-msm
Date: Wed, 30 Aug 2017 18:29:57 +0530
Message-ID: <1504097999-27355-3-git-send-email-rharjani@qti.qualcomm.com>
References: <1504097999-27355-1-git-send-email-rharjani@qti.qualcomm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504097999-27355-1-git-send-email-rharjani@qti.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, asutoshd@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Ritesh Harjani <riteshh@codeaurora.org>

This adds CQHCI support for sdhci-msm platforms.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 .../devicetree/bindings/mmc/sdhci-msm.txt          |  1 +
 drivers/mmc/host/Kconfig                           |  1 +
 drivers/mmc/host/sdhci-msm.c                       | 90 +++++++++++++++++++++-
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 0576264..897294f 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -5,6 +5,7 @@ and the properties used by the sdhci-msm driver.
 
 Required properties:
 - compatible: Should contain "qcom,sdhci-msm-v4".
+- compatible: "qcom,sdhci-msm-cqe" - Optional in case the controller support CQE.
 - reg: Base address and length of the register in the following order:
 	- Host controller register map (required)
 	- SD Core register map (required)
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index b8c9ea5..a2524c7 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -430,6 +430,7 @@ config MMC_SDHCI_MSM
 	tristate "Qualcomm SDHCI Controller Support"
 	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
 	depends on MMC_SDHCI_PLTFM
+	select MMC_CQHCI
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in Qualcomm SOCs. The controller supports
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index df66724..346cdfb 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -23,6 +23,7 @@
 #include <linux/iopoll.h>
 
 #include "sdhci-pltfm.h"
+#include "cqhci.h"
 
 #define CORE_MCI_VERSION		0x50
 #define CORE_VERSION_MAJOR_SHIFT	28
@@ -1092,8 +1093,87 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	__sdhci_msm_set_clock(host, clock);
 }
 
+/*****************************************************************************\
+ *                                                                           *
+ * MSM Command Queue Engine (CQE)                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static u32 sdhci_msm_cqe_irq(struct sdhci_host *host, u32 intmask)
+{
+	int cmd_error = 0;
+	int data_error = 0;
+
+	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
+		return intmask;
+
+	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
+	return 0;
+}
+
+static const struct cqhci_host_ops sdhci_msm_cqhci_ops = {
+	.enable		= sdhci_cqe_enable,
+	.disable	= sdhci_cqe_disable,
+};
+
+#ifdef CONFIG_MMC_CQHCI
+static int sdhci_msm_cqe_add_host(struct sdhci_host *host,
+				struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct cqhci_host *cq_host;
+	bool dma64;
+	int ret;
+
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	cq_host = cqhci_pltfm_init(pdev);
+	if (IS_ERR(cq_host)) {
+		ret = PTR_ERR(cq_host);
+		dev_err(&pdev->dev, "cqhci-pltfm init: failed: %d\n", ret);
+		goto cleanup;
+	}
+
+	msm_host->mmc->caps2 |= MMC_CAP2_CQE;
+	cq_host->ops = &sdhci_msm_cqhci_ops;
+
+	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
+	if (dma64)
+		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+
+	ret = cqhci_init(cq_host, host->mmc, dma64);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: CQE init: failed (%d)\n", mmc_hostname(host->mmc),
+				ret);
+		goto cleanup;
+	}
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto cleanup;
+
+	dev_info(&pdev->dev, "%s: CQE init: success\n", mmc_hostname(host->mmc));
+	return ret;
+
+cleanup:
+	sdhci_cleanup_host(host);
+	return ret;
+}
+#else
+static void sdhci_msm_cqe_add_host(struct sdhci_host *host,
+				struct platform_device *pdev)
+{
+	dev_warn(&pdev->dev, "CQE config not enabled, defaulting to sdhci\n");
+	return sdhci_add_host(host);
+}
+#endif /* CONFIG_MMC_CQHCI */
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
+	{ .compatible = "qcom,sdhci-msm-cqe" },
 	{},
 };
 
@@ -1107,6 +1187,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
 	.voltage_switch = sdhci_msm_voltage_switch,
+	.irq			= sdhci_msm_cqe_irq,
 };
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
@@ -1125,6 +1206,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_msm_host *msm_host;
 	struct resource *core_memres;
+	struct device_node *node = pdev->dev.of_node;
 	int ret;
 	u16 host_version, core_minor;
 	u32 core_version, config;
@@ -1277,7 +1359,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 
 	host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
-	ret = sdhci_add_host(host);
+
+	if (of_device_is_compatible(node, "qcom,sdhci-msm-cqe")) {
+		dev_dbg(&pdev->dev, "node with qcom,sdhci-msm-cqe\n");
+		ret = sdhci_msm_cqe_add_host(host, pdev);
+	} else {
+		ret = sdhci_add_host(host);
+	}
 	if (ret)
 		goto pm_runtime_disable;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
