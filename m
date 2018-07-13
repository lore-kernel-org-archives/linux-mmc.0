From: Sayali Lokhande <sayalil@codeaurora.org>
Subject: [PATCH RFC 6/7] mmc: sdhci-msm: Enable clock scaling property
Date: Fri, 13 Jul 2018 15:23:02 +0530
Message-ID: <1531475583-7050-7-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

This change enables clock scaling capability for sdhci-msm
platform driver.

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e9fe8c6..8846a76 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1803,6 +1803,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	msm_offset = msm_host->offset;
 
 	sdhci_get_of_property(pdev);
+	msm_host->mmc->caps2 |= MMC_CAP2_CLK_SCALE;
 
 	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
