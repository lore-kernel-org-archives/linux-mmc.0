From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 07/22] mmc: jz4740_mmc: remove unnecessary
 platform_set_drvdata()
Date: Mon, 06 May 2013 15:17:27 +0900
Message-ID: <005201ce4a21$621061a0$263124e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13017 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab3EFGR3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:17:29 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD0084J5GOMVG0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:17:28 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/jz4740_mmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 2391c6b..1c47b34 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -932,7 +932,6 @@ err_release_mem_region:
 err_clk_put:
 	clk_put(host->clk);
 err_free_host:
-	platform_set_drvdata(pdev, NULL);
 	mmc_free_host(mmc);
 
 	return ret;
@@ -960,7 +959,6 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 
 	clk_put(host->clk);
 
-	platform_set_drvdata(pdev, NULL);
 	mmc_free_host(host->mmc);
 
 	return 0;
-- 
1.7.2.5


