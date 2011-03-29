From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: sdhci-pci: Fix error case in sdhci_pci_probe_slot()
Date: Tue, 29 Mar 2011 00:46:12 -0400
Message-ID: <1301373972-18090-1-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:33177 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1C2Ela (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2011 00:41:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, stable@kernel.org

If pci_ioremap_bar() fails during probe, we "goto release;" and free the
host, but then we return 0 -- which tells sdhci_pci_probe() that the probe
succeeded.  Since we think the probe succeeded, when we unload sdhci we'll
go to sdhci_pci_remove_slot() and it will try to dereference slot->host,
which is now NULL because we freed it in the error path earlier.

The patch simply sets ret appropriately, so that sdhci_pci_probe() will
detect the failure immediately and bail out.

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: <stable@kernel.org>
---
 drivers/mmc/host/sdhci-pci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index a136be7..f8b5f37 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -957,6 +957,7 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 	host->ioaddr = pci_ioremap_bar(pdev, bar);
 	if (!host->ioaddr) {
 		dev_err(&pdev->dev, "failed to remap registers\n");
+		ret = -ENOMEM;
 		goto release;
 	}
 
-- 
1.7.0.1

