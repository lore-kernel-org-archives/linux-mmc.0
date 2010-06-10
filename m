From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH] omap_hsmmc: Remove unused state variable
Date: Thu, 10 Jun 2010 09:00:06 -0500
Message-ID: <1276178406-5747-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37601 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab0FJN75 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Jun 2010 09:59:57 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5ADxvwk019585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Jun 2010 08:59:57 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

This fixes the following warning:

drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
drivers/mmc/host/omap_hsmmc.c:2275: warning: unused variable 'state'

Introduced by commit ID:

  commit 1a13f8fa76c880be41d6b1e6a2b44404bcbfdf9e
  Author: Matt Fleming <matt@console-pimps.org>
  Date:   Wed May 26 14:42:08 2010 -0700

      mmc: remove the "state" argument to mmc_suspend_host()

The unique usage of this var was removed there, and missed
removing the respective declaration aswell.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
---
 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b032828..d50e917 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2272,7 +2272,6 @@ static int omap_hsmmc_suspend(struct device *dev)
 	int ret = 0;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_hsmmc_host *host = platform_get_drvdata(pdev);
-	pm_message_t state = PMSG_SUSPEND; /* unused by MMC core */
 
 	if (host && host->suspended)
 		return 0;
-- 
1.6.3.3

