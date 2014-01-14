From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] mmc: dw_mmc: fix sparse non static symbol warning
Date: Tue, 14 Jan 2014 10:03:33 +0800
Message-ID: <CAPgLHd8yJdkvVh6AkifxVMeudyA5bYF-QrEOzJrn1K_q8Mfm1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:57285 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbaANCDg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 21:03:36 -0500
Received: by mail-bk0-f45.google.com with SMTP id v16so40329bkz.4
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2014 18:03:34 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, grant.likely@linaro.org, robh+dt@kernel.org, zhangfei.gao@linaro.org
Cc: yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warning:

drivers/mmc/host/dw_mmc-k3.c:116:1: warning:
 symbol 'dw_mci_k3_pmops' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/dw_mmc-k3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 68e5e42..3542a03 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -113,7 +113,7 @@ static int dw_mci_k3_resume(struct device *dev)
 	return dw_mci_resume(host);
 }
 
-SIMPLE_DEV_PM_OPS(dw_mci_k3_pmops, dw_mci_k3_suspend, dw_mci_k3_resume);
+static SIMPLE_DEV_PM_OPS(dw_mci_k3_pmops, dw_mci_k3_suspend, dw_mci_k3_resume);
 
 static struct platform_driver dw_mci_k3_pltfm_driver = {
 	.probe		= dw_mci_k3_probe,

