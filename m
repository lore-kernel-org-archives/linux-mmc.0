From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: sdhci-of-at91: fix card detect when using runtime PM
Date: Thu, 11 Feb 2016 14:48:57 +0100
Message-ID: <1455198537-21791-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:52379 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbcBKNtI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 08:49:08 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, adrian.hunter@intel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Add quirk broken card detection to enable card detection polling. It is
a short term solution until reworking PM stuff.

If the card detect signal is connected to the sdhci controller and not a
gpio, when runtime PM suspend happens, we have no way to wake up on a card
detect event since these irqs are no more enabled.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: f5f17813ae9b ("mmc: sdhci-of-at91: add PM support")
---
 drivers/mmc/host/sdhci-of-at91.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 9cb86fb..efec736 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -45,6 +45,7 @@ static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
 
 static const struct sdhci_pltfm_data soc_data_sama5d2 = {
 	.ops = &sdhci_at91_sama5d2_ops,
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
 	.quirks2 = SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST,
 };
 
-- 
2.7.0

