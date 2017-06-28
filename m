From: srinivas.kandagatla@linaro.org
Subject: [RFC PATCH 2/2] mmc: sdhci-msm: enable SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER
Date: Wed, 28 Jun 2017 15:35:04 +0200
Message-ID: <20170628133504.17422-3-srinivas.kandagatla@linaro.org>
References: <20170628133504.17422-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170628133504.17422-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Programming legacy HOST SDMA Buffer Boundary bits in Block Size Register
(0x04) is not supported in Qualcomm sdhci controllers. Writing to this
would cause the controller not to transfer last block in case block size
is 4 bytes or less.

This issue was noticed while testing sdio wlan card on Qcom DB410c board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9d601dc0d646..50f650301ae6 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1114,7 +1114,8 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 		  SDHCI_QUIRK_NO_CARD_NO_RESET |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER,
 	.ops = &sdhci_msm_ops,
 };
 
-- 
2.11.0
