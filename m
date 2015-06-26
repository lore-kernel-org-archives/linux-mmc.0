From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mmc: MMC_MTK should depend on HAS_DMA
Date: Fri, 26 Jun 2015 14:09:26 +0200
Message-ID: <1435320566-5069-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:49226 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbFZMJc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2015 08:09:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If NO_DMA=y:

    ERROR: "dma_alloc_coherent" [drivers/mmc/host/mtk-sd.ko] undefined!
    ERROR: "dma_unmap_sg" [drivers/mmc/host/mtk-sd.ko] undefined!
    ERROR: "dma_map_sg" [drivers/mmc/host/mtk-sd.ko] undefined!
    ERROR: "dma_free_coherent" [drivers/mmc/host/mtk-sd.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index fd9a58e216a50ffd..6a0f9c79be2652bd 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -779,6 +779,7 @@ config MMC_TOSHIBA_PCI
 
 config MMC_MTK
 	tristate "MediaTek SD/MMC Card Interface support"
+	depends on HAS_DMA
 	help
 	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
 	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.
-- 
1.9.1

