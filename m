From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] mmc: sdhci-bcm-kona: fix logic to check for 8-bit data width
Date: Wed, 16 Sep 2015 11:53:20 +0200
Message-ID: <1442397200-29731-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-mmc@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The driver prints if the data width is 8-bit but it's using a
binary OR instead of a binary AND so it will always report as
"is_8bit=Y" regardless of the flags in host->mmc->caps.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 2bd90fb35c75..00a8a40a3729 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -273,7 +273,7 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
 	dev_dbg(dev, "is_8bit=%c\n",
-		(host->mmc->caps | MMC_CAP_8_BIT_DATA) ? 'Y' : 'N');
+		(host->mmc->caps & MMC_CAP_8_BIT_DATA) ? 'Y' : 'N');
 
 	ret = sdhci_bcm_kona_sd_reset(host);
 	if (ret)
-- 
2.4.3
