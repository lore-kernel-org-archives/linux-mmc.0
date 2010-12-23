From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] [patch v3] ARM: mach-shmobile: mackerel: Add zboot MMCIF support
Date: Thu, 23 Dec 2010 18:01:17 +0900
Message-ID: <1293094877-28875-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

This patch wires up LED debugging for the MMCIF boot
on the mackerel, which is all that is required to get MMCIF
boot functioning.

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
This patch depends on:
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

v2
* Use correct GPIO ports
  - my previous assumptions turned out to be incorrect

v3
* Actually make the v2 change
  - my git-foo was poor this morning
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

