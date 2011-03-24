From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 1/2] mmc, ARM: Rename SuperH Mobile ARM zboot helpers
Date: Thu, 24 Mar 2011 15:54:07 +0900
Message-ID: <1300949648-15078-2-git-send-email-horms@verge.net.au>
References: <1300949648-15078-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47435 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933026Ab1CXGyR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2011 02:54:17 -0400
In-Reply-To: <1300949648-15078-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: vger.kernel.org@vergenet.net, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>

These headers and helpers will also be used for SDHI boot
so the mmcif name will start to make a lot less sense.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/compressed/mmcif-sh7372.c            |   12 +++---
 arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h    |   29 +++++++++++++++
 arch/arm/mach-shmobile/include/mach/mmc-mackerel.h |   38 +++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/mmc.h          |   18 +++++++++
 arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h  |   29 ---------------
 .../mach-shmobile/include/mach/mmcif-mackerel.h    |   39 --------------------
 arch/arm/mach-shmobile/include/mach/mmcif.h        |   18 ---------
 7 files changed, 91 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/mmc-mackerel.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/mmc.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/mmcif.h

diff --git a/arch/arm/boot/compressed/mmcif-sh7372.c b/arch/arm/boot/compressed/mmcif-sh7372.c
index e6180af..28bcf3c 100644
--- a/arch/arm/boot/compressed/mmcif-sh7372.c
+++ b/arch/arm/boot/compressed/mmcif-sh7372.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/mmc/sh_mmcif.h>
-#include <mach/mmcif.h>
+#include <mach/mmc.h>
 
 #define MMCIF_BASE      (void __iomem *)0xe6bd0000
 
@@ -41,8 +41,8 @@
  */
 asmlinkage void mmcif_loader(unsigned char *buf, unsigned long len)
 {
-	mmcif_init_progress();
-	mmcif_update_progress(MMCIF_PROGRESS_ENTER);
+	mmc_init_progress();
+	mmc_update_progress(MMCIF_PROGRESS_ENTER);
 
 	/* Initialise MMC
 	 * registers: PORT84CR-PORT92CR
@@ -68,12 +68,12 @@ asmlinkage void mmcif_loader(unsigned char *buf, unsigned long len)
 	/* Enable clock to MMC hardware block */
 	__raw_writel(__raw_readl(SMSTPCR3) & ~(1 << 12), SMSTPCR3);
 
-	mmcif_update_progress(MMCIF_PROGRESS_INIT);
+	mmc_update_progress(MMCIF_PROGRESS_INIT);
 
 	/* setup MMCIF hardware */
 	sh_mmcif_boot_init(MMCIF_BASE);
 
-	mmcif_update_progress(MMCIF_PROGRESS_LOAD);
+	mmc_update_progress(MMCIF_PROGRESS_LOAD);
 
 	/* load kernel via MMCIF interface */
 	sh_mmcif_boot_do_read(MMCIF_BASE, 2, /* Kernel is at block 2 */
@@ -83,5 +83,5 @@ asmlinkage void mmcif_loader(unsigned char *buf, unsigned long len)
 	/* Disable clock to MMC hardware block */
 	__raw_writel(__raw_readl(SMSTPCR3) & (1 << 12), SMSTPCR3);
 
-	mmcif_update_progress(MMCIF_PROGRESS_DONE);
+	mmc_update_progress(MMCIF_PROGRESS_DONE);
 }
diff --git a/arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h b/arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h
new file mode 100644
index 0000000..db59fdb
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h
@@ -0,0 +1,29 @@
+#ifndef MMC_AP4EB_H
+#define MMC_AP4EB_H
+
+#define PORT185CR      (void __iomem *)0xe60520b9
+#define PORT186CR      (void __iomem *)0xe60520ba
+#define PORT187CR      (void __iomem *)0xe60520bb
+#define PORT188CR      (void __iomem *)0xe60520bc
+
+#define PORTR191_160DR (void __iomem *)0xe6056014
+
+static inline void mmc_init_progress(void)
+{
+       /* Initialise LEDS1-4
+        * registers: PORT185CR-PORT188CR (LED1-LED4 Control)
+        * value:     0x10 - enable output
+        */
+       __raw_writeb(0x10, PORT185CR);
+       __raw_writeb(0x10, PORT186CR);
+       __raw_writeb(0x10, PORT187CR);
+       __raw_writeb(0x10, PORT188CR);
+}
+
+static inline void mmc_update_progress(int n)
+{
+	__raw_writel((__raw_readl(PORTR191_160DR) & ~(0xf << 25)) |
+		     (1 << (25 + n)), PORTR191_160DR);
+}
+
+#endif /* MMC_AP4EB_H */
diff --git a/arch/arm/mach-shmobile/include/mach/mmc-mackerel.h b/arch/arm/mach-shmobile/include/mach/mmc-mackerel.h
new file mode 100644
index 0000000..15d3a9e
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/mmc-mackerel.h
@@ -0,0 +1,38 @@
+#ifndef MMC_MACKEREL_H
+#define MMC_MACKEREL_H
+
+#define PORT0CR      (void __iomem *)0xe6051000
+#define PORT1CR      (void __iomem *)0xe6051001
+#define PORT2CR      (void __iomem *)0xe6051002
+#define PORT159CR    (void __iomem *)0xe605009f
+
+#define PORTR031_000DR (void __iomem *)0xe6055000
+#define PORTL159_128DR (void __iomem *)0xe6054010
+
+static inline void mmc_init_progress(void)
+{
+       /* Initialise LEDS0-3
+        * registers: PORT0CR-PORT2CR,PORT159CR (LED0-LED3 Control)
+        * value:     0x10 - enable output
+        */
+       __raw_writeb(0x10, PORT0CR);
+       __raw_writeb(0x10, PORT1CR);
+       __raw_writeb(0x10, PORT2CR);
+       __raw_writeb(0x10, PORT159CR);
+}
+
+static inline void mmc_update_progress(int n)
+{
+	unsigned a = 0, b = 0;
+
+	if (n < 3)
+		a = 1 << n;
+	else
+		b = 1 << 31;
+
+	__raw_writel((__raw_readl(PORTR031_000DR) & ~0x7) | a,
+		     PORTR031_000DR);
+	__raw_writel((__raw_readl(PORTL159_128DR) & ~(1 << 31)) | b,
+		     PORTL159_128DR);
+}
+#endif /* MMC_MACKEREL_H */
diff --git a/arch/arm/mach-shmobile/include/mach/mmc.h b/arch/arm/mach-shmobile/include/mach/mmc.h
new file mode 100644
index 0000000..e11560a
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/mmc.h
@@ -0,0 +1,18 @@
+#ifndef MMC_H
+#define MMC_H
+
+/**************************************************
+ *
+ *		board specific settings
+ *
+ **************************************************/
+
+#ifdef CONFIG_MACH_AP4EVB
+#include "mach/mmc-ap4eb.h"
+#elif CONFIG_MACH_MACKEREL
+#include "mach/mmc-mackerel.h"
+#else
+#error "unsupported board."
+#endif
+
+#endif /* MMC_H */
diff --git a/arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h b/arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h
deleted file mode 100644
index a8d02be..0000000
--- a/arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef MMCIF_AP4EB_H
-#define MMCIF_AP4EB_H
-
-#define PORT185CR      (void __iomem *)0xe60520b9
-#define PORT186CR      (void __iomem *)0xe60520ba
-#define PORT187CR      (void __iomem *)0xe60520bb
-#define PORT188CR      (void __iomem *)0xe60520bc
-
-#define PORTR191_160DR (void __iomem *)0xe6056014
-
-static inline void mmcif_init_progress(void)
-{
-       /* Initialise LEDS1-4
-        * registers: PORT185CR-PORT188CR (LED1-LED4 Control)
-        * value:     0x10 - enable output
-        */
-       __raw_writeb(0x10, PORT185CR);
-       __raw_writeb(0x10, PORT186CR);
-       __raw_writeb(0x10, PORT187CR);
-       __raw_writeb(0x10, PORT188CR);
-}
-
-static inline void mmcif_update_progress(int n)
-{
-	__raw_writel((__raw_readl(PORTR191_160DR) & ~(0xf << 25)) |
-		     (1 << (25 + n)), PORTR191_160DR);
-}
-
-#endif /* MMCIF_AP4EB_H */
diff --git a/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h b/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h
deleted file mode 100644
index 4b4f694..0000000
--- a/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h
+++ /dev/null
@@ -1,39 +0,0 @@
-#ifndef MMCIF_MACKEREL_H
-#define MMCIF_MACKEREL_H
-
-#define PORT0CR      (void __iomem *)0xe6051000
-#define PORT1CR      (void __iomem *)0xe6051001
-#define PORT2CR      (void __iomem *)0xe6051002
-#define PORT159CR    (void __iomem *)0xe605009f
-
-#define PORTR031_000DR (void __iomem *)0xe6055000
-#define PORTL159_128DR (void __iomem *)0xe6054010
-
-static inline void mmcif_init_progress(void)
-{
-       /* Initialise LEDS0-3
-        * registers: PORT0CR-PORT2CR,PORT159CR (LED0-LED3 Control)
-        * value:     0x10 - enable output
-        */
-       __raw_writeb(0x10, PORT0CR);
-       __raw_writeb(0x10, PORT1CR);
-       __raw_writeb(0x10, PORT2CR);
-       __raw_writeb(0x10, PORT159CR);
-}
-
-static inline void mmcif_update_progress(int n)
-{
-	unsigned a = 0, b = 0;
-
-	if (n < 3)
-		a = 1 << n;
-	else
-		b = 1 << 31;
-
-	__raw_writel((__raw_readl(PORTR031_000DR) & ~0x7) | a,
-		     PORTR031_000DR);
-	__raw_writel((__raw_readl(PORTL159_128DR) & ~(1 << 31)) | b,
-		     PORTL159_128DR);
-}
-
-#endif /* MMCIF_MACKEREL_H */
diff --git a/arch/arm/mach-shmobile/include/mach/mmcif.h b/arch/arm/mach-shmobile/include/mach/mmcif.h
deleted file mode 100644
index f4dc327..0000000
--- a/arch/arm/mach-shmobile/include/mach/mmcif.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef MMCIF_H
-#define MMCIF_H
-
-/**************************************************
- *
- *		board specific settings
- *
- **************************************************/
-
-#ifdef CONFIG_MACH_AP4EVB
-#include "mach/mmcif-ap4eb.h"
-#elif CONFIG_MACH_MACKEREL
-#include "mach/mmcif-mackerel.h"
-#else
-#error "unsupported board."
-#endif
-
-#endif /* MMCIF_H */
-- 
1.7.2.3

