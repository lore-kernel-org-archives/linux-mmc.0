From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: sdhci-cadence: include <linux/bits.h> instead of <linux/bitops.h>
Date: Tue, 30 Oct 2018 20:05:06 +0900
Message-ID: <1540897506-3075-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The reason of including <linux/bitops.h> here is just for BIT() and
GENMASK() macros.

Since commit 8bd9cb51daac8 ("locking/atomics, asm-generic: Move some
macros from <linux/bitops.h> to a new <linux/bits.h> file"),
<linux/bits.h> is enough for such compile-time macros.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 7a343b8..e241287 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -14,7 +14,7 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
-- 
2.7.4
