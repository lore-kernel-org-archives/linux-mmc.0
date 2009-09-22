From: akpm@linux-foundation.org
Subject: [patch 088/232] sdhci: add no-card-no-reset quirk for Ricoh R5C822/Sony Z11
Date: Tue, 22 Sep 2009 16:45:22 -0700
Message-ID: <200909222345.n8MNjNjx014238@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39186 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753056AbZIWADT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 20:03:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, cjb@laptop.org, linux-mmc@vger.kernel.org, preining@logic.at

From: Chris Ball <cjb@laptop.org>

Card insertion detection is broken without this quirk on a Sony Vaio
Z11, as discussed on linux-mmc here: http://marc.info/?t=125017355000008

Signed-off-by: Chris Ball <cjb@laptop.org>
Tested-by: Norbert Preining <preining@logic.at>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/host/sdhci-pci.c~sdhci-add-no-card-no-reset-quirk-for-ricoh-r5c822-sony-z11 drivers/mmc/host/sdhci-pci.c
--- a/drivers/mmc/host/sdhci-pci.c~sdhci-add-no-card-no-reset-quirk-for-ricoh-r5c822-sony-z11
+++ a/drivers/mmc/host/sdhci-pci.c
@@ -83,7 +83,8 @@ static int ricoh_probe(struct sdhci_pci_
 	if (chip->pdev->subsystem_vendor == PCI_VENDOR_ID_IBM)
 		chip->quirks |= SDHCI_QUIRK_CLOCK_BEFORE_RESET;
 
-	if (chip->pdev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG)
+	if (chip->pdev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG ||
+	    chip->pdev->subsystem_vendor == PCI_VENDOR_ID_SONY)
 		chip->quirks |= SDHCI_QUIRK_NO_CARD_NO_RESET;
 
 	return 0;
_
