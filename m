From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] mmc: omap_hsmmc: fix error return code in omap_hsmmc_probe()
Date: Thu, 9 May 2013 10:06:20 +0800
Message-ID: <CAPgLHd-Trv1W4+NC2m8=quDpyZ74kHZiY35ZV7f7_PnRZAP+4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:65334 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab3EICGW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 May 2013 22:06:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balajitk@ti.com, cjb@laptop.org, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code in the init error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/omap_hsmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6e44025..32d3659 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1948,7 +1948,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	}
 
 	if (pdata->init != NULL) {
-		if (pdata->init(&pdev->dev) != 0) {
+		ret = pdata->init(&pdev->dev);
+		if (ret != 0) {
 			dev_err(mmc_dev(host->mmc),
 				"Unable to configure MMC IRQs\n");
 			goto err_irq_cd_init;

