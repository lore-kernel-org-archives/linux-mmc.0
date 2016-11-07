From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v6 07/14] mmc: sdhci-msm: Enable few quirks
Date: Mon,  7 Nov 2016 16:54:30 +0530
Message-ID: <1478517877-23733-8-git-send-email-riteshh@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

sdhc-msm controller needs this SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
& SDHCI_QUIRK2_PRESET_VALUE_BROKEN to be set. Hence setting it.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-msm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 66ca444..fde2777 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -594,7 +594,9 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_NO_CARD_NO_RESET |
-		  SDHCI_QUIRK_SINGLE_POWER_WRITE,
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_msm_ops,
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

