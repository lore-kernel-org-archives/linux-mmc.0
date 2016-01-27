From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 20/21] mmc: sdhci-s3c: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:09:30 +0800
Message-ID: <1453871370-4134-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch remove SDHCI_QUIRK_BROKEN_CARD_DETECTION and use
MMC_CAP_NEEDS_POLL to claim "broken-cd".

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-s3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 70c724b..dd25767 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -571,7 +571,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 
 	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
 	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
-		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		host->mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->mmc->caps = MMC_CAP_NONREMOVABLE;
-- 
2.3.7
