From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] mmc: sdhci-pci: move suspend/resume hooks to dev_pm_ops
Date: Tue,  1 Nov 2011 13:34:05 +0100
Message-ID: <1320150845-4185-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47614 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab1KAMeP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Nov 2011 08:34:15 -0400
Received: by bke11 with SMTP id 11so364526bke.19
        for <linux-mmc@vger.kernel.org>; Tue, 01 Nov 2011 05:34:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>

Move suspend/resume/freeze/thaw hooks from struct pci_driver to dev_pm_ops,
mainly to shut up the driver cores' complaints about this driver using
both new and legacy PM methods.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
I've only tested suspend to ram, but it works.

 drivers/mmc/host/sdhci-pci.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d833d9c..53bfbe7 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -993,7 +993,7 @@ static struct sdhci_ops sdhci_pci_ops = {
 
 #ifdef CONFIG_PM
 
-static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+static int sdhci_pci_do_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
@@ -1050,8 +1050,9 @@ static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
-static int sdhci_pci_resume(struct pci_dev *pdev)
+static int sdhci_pci_resume(struct device *dev)
 {
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
 	int i, ret;
@@ -1085,9 +1086,22 @@ static int sdhci_pci_resume(struct pci_dev *pdev)
 	return 0;
 }
 
+static int sdhci_pci_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	return sdhci_pci_do_suspend(pdev, PMSG_SUSPEND);
+}
+
+static int sdhci_pci_freeze(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	return sdhci_pci_do_suspend(pdev, PMSG_FREEZE);
+}
+
 #else /* CONFIG_PM */
 
 #define sdhci_pci_suspend NULL
+#define sdhci_pci_freeze NULL
 #define sdhci_pci_resume NULL
 
 #endif /* CONFIG_PM */
@@ -1176,6 +1190,10 @@ static int sdhci_pci_runtime_idle(struct device *dev)
 #endif
 
 static const struct dev_pm_ops sdhci_pci_pm_ops = {
+	.suspend = sdhci_pci_suspend,
+	.freeze = sdhci_pci_freeze,
+	.resume = sdhci_pci_resume,
+	.thaw = sdhci_pci_resume,
 	.runtime_suspend = sdhci_pci_runtime_suspend,
 	.runtime_resume = sdhci_pci_runtime_resume,
 	.runtime_idle = sdhci_pci_runtime_idle,
@@ -1428,8 +1446,6 @@ static struct pci_driver sdhci_driver = {
 	.id_table =	pci_ids,
 	.probe =	sdhci_pci_probe,
 	.remove =	__devexit_p(sdhci_pci_remove),
-	.suspend =	sdhci_pci_suspend,
-	.resume	=	sdhci_pci_resume,
 	.driver =	{
 		.pm =   &sdhci_pci_pm_ops
 	},
-- 
1.7.7.1

