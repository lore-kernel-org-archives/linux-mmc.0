From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci-pci: fix 'Invalid iomem size' error message condition
Date: Thu, 18 Oct 2012 09:54:31 +0300
Message-ID: <507FA7A7.4070100@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23708 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378Ab2JRGv7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 02:51:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

The SDHCI standard defines a 256 byte register set but a device
that specifies a larger iomem region is not an error.  Alter the
message condition accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 4bb74b0..04936f3 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1196,7 +1196,7 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 		return ERR_PTR(-ENODEV);
 	}
 
-	if (pci_resource_len(pdev, bar) != 0x100) {
+	if (pci_resource_len(pdev, bar) < 0x100) {
 		dev_err(&pdev->dev, "Invalid iomem size. You may "
 			"experience problems.\n");
 	}
-- 
1.7.11.4
