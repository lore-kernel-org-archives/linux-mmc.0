From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] mmc: host: omap_hsmmc: constify dev_pm_ops structures.
Date: Thu, 29 Jun 2017 13:39:29 +0530
Message-ID: <8a917dbec5b7eb9fd463cc9b7a596ab831f04965.1498723559.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32979 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdF2IKV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jun 2017 04:10:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, dan.carpenter@oracle.com, linus.walleij@linaro.org, hkallweit1@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

dev_pm_ops are not supposed to change at runtime. All functions
working with dev_pm_ops provided by <linux/device.h> work with const
dev_pm_ops. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  11586	    624	      0	  12210	   2fb2	drivers/mmc/host/omap_hsmmc.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  11778	    432	      0	  12210	   2fb2	drivers/mmc/host/omap_hsmmc.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8c39dcc..5b391dc 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2342,7 +2342,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
+static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
 	.runtime_suspend = omap_hsmmc_runtime_suspend,
 	.runtime_resume = omap_hsmmc_runtime_resume,
-- 
1.9.1

