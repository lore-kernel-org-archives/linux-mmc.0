From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 2/4] mmc: sdhci: Do not unnecessarily enable wakeup for SDIO card interrupt
Date: Wed, 14 Feb 2018 14:56:30 +0200
Message-ID: <1518612992-4951-3-git-send-email-adrian.hunter@intel.com>
References: <1518612992-4951-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11167 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967724AbeBNM5T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Feb 2018 07:57:19 -0500
In-Reply-To: <1518612992-4951-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

Do not enable wakeup for SDIO card interrupt unless the SDIO function
driver has requested it which is indicated by mmc_card_wake_sdio_irq().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c2653347bb5e..565d24ccb2f2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2928,8 +2928,13 @@ static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
 		irq_val |= SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE;
 	}
 
-	wake_val |= SDHCI_WAKE_ON_INT;
-	irq_val |= SDHCI_INT_CARD_INT;
+	if (mmc_card_wake_sdio_irq(host->mmc)) {
+		wake_val |= SDHCI_WAKE_ON_INT;
+		irq_val |= SDHCI_INT_CARD_INT;
+	}
+
+	if (!irq_val)
+		return false;
 
 	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
 	val &= ~mask;
-- 
1.9.1

