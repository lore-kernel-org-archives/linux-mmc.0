From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] mmc: sdhci-pci: Remove useless check for "slots == 0"
Date: Mon, 14 Apr 2014 16:23:30 -0600
Message-ID: <20140414222330.14817.81724.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54398 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbaDNWXc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Apr 2014 18:23:32 -0400
Received: by mail-ie0-f174.google.com with SMTP id rp18so8484704iec.5
        for <linux-mmc@vger.kernel.org>; Mon, 14 Apr 2014 15:23:32 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the check for "slots == 0" because it can never be 0 here.

Found by Coverity (CID 744269).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/mmc/host/sdhci-pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index fdc612120362..15edb3f56dae 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1491,8 +1491,6 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	slots = PCI_SLOT_INFO_SLOTS(slots) + 1;
 	dev_dbg(&pdev->dev, "found %d slot(s)\n", slots);
-	if (slots == 0)
-		return -ENODEV;
 
 	BUG_ON(slots > MAX_SLOTS);
 

