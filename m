From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH REPOST] mmc: bcm2835: set SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
Date: Fri,  8 Feb 2013 20:56:27 -0700
Message-ID: <1360382187-26296-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37022 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760623Ab3BID4f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Feb 2013 22:56:35 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>

SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK does basically the same as
implementing struct sdhci_ops .get_timeout_clock, so simply set that
quirk and remove the custom code to simplify the driver.

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 drivers/mmc/host/sdhci-bcm2835.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 453825f..21fc735 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -133,14 +133,6 @@ unsigned int bcm2835_sdhci_get_min_clock(struct sdhci_host *host)
 	return MIN_FREQ;
 }
 
-unsigned int bcm2835_sdhci_get_timeout_clock(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct bcm2835_sdhci *bcm2835_host = pltfm_host->priv;
-
-	return clk_get_rate(bcm2835_host->clk);
-}
-
 static struct sdhci_ops bcm2835_sdhci_ops = {
 	.write_l = bcm2835_sdhci_writel,
 	.write_w = bcm2835_sdhci_writew,
@@ -150,11 +142,11 @@ static struct sdhci_ops bcm2835_sdhci_ops = {
 	.read_b = bcm2835_sdhci_readb,
 	.get_max_clock = bcm2835_sdhci_get_max_clock,
 	.get_min_clock = bcm2835_sdhci_get_min_clock,
-	.get_timeout_clock = bcm2835_sdhci_get_timeout_clock,
 };
 
 static struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
-	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+			SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.ops = &bcm2835_sdhci_ops,
 };
 
-- 
1.7.10.4

