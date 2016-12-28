From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 4/8] mmc: sdhci-msm: Reset vendor specific func register on probe
Date: Wed, 28 Dec 2016 16:36:27 +0530
Message-ID: <1482923191-17362-5-git-send-email-riteshh@codeaurora.org>
References: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Venkat Gopalakrishnan <venkatg@codeaurora.org>

The vendor specific func register doesn't get reset when using the
software reset register. The various bootloader's could leave this
in an unknown state, hence reset this register to it's power on reset
value during probe.

Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5a37c29..a028568 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -69,6 +69,7 @@
 #define CORE_DLL_CLOCK_DISABLE	BIT(21)
 
 #define CORE_VENDOR_SPEC	0x10c
+#define CORE_VENDOR_SPEC_POR_VAL	0xa1c
 #define CORE_CLK_PWRSAVE	BIT(1)
 #define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
 #define CORE_HC_MCLK_SEL_HS400	(3 << 8)
@@ -1197,17 +1198,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
-	config = readl_relaxed(msm_host->core_mem + CORE_POWER);
-	config |= CORE_SW_RST;
-	writel_relaxed(config, msm_host->core_mem + CORE_POWER);
-
-	/* SW reset can take upto 10HCLK + 15MCLK cycles. (min 40us) */
-	usleep_range(1000, 5000);
-	if (readl(msm_host->core_mem + CORE_POWER) & CORE_SW_RST) {
-		dev_err(&pdev->dev, "Stuck in reset\n");
-		ret = -ETIMEDOUT;
-		goto clk_disable;
-	}
+	/* Reset the vendor spec register to power on reset state */
+	writel_relaxed(CORE_VENDOR_SPEC_POR_VAL,
+		       host->ioaddr + CORE_VENDOR_SPEC);
 
 	/* Set HC_MODE_EN bit in HC_MODE register */
 	writel_relaxed(HC_MODE_EN, (msm_host->core_mem + CORE_HC_MODE));
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
