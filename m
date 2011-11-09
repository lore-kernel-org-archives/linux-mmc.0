From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] mmc: sdhci-pci: shut up BAR size warning
Date: Wed,  9 Nov 2011 21:21:58 +0100
Message-ID: <1320870118-3427-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57837 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430Ab1KIUWF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2011 15:22:05 -0500
Received: by bke11 with SMTP id 11so1694997bke.19
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2011 12:22:03 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Manuel Lauss <manuel.lauss@googlemail.com>

kernel complains about invalid SDHCI iomem size on boot.  The BAR on my
O2-Micro controller is 512 bytes large, twice the size SDHCI-PCI needs.
This patch changes the warning to only appear when the BAR is smaller
than expected.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/mmc/host/sdhci-pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d833d9c..0ee5c07 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1199,7 +1199,7 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 		return ERR_PTR(-ENODEV);
 	}
 
-	if (pci_resource_len(pdev, bar) != 0x100) {
+	if (pci_resource_len(pdev, bar) < 0x100) {
 		dev_err(&pdev->dev, "Invalid iomem size. You may "
 			"experience problems.\n");
 	}
-- 
1.7.7.2

