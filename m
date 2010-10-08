From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: on error print out SD CMD and CAPABILITY_1 Register
Date: Thu, 7 Oct 2010 21:05:58 -0700
Message-ID: <8D8E1470-A817-4A97-962E-DC94DA424953@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:53699 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750884Ab0JHEHH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Oct 2010 00:07:07 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


More information should be shown when sdhci_dumpregs is called.


Knowing the command is useful for debugging.
Capability 1 is useful for sdio v3

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    5 ++++-
 drivers/mmc/host/sdhci.h |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9cb60ba..ea8472b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -77,8 +77,11 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 	printk(KERN_DEBUG DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
 		sdhci_readw(host, SDHCI_ACMD12_ERR),
 		sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
-	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Max curr: 0x%08x\n",
+	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
 		sdhci_readl(host, SDHCI_CAPABILITIES),
+		sdhci_readl(host, SDHCI_CAPABILITIES_1));
+	printk(KERN_DEBUG DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
+		sdhci_readw(host, SDHCI_COMMAND),
 		sdhci_readl(host, SDHCI_MAX_CURRENT));
 
 	if (host->flags & SDHCI_USE_ADMA)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index bfcd611..38ae340 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -161,7 +161,7 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT	0x10000000
 
-/* 44-47 reserved for more caps */
+#define SDHCI_CAPABILITIES_1	0x44
 
 #define SDHCI_MAX_CURRENT	0x48
 
-- 
1.6.0.4

