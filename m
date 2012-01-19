From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 04/10] MTD/GPMI : change the DMA header file
Date: Thu, 19 Jan 2012 14:16:01 +0800
Message-ID: <1326953767-24155-5-git-send-email-b32955@freescale.com>
References: <1326953767-24155-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1326953767-24155-1-git-send-email-b32955@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: shawn.guo@linaro.org, artem.bityutskiy@intel.com, shijie8@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, w.sang@pengutronix.de, LW@KARO-electronics.de, alsa-devel@alsa-project.org, b29396@freescale.com, Huang Shijie <b32955@freescale.com>
List-Id: linux-mmc@vger.kernel.org

change the DMA header file for GPMI NAND driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index e023bcc..1c7fdbb 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -20,7 +20,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
-#include <mach/dma.h>
+#include <linux/mxs-dma.h>
 
 struct resources {
 	void          *gpmi_regs;
-- 
1.7.0.4
