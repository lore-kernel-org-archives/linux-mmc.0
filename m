From: Philip Rakity <prakity@marvell.com>
Subject: sdhci: Kconfig: Restrict PLAT_PXA to MMP2 only.  Other processors
 not supported
Date: Fri, 22 Apr 2011 13:20:05 -0700
Message-ID: <EAE8C2E5-7397-4C55-82B8-F902A3A15E3F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44832 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756256Ab1DVUVX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 16:21:23 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zgao6@marvell.com>


PLAT_PXA currently only supports MMP2.  Registers used for private control
only support MMP2 at this time.  Extend supported platforms when other
systems are added.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1a21c64..cf4e9eb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -179,13 +179,13 @@ config MMC_SDHCI_S3C
 	  If unsure, say N.
 
 config MMC_SDHCI_PXA
-	tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
-	depends on ARCH_PXA || ARCH_MMP
+	tristate "Marvell MMP2 SD Host Controller support"
+	depends on ARCH_MMP
 	select MMC_SDHCI
 	select MMC_SDHCI_IO_ACCESSORS
 	help
-	  This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
-	  If you have a PXA168/PXA910/MMP2 platform with SD Host Controller
+	  This selects the Marvell(R) MMP2 SD Host Controller.
+	  If you have a MMP2 platform with SD Host Controller
 	  and a card slot, say Y or M here.
 
 	  If unsure, say N.
-- 
1.7.0.4


