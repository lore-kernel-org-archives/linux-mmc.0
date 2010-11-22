From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/4] [ARM] mvsdio: fix a memory leak
Date: Mon, 22 Nov 2010 16:45:34 +0800
Message-ID: <1290415534.5471.8.camel@mola>
References: <1290415359.5471.4.camel@mola>  <1290415467.5471.7.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46653 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0KVIkf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 03:40:35 -0500
In-Reply-To: <1290415467.5471.7.camel@mola>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

request_mem_region() will call kzalloc to allocate memory for struct resource.
release_resource() unregisters the resource but does not free the allocated
memory, thus use release_mem_region() instead to fix the memory leak.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/mmc/host/mvsdio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index a5bf60e..6a29972 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -825,7 +825,7 @@ out:
 			iounmap(host->base);
 	}
 	if (r)
-		release_resource(r);
+		release_mem_region(r->start, SZ_1K);
 	if (mmc)
 		mmc_free_host(mmc);
 
@@ -850,7 +850,7 @@ static int __exit mvsd_remove(struct platform_device *pdev)
 		del_timer_sync(&host->timer);
 		mvsd_power_down(host);
 		iounmap(host->base);
-		release_resource(host->res);
+		release_mem_region(host->res->start, SZ_1K);
 		mmc_free_host(mmc);
 	}
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.2



