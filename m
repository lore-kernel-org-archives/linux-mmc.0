From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/4] [ARM] pxamci: fix a memory leak
Date: Mon, 22 Nov 2010 16:46:36 +0800
Message-ID: <1290415596.5471.10.camel@mola>
References: <1290415359.5471.4.camel@mola>  <1290415467.5471.7.camel@mola>
	 <1290415534.5471.8.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45964 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab0KVIlh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 03:41:37 -0500
In-Reply-To: <1290415534.5471.8.camel@mola>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Eric Miao <eric.y.miao@gmail.com>, linux-mmc@vger.kernel.org

request_mem_region() will call kzalloc to allocate memory for struct resource.
release_resource() unregisters the resource but does not free the allocated
memory, thus use release_mem_region() instead to fix the memory leak.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/mmc/host/pxamci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 7257738..d98e647 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -774,7 +774,7 @@ err_gpio_ro:
 	}
 	if (mmc)
 		mmc_free_host(mmc);
-	release_resource(r);
+	release_mem_region(r->start, SZ_4K);
 	return ret;
 }
 
@@ -824,7 +824,7 @@ static int pxamci_remove(struct platform_device *pdev)
 
 		clk_put(host->clk);
 
-		release_resource(host->res);
+		release_mem_region(host->res->start, SZ_4K);
 
 		mmc_free_host(mmc);
 	}
-- 
1.7.2



