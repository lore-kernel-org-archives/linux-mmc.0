From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v6 06/14] mmc: sdhci-msm: Add get_min_clock() and get_max_clock() callback
Date: Mon,  7 Nov 2016 16:54:29 +0530
Message-ID: <1478517877-23733-7-git-send-email-riteshh@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This add get_min_clock() and get_max_clock() callback
for sdhci-msm. sdhci-msm min/max clocks may be different
hence implement these callbacks.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 32b0b79..66ca444 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -68,6 +68,7 @@
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
 #define TCXO_FREQ		19200000
+#define SDHCI_MSM_MIN_CLOCK	400000
 
 #define CDR_SELEXT_SHIFT	20
 #define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
@@ -559,6 +560,19 @@ static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static unsigned int sdhci_msm_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	return clk_round_rate(msm_host->clk, ULONG_MAX);
+}
+
+static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
+{
+	return SDHCI_MSM_MIN_CLOCK;
+}
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
@@ -570,6 +584,8 @@ static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
 	.platform_execute_tuning = sdhci_msm_execute_tuning,
 	.reset = sdhci_reset,
 	.set_clock = sdhci_set_clock,
+	.get_min_clock = sdhci_msm_get_min_clock,
+	.get_max_clock = sdhci_msm_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
 	.voltage_switch = sdhci_msm_voltage_switch,
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
