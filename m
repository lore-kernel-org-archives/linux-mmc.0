From: akpm@linux-foundation.org
Subject: [patch 116/160] mmc: enable DMA on Ricoh sdhci reader by default
Date: Fri, 05 Mar 2010 13:43:46 -0800
Message-ID: <201003052143.o25LhknS029867@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55964 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755565Ab0CEVoA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:44:00 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, anarsoul@gmail.com, HaraldWelte@viatech.com, linux-mmc@vger.kernel.org, maximlevitsky@gmail.com, preining@logic.at

From: Vasily Khoruzhick <anarsoul@gmail.com>

This card reader doesn't advertise, however DMA works well.  Probably
windows SDHCI driver assumes that all readers support DMA and thus we see
that bug.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Harald Welte <HaraldWelte@viatech.com>
Cc: Norbert Preining <preining@logic.at>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-pci.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/mmc/host/sdhci-pci.c~mmc-enable-dma-on-ricoh-sdhci-reader-by-default drivers/mmc/host/sdhci-pci.c
--- a/drivers/mmc/host/sdhci-pci.c~mmc-enable-dma-on-ricoh-sdhci-reader-by-default
+++ a/drivers/mmc/host/sdhci-pci.c
@@ -80,9 +80,6 @@ struct sdhci_pci_chip {
 
 static int ricoh_probe(struct sdhci_pci_chip *chip)
 {
-	if (chip->pdev->subsystem_vendor == PCI_VENDOR_ID_IBM)
-		chip->quirks |= SDHCI_QUIRK_CLOCK_BEFORE_RESET;
-
 	if (chip->pdev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG ||
 	    chip->pdev->subsystem_vendor == PCI_VENDOR_ID_SONY)
 		chip->quirks |= SDHCI_QUIRK_NO_CARD_NO_RESET;
@@ -92,7 +89,9 @@ static int ricoh_probe(struct sdhci_pci_
 
 static const struct sdhci_pci_fixes sdhci_ricoh = {
 	.probe		= ricoh_probe,
-	.quirks		= SDHCI_QUIRK_32BIT_DMA_ADDR,
+	.quirks		= SDHCI_QUIRK_32BIT_DMA_ADDR |
+			  SDHCI_QUIRK_FORCE_DMA |
+			  SDHCI_QUIRK_CLOCK_BEFORE_RESET,
 };
 
 static const struct sdhci_pci_fixes sdhci_ene_712 = {
_
