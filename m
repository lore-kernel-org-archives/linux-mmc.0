From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 7/9] mmc: sdhci: Do not unnecessarily enable wakeup for SDIO card interrupt
Date: Wed, 20 Dec 2017 10:18:51 +0200
Message-ID: <1513757933-11232-8-git-send-email-adrian.hunter@intel.com>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36192 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932260AbdLTITb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Dec 2017 03:19:31 -0500
In-Reply-To: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

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

