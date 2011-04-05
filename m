From: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH] mmc: sdhci-pci: Fix checkpatch.pl errors
Date: Tue,  5 Apr 2011 21:13:13 +0300
Message-ID: <1302027193-15696-1-git-send-email-2ameya@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45510 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab1DESNU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 14:13:20 -0400
Received: by ewy4 with SMTP id 4so203194ewy.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 11:13:19 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This patch fixes 21 errors and 6 warnings reported by checkpatch.pl

Signed-off-by: Ameya Palande <2ameya@gmail.com>
---
 drivers/mmc/host/sdhci-pci.c |   44 ++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index a136be7..96623e1 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -18,11 +18,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/device.h>
-
 #include <linux/mmc/host.h>
-
-#include <asm/scatterlist.h>
-#include <asm/io.h>
+#include <linux/scatterlist.h>
+#include <linux/io.h>
 
 #include "sdhci.h"
 
@@ -46,14 +44,14 @@ struct sdhci_pci_slot;
 struct sdhci_pci_fixes {
 	unsigned int		quirks;
 
-	int			(*probe)(struct sdhci_pci_chip*);
+	int			(*probe) (struct sdhci_pci_chip *);
 
-	int			(*probe_slot)(struct sdhci_pci_slot*);
-	void			(*remove_slot)(struct sdhci_pci_slot*, int);
+	int			(*probe_slot) (struct sdhci_pci_slot *);
+	void			(*remove_slot) (struct sdhci_pci_slot *, int);
 
-	int			(*suspend)(struct sdhci_pci_chip*,
+	int			(*suspend) (struct sdhci_pci_chip *,
 					pm_message_t);
-	int			(*resume)(struct sdhci_pci_chip*);
+	int			(*resume) (struct sdhci_pci_chip *);
 };
 
 struct sdhci_pci_slot {
@@ -402,7 +400,7 @@ static int jmicron_suspend(struct sdhci_pci_chip *chip, pm_message_t state)
 
 	if (chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB38X_MMC ||
 	    chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB388_ESD) {
-		for (i = 0;i < chip->num_slots;i++)
+		for (i = 0; i < chip->num_slots; i++)
 			jmicron_enable_mmc(chip->slots[i]->host, 0);
 	}
 
@@ -415,7 +413,7 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 
 	if (chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB38X_MMC ||
 	    chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB388_ESD) {
-		for (i = 0;i < chip->num_slots;i++)
+		for (i = 0; i < chip->num_slots; i++)
 			jmicron_enable_mmc(chip->slots[i]->host, 1);
 	}
 
@@ -798,7 +796,7 @@ static struct sdhci_ops sdhci_pci_ops = {
 
 #ifdef CONFIG_PM
 
-static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
+static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
@@ -810,7 +808,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 	if (!chip)
 		return 0;
 
-	for (i = 0;i < chip->num_slots;i++) {
+	for (i = 0; i < chip->num_slots; i++) {
 		slot = chip->slots[i];
 		if (!slot)
 			continue;
@@ -818,7 +816,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 		ret = sdhci_suspend_host(slot->host, state);
 
 		if (ret) {
-			for (i--;i >= 0;i--)
+			for (i--; i >= 0; i--)
 				sdhci_resume_host(chip->slots[i]->host);
 			return ret;
 		}
@@ -833,7 +831,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 	if (chip->fixes && chip->fixes->suspend) {
 		ret = chip->fixes->suspend(chip, state);
 		if (ret) {
-			for (i = chip->num_slots - 1;i >= 0;i--)
+			for (i = chip->num_slots - 1; i >= 0; i--)
 				sdhci_resume_host(chip->slots[i]->host);
 			return ret;
 		}
@@ -855,7 +853,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
-static int sdhci_pci_resume (struct pci_dev *pdev)
+static int sdhci_pci_resume(struct pci_dev *pdev)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
@@ -877,7 +875,7 @@ static int sdhci_pci_resume (struct pci_dev *pdev)
 			return ret;
 	}
 
-	for (i = 0;i < chip->num_slots;i++) {
+	for (i = 0; i < chip->num_slots; i++) {
 		slot = chip->slots[i];
 		if (!slot)
 			continue;
@@ -1058,7 +1056,7 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 	}
 
 	chip->pdev = pdev;
-	chip->fixes = (const struct sdhci_pci_fixes*)ent->driver_data;
+	chip->fixes = (const struct sdhci_pci_fixes *)ent->driver_data;
 	if (chip->fixes)
 		chip->quirks = chip->fixes->quirks;
 	chip->num_slots = slots;
@@ -1073,10 +1071,10 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 
 	slots = chip->num_slots;	/* Quirk may have changed this */
 
-	for (i = 0;i < slots;i++) {
+	for (i = 0; i < slots; i++) {
 		slot = sdhci_pci_probe_slot(pdev, chip, first_bar + i);
 		if (IS_ERR(slot)) {
-			for (i--;i >= 0;i--)
+			for (i--; i >= 0; i--)
 				sdhci_pci_remove_slot(chip->slots[i]);
 			ret = PTR_ERR(slot);
 			goto free;
@@ -1104,7 +1102,7 @@ static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
 	chip = pci_get_drvdata(pdev);
 
 	if (chip) {
-		for (i = 0;i < chip->num_slots; i++)
+		for (i = 0; i < chip->num_slots; i++)
 			sdhci_pci_remove_slot(chip->slots[i]);
 
 		pci_set_drvdata(pdev, NULL);
@@ -1115,9 +1113,9 @@ static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
 }
 
 static struct pci_driver sdhci_driver = {
-	.name = 	"sdhci-pci",
+	.name =		"sdhci-pci",
 	.id_table =	pci_ids,
-	.probe = 	sdhci_pci_probe,
+	.probe =	sdhci_pci_probe,
 	.remove =	__devexit_p(sdhci_pci_remove),
 	.suspend =	sdhci_pci_suspend,
 	.resume	=	sdhci_pci_resume,
-- 
1.7.1

