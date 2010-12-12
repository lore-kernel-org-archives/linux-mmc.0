From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] rfc v1: ARM: mach-shmobile: mackerel: Add zboot MMCIF support
Date: Sun, 12 Dec 2010 15:57:07 +0900
Message-ID: <1292137027-17779-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60761 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab0LLG5Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Dec 2010 01:57:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

Hi Magnus, Hi Morimoto-san, I wonder if this might
be sufficient to get MMCIF zboot working on mackerel.

This patch depends on
* ARM: 6515/1: Add zboot support for SuperH Mobile ARM
  (merged into the devel branch of Russel King's linux-2.6-arm tree)
* ARM: 6514/1: mach-shmobile: Add zboot support for SuperH Mobile ARM
  (merged into the devel branch of Russel King's linux-2.6-arm tree)
* MACH_MACKEREL (3211) being present in arch/arm/tools/mach-types
* ARM: mach-shmobile: mackerel: Add zboot support
* rfc v3: mmc, ARM: Add zboot from MMC support for SuperH Mobile ARM,
  which depends on
  * mmc, sh: Remove sh_mmcif_boot_slurp()
    (merged into the common/mmcif branch of Paul Mundt's sh-2.6 tree)
  * sh, mmc: Use defines when setting CE_CLK_CTRL
    (merged into the common/mmcif branch of Paul Mundt's sh-2.6 tree)
  * mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
    (merged into the common/mmcif branch of Paul Mundt's sh-2.6 tree)

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 .../mach-shmobile/include/mach/mmcif-mackerel.h    |   29 ++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/mmcif.h        |    2 +
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h

diff --git a/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h b/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h
new file mode 100644
index 0000000..34253c1
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h
@@ -0,0 +1,29 @@
+#ifndef MMCIF_MACKEREL_H
+#define MMCIF_MACKEREL_H
+
+#define PORT0CR      0xe6051001
+#define PORT1CR      0xe6051002
+#define PORT2CR      0xe6051003
+#define PORT3CR      0xe6051004
+
+#define PORTR031_000DR 0xe6055000
+
+static inline void mmcif_init_progress(void)
+{
+       /* Initialise LEDS0-3
+        * registers: PORT0CR-PORT1CR (LED0-LED3 Control)
+        * value:     0x10 - enable output
+        */
+       __raw_writeb(0x10, PORT0CR);
+       __raw_writeb(0x10, PORT1CR);
+       __raw_writeb(0x10, PORT2CR);
+       __raw_writeb(0x10, PORT3CR);
+}
+
+static inline void mmcif_update_progress(int n)
+{
+	__raw_writel((__raw_readl(PORTR031_000DR) & 0xf) |
+		     (1 << n), PORTR031_000DR);
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

