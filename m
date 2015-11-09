From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mmc: MMC_GOLDFISH should depend on HAS_DMA
Date: Mon,  9 Nov 2015 10:36:01 +0100
Message-ID: <1447061761-19783-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:38786 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbKIJf4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2015 04:35:56 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Luis de Bethencourt <luisbg@osg.samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If NO_DMA=y:

    ERROR: dma_unmap_sg [drivers/mmc/host/android-goldfish.ko] undefined!
    ERROR: dma_alloc_coherent [drivers/mmc/host/android-goldfish.ko] undefined!
    ERROR: dma_map_sg [drivers/mmc/host/android-goldfish.ko] undefined!
    ERROR: dma_free_coherent [drivers/mmc/host/android-goldfish.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index af71de5fda3b48c9..1dee533634c986d7 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -473,6 +473,7 @@ config MMC_DAVINCI
 
 config MMC_GOLDFISH
 	tristate "goldfish qemu Multimedia Card Interface support"
+	depends on HAS_DMA
 	depends on GOLDFISH || COMPILE_TEST
 	help
 	  This selects the Goldfish Multimedia card Interface emulation
-- 
1.9.1

