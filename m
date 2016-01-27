From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 13/21] mmc: sdhci-bcm2835: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:08:29 +0800
Message-ID: <1453871309-3847-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>
List-Id: linux-mmc@vger.kernel.org

It seems SDHCI_QUIRK_BROKEN_CARD_DETECTION is a must quirk for
this driver, so we remove SDHCI_QUIRK_BROKEN_CARD_DETECTION and
add MMC_CAP_NEEDS_POLL for it.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-bcm2835.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 1c65d46..b34115c 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -140,8 +140,7 @@ static const struct sdhci_ops bcm2835_sdhci_ops = {
 };
 
 static const struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
-	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.ops = &bcm2835_sdhci_ops,
 };
 
@@ -156,6 +155,8 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
+	host->mmc->caps |= MMC_CAP_NEEDS_POLL;
+
 	bcm2835_host = devm_kzalloc(&pdev->dev, sizeof(*bcm2835_host),
 					GFP_KERNEL);
 	if (!bcm2835_host) {
-- 
2.3.7
