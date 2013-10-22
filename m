From: "Shen, Jackey" <Jackey.Shen@amd.com>
Subject: RE: [PATCH] mmc: sdhci-pci: identify correct base addresses for
 slots
Date: Tue, 22 Oct 2013 08:24:58 +0000
Message-ID: <0C8FBB70FF40A94D98BE847F9C171A9803ACEAFE@SCYBEXDAG04.amd.com>
References: <1372670535-2778-1-git-send-email-jackey.shen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:53985
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753407Ab3JVIZI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Oct 2013 04:25:08 -0400
In-Reply-To: <1372670535-2778-1-git-send-email-jackey.shen@amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Shen, Jackey" <Jackey.Shen@amd.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Chris,

Do you have any comments on this patch?

Thanks,
Jackey

-----Original Message-----
From: Jackey Shen [mailto:jackey.shen@amd.com] 
Sent: Monday, July 01, 2013 5:22 PM
To: linux-mmc@vger.kernel.org
Cc: Shen, Jackey
Subject: [PATCH] mmc: sdhci-pci: identify correct base addresses for slots

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


