From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: Kconfig: MMC_SDHCI_PXA: CPU_MMP2 no need IO_ACCESSORS
Date: Wed, 24 Nov 2010 13:30:24 -0800
Message-ID: <6AF03C74-B11E-44E6-B085-35B2D2E8D8D3@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41579 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753374Ab0KXVdl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Nov 2010 16:33:41 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>, Zhangfei Gao <zhangfei.gao@gmail.com>

Resend as plain text

>From 5ffe0546fb3d70dd97af178e474fbcdfa64ea4e8 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Wed, 24 Nov 2010 13:25:47 -0800
Subject: [PATCH] sdhci: Kconfig: MMC_SDHCI_PXA: CPU_MMP2 no need IO_ACCESSORS

read and write to MMP2 controller in sdhci-pxa does not use
IO_ACCESSORS.  MMP2 hardware does not require special handling
for read and write.

change Kconfig to not set this option.  Speed Improvement.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f8fa9ef..f48532f 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -170,7 +170,7 @@ config MMC_SDHCI_PXA
 	tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
 	depends on ARCH_PXA || ARCH_MMP
 	select MMC_SDHCI
-	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_SDHCI_IO_ACCESSORS if !CPU_MMP2
 	help
 	  This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
 	  If you have a PXA168/PXA910/MMP2 platform with SD Host Controller
-- 
1.6.0.4

