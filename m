From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/21] sh: sh7724: Don't use a public mmc header for MMC_PROGRESS*
Date: Fri, 30 Dec 2016 13:47:14 +0100
Message-ID: <1483102054-1752-2-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
List-Id: linux-mmc@vger.kernel.org

The enum that specifies the MMC_PROGRESS* types, is a sh mmcif specific
thing and has no relevance in a public mmc header. Currently it's used only
by the sh romImage MMCIF boot, so let's instead define the enum in there
and rename the types to MMCIF_* to show this.

Cc: linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/sh/boot/romimage/mmcif-sh7724.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/sh/boot/romimage/mmcif-sh7724.c b/arch/sh/boot/romimage/mmcif-sh7724.c
index 16b1225..6595b6b4 100644
--- a/arch/sh/boot/romimage/mmcif-sh7724.c
+++ b/arch/sh/boot/romimage/mmcif-sh7724.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/mmc/sh_mmcif.h>
-#include <linux/mmc/boot.h>
 #include <mach/romimage.h>
 
 #define MMCIF_BASE      (void __iomem *)0xa4ca0000
@@ -22,6 +21,13 @@
 #define HIZCRC		0xa405015c
 #define DRVCRA		0xa405018a
 
+enum {
+	MMCIF_PROGRESS_ENTER,
+	MMCIF_PROGRESS_INIT,
+	MMCIF_PROGRESS_LOAD,
+	MMCIF_PROGRESS_DONE
+};
+
 /* SH7724 specific MMCIF loader
  *
  * loads the romImage from an MMC card starting from block 512
@@ -30,7 +36,7 @@
  */
 asmlinkage void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
 {
-	mmcif_update_progress(MMC_PROGRESS_ENTER);
+	mmcif_update_progress(MMCIF_PROGRESS_ENTER);
 
 	/* enable clock to the MMCIF hardware block */
 	__raw_writel(__raw_readl(MSTPCR2) & ~0x20000000, MSTPCR2);
@@ -53,12 +59,12 @@ asmlinkage void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
 	/* high drive capability for MMC pins */
 	__raw_writew(__raw_readw(DRVCRA) | 0x3000, DRVCRA);
 
-	mmcif_update_progress(MMC_PROGRESS_INIT);
+	mmcif_update_progress(MMCIF_PROGRESS_INIT);
 
 	/* setup MMCIF hardware */
 	sh_mmcif_boot_init(MMCIF_BASE);
 
-	mmcif_update_progress(MMC_PROGRESS_LOAD);
+	mmcif_update_progress(MMCIF_PROGRESS_LOAD);
 
 	/* load kernel via MMCIF interface */
 	sh_mmcif_boot_do_read(MMCIF_BASE, 512,
@@ -68,5 +74,5 @@ asmlinkage void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
 	/* disable clock to the MMCIF hardware block */
 	__raw_writel(__raw_readl(MSTPCR2) | 0x20000000, MSTPCR2);
 
-	mmcif_update_progress(MMC_PROGRESS_DONE);
+	mmcif_update_progress(MMCIF_PROGRESS_DONE);
 }
-- 
1.9.1

