From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] mmc: jz4740: fix return value check in jz4740_mmc_probe()
Date: Sat, 29 Jun 2013 08:44:53 +0800
Message-ID: <CAPgLHd9ij8_+Kk7Sjp=5xVwg_t2EjkuhVPKf2C35Y5kRwa=zVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:38548 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab3F2Aoy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Jun 2013 20:44:54 -0400
Received: by mail-bk0-f52.google.com with SMTP id d7so999883bkh.25
        for <linux-mmc@vger.kernel.org>; Fri, 28 Jun 2013 17:44:53 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, lars@metafoo.de, viresh.kumar@linaro.org, g.liakhovetski@gmx.de, gregkh@linuxfoundation.org
Cc: yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR(). Also there is already a error message within
devm_ioremap_resource(), so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/jz4740_mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 0308c9f..d058f0c 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -783,9 +783,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->base = devm_ioremap_resource(&pdev->dev, res);
-	if (!host->base) {
-		ret = -EBUSY;
-		dev_err(&pdev->dev, "Failed to ioremap base memory\n");
+	if (IS_ERR(host->base)) {
+		ret = PTR_ERR(host->base);
 		goto err_free_host;
 	}
 

