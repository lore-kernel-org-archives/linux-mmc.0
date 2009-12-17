From: akpm@linux-foundation.org
Subject: [patch 11/20] sdio: fix reference counting in sdio_remove_func()
Date: Thu, 17 Dec 2009 15:27:17 -0800
Message-ID: <200912172327.nBHNRHJw024877@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47176 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755016AbZLQX1X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2009 18:27:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, dsd@laptop.org, linux-mmc@vger.kernel.org, matt@console-pimps.org

From: Daniel Drake <dsd@laptop.org>

sdio_remove_func() needs to be more careful about reference counting.  It
can be called in error paths where sdio_add_func() has never been called
e.g.  mmc_attach_sdio error path --> mmc_sdio_remove --> sdio_remove_func

Signed-off-by: Daniel Drake <dsd@laptop.org>
Reviewed-by: Matt Fleming <matt@console-pimps.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sdio_bus.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/core/sdio_bus.c~sdio-fix-reference-counting-in-sdio_remove_func drivers/mmc/core/sdio_bus.c
--- a/drivers/mmc/core/sdio_bus.c~sdio-fix-reference-counting-in-sdio_remove_func
+++ a/drivers/mmc/core/sdio_bus.c
@@ -248,12 +248,15 @@ int sdio_add_func(struct sdio_func *func
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
 
_
