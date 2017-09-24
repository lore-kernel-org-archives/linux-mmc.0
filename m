From: Sascha El-Sharkawy <elscha@sse.uni-hildesheim.de>
Subject: [Patch] MMC: Avoid useless selection of MMC_RICOH_MMC quirk
Date: Sun, 24 Sep 2017 17:55:59 +0200
Message-ID: <59C7D58F.4040904@sse.uni-hildesheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from messagesink.samelson.uni-hildesheim.de ([147.172.172.66]:41327
        "EHLO messagesink.samelson.uni-hildesheim.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752590AbdIXPz6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Sep 2017 11:55:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Ensure correct functionality of MMC_RICOH_MMC pci quirk.

MMC_RICOH_MMC is a pci quirk (realized in /drivers/pci/quirks.c lines 2877
- 2959), which in turn depend on PCI_QUIRKS. However, MMC_RICOH_MMC can be
selected even if pci quirks (PCI_QUIRKS) are globally disabled. This patch
adds the missing dependency to MMC_RICOH_MMC to ensure that it can only be
selected if pci quirks are active.

Signed-off-by:  Sascha El-Sharkawy<elscha@sse.uni-hildesheim.de>
---
  drivers/mmc/host/Kconfig |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8c15637..81143fb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -91,7 +91,7 @@ config MMC_SDHCI_PCI
  
  config MMC_RICOH_MMC
  	bool "Ricoh MMC Controller Disabler"
-	depends on MMC_SDHCI_PCI
+	depends on MMC_SDHCI_PCI && PCI_QUIRKS
  	default y
  	help
  	  This adds a pci quirk to disable Ricoh MMC Controller. This

