From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH v2 3/7] ARM: mxs: make ssp error irq definition consistent
Date: Mon, 14 Feb 2011 10:32:22 +0800
Message-ID: <1297650746-12841-4-git-send-email-shawn.guo@freescale.com>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.181]:46995
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754676Ab1BMSbE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 13:31:04 -0500
In-Reply-To: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@freescale.com>

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/include/mach/mx23.h |    2 +-
 arch/arm/mach-mxs/include/mach/mx28.h |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mx23.h b/arch/arm/mach-mxs/include/mach/mx23.h
index 1730c9c..e858692 100644
--- a/arch/arm/mach-mxs/include/mach/mx23.h
+++ b/arch/arm/mach-mxs/include/mach/mx23.h
@@ -93,7 +93,7 @@
 #define MX23_INT_USB_WAKEUP		12
 #define MX23_INT_GPMI_DMA		13
 #define MX23_INT_SSP1_DMA		14
-#define MX23_INT_SSP_ERROR		15
+#define MX23_INT_SSP1_ERROR		15
 #define MX23_INT_GPIO0			16
 #define MX23_INT_GPIO1			17
 #define MX23_INT_GPIO2			18
diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
index 3f3485a..75d8611 100644
--- a/arch/arm/mach-mxs/include/mach/mx28.h
+++ b/arch/arm/mach-mxs/include/mach/mx28.h
@@ -163,10 +163,10 @@
 #define MX28_INT_USB0			93
 #define MX28_INT_USB1_WAKEUP		94
 #define MX28_INT_USB0_WAKEUP		95
-#define MX28_INT_SSP0			96
-#define MX28_INT_SSP1			97
-#define MX28_INT_SSP2			98
-#define MX28_INT_SSP3			99
+#define MX28_INT_SSP0_ERROR		96
+#define MX28_INT_SSP1_ERROR		97
+#define MX28_INT_SSP2_ERROR		98
+#define MX28_INT_SSP3_ERROR		99
 #define MX28_INT_ENET_SWI		100
 #define MX28_INT_ENET_MAC0		101
 #define MX28_INT_ENET_MAC1		102
-- 
1.7.1


