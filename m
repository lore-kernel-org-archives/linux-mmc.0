From: weiyj_lk@163.com
Subject: [PATCH] mmc: au1xmmc: fix error return code in au1xmmc_probe()
Date: Thu, 14 Aug 2014 09:00:19 +0800
Message-ID: <1407978019-15673-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m12-16.163.com ([220.181.12.16]:50478 "EHLO m12-16.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbaHNBAf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Aug 2014 21:00:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manuel Lauss <manuel.lauss@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-mmc@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/au1xmmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 9c9f6af..725f6a6 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1028,9 +1028,12 @@ static int au1xmmc_probe(struct platform_device *pdev)
 	host->clk = clk_get(&pdev->dev, ALCHEMY_PERIPH_CLK);
 	if (IS_ERR(host->clk)) {
 		dev_err(&pdev->dev, "cannot find clock\n");
+		ret = PTR_ERR(host->clk);
 		goto out_irq;
 	}
-	if (clk_prepare_enable(host->clk)) {
+
+	ret = clk_prepare_enable(host->clk);
+	if (ret) {
 		dev_err(&pdev->dev, "cannot enable clock\n");
 		goto out_clk;
 	}

