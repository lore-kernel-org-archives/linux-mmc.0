From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] dw_mmc-pci: enable bus-mastering mode
Date: Thu,  8 Aug 2013 13:44:58 +0300
Message-ID: <1375958698-10569-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1375958698-10569-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33645 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757726Ab3HHKpQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Aug 2013 06:45:16 -0400
In-Reply-To: <1375958698-10569-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Prabu Thangamuthu <Prabu.T@synopsys.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This patch enables bus-mastering mode for MMC controller to allow IDMAC
transfers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/dw_mmc-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 7d148d6..f70546a 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -61,6 +61,8 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
 
 	host->regs = pcim_iomap_table(pdev)[PCI_BAR_NO];
 
+	pci_set_master(pdev);
+
 	ret = dw_mci_probe(host);
 	if (ret)
 		return ret;
-- 
1.8.4.rc1

