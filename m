From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Subject: [RFC 2/4] sdhci: sanity check for triggering interrupts thread
Date: Fri, 18 Mar 2011 15:11:58 -0700
Message-ID: <1300486320-23607-3-git-send-email-lrodriguez@atheros.com>
References: <1300486320-23607-1-git-send-email-lrodriguez@atheros.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atheros.com ([12.19.149.2]:44357 "EHLO mail.atheros.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932908Ab1CRWMN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Mar 2011 18:12:13 -0400
In-Reply-To: <1300486320-23607-1-git-send-email-lrodriguez@atheros.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, vmehta@atheros.com, naveen.singh@atheros.com, kvalo@adurom.com, j@w1.fi, "Luis R. Rodriguez" <lrodriguez@atheros.com>, Naveen Singh <nsingh@atheros.com>, Vipin Mehta <Vipin.Mehta@atheros.com>

Instead of just assuming an interrupt is pending and
processing it, ensure we have interrupts enabled first
prior to calling our IRQ thread processor.

Cc: Chris Ball <cjb@laptop.org>
Cc: Kalle Valo <kvalo@adurom.com>
Cc: Naveen Singh <nsingh@atheros.com>
Cc: Vipin Mehta <Vipin.Mehta@atheros.com>
Signed-off-by: Luis R. Rodriguez <lrodriguez@atheros.com>
---
 drivers/mmc/host/sdhci.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c95dfc2..7074870 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1616,8 +1616,11 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	intmask &= ~SDHCI_INT_BUS_POWER;
 
-	if (intmask & SDHCI_INT_CARD_INT)
-		cardint = 1;
+	if (intmask & SDHCI_INT_CARD_INT) {
+		if (readl(host->ioaddr + SDHCI_INT_ENABLE) & SDHCI_INT_CARD_INT)
+			cardint = 1;
+	}
+
 
 	intmask &= ~SDHCI_INT_CARD_INT;
 
-- 
1.7.4.15.g7811d

