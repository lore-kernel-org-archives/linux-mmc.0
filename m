From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCHv1 2/2] mmc: sdhci-msm: Remove unnecessary comments of CDC init sequence
Date: Tue, 24 Jan 2017 14:20:27 +0530
Message-ID: <1485247827-12898-3-git-send-email-riteshh@codeaurora.org>
References: <1485247827-12898-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1485247827-12898-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This removes CDC init sequence comments which are
not useful anyway.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b3e8f44..10cdc84 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -664,19 +664,7 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
 	config &= ~CORE_START_CDC_TRAFFIC;
 	writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
 
-	/*
-	 * Perform CDC Register Initialization Sequence
-	 *
-	 * CORE_CSR_CDC_CTLR_CFG0	0x11800EC
-	 * CORE_CSR_CDC_CTLR_CFG1	0x3011111
-	 * CORE_CSR_CDC_CAL_TIMER_CFG0	0x1201000
-	 * CORE_CSR_CDC_CAL_TIMER_CFG1	0x4
-	 * CORE_CSR_CDC_REFCOUNT_CFG	0xCB732020
-	 * CORE_CSR_CDC_COARSE_CAL_CFG	0xB19
-	 * CORE_CSR_CDC_DELAY_CFG	0x3AC
-	 * CORE_CDC_OFFSET_CFG		0x0
-	 * CORE_CDC_SLAVE_DDA_CFG	0x16334
-	 */
+	/* Perform CDC Register Initialization Sequence */
 
 	writel_relaxed(0x11800EC, host->ioaddr + CORE_CSR_CDC_CTLR_CFG0);
 	writel_relaxed(0x3011111, host->ioaddr + CORE_CSR_CDC_CTLR_CFG1);
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
