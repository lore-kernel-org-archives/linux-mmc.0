From: Ram Prakash Gupta <rampraka@codeaurora.org>
Subject: [RFC 5/6] mmc: sdhci-msm: Add capability in platform host
Date: Mon, 21 Oct 2019 19:59:36 +0530
Message-ID: <1571668177-3766-6-git-send-email-rampraka@codeaurora.org>
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: asutoshd@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, vbadigan@codeaurora.org, cang@codeaurora.org, ppvk@codeaurora.org, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, Talel Shenhar <tatias@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, "Bao D. Nguyen" <nguyenb@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Talel Shenhar <tatias@codeaurora.org>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Co-Developed-by: Ram Prakash Gupta <rampraka@codeaurora.org>
Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b75c82d..67accf6 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1934,6 +1934,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	msm_host->mmc->caps2 |= MMC_CAP2_CLK_SCALE;
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
1.9.1
