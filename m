From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 10/31] mmc: sdhci: plug hole in disabling card detection
 interrupts
Date: Tue, 18 Feb 2014 15:09:53 +0000
Message-ID: <E1WFmIz-0006mP-T5@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40465 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755906AbaBRPJz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:09:55 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

When we disable card detection interrupts, we should disable both the
insert and remove interrupts irrespective of the current state - this
avoids races between the hardware card detect changing state before
we've read that updated state and altered the interrupt mask.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 84cd0fd820d9..5fe211dfb792 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -133,20 +133,21 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
-	u32 present, irqs;
=+DO NOT APPLY+=	u32 present;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
 	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
 		return;
 
-	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
-			      SDHCI_CARD_PRESENT;
-	irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
=+DO NOT APPLY+=	if (enable) {
=+DO NOT APPLY+=		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
=+DO NOT APPLY+=				      SDHCI_CARD_PRESENT;
 
-	if (enable)
-		host->ier |= irqs;
-	else
-		host->ier &= ~irqs;
=+DO NOT APPLY+=		host->ier |= present ? SDHCI_INT_CARD_REMOVE :
=+DO NOT APPLY+=				       SDHCI_INT_CARD_INSERT;
=+DO NOT APPLY+=	} else {
=+DO NOT APPLY+=		host->ier &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
=+DO NOT APPLY+=	}
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
-- 
1.8.3.1

