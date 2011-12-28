From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH 2/2] mmc: sdhci: Deal with failure case in sdhci_suspend_host
Date: Wed, 28 Dec 2011 11:11:13 +0800
Message-ID: <1325041873-1320-3-git-send-email-aaron.lu@amd.com>
References: <1325041873-1320-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:15255
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753101Ab1L1DLq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Dec 2011 22:11:46 -0500
In-Reply-To: <1325041873-1320-1-git-send-email-aaron.lu@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Aaron Lu <aaron.lu@amd.com>

If there are errors happened in sdhci_suspend_host, handle it so that
when the function returns with error, the host's behaviour is the same
before this function call, e.g. card detection is enabled and tuning
timer is active, etc.

Previously, sdhci_suspend_host will return the error code and rely on
the calling function to handle it. sdhci-pci will handle it in
sdhci_pci_suspend while sdhci-platform code will not.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/host/sdhci-pci.c |    9 ++-------
 drivers/mmc/host/sdhci.c     |   27 +++++++++++++++++++++------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d2e77fb..494d14b 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1013,7 +1013,7 @@ static int sdhci_pci_suspend(struct device *dev)
 		ret = sdhci_suspend_host(slot->host);
 
 		if (ret)
-			goto err_pci_suspend;
+			return ret;
 
 		slot_pm_flags = slot->host->mmc->pm_flags;
 		if (slot_pm_flags & MMC_PM_WAKE_SDIO_IRQ)
@@ -1025,7 +1025,7 @@ static int sdhci_pci_suspend(struct device *dev)
 	if (chip->fixes && chip->fixes->suspend) {
 		ret = chip->fixes->suspend(chip);
 		if (ret)
-			goto err_pci_suspend;
+			return ret;
 	}
 
 	pci_save_state(pdev);
@@ -1042,11 +1042,6 @@ static int sdhci_pci_suspend(struct device *dev)
 	}
 
 	return 0;
-
-err_pci_suspend:
-	while (--i >= 0)
-		sdhci_resume_host(chip->slots[i]->host);
-	return ret;
 }
 
 static int sdhci_pci_resume(struct device *dev)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2007d37..37aeb81 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2339,25 +2339,40 @@ out:
 
 int sdhci_suspend_host(struct sdhci_host *host)
 {
-	int ret;
+	int ret, has_tuning_timer;
 
 	sdhci_disable_card_detection(host);
 
 	/* Disable tuning since we are suspending */
-	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
-	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
+	has_tuning_timer = host->version >= SDHCI_SPEC_300 &&
+		host->tuning_count && host->tuning_mode == SDHCI_TUNING_MODE_1;
+	if (has_tuning_timer) {
 		del_timer_sync(&host->tuning_timer);
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 	}
 
 	ret = mmc_suspend_host(host->mmc);
 	if (ret)
-		return ret;
+		goto err_suspend;
+
+	if (host->vmmc) {
+		ret = regulator_disable(host->vmmc);
+		if (ret)
+			goto err_suspend;
+	}
 
 	free_irq(host->irq, host);
 
-	if (host->vmmc)
-		ret = regulator_disable(host->vmmc);
+	return 0;
+
+err_suspend:
+	if (has_tuning_timer) {
+		host->flags |= SDHCI_NEEDS_RETUNING;
+		mod_timer(&host->tuning_timer, jiffies +
+				host->tuning_count * HZ);
+	}
+
+	sdhci_enable_card_detection(host);
 
 	return ret;
 }
-- 
1.7.7.4


