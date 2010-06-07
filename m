From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] initialise DMA engine before MMC
Date: Mon, 7 Jun 2010 13:16:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1006071312060.12965@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:50708 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751947Ab0FGLQa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Jun 2010 07:16:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-mmc@vger.kernel.org

To use DMA engine based DMA with MMC in a non-modular build, the DMA 
engine has to initialise before MMC.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/drivers/Makefile b/drivers/Makefile
index 91874e0..b713e75 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_EISA)		+= eisa/
 obj-y				+= lguest/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle/
+obj-$(CONFIG_DMA_ENGINE)	+= dma/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_MEMSTICK)		+= memstick/
 obj-$(CONFIG_NEW_LEDS)		+= leds/
@@ -102,7 +103,6 @@ obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
 obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
-obj-$(CONFIG_DMA_ENGINE)	+= dma/
 obj-$(CONFIG_DCA)		+= dca/
 obj-$(CONFIG_HID)		+= hid/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
