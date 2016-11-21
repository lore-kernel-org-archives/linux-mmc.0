From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v9 07/16] mmc: sdhci-msm: Add get_min_clock() and get_max_clock() callback
Date: Mon, 21 Nov 2016 12:07:17 +0530
Message-ID: <1479710246-26676-8-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This add get_min_clock() and get_max_clock() callback
for sdhci-msm. sdhci-msm min/max clocks may be different
hence implement these callbacks.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index fc093b8..aaeaf47 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -68,6 +68,8 @@
 
 #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
 
+#define SDHCI_MSM_MIN_CLOCK	400000
+
 #define CDR_SELEXT_SHIFT	20
 #define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
 #define CMUX_SHIFT_PHASE_SHIFT	24
@@ -556,6 +558,19 @@ static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
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
@@ -567,6 +582,8 @@ static irqreturn_t sdhci_msm_pwr_irq(int irq, void *data)
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

