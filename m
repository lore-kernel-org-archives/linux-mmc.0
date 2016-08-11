From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 08/10] mmc: sdhci-msm: Add get_clk_div callback definition
Date: Thu, 11 Aug 2016 19:22:54 +0530
Message-ID: <1470923574-411-3-git-send-email-riteshh@codeaurora.org>
References: <a48103a7-1aa2-b9e2-527c-c7237a9ea9c0@rock-chips.com>
 <1470923574-411-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59488 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174AbcHKNx0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Aug 2016 09:53:26 -0400
In-Reply-To: <1470923574-411-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

MSM controller does not use the div, instead needs
the base clock and the driver controls the
base clock (MCLK) at GCC directly.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index cfd0209..f148c96 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -570,6 +570,16 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
 	return msm_host->pdata->clk_table[0];
 }
 
+/*
+ * MSM SDHC controller HW recomendation is to not use
+ * clock divisor hence return 0 from here.
+ * Driver directly controls the clk-rate at GCC.
+ */
+static int sdhci_msm_get_clk_div(struct sdhci_host *host, int div)
+{
+		return 0;
+}
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
@@ -586,6 +596,7 @@ static const struct sdhci_ops sdhci_msm_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
 	.voltage_switch = sdhci_msm_voltage_switch,
+	.get_clk_div = sdhci_msm_get_clk_div,
 };
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
-- 
1.8.2.1

