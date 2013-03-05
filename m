From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] mmc: mvsdio: use module_platform_driver_probe()
Date: Tue, 05 Mar 2013 12:54:06 +0900
Message-ID: <005901ce1955$15a43280$40ec9780$%han@samsung.com>
References: <005801ce1954$fc029ce0$f407d6a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:61291 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933058Ab3CEDyH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Mar 2013 22:54:07 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ60043J5HUADE0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 05 Mar 2013 12:54:06 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MJ600F765I68R30@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 05 Mar 2013 12:54:06 +0900 (KST)
In-reply-to: <005801ce1954$fc029ce0$f407d6a0$%han@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This patch uses module_platform_driver_probe() macro which makes
the code smaller and simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/mvsdio.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 145cdaf..2b7d5b7 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -881,18 +881,7 @@ static struct platform_driver mvsd_driver = {
 	},
 };
 
-static int __init mvsd_init(void)
-{
-	return platform_driver_probe(&mvsd_driver, mvsd_probe);
-}
-
-static void __exit mvsd_exit(void)
-{
-	platform_driver_unregister(&mvsd_driver);
-}
-
-module_init(mvsd_init);
-module_exit(mvsd_exit);
+module_platform_driver_probe(mvsd_driver, mvsd_probe);
 
 /* maximum card clock frequency (default 50MHz) */
 module_param(maxfreq, int, 0);
-- 
1.7.2.5


