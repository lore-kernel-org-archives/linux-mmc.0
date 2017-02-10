From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 37/39] mmc: sdhci-pci: Add runtime suspend/resume callbacks
Date: Fri, 10 Feb 2017 14:55:50 +0200
Message-ID: <1486731352-8018-38-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:35955 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbdBJNMK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:12:10 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Add runtime suspend/resume callbacks to match suspend/resume callbacks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 85 +++++++++++++++++++++++----------------
 drivers/mmc/host/sdhci-pci.h      |  4 ++
 2 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 7c3c63a03dfc..ca7c06508dcd 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -117,6 +117,49 @@ int sdhci_pci_resume_host(struct sdhci_pci_chip *chip)
 }
 #endif
 
+#ifdef CONFIG_PM
+static int sdhci_pci_runtime_suspend_host(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot;
+	int i, ret;
+
+	for (i = 0; i < chip->num_slots; i++) {
+		slot = chip->slots[i];
+		if (!slot)
+			continue;
+
+		ret = sdhci_runtime_suspend_host(slot->host);
+		if (ret)
+			goto err_pci_runtime_suspend;
+	}
+
+	return 0;
+
+err_pci_runtime_suspend:
+	while (--i >= 0)
+		sdhci_runtime_resume_host(chip->slots[i]->host);
+	return ret;
+}
+
+static int sdhci_pci_runtime_resume_host(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot;
+	int i, ret;
+
+	for (i = 0; i < chip->num_slots; i++) {
+		slot = chip->slots[i];
+		if (!slot)
+			continue;
+
+		ret = sdhci_runtime_resume_host(slot->host);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
 /*****************************************************************************\
  *                                                                           *
  * Hardware specific quirk handling                                          *
@@ -1769,55 +1812,29 @@ static int sdhci_pci_resume(struct device *dev)
 static int sdhci_pci_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip;
-	struct sdhci_pci_slot *slot;
-	int i, ret;
+	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
 
-	chip = pci_get_drvdata(pdev);
 	if (!chip)
 		return 0;
 
-	for (i = 0; i < chip->num_slots; i++) {
-		slot = chip->slots[i];
-		if (!slot)
-			continue;
-
-		ret = sdhci_runtime_suspend_host(slot->host);
-
-		if (ret)
-			goto err_pci_runtime_suspend;
-	}
-
-	return 0;
+	if (chip->fixes && chip->fixes->runtime_suspend)
+		return chip->fixes->runtime_suspend(chip);
 
-err_pci_runtime_suspend:
-	while (--i >= 0)
-		sdhci_runtime_resume_host(chip->slots[i]->host);
-	return ret;
+	return sdhci_pci_runtime_suspend_host(chip);
 }
 
 static int sdhci_pci_runtime_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct sdhci_pci_chip *chip;
-	struct sdhci_pci_slot *slot;
-	int i, ret;
+	struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
 
-	chip = pci_get_drvdata(pdev);
 	if (!chip)
 		return 0;
 
-	for (i = 0; i < chip->num_slots; i++) {
-		slot = chip->slots[i];
-		if (!slot)
-			continue;
-
-		ret = sdhci_runtime_resume_host(slot->host);
-		if (ret)
-			return ret;
-	}
+	if (chip->fixes && chip->fixes->runtime_resume)
+		return chip->fixes->runtime_resume(chip);
 
-	return 0;
+	return sdhci_pci_runtime_resume_host(chip);
 }
 #endif
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 182c95894768..edf9b6963fd6 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -71,6 +71,10 @@ struct sdhci_pci_fixes {
 	int			(*suspend) (struct sdhci_pci_chip *);
 	int			(*resume) (struct sdhci_pci_chip *);
 #endif
+#ifdef CONFIG_PM
+	int			(*runtime_suspend) (struct sdhci_pci_chip *);
+	int			(*runtime_resume) (struct sdhci_pci_chip *);
+#endif
 
 	const struct sdhci_ops	*ops;
 };
-- 
1.9.1

