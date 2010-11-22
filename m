From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/4] [ARM] davinci_mmc: fix a memory leak
Date: Mon, 22 Nov 2010 16:44:27 +0800
Message-ID: <1290415467.5471.7.camel@mola>
References: <1290415359.5471.4.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50306 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0KVIj3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 03:39:29 -0500
In-Reply-To: <1290415359.5471.4.camel@mola>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Vipin Bhandari <vipin.bhandari@ti.com>, David Brownell <dbrownell@users.sourceforge.net>, linux-mmc@vger.kernel.org

request_mem_region() will call kzalloc to allocate memory for struct resource.
release_resource() unregisters the resource but does not free the allocated
memory, thus use release_mem_region() instead to fix the memory leak.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/mmc/host/davinci_mmc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index e15547c..7c7d268 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1297,7 +1297,7 @@ cpu_freq_fail:
 		mmc_free_host(mmc);
 
 	if (mem)
-		release_resource(mem);
+		release_mem_region(mem->start, resource_size(mem));
 
 	dev_dbg(&pdev->dev, "probe err %d\n", ret);
 
@@ -1322,7 +1322,8 @@ static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
 
 		iounmap(host->base);
 
-		release_resource(host->mem_res);
+		release_mem_region(host->mem_res->start,
+					resource_size(host->mem_res));
 
 		mmc_free_host(host->mmc);
 	}
-- 
1.7.2



