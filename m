From: <r66093@freescale.com>
Subject: [PATCH] powerpc/esdhc: enable the card insert/remove interrupt
Date: Tue, 23 Oct 2012 15:01:17 +0800
Message-ID: <1350975677-8195-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:27213
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752355Ab2JWHm0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Oct 2012 03:42:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

The current eSDHC driver use the poll mode to detect
if the SD/MMC card is inserted or removed, which will generate
many interrupts and impact the performance. 
Therefore, change the default card detect to interrupt mode,
if the board can't support this mode, we still use the poll mode.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index ffc1226..5dc362f 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -196,6 +196,11 @@ static void esdhc_of_detect_limitation(struct platform_device *pdev,
 	if (vvn == VENDOR_V_22)
 		pdata->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
 
+	/* P4080DS and MPC837XMDS board don't support interrupt mode */
+	if (of_machine_is_compatible("fsl,mpc837xmds") ||
+	    of_machine_is_compatible("fsl,P4080DS"))
+		pdata->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
 	iounmap(ioaddr);
 end:
 	return;
@@ -223,7 +228,7 @@ static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 	 * card detection could be handled via GPIO
 	 * eSDHC cannot support End Attribute in NOP ADMA descriptor
 	 */
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
+	.quirks = ESDHC_DEFAULT_QUIRKS
 		| SDHCI_QUIRK_NO_CARD_NO_RESET
 		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.ops = &sdhci_esdhc_ops,
-- 
1.7.9.5


