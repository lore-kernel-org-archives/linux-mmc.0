From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 6/7] sdhci_pci: Tidy this as well
Date: Mon, 13 Sep 2010 18:39:51 +0100
Message-ID: <20100913173948.20345.65227.stgit@localhost.localdomain>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56992 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785Ab0IMSYX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 14:24:23 -0400
In-Reply-To: <20100913172738.20345.61119.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

While doing the tidy up of the new stuff might as well tidy the old
---

 drivers/mmc/host/sdhci-pci.c |   48 ++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 23 deletions(-)


diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index bb14047..9692eab 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -21,8 +21,8 @@
 
 #include <linux/mmc/host.h>
 
-#include <asm/scatterlist.h>
-#include <asm/io.h>
+#include <linux/scatterlist.h>
+#include <linux/io.h>
 
 #include "sdhci.h"
 
@@ -46,14 +46,14 @@ struct sdhci_pci_slot;
 struct sdhci_pci_fixes {
 	unsigned int		quirks;
 
-	int			(*probe)(struct sdhci_pci_chip*);
+	int			(*probe)(struct sdhci_pci_chip *);
 
-	int			(*probe_slot)(struct sdhci_pci_slot*);
-	void			(*remove_slot)(struct sdhci_pci_slot*, int);
+	int			(*probe_slot)(struct sdhci_pci_slot *);
+	void			(*remove_slot)(struct sdhci_pci_slot *, int);
 
-	int			(*suspend)(struct sdhci_pci_chip*,
+	int			(*suspend)(struct sdhci_pci_chip *,
 					pm_message_t);
-	int			(*resume)(struct sdhci_pci_chip*);
+	int			(*resume)(struct sdhci_pci_chip *);
 
 	/* Allow the driver to override some operations for particularly
 	   quirky chips */
@@ -287,7 +287,7 @@ static int jmicron_suspend(struct sdhci_pci_chip *chip, pm_message_t state)
 	int i;
 
 	if (chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB38X_MMC) {
-		for (i = 0;i < chip->num_slots;i++)
+		for (i = 0; i < chip->num_slots; i++)
 			jmicron_enable_mmc(chip->slots[i]->host, 0);
 	}
 
@@ -299,7 +299,7 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 	int ret, i;
 
 	if (chip->pdev->device == PCI_DEVICE_ID_JMICRON_JMB38X_MMC) {
-		for (i = 0;i < chip->num_slots;i++)
+		for (i = 0; i < chip->num_slots; i++)
 			jmicron_enable_mmc(chip->slots[i]->host, 1);
 	}
 
@@ -401,7 +401,8 @@ static const struct sdhci_pci_fixes sdhci_via = {
 	.probe		= via_probe,
 };
 
-#if defined(CONFIG_MMC_SDHCI_INTEL_MID) || defined(CONFIG_MMC_SDHCI_INTEL_MID_MODULE)
+#if defined(CONFIG_MMC_SDHCI_INTEL_MID) || \
+		defined(CONFIG_MMC_SDHCI_INTEL_MID_MODULE)
 
 /*
  * ADMA operation is disabled for Moorestown platform due to
@@ -536,7 +537,8 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 		.driver_data	= (kernel_ulong_t)&sdhci_via,
 	},
 
-#if defined(CONFIG_MMC_SDHCI_INTEL_MID) || defined(CONFIG_MMC_SDHCI_INTEL_MID_MODULE)
+#if defined(CONFIG_MMC_SDHCI_INTEL_MID) || \
+			defined(CONFIG_MMC_SDHCI_INTEL_MID_MODULE)
 	{
 		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_MRST_SD0,
@@ -646,7 +648,7 @@ static struct sdhci_ops sdhci_pci_ops = {
 
 #ifdef CONFIG_PM
 
-static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
+static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
@@ -657,7 +659,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 	if (!chip)
 		return 0;
 
-	for (i = 0;i < chip->num_slots;i++) {
+	for (i = 0; i < chip->num_slots; i++) {
 		slot = chip->slots[i];
 		if (!slot)
 			continue;
@@ -665,7 +667,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 		ret = sdhci_suspend_host(slot->host, state);
 
 		if (ret) {
-			for (i--;i >= 0;i--)
+			for (i--; i >= 0; i--)
 				sdhci_resume_host(chip->slots[i]->host);
 			return ret;
 		}
@@ -676,7 +678,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 	if (chip->fixes && chip->fixes->suspend) {
 		ret = chip->fixes->suspend(chip, state);
 		if (ret) {
-			for (i = chip->num_slots - 1;i >= 0;i--)
+			for (i = chip->num_slots - 1; i >= 0; i--)
 				sdhci_resume_host(chip->slots[i]->host);
 			return ret;
 		}
@@ -696,7 +698,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
-static int sdhci_pci_resume (struct pci_dev *pdev)
+static int sdhci_pci_resume(struct pci_dev *pdev)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
@@ -718,7 +720,7 @@ static int sdhci_pci_resume (struct pci_dev *pdev)
 			return ret;
 	}
 
-	for (i = 0;i < chip->num_slots;i++) {
+	for (i = 0; i < chip->num_slots; i++) {
 		slot = chip->slots[i];
 		if (!slot)
 			continue;
@@ -908,7 +910,7 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 	}
 
 	chip->pdev = pdev;
-	chip->fixes = (const struct sdhci_pci_fixes*)ent->driver_data;
+	chip->fixes = (const struct sdhci_pci_fixes *)ent->driver_data;
 	if (chip->fixes)
 		chip->quirks = chip->fixes->quirks;
 	chip->num_slots = slots;
@@ -923,10 +925,10 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 
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
@@ -954,7 +956,7 @@ static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
 	chip = pci_get_drvdata(pdev);
 
 	if (chip) {
-		for (i = 0;i < chip->num_slots; i++)
+		for (i = 0; i < chip->num_slots; i++)
 			sdhci_pci_remove_slot(chip->slots[i]);
 
 		pci_set_drvdata(pdev, NULL);
@@ -965,9 +967,9 @@ static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
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

