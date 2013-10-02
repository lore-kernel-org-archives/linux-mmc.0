From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] mmc: sdhci-pci: remove unnecessary pci_set_drvdata()
Date: Wed, 02 Oct 2013 17:44:36 +0900
Message-ID: <000001cebf4b$a0011140$e00333c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:30890 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab3JBIoi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Oct 2013 04:44:38 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MU1004A59M6PB20@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 02 Oct 2013 17:44:37 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Adrian Hunter' <adrian.hunter@intel.com>, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/sdhci-pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d7d6bc8..f0d20f0 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1533,7 +1533,6 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 free:
-	pci_set_drvdata(pdev, NULL);
 	kfree(chip);
 
 err:
@@ -1555,7 +1554,6 @@ static void sdhci_pci_remove(struct pci_dev *pdev)
 		for (i = 0; i < chip->num_slots; i++)
 			sdhci_pci_remove_slot(chip->slots[i]);
 
-		pci_set_drvdata(pdev, NULL);
 		kfree(chip);
 	}
 
-- 
1.7.10.4


