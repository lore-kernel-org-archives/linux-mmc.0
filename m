From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] mmc: sdhci-pci: simplify error handling
Date: Sat, 03 Dec 2011 15:28:05 +0800
Message-ID: <1322897285.3884.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43377 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1LCH2Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 3 Dec 2011 02:28:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/mmc/host/sdhci-pci.c |   38 ++++++++++++++++++--------------------
 1 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 6878a94..d2e77fb 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1012,11 +1012,8 @@ static int sdhci_pci_suspend(struct device *dev)
 
 		ret = sdhci_suspend_host(slot->host);
 
-		if (ret) {
-			for (i--; i >= 0; i--)
-				sdhci_resume_host(chip->slots[i]->host);
-			return ret;
-		}
+		if (ret)
+			goto err_pci_suspend;
 
 		slot_pm_flags = slot->host->mmc->pm_flags;
 		if (slot_pm_flags & MMC_PM_WAKE_SDIO_IRQ)
@@ -1027,11 +1024,8 @@ static int sdhci_pci_suspend(struct device *dev)
 
 	if (chip->fixes && chip->fixes->suspend) {
 		ret = chip->fixes->suspend(chip);
-		if (ret) {
-			for (i = chip->num_slots - 1; i >= 0; i--)
-				sdhci_resume_host(chip->slots[i]->host);
-			return ret;
-		}
+		if (ret)
+			goto err_pci_suspend;
 	}
 
 	pci_save_state(pdev);
@@ -1048,6 +1042,11 @@ static int sdhci_pci_suspend(struct device *dev)
 	}
 
 	return 0;
+
+err_pci_suspend:
+	while (--i >= 0)
+		sdhci_resume_host(chip->slots[i]->host);
+	return ret;
 }
 
 static int sdhci_pci_resume(struct device *dev)
@@ -1113,23 +1112,22 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
 
 		ret = sdhci_runtime_suspend_host(slot->host);
 
-		if (ret) {
-			for (i--; i >= 0; i--)
-				sdhci_runtime_resume_host(chip->slots[i]->host);
-			return ret;
-		}
+		if (ret)
+			goto err_pci_runtime_suspend;
 	}
 
 	if (chip->fixes && chip->fixes->suspend) {
 		ret = chip->fixes->suspend(chip);
-		if (ret) {
-			for (i = chip->num_slots - 1; i >= 0; i--)
-				sdhci_runtime_resume_host(chip->slots[i]->host);
-			return ret;
-		}
+		if (ret)
+			goto err_pci_runtime_suspend;
 	}
 
 	return 0;
+
+err_pci_runtime_suspend:
+	while (--i >= 0)
+		sdhci_runtime_resume_host(chip->slots[i]->host);
+	return ret;
 }
 
 static int sdhci_pci_runtime_resume(struct device *dev)
-- 
1.7.5.4



