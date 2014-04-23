From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 08/38] mmc: sdhci: plug hole in disabling card detection
 interrupts
Date: Wed, 23 Apr 2014 20:06:51 +0100
Message-ID: <E1Wd2VP-0003um-2T@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46375 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932291AbaDWTGx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:06:53 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

When we disable card detection interrupts, we should disable both the
insert and remove interrupts irrespective of the current state - this
avoids races between the hardware card detect changing state before
we've read that updated state and altered the interrupt mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d568c8e4ee33..6b3ccd2d1f6c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -133,20 +133,21 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
-	u32 present, irqs;
+	u32 present;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
 	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
 		return;
 
-	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
-			      SDHCI_CARD_PRESENT;
-	irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
+	if (enable) {
+		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
+				      SDHCI_CARD_PRESENT;
 
-	if (enable)
-		host->ier |= irqs;
-	else
-		host->ier &= ~irqs;
+		host->ier |= present ? SDHCI_INT_CARD_REMOVE :
+				       SDHCI_INT_CARD_INSERT;
+	} else {
+		host->ier &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
+	}
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
-- 
1.8.3.1

