From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/1] mmc: block: don't use parameter prefix if built as module
Date: Wed, 24 Jun 2015 14:32:21 +0300
Message-ID: <1435145541-127393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37992 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbbFXLc0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Jun 2015 07:32:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It's excessive to use prefix for the parameters when you do
	modrpobe mmc-block mmcblk.perdev_minors=16

Make this available only for built-in case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/card/block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c9c3d20..b94540b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -47,10 +47,13 @@
 #include "queue.h"
 
 MODULE_ALIAS("mmc:block");
+
+#ifdef KERNEL
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
 #define MODULE_PARAM_PREFIX "mmcblk."
+#endif
 
 #define INAND_CMD38_ARG_EXT_CSD  113
 #define INAND_CMD38_ARG_ERASE    0x00
-- 
2.1.4

