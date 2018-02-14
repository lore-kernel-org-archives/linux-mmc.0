From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 1/4] mmc: sdhci: Do not unnecessarily enable wakeup for card detect interrupt
Date: Wed, 14 Feb 2018 14:56:29 +0200
Message-ID: <1518612992-4951-2-git-send-email-adrian.hunter@intel.com>
References: <1518612992-4951-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11167 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967589AbeBNM5R (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Feb 2018 07:57:17 -0500
In-Reply-To: <1518612992-4951-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

Do not unnecessarily enable card detect wakeup in the cases that the card
is not removable or a GPIO is used for card detect.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2020e57ffa7e..c2653347bb5e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2899,6 +2899,14 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 \*****************************************************************************/
 
 #ifdef CONFIG_PM
+
+static bool sdhci_cd_irq_can_wakeup(struct sdhci_host *host)
+{
+	return mmc_card_is_removable(host->mmc) &&
+	       !(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
+	       host->mmc->slot.cd_irq < 0;
+}
+
 /*
  * To enable wakeup events, the corresponding events have to be enabled in
  * the Interrupt Status Enable register too. See 'Table 1-6: Wakeup Signal
@@ -2915,7 +2923,7 @@ static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
 	u8 wake_val = 0;
 	u8 val;
 
-	if (!(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)) {
+	if (sdhci_cd_irq_can_wakeup(host)) {
 		wake_val |= SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE;
 		irq_val |= SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE;
 	}
-- 
1.9.1

