From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: renesas-sdhi: export renesas_sdhi_probe
Date: Mon, 22 May 2017 15:33:08 +0200
Message-ID: <20170522133339.798278-1-arnd@arndb.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61342 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933201AbdEVNd6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 09:33:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Brandt <chris.brandt@renesas.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

We now build the sdhi driver in separate modules, which means we
have to export the symbols that are called from another module:

ERROR: "renesas_sdhi_remove" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!
ERROR: "renesas_sdhi_probe" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!

Fixes: 94418768f765 ("mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/renesas_sdhi_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 846ee1a8e5a6..fa6c188e0327 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -638,6 +638,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 eprobe:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
 
 int renesas_sdhi_remove(struct platform_device *pdev)
 {
@@ -648,3 +649,4 @@ int renesas_sdhi_remove(struct platform_device *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
-- 
2.9.0

