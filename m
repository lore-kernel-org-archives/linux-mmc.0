From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/7 v2] dma: shdma: prepare for simple DMA conversion
Date: Thu, 26 Jan 2012 15:56:19 +0100
Message-ID: <1327589784-4287-3-git-send-email-g.liakhovetski@gmx.de>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-mmc@vger.kernel.org, alsa-devel@alsa-project.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

By placing an anonymous union at the top of struct sh_dmae_slave we can
transparently prepare all drivers for the upcoming simple DMA conversion.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/sh_dma.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index 425450b..ed2aa1e 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -10,12 +10,16 @@
 #ifndef SH_DMA_H
 #define SH_DMA_H
 
-#include <linux/list.h>
+#include <linux/dma-simple.h>
 #include <linux/dmaengine.h>
+#include <linux/list.h>
 
 /* Used by slave DMA clients to request DMA to/from a specific peripheral */
 struct sh_dmae_slave {
-	unsigned int			slave_id; /* Set by the platform */
+	union {
+		unsigned int		slave_id; /* Set by the platform */
+		struct dma_simple_slave	simple_slave;
+	};
 	struct device			*dma_dev; /* Set by the platform */
 	const struct sh_dmae_slave_config	*config;  /* Set by the driver */
 };
-- 
1.7.2.5
