From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 12/22] mmc: omap_hsmmc: remove unnecessary
 platform_set_drvdata()
Date: Mon, 06 May 2013 15:26:59 +0900
Message-ID: <005701ce4a22$b6adccb0$24096610$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:11016 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab3EFG1B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:27:01 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD0008F5WYHFO0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:27:00 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Balaji T K' <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>, "'Hebbar, Gururaja'" <gururaja.hebbar@ti.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6e44025..61bb87a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2034,7 +2034,6 @@ err_irq:
 	}
 err1:
 	iounmap(host->base);
-	platform_set_drvdata(pdev, NULL);
 	mmc_free_host(mmc);
 err_alloc:
 	omap_hsmmc_gpio_free(pdata);
@@ -2080,7 +2079,6 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.2.5

