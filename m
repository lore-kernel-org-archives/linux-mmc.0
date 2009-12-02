From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] sdio: Fix reference counting in sdio_remove_func()
Date: Wed,  2 Dec 2009 09:22:19 +0000 (GMT)
Message-ID: <20091202092219.2AD329D404F@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:25455 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751320AbZLBJWQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2009 04:22:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-mmc@vger.kernel.org, matt@console-pimps.org

sdio_remove_func() needs to be more careful about reference counting.
It can be called in error paths where sdio_add_func() has never been called
e.g. mmc_attach_sdio error path --> mmc_sdio_remove --> sdio_remove_func

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/core/sdio_bus.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index d37464e..9e060c8 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -248,12 +248,15 @@ int sdio_add_func(struct sdio_func *func)
 /*
  * Unregister a SDIO function with the driver model, and
  * (eventually) free it.
+ * This function can be called through error paths where sdio_add_func() was
+ * never executed (because a failure occurred at an earlier point).
  */
 void sdio_remove_func(struct sdio_func *func)
 {
-	if (sdio_func_present(func))
-		device_del(&func->dev);
+	if (!sdio_func_present(func))
+		return;
 
+	device_del(&func->dev);
 	put_device(&func->dev);
 }
 
-- 
1.6.2.5

