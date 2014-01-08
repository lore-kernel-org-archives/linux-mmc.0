From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] mmc: sdhci-pci: remove unnecessary pci_set_drvdata()
Date: Wed, 08 Jan 2014 10:52:56 +0900
Message-ID: <000401cf0c14$59c5d3d0$0d517b70$%han@samsung.com>
References: <000001cf0c13$dcea0570$96be1050$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:60818 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbaAHBw5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jan 2014 20:52:57 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZ200I917W8OZD0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 08 Jan 2014 10:52:56 +0900 (KST)
In-reply-to: <000001cf0c13$dcea0570$96be1050$%han@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jiri Kosina' <jkosina@suse.cz>
Cc: trivial@kernel.org, 'Chris Ball' <chris@printf.net>, linux-mmc@vger.kernel.org, 'Sonic Zhang' <sonic.zhang@analog.com>, 'Adrian Hunter' <adrian.hunter@intel.com>, 'David Cohen' <david.a.cohen@linux.intel.com>, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/sdhci-pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 8f75381..9f66f73 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1609,7 +1609,6 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 free:
-	pci_set_drvdata(pdev, NULL);
 	kfree(chip);
 
 err:
@@ -1631,7 +1630,6 @@ static void sdhci_pci_remove(struct pci_dev *pdev)
 		for (i = 0; i < chip->num_slots; i++)
 			sdhci_pci_remove_slot(chip->slots[i]);
 
-		pci_set_drvdata(pdev, NULL);
 		kfree(chip);
 	}
 
-- 
1.7.10.4


