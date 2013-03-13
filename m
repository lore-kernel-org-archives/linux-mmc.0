From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] mmc: vt8500: use resource_size() macro
Date: Wed, 13 Mar 2013 13:36:01 +0800
Message-ID: <CAPgLHd8h9cKyqd7NGk5eaGYPMqauEcZ1agiDmk5ih2FjGcjgcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:34965 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab3CMFgD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 01:36:03 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so253594bkc.30
        for <linux-mmc@vger.kernel.org>; Tue, 12 Mar 2013 22:36:01 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux@prisktech.co.nz, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use resource_size function on resource object
instead of explicit computation.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/wmt-sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index c6d0015..04102d2 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -925,7 +925,7 @@ static int wmt_mci_remove(struct platform_device *pdev)
 	clk_put(priv->clk_sdmmc);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 	mmc_free_host(mmc);
 


