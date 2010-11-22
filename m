From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/4] [ARM] mxcmmc: remove a unnecessary release_resource()
	call
Date: Mon, 22 Nov 2010 16:47:51 +0800
Message-ID: <1290415671.5471.13.camel@mola>
References: <1290415359.5471.4.camel@mola>  <1290415467.5471.7.camel@mola>
	 <1290415534.5471.8.camel@mola>  <1290415596.5471.10.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51501 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab0KVImw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 03:42:52 -0500
In-Reply-To: <1290415596.5471.10.camel@mola>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

Remove release_resource() after release_mem_region().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/mmc/host/mxcmmc.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 2b9f7c8..4428594 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -967,7 +967,6 @@ static int mxcmci_remove(struct platform_device *pdev)
 	clk_put(host->clk);
 
 	release_mem_region(host->res->start, resource_size(host->res));
-	release_resource(host->res);
 
 	mmc_free_host(mmc);
 
-- 
1.7.2



