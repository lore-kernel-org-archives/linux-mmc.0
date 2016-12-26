From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: remove default broken-cd for ARM
Date: Mon, 26 Dec 2016 17:40:44 +0800
Message-ID: <1482745244-24114-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-cys01nam02on0050.outbound.protection.outlook.com ([104.47.37.50]:21312
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750890AbcLZK04 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Dec 2016 05:26:56 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>

Initially all QorIQ platforms were PowerPC architecture and they didn't
support card detection except several platforms. The driver added the
quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION as default and this made broken-cd
property in dts node didn't work. Now QorIQ platform turns to ARM
architecture and most of them could support card detection. However it's
a large number of dts trees that need to be fixed with broken-cd if we
remove the default SDHCI_QUIRK_BROKEN_CARD_DETECTION in driver. And the
users don't want to see this. So this patch is to remove this default
quirk just for ARM and keep it for PowerPC.(Note, QorIQ PowerPC platform
only has big-endian eSDHC while QorIQ ARM platform has big-endian or
little-endian eSDHC) This makes broken-cd property work again for ARM.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 9a6eb44..364f6b8 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -569,16 +569,19 @@ static const struct sdhci_ops sdhci_esdhc_le_ops = {
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_be_pdata = {
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
-		| SDHCI_QUIRK_NO_CARD_NO_RESET
-		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks = ESDHC_DEFAULT_QUIRKS |
+#ifdef CONFIG_PPC
+		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+#endif
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
 
@@ -643,8 +646,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p1020-esdhc") ||
-	    of_device_is_compatible(np, "fsl,t1040-esdhc") ||
-	    of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
+	    of_device_is_compatible(np, "fsl,t1040-esdhc"))
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
 	if (of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
-- 
2.1.0.27.g96db324

