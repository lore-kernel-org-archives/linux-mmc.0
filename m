From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] Revert "mmc: block: don't use parameter prefix if built as module"
Date: Thu, 11 Feb 2016 16:54:11 +0100
Message-ID: <1455206051-8633-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36327 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbcBKPyX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 10:54:23 -0500
Received: by mail-lb0-f181.google.com with SMTP id tk3so17756966lbb.3
        for <linux-mmc@vger.kernel.org>; Thu, 11 Feb 2016 07:54:22 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This reverts commit 829b6962f7e3cfc06f7c5c26269fd47ad48cf503.

Revert this change as it causes a sysfs path to change and therefore
introduces and ABI regression. More precisely Android's vold is not being
able to access /sys/module/mmcblk/parameters/perdev_minors any more, since
the path becomes changed to: "/sys/module/mmc_block/..."

Fixes: 829b6962f7e3 ("mmc: block: don't use parameter prefix if built as
module")
Reported-by: John Stultz <john.stultz@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 951641a..fe207e5 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -47,13 +47,10 @@
 #include "queue.h"
 
 MODULE_ALIAS("mmc:block");
-
-#ifdef KERNEL
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
 #endif
 #define MODULE_PARAM_PREFIX "mmcblk."
-#endif
 
 #define INAND_CMD38_ARG_EXT_CSD  113
 #define INAND_CMD38_ARG_ERASE    0x00
-- 
1.9.1

