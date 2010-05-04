From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/9 v2] sh: define DMA slaves per CPU type, remove now
 redundant header
Date: Tue, 4 May 2010 16:06:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005041336080.4925@axis700.grange>
References: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34481 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754057Ab0EDOGM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 May 2010 10:06:12 -0400
In-Reply-To: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>

Now that DMA slave IDs are only used used in platform specific code and have
become opaque cookies for the rest of the code, we can make the, CPU specific
too.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This patch is new in v2 - added per request from Magnus.

 arch/sh/include/asm/dmaengine.h        |   34 --------------------------------
 arch/sh/include/asm/siu.h              |    2 -
 arch/sh/include/cpu-sh4/cpu/sh7722.h   |   15 ++++++++++++++
 arch/sh/include/cpu-sh4/cpu/sh7724.h   |   19 +++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |    3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |    2 +-
 sound/soc/sh/siu.h                     |    3 +-
 sound/soc/sh/siu_pcm.c                 |    9 +++----
 10 files changed, 42 insertions(+), 48 deletions(-)
 delete mode 100644 arch/sh/include/asm/dmaengine.h

diff --git a/arch/sh/include/asm/dmaengine.h b/arch/sh/include/asm/dmaengine.h
deleted file mode 100644
index 2a02b61..0000000
--- a/arch/sh/include/asm/dmaengine.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Header for the new SH dmaengine driver
- *
- * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef ASM_DMAENGINE_H
-#define ASM_DMAENGINE_H
-
-#include <linux/sh_dma.h>
-
-enum {
-	SHDMA_SLAVE_SCIF0_TX,
-	SHDMA_SLAVE_SCIF0_RX,
-	SHDMA_SLAVE_SCIF1_TX,
-	SHDMA_SLAVE_SCIF1_RX,
-	SHDMA_SLAVE_SCIF2_TX,
-	SHDMA_SLAVE_SCIF2_RX,
-	SHDMA_SLAVE_SCIF3_TX,
-	SHDMA_SLAVE_SCIF3_RX,
-	SHDMA_SLAVE_SCIF4_TX,
-	SHDMA_SLAVE_SCIF4_RX,
-	SHDMA_SLAVE_SCIF5_TX,
-	SHDMA_SLAVE_SCIF5_RX,
-	SHDMA_SLAVE_SIUA_TX,
-	SHDMA_SLAVE_SIUA_RX,
-	SHDMA_SLAVE_SIUB_TX,
-	SHDMA_SLAVE_SIUB_RX,
-};
-
-#endif
diff --git a/arch/sh/include/asm/siu.h b/arch/sh/include/asm/siu.h
index e8d4142..1d95c78 100644
--- a/arch/sh/include/asm/siu.h
+++ b/arch/sh/include/asm/siu.h
@@ -11,8 +11,6 @@
 #ifndef ASM_SIU_H
 #define ASM_SIU_H
 
-#include <asm/dmaengine.h>
-
 struct device;
 
 struct siu_platform {
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7722.h b/arch/sh/include/cpu-sh4/cpu/sh7722.h
index 4856040..7a5b8a3 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7722.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7722.h
@@ -235,4 +235,19 @@ enum {
 	HWBLK_NR,
 };
 
+enum {
+	SHDMA_SLAVE_SCIF0_TX,
+	SHDMA_SLAVE_SCIF0_RX,
+	SHDMA_SLAVE_SCIF1_TX,
+	SHDMA_SLAVE_SCIF1_RX,
+	SHDMA_SLAVE_SCIF2_TX,
+	SHDMA_SLAVE_SCIF2_RX,
+	SHDMA_SLAVE_SIUA_TX,
+	SHDMA_SLAVE_SIUA_RX,
+	SHDMA_SLAVE_SIUB_TX,
+	SHDMA_SLAVE_SIUB_RX,
+	SHDMA_SLAVE_SDHI0_TX,
+	SHDMA_SLAVE_SDHI0_RX,
+};
+
 #endif /* __ASM_SH7722_H__ */
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7724.h b/arch/sh/include/cpu-sh4/cpu/sh7724.h
index 0cd1f71..fbbf550 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7724.h
@@ -283,4 +283,23 @@ enum {
 	HWBLK_NR,
 };
 
+enum {
+	SHDMA_SLAVE_SCIF0_TX,
+	SHDMA_SLAVE_SCIF0_RX,
+	SHDMA_SLAVE_SCIF1_TX,
+	SHDMA_SLAVE_SCIF1_RX,
+	SHDMA_SLAVE_SCIF2_TX,
+	SHDMA_SLAVE_SCIF2_RX,
+	SHDMA_SLAVE_SCIF3_TX,
+	SHDMA_SLAVE_SCIF3_RX,
+	SHDMA_SLAVE_SCIF4_TX,
+	SHDMA_SLAVE_SCIF4_RX,
+	SHDMA_SLAVE_SCIF5_TX,
+	SHDMA_SLAVE_SCIF5_RX,
+	SHDMA_SLAVE_SDHI0_TX,
+	SHDMA_SLAVE_SDHI0_RX,
+	SHDMA_SLAVE_SDHI1_TX,
+	SHDMA_SLAVE_SDHI1_RX,
+};
+
 #endif /* __ASM_SH7724_H__ */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index fe28f52..5ea2d03 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -17,7 +17,6 @@
 #include <linux/usb/m66592.h>
 
 #include <asm/clock.h>
-#include <asm/dmaengine.h>
 #include <asm/mmzone.h>
 #include <asm/siu.h>
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index c4572b1..06a0683 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -18,13 +18,13 @@
 #include <linux/mm.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <linux/io.h>
 #include <linux/notifier.h>
 
 #include <asm/suspend.h>
 #include <asm/clock.h>
-#include <asm/dmaengine.h>
 #include <asm/mmzone.h>
 
 #include <cpu/dma-register.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index c3fcb39..b309f63 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -12,10 +12,9 @@
 #include <linux/serial.h>
 #include <linux/io.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 
-#include <asm/dmaengine.h>
-
 #include <cpu/dma-register.h>
 
 static struct plat_sci_port scif0_platform_data = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index 771ae76..9cbde9d 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -13,9 +13,9 @@
 #include <linux/serial_sci.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 
-#include <asm/dmaengine.h>
 #include <asm/mmzone.h>
 
 #include <cpu/dma-register.h>
diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
index c0bfab8..492b1ca 100644
--- a/sound/soc/sh/siu.h
+++ b/sound/soc/sh/siu.h
@@ -71,8 +71,7 @@ struct siu_firmware {
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-
-#include <asm/dmaengine.h>
+#include <linux/sh_dma.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index ba7f8d0..f7b7fcf 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -32,7 +32,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc-dai.h>
 
-#include <asm/dmaengine.h>
 #include <asm/siu.h>
 
 #include "siu.h"
@@ -359,13 +358,13 @@ static int siu_pcm_open(struct snd_pcm_substream *ss)
 	if (ss->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		siu_stream = &port_info->playback;
 		param = &siu_stream->param;
-		param->slave_id = port ? SHDMA_SLAVE_SIUB_TX :
-			SHDMA_SLAVE_SIUA_TX;
+		param->slave_id = port ? pdata->dma_slave_tx_b :
+			pdata->dma_slave_tx_a;
 	} else {
 		siu_stream = &port_info->capture;
 		param = &siu_stream->param;
-		param->slave_id = port ? SHDMA_SLAVE_SIUB_RX :
-			SHDMA_SLAVE_SIUA_RX;
+		param->slave_id = port ? pdata->dma_slave_rx_b :
+			pdata->dma_slave_rx_a;
 	}
 
 	param->dma_dev = pdata->dma_dev;
-- 
1.6.2.4

