From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mmc: sdhci: query card presence from cd-gpio before asking SDHCI
Date: Tue, 11 Dec 2012 15:23:42 +0800
Message-ID: <1355210622-9753-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:31200
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751240Ab2LKHXq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 02:23:46 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Call mmc_gpio_get_cd() to query card presence from cd-gpio before
asking SDHCI.  The rationale behind this change is that flag
SDHCI_QUIRK_BROKEN_CARD_DETECTION is designed for SDHCI controller to
tell that SDHCI_PRESENT_STATE is broken, and it should be used for this
case only.  So when cd-gpio is being used, the controller should set
the flag to tell that SDHCI_PRESENT_STATE is not available.

However, the existing code will skip checking cd-gpio as long as flag
SDHCI_QUIRK_BROKEN_CARD_DETECTION is set.  Change the querying order
between cd-gpio and SDHCI to support the rationale above.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0d2dbf8..037bd55 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1258,7 +1258,7 @@ static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host;
-	bool present;
+	int present;
 	unsigned long flags;
 	u32 tuning_opcode;
 
@@ -1287,18 +1287,21 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	host->mrq = mrq;
 
-	/* If polling, assume that the card is always present. */
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
-		present = true;
-	else
-		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
-				SDHCI_CARD_PRESENT;
-
-	/* If we're using a cd-gpio, testing the presence bit might fail. */
-	if (!present) {
-		int ret = mmc_gpio_get_cd(host->mmc);
-		if (ret > 0)
-			present = true;
+	/*
+	 * Firstly check card presence from cd-gpio.  The return could
+	 * be one of the following possibilities:
+	 *     negative: cd-gpio is not available
+	 *     zero: cd-gpio is used, and card is removed
+	 *     one: cd-gpio is used, and card is present
+	 */
+	present = mmc_gpio_get_cd(host->mmc);
+	if (present < 0) {
+		/* If polling, assume that the card is always present. */
+		if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+			present = 1;
+		else
+			present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
+					SDHCI_CARD_PRESENT;
 	}
 
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
-- 
1.7.9.5


