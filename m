From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: [PATCH RFC 4/4] host: sdhci-msm: implement get_current_limit() host op
Date: Tue,  1 May 2018 16:09:13 +0530
Message-ID: <1525171153-24476-5-git-send-email-vviswana@codeaurora.org>
References: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525171153-24476-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

This is needed to get the current capabilities of vdd
regulator that is not managed by SDHCI driver.

Change-Id: I927c14b9890f1d672fe8a3e89d0b334f43463b36
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 0e0f12d..083b4a5 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2079,6 +2079,18 @@ static void sdhci_msm_set_default_hw_caps(struct device *dev,
 	{},
 };
 
+static unsigned int sdhci_msm_get_current_limit(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_msm_reg_data *vdd_data = msm_host->pdata.vdd_data;
+	u32 max_curr = 0;
+
+	if (vdd_data)
+		max_curr = vdd_data->hpm_uA;
+	return max_curr;
+}
+
 MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
 
 static const struct sdhci_ops sdhci_msm_ops = {
@@ -2090,6 +2102,7 @@ static void sdhci_msm_set_default_hw_caps(struct device *dev,
 	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
 	.write_w = sdhci_msm_writew,
 	.write_b = sdhci_msm_writeb,
+	.get_current_limit = sdhci_msm_get_current_limit,
 };
 
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
