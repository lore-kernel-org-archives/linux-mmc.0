From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 12/21] mmc: sdhci-bcm-kona: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:08:19 +0800
Message-ID: <1453871299-3806-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Ray Jui <rjui@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-mmc@vger.kernel.org

If MMC_CAP_NONREMOVABLE is provided, SDHCI_QUIRK_BROKEN_CARD_DETECTION
is redunant.

Cc: Ray Jui <rjui@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-bcm-kona.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 00a8a40..2bd541f0 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -269,9 +269,6 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
 		(mmc_gpio_get_cd(host->mmc) != -ENOSYS) ? 'Y' : 'N',
 		(mmc_gpio_get_ro(host->mmc) != -ENOSYS) ? 'Y' : 'N');
 
-	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
-		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-
 	dev_dbg(dev, "is_8bit=%c\n",
 		(host->mmc->caps & MMC_CAP_8_BIT_DATA) ? 'Y' : 'N');
 
-- 
2.3.7
