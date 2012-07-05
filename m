From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH] MMC: OMAP: make MMC_OMAP* depend on DMA_OMAP
Date: Thu,  5 Jul 2012 09:12:01 +0800
Message-ID: <1341450721-20993-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48763 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab2GEBML (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jul 2012 21:12:11 -0400
Received: by pbbrp8 with SMTP id rp8so11890498pbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jul 2012 18:12:10 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ming Lei <ming.lei@canonical.com>

Recent commits on omap mmc/hsmmc in -next tree switch to
DMA_ENGINE entirely, so make MMC_OMAP* depend on DMA_OMAP
and DMA_ENGINE, otherwise OMAP MMC/HSMMC won't work without
enabling DMA_ENGINE and DMA_OMAP.

The patch simply make them depend on DMA_OMAP since DMA_OMAP
will select DMA_ENGINE automatically.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/mmc/host/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index aa131b3..ef72c50 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -231,7 +231,7 @@ config MMC_SDHCI_S3C_DMA
 
 config MMC_OMAP
 	tristate "TI OMAP Multimedia Card Interface support"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP && DMA_OMAP
 	select TPS65010 if MACH_OMAP_H2
 	help
 	  This selects the TI OMAP Multimedia card Interface.
@@ -242,7 +242,7 @@ config MMC_OMAP
 
 config MMC_OMAP_HS
 	tristate "TI OMAP High Speed Multimedia Card Interface support"
-	depends on SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4
+	depends on (SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4) && DMA_OMAP
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
 	  If you have an OMAP2430 or OMAP3 board or OMAP4 board with a
-- 
1.7.9.5

