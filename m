From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 6/9] mmc: sdhci: Do not unnecessarily enable wakeup for card detect interrupt
Date: Wed, 20 Dec 2017 10:18:50 +0200
Message-ID: <1513757933-11232-7-git-send-email-adrian.hunter@intel.com>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:36192 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932259AbdLTIT3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Dec 2017 03:19:29 -0500
In-Reply-To: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>

Do not unnecessarily enable card detect wakeup in the cases that the card
is not removable or a GPIO is used for card detect.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index dd922923019a..f16df253cc59 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2813,6 +2813,14 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
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
@@ -2829,7 +2837,7 @@ static bool sdhci_enable_irq_wakeups(struct sdhci_host *host)
 	u8 wake_val = 0;
 	u8 val;
 
-	if (!(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)) {
+	if (sdhci_cd_irq_can_wakeup(host)) {
 		wake_val |= SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE;
 		irq_val |= SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE;
 	}
-- 
1.9.1

