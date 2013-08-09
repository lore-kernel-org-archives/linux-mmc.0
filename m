From: Philippe De Swert <philippe.deswert@jollamobile.com>
Subject: [PATCH] mmc: sdhci-pci : Remove logically dead code
Date: Fri,  9 Aug 2013 23:01:46 +0300
Message-ID: <1376078506-10391-1-git-send-email-philippe.deswert@jollamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Philippe De Swert <philippe.deswert@jollamobile.com>
List-Id: linux-mmc@vger.kernel.org

The amount of slots is calculated as follows:
slots = PCI_SLOT_INFO_SLOTS(slots) + 1;

Which means that just after it slots cannot be 0.

Found with coverity: CID#744269

Signed-off-by: Philippe De Swert <philippe.deswert@jollamobile.com>
---
 drivers/mmc/host/sdhci-pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d7d6bc8..9c76558 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1470,9 +1470,6 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
 	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
-	if (slots == 0)
-		return -ENODEV;
-
 	BUG_ON(slots > MAX_SLOTS);
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &first_bar);
-- 
1.8.1.2
