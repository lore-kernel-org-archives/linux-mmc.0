From: Daniel J Blueman <daniel.blueman@gmail.com>
Subject: [PATCH] sdhci: fix undue iomem warning
Date: Mon, 30 May 2011 20:33:16 +0800
Message-ID: <1306758796-4254-1-git-send-email-daniel.blueman@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38170 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531Ab1E3Mdi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 08:33:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel J Blueman <daniel.blueman@gmail.com>

Some newer SDHCI controllers have memory mapped I/O regions of 512
bytes, so accept these without warning.

Signed-off-by: Daniel J Blueman <daniel.blueman@gmail.com>
---
 drivers/mmc/host/sdhci-pci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 936bbca..ae948b0 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -918,8 +918,9 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 		return ERR_PTR(-ENODEV);
 	}
 
-	if (pci_resource_len(pdev, bar) != 0x100) {
-		dev_err(&pdev->dev, "Invalid iomem size. You may "
+	int len = pci_resource_len(pdev, bar);
+	if (len != 0x100 && len != 0x200) {
+		dev_warn(&pdev->dev, "Invalid iomem size. You may "
 			"experience problems.\n");
 	}
 
-- 
1.7.4.1

