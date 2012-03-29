From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] mmc: sdhci-pci: add quirks for broken MSI on O2Micro controllers
Date: Thu, 29 Mar 2012 19:05:04 +0200
Message-ID: <1333040704-2179-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:51149 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab2C2RFR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Mar 2012 13:05:17 -0400
Received: by wibhr17 with SMTP id hr17so219186wib.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Mar 2012 10:05:16 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Manuel Lauss <manuel.lauss@googlemail.com>

MSI on my O2Micro OZ600 SD card reader is broken.  This patch adds a quirk
to disable MSI on these controllers.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/mmc/host/sdhci-pci.c |    4 +++-
 include/linux/mmc/sdhci.h    |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index fbbebe2..9303f7f 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -561,6 +561,7 @@ static int jmicron_resume(struct sdhci_pci_chip *chip)
 
 static const struct sdhci_pci_fixes sdhci_o2 = {
 	.probe		= o2_probe,
+	.quirks2	= SDHCI_QUIRK2_BROKEN_MSI,
 };
 
 static const struct sdhci_pci_fixes sdhci_jmicron = {
@@ -1418,7 +1419,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 
 	slots = chip->num_slots;	/* Quirk may have changed this */
 
-	pci_enable_msi(pdev);
+	if (!(chip->quirks2 & SDHCI_QUIRK2_BROKEN_MSI))
+		pci_enable_msi(pdev);
 
 	for (i = 0; i < slots; i++) {
 		slot = sdhci_pci_probe_slot(pdev, chip, first_bar, i);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e9051e1..9752fe4 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -91,6 +91,8 @@ struct sdhci_host {
 	unsigned int quirks2;	/* More deviations from spec. */
 
 #define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
+/* broken MSI Interrupts */
+#define SDHCI_QUIRK2_BROKEN_MSI				(1<<1)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.7.8.5

