From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] sdhci: Add no-card-no-reset quirk for Ricoh R5C822/Sony Z11.
Date: Mon, 31 Aug 2009 15:48:27 -0400
Message-ID: <m3vdk3ix2s.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40132 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301AbZHaTvP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 31 Aug 2009 15:51:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-mmc@vger.kernel.org, Norbert Preining <preining@logic.at>

Card insertion detection is broken without this quirk on a Sony Vaio
Z11, as discussed on linux-mmc here: http://marc.info/?t=125017355000008

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
Tested-by: Norbert Preining <preining@logic.at>

---
 drivers/mmc/host/sdhci-pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 2f15cc1..63b9d2a 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -83,7 +83,8 @@ static int ricoh_probe(struct sdhci_pci_chip *chip)
 	if (chip->pdev->subsystem_vendor == PCI_VENDOR_ID_IBM)
 		chip->quirks |= SDHCI_QUIRK_CLOCK_BEFORE_RESET;
 
-	if (chip->pdev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG)
+	if (chip->pdev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG ||
+	    chip->pdev->subsystem_vendor == PCI_VENDOR_ID_SONY)
 		chip->quirks |= SDHCI_QUIRK_NO_CARD_NO_RESET;
 
 	return 0;
-- 
1.6.2.2
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
