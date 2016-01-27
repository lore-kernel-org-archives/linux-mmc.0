From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 15/21] mmc: sdhci-msm: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:08:47 +0800
Message-ID: <1453871327-3929-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Georgi Djakov <georgi.djakov@linaro.org>
List-Id: linux-mmc@vger.kernel.org

We just replcae SDHCI_QUIRK_BROKEN_CARD_DETECTION with
MMC_CAP_NEEDS_POLL.

Cc: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index dfc6016..3274871 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -520,7 +520,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	/* Set HC_MODE_EN bit in HC_MODE register */
 	writel_relaxed(HC_MODE_EN, (msm_host->core_mem + CORE_HC_MODE));
 
-	host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+	host->mmc->caps |= MMC_CAP_NEEDS_POLL;
 	host->quirks |= SDHCI_QUIRK_SINGLE_POWER_WRITE;
 
 	host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
-- 
2.3.7
