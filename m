From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 16/21] mmc: sdhci-of-esdhc: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:08:55 +0800
Message-ID: <1453871335-3970-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, yangbo lu <yangbo.lu@freescale.com>
List-Id: linux-mmc@vger.kernel.org

This patch just remove SDHCI_QUIRK_BROKEN_CARD_DETECTION, and
use MMC_CAP_NEEDS_POLL if needed.

Cc: yangbo lu <yangbo.lu@freescale.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-esdhc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7fc0edc..df4fa8b 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -549,16 +549,16 @@ static const struct sdhci_ops sdhci_esdhc_le_ops = {
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_be_pdata = {
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
-		| SDHCI_QUIRK_NO_CARD_NO_RESET
-		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks = ESDHC_DEFAULT_QUIRKS |
+		  SDHCI_QUIRK_NO_CARD_NO_RESET |
+		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.ops = &sdhci_esdhc_be_ops,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_le_pdata = {
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
-		| SDHCI_QUIRK_NO_CARD_NO_RESET
-		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks = ESDHC_DEFAULT_QUIRKS |
+		  SDHCI_QUIRK_NO_CARD_NO_RESET |
+		  SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.ops = &sdhci_esdhc_le_ops,
 };
 
@@ -595,6 +595,8 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	else
 		host = sdhci_pltfm_init(pdev, &sdhci_esdhc_be_pdata, 0);
 
+	host->mmc->caps |= MMC_CAP_NEEDS_POLL;
+
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
@@ -618,7 +620,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,p1020-esdhc") ||
 	    of_device_is_compatible(np, "fsl,t1040-esdhc") ||
 	    of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
-		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		host->caps &= ~MMC_CAP_NEEDS_POLL;
 
 	if (of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
-- 
2.3.7
