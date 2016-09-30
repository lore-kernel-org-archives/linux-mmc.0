From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH 1/2] mmc: block: add missing header dependencies
Date: Fri, 30 Sep 2016 09:37:38 +0800
Message-ID: <1475199459-4775-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: michal.simek@xilinx.com, soren.brinkmann@xilinx.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, han.fei@zte.com.cn, tang.qiang007@zte.com.cn
List-Id: linux-mmc@vger.kernel.org

We get 1 warning when building kernel with W=1:
drivers/mmc/card/block.c:2147:5: warning: no previous prototype for 'mmc_blk_issue_rq' [-Wmissing-prototypes]

In fact, this function is declared in drivers/mmc/card/block.h,
so this patch adds missing header dependencies.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/mmc/card/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c333511..0f2cc9f2 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -46,6 +46,7 @@
 #include <asm/uaccess.h>
 
 #include "queue.h"
+#include "block.h"
 
 MODULE_ALIAS("mmc:block");
 #ifdef MODULE_PARAM_PREFIX
-- 
2.7.4
