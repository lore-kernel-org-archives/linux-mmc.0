From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] ARM: mach-shmobile: mackerel: Add zboot MMCIF support
Date: Sun,  9 Jan 2011 18:30:15 +0900
Message-ID: <1294565415-20901-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36548 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab1AIJai (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jan 2011 04:30:38 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, vger.kernel.org@vergenet.net, linux-arm-kernel@lists.arm.linux.org.uk
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Paul Mundt <lethal@lethal-sh.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch wires up LED debugging for the MMCIF boot
on the mackerel, which is all that is required to get MMCIF
boot functioning.

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 .../mach-shmobile/include/mach/mmcif-mackerel.h    |   39 ++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/mmcif.h        |    2 +
 2 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h

diff --git a/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h b/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h
new file mode 100644
index 0000000..e07fb3f
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h
@@ -0,0 +1,39 @@
+#ifndef MMCIF_MACKEREL_H
+#define MMCIF_MACKEREL_H
+
+#define PORT0CR      0xe6051000
+#define PORT1CR      0xe6051001
+#define PORT2CR      0xe6051002
+#define PORT159CR    0xe605009f
+
+#define PORTR031_000DR 0xe6055000
+#define PORTL159_128DR 0xe6054010
+
+static inline void mmcif_init_progress(void)
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
+static inline void mmcif_update_progress(int n)
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
+
+#endif /* MMCIF_MACKEREL_H */
diff --git a/arch/arm/mach-shmobile/include/mach/mmcif.h b/arch/arm/mach-shmobile/include/mach/mmcif.h
index 0812f1e..f4dc327 100644
--- a/arch/arm/mach-shmobile/include/mach/mmcif.h
+++ b/arch/arm/mach-shmobile/include/mach/mmcif.h
@@ -9,6 +9,8 @@
 
 #ifdef CONFIG_MACH_AP4EVB
 #include "mach/mmcif-ap4eb.h"
+#elif CONFIG_MACH_MACKEREL
+#include "mach/mmcif-mackerel.h"
 #else
 #error "unsupported board."
 #endif
-- 
1.7.2.3

