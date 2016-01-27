From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 19/21] mmc: sdhci-pxav2: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:09:22 +0800
Message-ID: <1453871362-4093-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

It already claims MMC_CAP_NONREMOVABLE, so we just remove the
quirk here since we don't need non-removeble and broken-cd together.

Cc: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-pxav2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index beffd86..8aa2c31 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -199,7 +199,6 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	if (pdata) {
 		if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
 			/* on-chip device */
-			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 			host->mmc->caps |= MMC_CAP_NONREMOVABLE;
 		}
 
-- 
2.3.7
