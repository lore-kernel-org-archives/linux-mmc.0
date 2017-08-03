From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 2/2] mmc: sdhci-msm: set sdma_boundary to zero
Date: Thu,  3 Aug 2017 14:46:14 +0200
Message-ID: <20170803124614.21788-3-srinivas.kandagatla@linaro.org>
References: <20170803124614.21788-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170803124614.21788-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
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
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9d601dc..adfe5bd 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1133,6 +1133,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
+	host->sdma_boundary = 0;
 	pltfm_host = sdhci_priv(host);
 	msm_host = sdhci_pltfm_priv(pltfm_host);
 	msm_host->mmc = host->mmc;
-- 
2.9.3
