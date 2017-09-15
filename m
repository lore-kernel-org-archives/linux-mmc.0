From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: sdhci-pci: remove outdated declaration
Date: Fri, 15 Sep 2017 20:13:28 +0200
Message-ID: <20170915181328.31510-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50184 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdIOSN5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 15 Sep 2017 14:13:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

The function was removed half a year ago, so this declaration can go,
too.

Fixes: 51ced59cc02e0d ("mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel devices")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/mmc/sdhci-pci-data.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/mmc/sdhci-pci-data.h b/include/linux/mmc/sdhci-pci-data.h
index fda15b6d4135d3..618f90d6e1ba1a 100644
--- a/include/linux/mmc/sdhci-pci-data.h
+++ b/include/linux/mmc/sdhci-pci-data.h
@@ -14,7 +14,4 @@ struct sdhci_pci_data {
 
 extern struct sdhci_pci_data *(*sdhci_pci_get_data)(struct pci_dev *pdev,
 				int slotno);
-
-extern int sdhci_pci_spt_drive_strength;
-
 #endif
-- 
2.11.0

