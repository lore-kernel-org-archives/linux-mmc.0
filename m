From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 5/8] mmc: sdhci-msm: configure CORE_CSR_CDC_DELAY_CFG to recommended value
Date: Wed, 28 Dec 2016 16:36:28 +0530
Message-ID: <1482923191-17362-6-git-send-email-riteshh@codeaurora.org>
References: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482923191-17362-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

Program CORE_CSR_CDC_DELAY_CFG for hardware recommended 1.25ns delay.
We may see data CRC errors if it's programmed for any other delay
value.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index a028568..84d29dd 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -679,7 +679,7 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
 	writel_relaxed(0x4, host->ioaddr + CORE_CSR_CDC_CAL_TIMER_CFG1);
 	writel_relaxed(0xCB732020, host->ioaddr + CORE_CSR_CDC_REFCOUNT_CFG);
 	writel_relaxed(0xB19, host->ioaddr + CORE_CSR_CDC_COARSE_CAL_CFG);
-	writel_relaxed(0x3AC, host->ioaddr + CORE_CSR_CDC_DELAY_CFG);
+	writel_relaxed(0x4E2, host->ioaddr + CORE_CSR_CDC_DELAY_CFG);
 	writel_relaxed(0x0, host->ioaddr + CORE_CDC_OFFSET_CFG);
 	writel_relaxed(0x16334, host->ioaddr + CORE_CDC_SLAVE_DDA_CFG);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
