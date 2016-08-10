From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 07/10] mmc: sdhci-msm: Implement set_clock callback for sdhci-msm
Date: Wed, 10 Aug 2016 20:31:56 +0530
Message-ID: <1470841319-6091-8-git-send-email-riteshh@codeaurora.org>
References: <1470841319-6091-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53479 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936523AbcHJSlI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2016 14:41:08 -0400
In-Reply-To: <1470841319-6091-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>

From: Sahitya Tummala <stummala@codeaurora.org>

sdhci-msm controller may have different clk-rates for each
bus speed mode. Thus implement set_clock callback for
sdhci-msm driver.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 56 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index cfd0209..03deeab 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -89,6 +89,7 @@ struct sdhci_msm_host {
 	struct mmc_host *mmc;
 	bool use_updated_dll_reset;
 	struct sdhci_msm_pltfm_data *pdata;
+	u32 clk_rate;
 };
 
 /* Platform specific tuning */
@@ -570,6 +571,59 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
 	return msm_host->pdata->clk_table[0];
 }
 
+static unsigned int sdhci_msm_get_msm_clk_rate(struct sdhci_host *host,
+					u32 req_clk)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	int count = msm_host->pdata->clk_table_sz;
+	unsigned int sel_clk = -1;
+	int cnt;
+
+	if (req_clk < sdhci_msm_get_min_clock(host)) {
+		sel_clk = sdhci_msm_get_min_clock(host);
+		return sel_clk;
+	}
+
+	for (cnt = 0; cnt < count; cnt++) {
+		if (msm_host->pdata->clk_table[cnt] > req_clk) {
+			break;
+		} else if (msm_host->pdata->clk_table[cnt] == req_clk) {
+			sel_clk = msm_host->pdata->clk_table[cnt];
+			break;
+		} else {
+			sel_clk = msm_host->pdata->clk_table[cnt];
+		}
+	}
+	return sel_clk;
+}
+
+static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	u32 msm_clock = 0;
+	int rc = 0;
+
+	if (!clock)
+		goto out;
+
+	if (clock != msm_host->clk_rate) {
+		msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
+		rc = clk_set_rate(msm_host->clk, msm_clock);
+		if (rc) {
+			pr_err("%s: failed to set clock at rate %u, requested clock rate %u\n",
+				mmc_hostname(host->mmc), msm_clock, clock);
+			goto out;
+		}
+		msm_host->clk_rate = clock;
+		pr_debug("%s: setting clock at rate %lu\n",
+			mmc_hostname(host->mmc), clk_get_rate(msm_host->clk));
+	}
+out:
+	sdhci_set_clock(host, clock);
+}
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
@@ -580,7 +634,7 @@ MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
 static const struct sdhci_ops sdhci_msm_ops = {
 	.platform_execute_tuning = sdhci_msm_execute_tuning,
 	.reset = sdhci_reset,
-	.set_clock = sdhci_set_clock,
+	.set_clock = sdhci_msm_set_clock,
 	.get_min_clock = sdhci_msm_get_min_clock,
 	.get_max_clock = sdhci_msm_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

