From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH -mm] mmc: add ricoh e822 pci id
Date: Wed, 4 Aug 2010 18:20:57 +0200
Message-ID: <20100804182057.6d1c14bb@dhcp-lab-109.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6492 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807Ab0HDQVM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Aug 2010 12:21:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, CyberCastle@gmail.com, Gregg Lebovitz <gregg@lebovitz.net>

From: CyberCastle@gmail.com

Signed-off-by: CyberCastle@gmail.com
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Tested-by: Gregg Lebovitz <gregg@lebovitz.net>
---
Note Gregg tested patch with mmc-make-sdhci-work-with-ricoh-mmc-controller.patch
and some other mmc patches from -mm tree backported to Fedora 13 kernel.

 drivers/mmc/host/sdhci-pci.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index e021431..e8aa99d 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -415,6 +415,14 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 	},
 
 	{
+		.vendor         = PCI_VENDOR_ID_RICOH,
+		.device         = 0xe822,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.driver_data    = (kernel_ulong_t)&sdhci_ricoh_mmc,
+	},
+
+	{
 		.vendor		= PCI_VENDOR_ID_ENE,
 		.device		= PCI_DEVICE_ID_ENE_CB712_SD,
 		.subvendor	= PCI_ANY_ID,
-- 
1.5.5.6
