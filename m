From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] dw_mmc-pci: get resources from a proper BAR
Date: Thu,  8 Aug 2013 13:44:57 +0300
Message-ID: <1375958698-10569-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46202 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965111Ab3HHKpj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Aug 2013 06:45:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Prabu Thangamuthu <Prabu.T@synopsys.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is a typo when the mapped space is from BAR 2, but BAR 0 is used instead.
This patch fixes the typo.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/dw_mmc-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index b456b0c..7d148d6 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -59,7 +59,7 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	host->regs = pcim_iomap_table(pdev)[0];
+	host->regs = pcim_iomap_table(pdev)[PCI_BAR_NO];
 
 	ret = dw_mci_probe(host);
 	if (ret)
-- 
1.8.4.rc1

