From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/2] mmc: davinci_mmc: use module_platform_driver_probe()
Date: Tue, 05 Mar 2013 12:53:23 +0900
Message-ID: <005801ce1954$fc029ce0$f407d6a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46863 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566Ab3CEDxl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Mar 2013 22:53:41 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ60034C5GHOQH0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 05 Mar 2013 12:53:23 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MJ600F1V5GZ8R30@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 05 Mar 2013 12:53:23 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This patch uses module_platform_driver_probe() macro which makes
the code smaller and simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/davinci_mmc.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 2063677..7635e48 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1410,18 +1410,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 	.remove		= __exit_p(davinci_mmcsd_remove),
 };
 
-static int __init davinci_mmcsd_init(void)
-{
-	return platform_driver_probe(&davinci_mmcsd_driver,
-				     davinci_mmcsd_probe);
-}
-module_init(davinci_mmcsd_init);
-
-static void __exit davinci_mmcsd_exit(void)
-{
-	platform_driver_unregister(&davinci_mmcsd_driver);
-}
-module_exit(davinci_mmcsd_exit);
+module_platform_driver_probe(davinci_mmcsd_driver, davinci_mmcsd_probe);
 
 MODULE_AUTHOR("Texas Instruments India");
 MODULE_LICENSE("GPL");
-- 
1.7.2.5


