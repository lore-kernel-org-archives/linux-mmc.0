From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 02/10] MXS-DMA : change the header
Date: Thu, 19 Jan 2012 14:15:59 +0800
Message-ID: <1326953767-24155-3-git-send-email-b32955@freescale.com>
References: <1326953767-24155-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1326953767-24155-1-git-send-email-b32955@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: shawn.guo@linaro.org, artem.bityutskiy@intel.com, shijie8@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, w.sang@pengutronix.de, LW@KARO-electronics.de, alsa-devel@alsa-project.org, b29396@freescale.com, Huang Shijie <b32955@freescale.com>
List-Id: linux-mmc@vger.kernel.org

change the header for MXS-DMA driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/dma/mxs-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index b06cd4c..c80fbed 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -22,10 +22,10 @@
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
 #include <linux/delay.h>
+#include <linux/mxs-dma.h>
 
 #include <asm/irq.h>
 #include <mach/mxs.h>
-#include <mach/dma.h>
 #include <mach/common.h>
 
 /*
-- 
1.7.0.4
