From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] mmc: usdhi6rol0: Handle return value of platform_get_irq_byname for card detect
Date: Fri, 17 Nov 2017 22:05:07 +0530
Message-ID: <8fcf045dd4601511186b828d1911ba4659d8f923.1510936216.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43153 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdKQQfQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Nov 2017 11:35:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

platform_get_irq_byname() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mmc/host/usdhi6rol0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index cdfeb15..5a896de 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1749,7 +1749,7 @@ static int usdhi6_probe(struct platform_device *pdev)
 	irq_cd = platform_get_irq_byname(pdev, "card detect");
 	irq_sd = platform_get_irq_byname(pdev, "data");
 	irq_sdio = platform_get_irq_byname(pdev, "SDIO");
-	if (irq_sd < 0 || irq_sdio < 0)
+	if (irq_cd < 0 || irq_sd < 0 || irq_sdio < 0)
 		return -ENODEV;
 
 	mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
-- 
2.7.4

