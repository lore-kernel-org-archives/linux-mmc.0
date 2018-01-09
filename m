From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RESEND 7/9] mmc: sdhci: Do not unnecessarily enable wakeup for SDIO card interrupt
Date: Tue,  9 Jan 2018 09:52:24 +0200
Message-ID: <1515484346-800-8-git-send-email-adrian.hunter@intel.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46300 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755127AbeAIHxP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 9 Jan 2018 02:53:15 -0500
In-Reply-To: <1515484346-800-1-git-send-email-adrian.hunter@intel.com>
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
index f16df253cc59..c82fd16dd14e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2842,8 +2842,13 @@ static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
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

