From: Jackey Shen <jackey.shen@amd.com>
Subject: [PATCH] mmc: sdhci-pci: identify correct base addresses for slots
Date: Mon, 1 Jul 2013 17:22:15 +0800
Message-ID: <1372670535-2778-1-git-send-email-jackey.shen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:42592
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752974Ab3GAJZD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jul 2013 05:25:03 -0400
Received: from mail134-co9 (localhost [127.0.0.1])	by
 mail134-co9-R.bigfish.com (Postfix) with ESMTP id 57372480745	for
 <linux-mmc@vger.kernel.org>; Mon,  1 Jul 2013 09:25:02 +0000 (UTC)
Received: from CO9EHSMHS007.bigfish.com (unknown [10.236.132.236])	by
 mail134-co9.bigfish.com (Postfix) with ESMTP id 977CF3C0294	for
 <linux-mmc@vger.kernel.org>; Mon,  1 Jul 2013 09:25:00 +0000 (UTC)
Received: from sausexedgep01.amd.com (sausexedgep01-ext.amd.com
 [163.181.249.72])	(using TLSv1 with cipher AES128-SHA (128/128 bits))	(No
 client certificate requested)	by ausb3twp01.amd.com (Axway MailGate 3.8.1)
 with ESMTP id 2E66210280BA	for <linux-mmc@vger.kernel.org>; Mon,  1 Jul 2013
 04:24:58 -0500 (CDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jackey Shen <jackey.shen@amd.com>

A PCI Based SD Host Controller can support up to a total of six SD Slots, and
the base addresses are specified by Slot Information Register of its PCI header.
Please refer to C.3.3 of SD Host Controller Standard Specification Version 3.0.

Signed-off-by: Jackey Shen <jackey.shen@amd.com>
---
 drivers/mmc/host/sdhci-pci.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d7d6bc8..3a84e95 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -50,7 +50,8 @@
 #define  PCI_SLOT_INFO_SLOTS(x)		((x >> 4) & 7)
 #define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x07
 
-#define MAX_SLOTS			8
+#define MAX_SLOTS			6
+#define MAX_BARS			6
 
 struct sdhci_pci_chip;
 struct sdhci_pci_slot;
@@ -1282,7 +1283,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 {
 	struct sdhci_pci_slot *slot;
 	struct sdhci_host *host;
-	int ret, bar = first_bar + slotno;
+	int ret, bar = (first_bar + slotno) % MAX_BARS;
 
 	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "BAR %d is not iomem. Aborting.\n", bar);
@@ -1481,7 +1482,7 @@ static int sdhci_pci_probe(struct pci_dev *pdev,
 
 	first_bar &= PCI_SLOT_INFO_FIRST_BAR_MASK;
 
-	if (first_bar > 5) {
+	if (first_bar > MAX_BARS - 1) {
 		dev_err(&pdev->dev, "Invalid first BAR. Aborting.\n");
 		return -ENODEV;
 	}
-- 
1.7.10.4


